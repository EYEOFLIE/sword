-- Generated from template
require( 'precache')
require( "abilities/abilityCourier")
require( "ui/shops")
require( "utils/itemtable")
require( "utils/suitSystem")
require( "utils/spawnsystem")
require( "utils/questsystem")
require( "utils/equip_system")
require( "utils/wings_system")
require( "ui/item_data")
require( "ui/events")
require( "utils/backpack")
require( "trigger/hsj_task")
require( "trigger/hechengshop")
require( "trigger/teleport")
require( "utils/PlayerMessage")
require( "utils/itemsystem")
require( "utils/musicsystem")
require("libraries/animations")
require("libraries/attachments")
require("libraries/notifications")
require("libraries/physics")
require("libraries/projectiles")
require("libraries/modifiers/modifier_animation")
require("libraries/modifiers/modifier_animation_translate")
require("npc_abilities/dialogue")
require("npc_abilities/patrol")
require( "utils/dropped")
require( "filters")
require("wallphysics")
require("dungeons")


if sword == nil then
	sword = class({})
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

function Precache( context )
	print("BEGIN TO  PRECACHE RESOURCE")
	local time = GameRules:GetGameTime()
	PrecacheEveryThingFromKV(context)

	

	PrecacheResource( "soundfile","soundevents/custom_game.vsndevts", context )
	
	time= time -GameRules:GetGameTime()
	print("DONE PRECACHEING IN:"..tostring(time).."Seconds")	
end
-- 预载入
-- Create the game mode when we activate
function Activate()
	
	GameRules.AddonTemplate = sword()
	GameRules.AddonTemplate:InitGameMode()
end

function sword:InitGameMode()
	print( "Template addon is loaded." )
	
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
 	GameRules:GetGameModeEntity():SetExecuteOrderFilter(Dynamic_Wrap(sword, "ExecuteOrderFilter"),self) --设置一个过滤器，用来控制单位捡起物品时的行为 
 	
	ListenToGameEvent( "game_rules_state_change", Dynamic_Wrap( sword, 'OnGameRulesStateChange' ), self )
	ListenToGameEvent('entity_killed', Dynamic_Wrap(sword,'OnEntityKilled'),self)
	ListenToGameEvent('npc_spawned', Dynamic_Wrap(sword,'OnNPCSpawned'),self)
	ListenToGameEvent("dota_item_picked_up", Dynamic_Wrap(sword, "OnItemPickedUp"), self)


	
	
	CustomNetTables:SetTableValue("HeroInfo", "courierIndex", {})
	CustomNetTables:SetTableValue("HeroInfo", "heroState", {})
	CustomNetTables:SetTableValue("HeroInfo", "BaseBuilding", {EntIndex=0,Level=1,SpawnTime=0,SpawnPauseTime=0})
	
end

hsj_hero_wearables = {}
-- Evaluate the state of the game
function sword:OnItemPickedUp( keys )
	
	local itemName = keys.itemname
	local player = PlayerResource:GetPlayer(keys.PlayerID)
	local hero = EntIndexToHScript(keys.HeroEntityIndex or 0)
	local item = EntIndexToHScript(keys.ItemEntityIndex or 0)
	
	if player == nil then return end

	local ahero = player:GetAssignedHero()

	if ahero == hero then
		Backpack:AddItemImmediate( ahero, item )
	end
end

