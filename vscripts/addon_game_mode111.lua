-- Generated from template

require("libraries/animations")
require("libraries/attachments")
require("libraries/notifications")
require("libraries/physics")
require("libraries/projectiles")
require("libraries/modifiers/modifier_animation")
require("libraries/modifiers/modifier_animation_translate")

if sword == nil then
	_G.sword = class({})
end

function Precache( context )

end

-- Create the game mode when we activate
function Activate()
	sword:InitGameMode()
end

HERO_MAX_LEVEL = 100
HERO_EXP_TABLE={0}
exp={80,160,240,320,400,480,560,640,720,800,
	 880,960,1040,1120,1200,1280,1360,1440,1520,1600,
	 1680,1760,1840,1920,2000,2080,2160,2240,2320,2400,
	 2480,2560,2640,2720,2800,2880,2960,3040,3120,3200,
	 3280,3340,3420,3500,3580,3660,3740,3820,3900,3980,
	 4060,4140,4220,4300,4380,4460,4540,4620,4700,4780,
	 4860,4940,5020,5100,5180,5260,5340,5420,5500,5580,
	 5660,5740,5820,5900,5980,6060,6140,6220,6300,6380,
	 6460,6540,6620,6700,6780,6860,6940,7020,7100,7180,
	 7260,7340,7420,7500,7580,7660,7740,7820,7900,7980,
	 8060,8140,8220,8300
	}
xp=0

for i=2,HERO_MAX_LEVEL-1 do
	HERO_EXP_TABLE[i]=HERO_EXP_TABLE[i-1]+exp[i-1]
end
function sword:InitGameMode()
	print( "Template addon is loaded." )
	GameRules:GetGameModeEntity().sword = self

	self.m_GoldRadiusMin = 100
	self.m_GoldRadiusMax = 300

	GameRules:GetGameModeEntity():SetCameraDistanceOverride(1434.0)--设置镜头距离，默认1134
	--GameRules:GetGameModeEntity():SetUnseenFogOfWarEnabled(true)
	GameRules:GetGameModeEntity():SetFogOfWarDisabled(true)--去掉战争迷雾
	GameRules:GetGameModeEntity():SetUseCustomHeroLevels(true) --开关自定议英雄经验表
	GameRules:GetGameModeEntity():SetCustomXPRequiredToReachNextLevel(HERO_EXP_TABLE)--定义英雄经验值表，这表在上面已经创建好了
	GameRules:GetGameModeEntity():SetCustomHeroMaxLevel(HERO_MAX_LEVEL)--定议英雄最大等级
	GameRules:GetGameModeEntity():SetFixedRespawnTime(5)--定议重生时间
	GameRules:GetGameModeEntity():SetLoseGoldOnDeath(true)--定义禁止死亡时掉落金钱
	GameRules:GetGameModeEntity():SetCustomGameForceHero( "npc_dota_hero_phantom_assassin" )
	GameRules:SetStartingGold(1000)--初始金钱
	GameRules:SetGoldPerTick(0)--每秒获得金钱
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 10 )
 	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 0 )
 	GameRules:SetSameHeroSelectionEnabled(true)
 	GameRules:SetHeroSelectionTime(0)

	ListenToGameEvent( "game_rules_state_change", Dynamic_Wrap( sword, 'OnGameRulesStateChange' ), self )

	CustomNetTables:SetTableValue("HeroInfo", "courierIndex", {})
	CustomNetTables:SetTableValue("HeroInfo", "heroState", {})
	CustomNetTables:SetTableValue("HeroInfo", "BaseBuilding", {EntIndex=0,Level=1,SpawnTime=0,SpawnPauseTime=0})
end

--游戏状态改变，然后开始刷怪之类的
function sword:OnGameRulesStateChange(event)
	local GameMode = GameRules:GetGameModeEntity() 
	local nNewState = GameRules:State_Get()
	print( "OnGameRulesStateChange: " .. nNewState )
	if nNewState == DOTA_GAMERULES_STATE_HERO_SELECTION then
		self:Start()
    end
    
end



SELECTION_DURATION_LIMIT = 60
function sword:Start()
	--Figure out which players have to pick
	
	 sword.playerPicks = {}
	 sword.numPickers = 0
	for pID = 0, DOTA_MAX_PLAYERS -1 do
		if PlayerResource:IsValidPlayer( pID ) then
			sword.numPickers =sword.numPickers + 1
		end
	end
	
	--Start the pick timer
	sword.TimeLeft = SELECTION_DURATION_LIMIT
	Timers:CreateTimer( 0.04, sword.Tick )

	--Keep track of the number of players that have picked
	sword.playersPicked = 0

	--Listen for the pick event
	sword.listener = CustomGameEventManager:RegisterListener( "hero_selected", sword.HeroSelect )
end

--[[
	Tick
	A tick of the pick timer.
	Params:
		- event {table} - A table containing PlayerID and HeroID.
]]
function sword:Tick() 
	--Send a time update to all clients
	if sword.TimeLeft >= 0 then
		CustomGameEventManager:Send_ServerToAllClients( "picking_time_update", {time = sword.TimeLeft} )
	end

	--Tick away a second of time
	sword.TimeLeft = sword.TimeLeft - 1
	if sword.TimeLeft == -1 then
		--End picking phase
		sword:EndPicking()
		return nil
	elseif sword.TimeLeft >= 0 then
		return 1
	else
		return nil
	end
end

--[[
	HeroSelect
	A player has selected a hero. This function is caled by the CustomGameEventManager
	once a 'hero_selected' event was seen.
	Params:
		- event {table} - A table containing PlayerID and HeroID.
]]
function sword:HeroSelect( event )

	--If this player has not picked yet give him the hero
	if sword.playerPicks[ event.PlayerID ] == nil then
		sword.playersPicked = sword.playersPicked + 1
		sword.playerPicks[ event.PlayerID ] = event.HeroName
		
		--Send a pick event to all clients
		CustomGameEventManager:Send_ServerToAllClients( "picking_player_pick", 
			{ PlayerID = event.PlayerID, HeroName = event.HeroName} )

		--Assign the hero if picking is over
		if sword.TimeLeft <= 0 then
			sword:AssignHero( event.PlayerID, event.HeroName )
		end
	end

	--Check if all heroes have been picked
	if sword.playersPicked >= sword.numPickers then
		--End picking
		sword.TimeLeft = 0
		sword:Tick()
	end
end

--[[
	EndPicking
	The final function of hero selection which is called once the selection is done.
	This function spawns the heroes for the players and signals the picking screen
	to disappear.
]]
function sword:EndPicking()
	--Stop listening to pick events
	--CustomGameEventManager:UnregisterListener( self.listener )

	--Assign the picked heroes to all players that have picked
	for player, hero in pairs( sword.playerPicks ) do

		sword:AssignHero( player, hero )
	end

	--Signal the picking screen to disappear
	CustomGameEventManager:Send_ServerToAllClients( "picking_done", {} )
end

--[[
	AssignHero
	Assign a hero to the player. Replaces the current hero of the player
	with the selected hero, after it has finished precaching.
	Params:
		- player {integer} - The playerID of the player to assign to.
		- hero {string} - The unit name of the hero to assign (e.g. 'npc_dota_hero_rubick')
]]
function sword:AssignHero( player, hero )
	PrecacheUnitByNameAsync( hero, function()
		PlayerResource:ReplaceHeroWith( player, hero,1000, 0 )
	end, player)
end