function sword:OnEntityKilled( keys )
	-- 储存被击杀的单位
	local killedUnit = EntIndexToHScript( keys.entindex_killed )
	-- 储存杀手单位
	local killerEntity = EntIndexToHScript( keys.entindex_attacker )

	if killerEntity:IsHero() then

		local merits = killerEntity:GetContext("hero_xiuwei")
		if merits~= nil then
			killerEntity:SetContextNum("hero_xiuwei", merits + 1, 0)
		end
		local findNum =  string.find(killedUnit:GetUnitName(), 'creature')
		if findNum ~= nil then
			local defencePoint = killerEntity:GetContext("hsj_hero_defence_point")
			if defencePoint~= nil then
				killerEntity:SetContextNum("hsj_hero_defence_point", defencePoint + 1, 0)

				local data = {}
				data.defence_point = killerEntity:GetContext("hsj_hero_defence_point")
				data.boss_point = killerEntity:GetContext("hsj_hero_solo_random_point")

				CustomGameEventManager:Send_ServerToPlayer(killerEntity:GetPlayerOwner(),"hsj_ui_event_get_integral_return",data)
			end
		end

		local findBossNum =  string.find(killedUnit:GetUnitName(), 'BOSS')
		if findBossNum ~= nil then
			local soloRandomPoint = killerEntity:GetContext("hsj_hero_solo_random_point")
			if soloRandomPoint~= nil then
				killerEntity:SetContextNum("hsj_hero_solo_random_point", soloRandomPoint + 1, 0)
			end
		end

		if killedUnit.is_random_boss == true then
			local soloRandomPoint = killerEntity:GetContext("hsj_hero_solo_random_point")
			if soloRandomPoint~= nil then
				killerEntity:SetContextNum("hsj_hero_solo_random_point", soloRandomPoint + killedUnit.boss_random_level, 0)

				local data = {}
				data.defence_point = killerEntity:GetContext("hsj_hero_defence_point")
				data.boss_point = killerEntity:GetContext("hsj_hero_solo_random_point")

				CustomGameEventManager:Send_ServerToPlayer(killerEntity:GetPlayerOwner(),"hsj_ui_event_get_integral_return",data)
			end
		end
	else
		if killerEntity.hero~=nil then
			local merits = killerEntity.hero:GetContext("hero_xiuwei")
			if merits~= nil then
				killerEntity.hero:SetContextNum("hero_xiuwei", merits + 1, 0)
			end
			local findNum =  string.find(killedUnit:GetUnitName(), 'creature')
			if findNum ~= nil then
				local player = killerEntity:GetPlayerOwner()
				if player then
					local hero = player:GetAssignedHero()
					if hero then
						local defencePoint = hero:GetContext("hsj_hero_defence_point")
						if defencePoint~= nil then
							hero:SetContextNum("hsj_hero_defence_point", defencePoint + 1, 0)

							local data = {}
							data.defence_point = killerEntity:GetContext("hsj_hero_defence_point")
							data.boss_point = killerEntity:GetContext("hsj_hero_solo_random_point")

							CustomGameEventManager:Send_ServerToPlayer(player,"hsj_ui_event_get_integral_return",data)
						end
					end
				end
			end
		end
	end

	killerEntity:EmitSound(killedUnit:GetUnitName()..".Death")
end
--游戏状态改变，然后开始刷怪之类的
function sword:OnGameRulesStateChange(event)
	local GameMode = GameRules:GetGameModeEntity() 
	local nNewState = GameRules:State_Get()
	print( "OnGameRulesStateChange: " .. nNewState )
	if nNewState == DOTA_GAMERULES_STATE_HERO_SELECTION then
		self:Start()
    end
  
    --CustomGameEventManager:Send_ServerToAllClients("display_timer", {msg="Remaining", duration=10, mode=0, endfade=false, position=0, warning=5, paused=false, sound=true} )
	if nNewState == DOTA_GAMERULES_STATE_PRE_GAME then
		local ent = Entities:FindByName(nil, "spawner_04")
		local sxxx=CreateUnitByName("fb_06_BOSS_04", ent:GetOrigin(), true, nil, nil, DOTA_TEAM_BADGUYS )

		local tree = Entities:FindByName(nil, "tree_03")
		PrintTable(tree)
		treeability=tree:FindAbilityByName("caoyao_ability")
		treeability:SetLevel(1)




		SpawnSystem:InitSpawn()
		QuestSystem:InitQuestSystem()
		CPlayerMessage:Init()
		
	    hsj_SetSuitNetTable()
		local base = Entities:FindByName(nil, "dota_goodguys_fort")
		base:AddAbility("ability_custom_base_state")
		baseability=base:FindAbilityByName("ability_custom_base_state")
		baseability:SetLevel(1)
		base:SetModifierStackCount("passive_hsj_base_armor", baseability, 50)
		--base:SetModelScale(3.3528)
		base:SetHullRadius(500)


		local BaseInfo = CustomNetTables:GetTableValue("HeroInfo", "BaseBuilding")
		BaseInfo.EntIndex = Entities:FindByName(nil, "dota_goodguys_fort"):GetEntityIndex()
		CustomNetTables:SetTableValue("HeroInfo", "BaseBuilding", BaseInfo)

	elseif nNewState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		print( "SpawnSystem:InitAttackSpawn" )
		SpawnSystem:InitAttackSpawn()
	end
end

function sword:OnSelectHero(hero)
	if(hero:GetClassname()=="npc_dota_hero_phantom_assassin") then return end
	local heroOwner = PlayerResource:GetPlayer(hero:GetPlayerID())
	if heroOwner == nil then return end
	hero:SetContextNum("hero_xiuwei", 0, 0)
	hero:SetContextNum("hsj_hero_task_equipmulti", 0, 0)
	hero:SetContextNum("hsj_hero_task_statemulti", 0, 0)
  	hero:SetContextNum("HeroMultiStateAbility", 0, 0)
 	hero:SetContextNum("EquipMultiAbility", 0, 0)
 	hero:SetAbilityPoints(5)

	local task=Entities:FindByName(nil, "npc_task_fb_01_01")

	--print(unit:GetUnitName())
	QuestSystem:OnArriveTrigger(hero,task)
	local ability=hero:GetAbilityByIndex(0)
	ability:SetLevel(1)
	local abilitystat=hero:FindAbilityByName("ability_custom_hero_state")
	abilitystat:SetLevel(1)--此函数调用以后4技能让移速可突破522，
	local abilityTelport=hero:FindAbilityByName("Ability_Teleport")
	abilityTelport:SetLevel(1)
	hero.EquipMulti = 0
	hero.HeroMultiState = 0
	--英雄武器值
	hero:SetContextThink("hsj_refresh_state", 
  		function ()
  			local ability = hero:FindAbilityByName("ability_custom_hero_state")
  			local item_kind
  			if ability ~= nil then

	  			if hero:HasModifier("passive_equipmulti") then

	  				item_kind = GetHeroItemKind(hero)

	  				hero:SetModifierStackCount("passive_equipmulti", ability, GetEquipMulti(hero,item_kind))
	  			end
	  		end
	  		local oldheroState = CustomNetTables:GetTableValue("HeroInfo", "heroState")	
	  		local heroIndex = hero:GetEntityIndex()
			--print(tostring(heroIndex))

	  		oldheroState[tostring(heroIndex)] = {
	  			weaponEquipMulti = GetEquipMulti(hero,item_kind),--装备系数
	  			multiState = GetHeroMultiState(hero),	--仙成圣状态
	  			merits = GetHeroMerits(hero),--功德
	  			heroitemkind = item_kind
	  		}
	  		
	  		CustomNetTables:SetTableValue("HeroInfo", "heroState", oldheroState)

  			return 1.0
  		end
  	,1)
  	--刷新额外属性 比如套装
  	hero:SetContextThink("hsj_refresh_extra_attribute", 
  		function ()
  			hsj_hero_item_suit(hero)--套装属性加成
  			hsj_hero_item_extra_attribute(hero)
  			return 1.0
  		end
  	,1.0)
--商店初始化
	Shops(hero);
	

end


function sword:OnNPCSpawned( keys )

	local unit = EntIndexToHScript(keys.entindex)
	if unit:IsHero() then

		if(unit:GetClassname()=="npc_dota_hero_phantom_assassin") then return end
		if  unit.IsInit == nil or unit.IsInit == false then
			self:OnSelectHero(unit)
			unit.IsInit = true
			local unitent=unit:GetChildren()
			for k,v in pairs(unitent) do
				if v:GetClassname() == "dota_item_wearable" then
				    v:RemoveSelf()
				end
			end
		
			-- 初始化背包
			Backpack(unit)
			-- 初始化装备系统
			EquipSystem:Init(unit)
			local model = unit:FirstMoveChild()
			while model ~= nil do
				local modal2 = model:NextMovePeer()
				if model:GetClassname() == "dota_item_wearable" then
				    table.insert(hsj_hero_wearables,model)
				end
				model = modal2
			end

			
			WingsSystem:CreateWingsForHero( unit )
	-- body
		end


		
		--unit:SetModelScale(0.7)
		local playerid=unit:GetPlayerOwnerID()
		--PlayerStats[playerid]['group']={}
		--PlayerStats[playerid]['group_pointer']=1
		--PlayerStats[playerid]['group'][PlayerStats[playerid]['group_pointer']]=unit
		unit:SetContext("name","play"..playerid,0)
		
		--[[GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("1"), 
			function()
				local chaoxiang=unit:GetForwardVector()
				--local truechaoxiang=chaoxiang:Normalized()
				local position=unit:GetAbsOrigin()

				unit:MoveToPosition(position+chaoxiang*500)
				
				local aroundit=FindUnitsInRadius(DOTA_TEAM_NEUTRALS, position,nil, 50,
                              DOTA_UNIT_TARGET_TEAM_FRIENDLY,
                              DOTA_UNIT_TARGET_ALL,
                              DOTA_UNIT_TARGET_FLAG_NONE,
                              FIND_ANY_ORDER,false)
				for k,v in pairs(aroundit) do
					local lable=v:GetContext("name")
					
						if lable then
							if lable == "yang" then
							v:ForceKill(true)
							createbody(playerid)
							end
							if lable == "niu" then
							v:ForceKill(true)
							createbody(playerid)
							end
							if lable == "huoren" then
							unit:ForceKill(true)
							end
							if lable == "littlebug" then
							unit:ForceKill(true)
							end
						end
					
				end

				return 0.5
			end
		, 0)]]
	end

end

function sword:ExecuteOrderFilter( keys )

	local units = {}
	for _,unitIndex in pairs(keys.units) do
		local unit = EntIndexToHScript(unitIndex)
		if unit then

			-- 
			if unit.m_Backpack_DropItemToPosition_OrderType == DOTA_UNIT_ORDER_DROP_ITEM then
				unit.m_Backpack_DropItemToPosition_OrderType = keys.order_type
			end

			-- 
			if unit.IsHero and unit:IsHero() and keys.order_type == DOTA_UNIT_ORDER_PICKUP_ITEM and unit:GetNumItemsInInventory() >= 6 then
				local container = EntIndexToHScript(keys.entindex_target)
				if container == nil then return false end

				unit.m_ExecuteOrderFilter_OrderType = DOTA_UNIT_ORDER_PICKUP_ITEM
				CourierPickupItem(unit,container)
				return true
			end

			-- 
			if keys.order_type == DOTA_UNIT_ORDER_PICKUP_ITEM and unit:GetUnitName() == "unit_courier" then
				keys.order_type = DOTA_UNIT_ORDER_MOVE_TO_POSITION

				local container = EntIndexToHScript(keys.entindex_target)
				if container then
					if (unit:GetOrigin() - container:GetOrigin()):Length2D() <= 150 then
						return false
					end

					local origin = container:GetOrigin()
					keys.position_x = origin.x
					keys.position_y = origin.y
					keys.position_z = origin.z
				else
					return false
				end

				unit.m_ExecuteOrderFilter_OrderType = DOTA_UNIT_ORDER_PICKUP_ITEM
				CourierPickupItem(unit,container)
				return true
			end

			-- 
			if keys.order_type == DOTA_UNIT_ORDER_ATTACK_TARGET then
				local target = EntIndexToHScript(keys.entindex_target)
				if target and not target:IsNull() and target:GetTeamNumber() == DOTA_TEAM_GOODGUYS then
					keys.order_type = DOTA_UNIT_ORDER_MOVE_TO_TARGET
				end
			end

			-- 
			unit.m_ExecuteOrderFilter_OrderType = keys.order_type
		end
	end

	return true
end
function OnMyUIOpen( index,keys )
         --index 是事件的index值
         --keys 是一个table，固定包含一个触发的PlayerID，其余的是传递过来的数据
         CustomUI:DynamicHud_Create(keys.PlayerID,"MyUIMain","file://{resources}/layout/custom_game/MyUI_main.xml",nil)
end
function OnMybackpackOpen( index,keys )
         --index 是事件的index值
         --keys 是一个table，固定包含一个触发的PlayerID，其余的是传递过来的数据
         CustomUI:DynamicHud_Create(keys.PlayerID,"MybackpackMain","file://{resources}/layout/custom_game/MyUI_main.xml",nil)
end
  
function OnJsToLua( index,keys )
		 print("num:"..keys.num.." str:"..tostring(keys.str))
         CustomUI:DynamicHud_Destroy(keys.PlayerID,"MyUIMain")
end
function close( index,keys )
		 print("num:"..keys.num.." str:"..tostring(keys.str))
         CustomUI:DynamicHud_Destroy(keys.PlayerID,"MybackpackMain")
end
  
function OnLuaToJs( index,keys )
         CustomGameEventManager:Send_ServerToPlayer( PlayerResource:GetPlayer(keys.PlayerID), "on_lua_to_js", {str="Lua"} )
         CustomUI:DynamicHud_Destroy(keys.PlayerID,"MyUIMain")
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