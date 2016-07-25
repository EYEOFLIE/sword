
require( "precache")
require( "abilities/abilityCourier")
require( "ui/shops")
require( "utils/itemtable")
require( "utils/suittable")
require( "utils/spawnsystem")
require( "utils/questsystem")
require( "utils/equip_system")
require( "utils/wings_system")
require( "ui/item_data")
require( "ui/events")
require( "utils/backpack")
require( "trigger/task")
require( "trigger/hechengshop")
require( "trigger/teleport")
require( "utils/itemsystem")
require( "utils/musicsystem")
require("libraries/animations")
require("libraries/attachments")
require("libraries/worldpanels")
require("libraries/notifications")
require("libraries/modifiers/modifier_animation")
require("libraries/modifiers/modifier_animation_translate")
require("npc_abilities/dialogue")
require("npc_abilities/patrol")
require( "utils/dropped")
require( "utils/items")
require( "utils/rpcbody")
require( "filters")
require("wallphysics")
require("dungeons")
require("ai_core")
require("lua_modifier/suit_lua")
require("lua_modifier/defend_huo")
require("lua_modifier/defend_jin")
require("lua_modifier/defend_mu")
require("lua_modifier/defend_shui")
require("lua_modifier/defend_tu")
require("lua_modifier/xixue")
require("equilibrium_constant")
require("utils/firstsystem")
require("lua_modifier/stun_nothing")

if sword == nil then
	_G.sword = class({})
end

HERO_MAX_LEVEL = 101
HERO_EXP_TABLE={0}
_G.MAIN_HERO_TABLE={}
_G.MAIN_NPC={}
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
	 8060,8140,8220,8300,8380
	}
_G.color={Vector(88,228,167),Vector(9,77,15),Vector(234,123,178),Vector(168,0,168),Vector(43,101,222)}
xp=0

for i=2,HERO_MAX_LEVEL-1 do
	HERO_EXP_TABLE[i]=HERO_EXP_TABLE[i-1]+exp[i-1]
end

function Precache( context )
	print("BEGIN TO  PRECACHE RESOURCE")
	local time = GameRules:GetGameTime()
	PrecacheEveryThingFromKV(context)
	PrecacheResource("particle_folder", "particles/buildinghelper", context)
	PrecacheResource( "soundfile","soundevents/custom_game.vsndevts", context )
	PrecacheResource( "soundfile","soundevents/jineng/jineng_game.vsndevts", context )
	PrecacheResource( "soundfile","soundevents/talkvo/custom_game_talk.vsndevts", context )
	PrecacheResource( "particle", "particles/dao/shake.vpcf", context ) --镜头摇动
	PrecacheResource( "model", "models/items/lanaya/tail_of_the_secret_order/tail_of_the_secret_order.vmdl", context ) 
	
	time= time -GameRules:GetGameTime()
	print("DONE PRECACHEING IN:"..tostring(time).."Seconds")	
end
-- 预载入
-- Create the game mode when we activate
function Activate()
	sword:InitGameMode()
end

function sword:InitGameMode()
	print( "Template addon is loaded." )
	GameRules:GetGameModeEntity().sword = self

	self.m_GoldRadiusMin = 100
	self.m_GoldRadiusMax = 300

	GameRules:GetGameModeEntity():SetCameraDistanceOverride(1334.0)--设置镜头距离，默认1134 2553
	--GameRules:GetGameModeEntity():SetUnseenFogOfWarEnabled(true)--地图全黑
	GameRules:GetGameModeEntity():SetFogOfWarDisabled(true)--去掉战争迷雾
	GameRules:GetGameModeEntity():SetUseCustomHeroLevels(true) --开关自定议英雄经验表
	GameRules:GetGameModeEntity():SetCustomXPRequiredToReachNextLevel(HERO_EXP_TABLE)--定义英雄经验值表，这表在上面已经创建好了
	GameRules:GetGameModeEntity():SetCustomHeroMaxLevel(HERO_MAX_LEVEL)--定议英雄最大等级
	GameRules:GetGameModeEntity():SetFixedRespawnTime(5)--定议重生时间
	GameRules:SetTreeRegrowTime(20)--定议树重生时间
	GameRules:GetGameModeEntity():SetLoseGoldOnDeath(true)--定义禁止死亡时掉落金钱
	GameRules:GetGameModeEntity():SetWeatherEffectsDisabled(false)--定义禁止天气特效
	GameRules:GetGameModeEntity():SetCustomGameForceHero( "npc_dota_hero_phantom_assassin" )
	GameRules:SetStartingGold(1000)--初始金钱
	GameRules:SetGoldPerTick(0)--每秒获得金钱
	GameRules:GetGameModeEntity():SetBuybackEnabled(false)
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 10 )
 	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 10 )
 	GameRules:SetSameHeroSelectionEnabled(true)
 	GameRules:SetHeroSelectionTime(0)
 	GameRules:SetHeroMinimapIconScale( 0.8 )--小地图图标缩放
 	--GameRules:SetCreepMinimapIconScale( 1.5 )
 	GameRules:GetGameModeEntity():SetExecuteOrderFilter(Dynamic_Wrap(sword, "ExecuteOrderFilter"),self) --设置一个过滤器，用来控制单位捡起物品时的行为 
 	GameRules:GetGameModeEntity():SetDamageFilter(Dynamic_Wrap( sword, "DamageFilter" ), self) 
 	
	ListenToGameEvent( "game_rules_state_change", Dynamic_Wrap( sword, 'OnGameRulesStateChange' ), self )
	ListenToGameEvent('entity_killed', Dynamic_Wrap(sword,'OnEntityKilled'),self)
	ListenToGameEvent('npc_spawned', Dynamic_Wrap(sword,'OnNPCSpawned'),self)
	ListenToGameEvent("dota_item_picked_up", Dynamic_Wrap(sword, "OnItemPickedUp"), self)
	ListenToGameEvent("dota_player_gained_level", Dynamic_Wrap(sword, "OnPlayerLevelUp"), self)



	
	CustomNetTables:SetTableValue("HeroInfo", "aggrtable", {})
	CustomNetTables:SetTableValue("HeroInfo", "courierIndex", {})
	CustomNetTables:SetTableValue("HeroInfo", "heroState", {})
	CustomNetTables:SetTableValue("HeroInfo", "BaseBuilding", {EntIndex=0,Level=1,SpawnTime=0,SpawnPauseTime=0})
	
end

if false and not debug.bHookIsSet then
--if true then
	debug.sethook(function()
		local info=debug.getinfo(2)
		local src=tostring(info.short_src)
		local name=tostring(info.name)
		if name ~= "__index" and name ~="nil" then
			local now = GameRules:GetGameTime()
			print(now)
			print("call:"..src.."--"..name)
			print(debug.traceback())
		end
	end,"c")
	debug.bHookIsSet=true
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
	
	r = 300
	--print(itemName)
	--r = RandomInt(200, 400)
	if itemName == "item_bag_of_gold" then
		--print("Bag of gold picked up")
		PlayerResource:ModifyGold( hero:GetPlayerID(), r, true, 0 )
		SendOverheadEventMessage( hero, OVERHEAD_ALERT_GOLD, hero, r, nil )
		UTIL_Remove( item ) -- otherwise it pollutes the player inventory
	elseif itemName == "item_tombstone" then

	else
		sword:SpecialItemAdd( keys )
		Backpack:AddItemImmediate( ahero, item )
	end
		
	end
end

function sword:OnPlayerLevelUp(keys)

	  local player = EntIndexToHScript(keys.player)
	  local level = keys.level
	  local hero = player:GetAssignedHero()
		hero:SetAbilityPoints(0)
	  hero:SetContextNum("hero_wuxing",hero:GetContext("hero_wuxing")+5,0)
	-- body
end

function sword:SpecialItemAdd( event )
	local item = EntIndexToHScript( event.ItemEntityIndex )
	local owner = EntIndexToHScript( event.HeroEntityIndex )
	local hero = owner:GetClassname()
	local ownerTeam = owner:GetTeamNumber()


	local tableindex = 0
	
	local t2 = "item_0001"
	local spawnedItem = ""
	spawnedItem = t2
	

	-- add the item to the inventory and broadcast
	--owner:AddItemByName( spawnedItem )
	EmitGlobalSound("powerup_04")
	local overthrow_item_drop =
	{
		hero_id = hero,
		dropped_item = spawnedItem
	}
	CustomGameEventManager:Send_ServerToAllClients( "overthrow_item_drop", overthrow_item_drop )
end


function sword:OnEntityKilled( keys )
	
	-- 储存被击杀的单位
	local killedUnit = EntIndexToHScript( keys.entindex_killed )
	-- 储存杀手单位
	local killerEntity = EntIndexToHScript( keys.entindex_attacker )

	if killerEntity:IsHero() then
		BASE_DROP_TABLE = {"item_0001", "item_0001"}
		local randomHelm = RandomInt(1,2)
		local itemVariant = BASE_DROP_TABLE[randomHelm]
		GameRules:GetGameModeEntity().sword:SpawnitemEntity( itemVariant,killedUnit:GetOrigin())
		local xiuwei = killerEntity:GetContext("hero_xiuwei")
		if xiuwei~= nil then
			killerEntity:SetContextNum("hero_xiuwei", xiuwei + 1, 0)
		end
		
	else
		local newItem = CreateItem( "item_tombstone", killedUnit, killedUnit )
		newItem:SetPurchaseTime( 0 )
		newItem:SetPurchaser( killedUnit )
		
		local tombstone = SpawnEntityFromTableSynchronous( "dota_item_tombstone_drop", {} )
		tombstone:SetContainedItem( newItem )
		tombstone:SetAngles( 0, RandomFloat( 0, 360 ), 0 )
		FindClearSpaceForUnit( tombstone, killedUnit:GetAbsOrigin(), true )	
		if killerEntity.hero~=nil then

			local xiuwei = killerEntity.hero:GetContext("hero_xiuwei")
			if xiuwei~= nil then
				killerEntity.hero:SetContextNum("hero_xiuwei", xiuwei + 1, 0)
			end
			
		end
	end
	
	killerEntity:EmitSound(killedUnit:GetUnitName()..".Death")
end
--游戏状态改变，然后开始刷怪之类的
_G.Playerlist={}
function sword:OnGameRulesStateChange(event)
	local GameMode = GameRules:GetGameModeEntity()
	local nNewState = GameRules:State_Get()
	print( "OnGameRulesStateChange: " .. nNewState )
	if nNewState == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
		for i = 1, PlayerResource:GetPlayerCount(), 1 do
			local player = EntIndexToHScript(i)
			local playernum={}
			playernum["id"]=player:GetPlayerID()
			playernum["check"]=0
			table.insert(Playerlist,playernum)
		end
    end

	if nNewState == DOTA_GAMERULES_STATE_HERO_SELECTION then
		self:Start()

		local difficulty = {easy=PlayersSelectDifficulty["easy"], hard=PlayersSelectDifficulty["hard"],
			 normal=PlayersSelectDifficulty["normal"], veryhard=PlayersSelectDifficulty["veryhard"],
			devil=PlayersSelectDifficulty["devil"]}
		local max = math.max(difficulty.easy,difficulty.normal,difficulty.hard,difficulty.veryhard,difficulty.devil)

		if max == difficulty.easy then
			
			GameRules:SetCustomGameDifficulty(1)
			
		elseif max == difficulty.normal then
			
			GameRules:SetCustomGameDifficulty(2)
		elseif max == difficulty.hard then
			
			GameRules:SetCustomGameDifficulty(3)
		elseif max == difficulty.veryhard then

			GameRules:SetCustomGameDifficulty(4)
		elseif max == difficulty.devil then
			GameRules:SetCustomGameDifficulty(5)
		end

		print("difficulty is "..max)
    end
  
    --CustomGameEventManager:Send_ServerToAllClients("display_timer", {msg="Remaining", duration=10, mode=0, endfade=false, position=0, warning=5, paused=false, sound=true} )
	if nNewState == DOTA_GAMERULES_STATE_PRE_GAME then
		local mainnpc=Entities:FindByName(nil, "npc_caoyao_unit")
		table.insert(MAIN_NPC,mainnpc)
		local ent = Entities:FindByName(nil, "spawner_04")
		local sxxx=CreateUnitByName("fb_06_BOSS_04", ent:GetOrigin(), true, nil, nil, DOTA_TEAM_BADGUYS )
		local ent2 = Entities:FindByName(nil, "long_path_01")
		local ddd=CreateUnitByName("fb_02_BOSS_01", ent2:GetOrigin(), true, nil, nil, DOTA_TEAM_BADGUYS )
		--禁止单位寻找最短路径
        ddd:SetMustReachEachGoalEntity(true)
 
        --让单位沿着设置好的路线开始行动
        ddd:SetInitialGoalEntity(ent2)

		
		
		mainnpc:FindAbilityByName("caoyao_ability"):SetLevel(1)
		
		local cun_01 = Entities:FindByName(nil, "npc_cun_01")
		--cun_01:FindAbilityByName("Ability_quest_02"):SetLevel(1)
		local cun_02 = Entities:FindByName(nil, "npc_cun_02")
		--cun_02:FindAbilityByName("Ability_quest_02"):SetLevel(1)
		local cun_03 = Entities:FindByName(nil, "npc_cun_03")
		--cun_03:FindAbilityByName("Ability_quest_02"):SetLevel(1)
		local cun_04 = Entities:FindByName(nil, "npc_cun_04")
		--cun_04:FindAbilityByName("Ability_quest_02"):SetLevel(1)
		local cun_05 = Entities:FindByName(nil, "npc_cun_05")
		--cun_05:FindAbilityByName("Ability_quest_02"):SetLevel(1)
		local cun_06 = Entities:FindByName(nil, "npc_cun_06")
		---cun_06:FindAbilityByName("Ability_quest_02"):SetLevel(1)


		local unit_06=CreateUnitByName("npc_cike3_BOSS", Vector(-10829.5,-7325.13,214.883), true, nil, nil, DOTA_TEAM_NEUTRALS )
		unit_06:AddAbility("ab_boss_01_ai_lua"):SetLevel(1)

		SpawnSystem:InitSpawn()
		QuestSystem:InitQuestSystem()
		--CPlayerMessage:Init()
	    SetSuitNetTable()

		
	elseif nNewState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then

		
		
	end
end

function sword:OnSelectHero(hero)
	if(hero:GetClassname()=="npc_dota_hero_phantom_assassin") then return end
	local heroOwner = PlayerResource:GetPlayer(hero:GetPlayerID())
	if heroOwner == nil then return end
	hero:SetContextNum("hero_xiuwei", 0, 0)
	hero:SetContextNum("hero_wuxing", 5, 0)
  	hero:SetContextNum("hero_jin", 0, 0)
 	hero:SetContextNum("hero_mu", 0, 0)
 	hero:SetContextNum("hero_shui", 0, 0)
 	hero:SetContextNum("hero_huo", 0, 0)
 	hero:SetContextNum("hero_tu", 0, 0)
 	

 	

 	--local jianlin = CreateUnitByName("npc_jianling_unit", Vector(-13668,-9290,1632.51), true, nil, nil, DOTA_TEAM_BADGUYS)
	
	--CreateUnitByName("town_footman", Vector(-13484,-9740,1577), true, nil, nil, DOTA_TEAM_GOODGUYS )
	--local task=Entities:FindByName(nil, "npc_task_fb_01_01")

	--QuestSystem:OnArriveTrigger(hero,task)
	local ability=hero:GetAbilityByIndex(0)
	ability:SetLevel(1)
	hero:SetAbilityPoints(5)
	--local abilitystat=hero:FindAbilityByName("ability_custom_hero_state")
	--abilitystat:SetLevel(1)--此函数调用以后4技能让移速可突破522，
	local abilityTelport=hero:FindAbilityByName("Ability_Teleport")
	abilityTelport:SetLevel(1)

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
	  			armor = GetHeroArmorState(hero),	--护甲
	  			attackspeed = GetHeroAttackspeedState(hero),	--攻速
	  			xiuwei = GetHeroxiuwei(hero),--修为
	  			wuxing = Getwuxing(hero,"wuxing"),--五行
	  			jin = Getwuxing(hero,"jin"),--金
	  			mu = Getwuxing(hero,"mu"),--木
	  			shui = Getwuxing(hero,"shui"),--水
	  			huo = Getwuxing(hero,"huo"),--火
	  			tu = Getwuxing(hero,"tu"),--土
	  			heroitemkind = item_kind,
	  			herocolor = Getherocolor(hero),
	  			
	  		}
	  		
	  		CustomNetTables:SetTableValue("HeroInfo", "heroState", oldheroState)

  			return 1.0
  		end
  	,1)
  	--刷新额外属性 比如套装
  	hero:SetContextThink("hsj_refresh_extra_attribute", 
  		function ()
  			--SetSuitAttribute(hero)--套装属性加成
  			--hsj_hero_item_extra_attribute(hero)
  			return 1.0
  		end
  	,1.0)
--商店初始化
	Shops(hero);
	

end

function sword:SpawnitemEntity( itemname,spawnPoint )
	
	local newItem = CreateItem( itemname, nil, nil )
	newItem:SetLevel(2)
	local drop = CreateItemOnPositionForLaunch( spawnPoint, newItem )
	local dropRadius = RandomFloat( self.m_GoldRadiusMin, self.m_GoldRadiusMax )
	newItem:LaunchLootInitialHeight( false, 0, 500, 0.75, spawnPoint + RandomVector( dropRadius ) )
	newItem:SetContextThink( "KillLoot", function() return self:KillLoot( newItem, drop ) end, 60 )
end


--Removes Bags of Gold after they expire
function sword:KillLoot( item, drop )

	if drop:IsNull() then
		return
	end

	local nFXIndex = ParticleManager:CreateParticle( "particles/items2_fx/veil_of_discord.vpcf", PATTACH_CUSTOMORIGIN, drop )
	ParticleManager:SetParticleControl( nFXIndex, 0, drop:GetOrigin() )
	ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 35, 35, 25 ) )
	ParticleManager:ReleaseParticleIndex( nFXIndex )
	UTIL_Remove( item )
	UTIL_Remove( drop )
end

function sword:OnNPCSpawned( keys )

	local unit = EntIndexToHScript(keys.entindex)
	local colornum=1
	if unit:IsHero() and unit:GetPlayerOwnerID()~=-1 then
		local unitent=unit:GetChildren()
			
		for k,v in pairs(unitent) do
			if v:GetClassname() == "dota_item_wearable" then
			    v:RemoveSelf()
			end
		end
		if(unit:GetClassname()=="npc_dota_hero_phantom_assassin") then return end
		if unit:GetUnitName()=="npc_dota_hero_dragon_knight" then
 			Timers:CreateTimer(0.1,function ()
 				unit:SetMana(0-unit:GetMaxMana())
 				end)
          
    	end

		if  unit.IsInit == nil or unit.IsInit == false then
			Timers:CreateTimer(3,function ()
				local enemies = FindUnitsInRadius( unit:GetTeam(), Vector(-14000,-12796,1570.88), nil, 500, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, 0, 0, false )
	
				for _,v in pairs(enemies) do
					
					if v:GetUnitName()=="npc_dota_hero_phantom_assassin" then
					
						UTIL_Remove(v)
						
					end
					
				end
			end)
			local playerID =unit:GetPlayerID()
			if playerID then
				unit.color=colornum
				PlayerResource:SetCustomPlayerColor(playerID,color[colornum].x,color[colornum].y,color[colornum].z)
				colornum=colornum+1
			end   	
		  
			table.insert(MAIN_HERO_TABLE, unit)
			CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(unit:GetPlayerID()),"diqu",{zhudiqu="location_tianxuanpai",fudiqu=nil})    	
			QuestSystem:initquestforplayer(unit)
			local npc = Entities:FindByName(nil, "shouwei_06")
			local vision=CreateUnitByName("npc_vision_unit", Vector(-6346.06,-9491.7,222.884), true, nil, nil, DOTA_TEAM_GOODGUYS)
			Timers:CreateTimer(3,function ()
					vision:SetOrigin(Vector(-6346.06,-9491.7,5000.884))
				end)
		

			if npc then 
				particleID= ParticleManager:CreateParticle("particles/juqing/gantanhao_pt.vpcf",PATTACH_OVERHEAD_FOLLOW,npc)
 				ParticleManager:SetParticleControl(particleID,0,npc:GetOrigin())
				
			end
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
		if not unit:HasModifier("defend_jin")  then
	        unit:AddNewModifier(unit,nil,"defend_jin",{})
	        unit:AddNewModifier(unit,nil,"defend_mu",{})
	        unit:AddNewModifier(unit,nil,"defend_shui",{})
	        unit:AddNewModifier(unit,nil,"defend_huo",{})
	        unit:AddNewModifier(unit,nil,"defend_tu",{})
	    end
	end

end


function sword:DamageFilter( event )
	
	local victim = EntIndexToHScript(event.entindex_victim_const)
	
	if victim:GetUnitName()~= "npc_dota_hero_phantom_assassin" then
		
		local attacker = EntIndexToHScript(event.entindex_attacker_const)
		local dcolor
		if attacker:IsHero()  then 
			dcolor=color[attacker.color]
					
		else 
			dcolor=Vector(153,153,102)
		end 
		

	    
	    if event.entindex_inflictor_const then --if there is no inflictor key then it was an auto attack
	    	if attacker:IsHero()  then
	    		event.damage=event.damage/(1+((attacker:GetIntellect()/16)/100))
	    		
	    	end
	        ability = EntIndexToHScript(event.entindex_inflictor_const)
	        if ability:GetAbilityDamageType()==DAMAGE_TYPE_MAGICAL then
	        	event.damage=event.damage/(1-victim:GetMagicalArmorValue())
		        local defend=ability:GetSpecialValueFor("defend")
		        if defend then
		        	if defend==1  then
		        	event.damage =event.damage-event.damage*(victim:GetModifierStackCount("defend_jin",victim)/100)
		        	end
		        	if defend==2  then
		        	event.damage =event.damage-event.damage*(victim:GetModifierStackCount("defend_mu",victim)/100)
		        	end
		        	if defend==3  then
		        	event.damage =event.damage-event.damage*(victim:GetModifierStackCount("defend_shui",victim)/100)
		        	end
		        	if defend==4  then
		        	event.damage =event.damage-event.damage*(victim:GetModifierStackCount("defend_huo",victim)/100)
		        	end
		        	if defend==5  then
		        	event.damage =event.damage-event.damage*(victim:GetModifierStackCount("defend_tu",victim)/100)
		        	end
		    	end 

	        end
	        
	    end
	    PopupNumbers_damage(victim, "damage", dcolor, 1.0, math.ceil(event.damage), 1, nil)
		return true
	end
end


function sword:ExecuteOrderFilter( keys )

	local units = {}
	
	for _,unitIndex in pairs(keys.units) do
		
		local unit = EntIndexToHScript(unitIndex)
		if unit then
			
			
			-- 是否点击右键
			unit.m_ExecuteOrderFilter_OrderType=1

			if unit.m_Backpack_DropItemToPosition_OrderType == DOTA_UNIT_ORDER_DROP_ITEM then
				unit.m_Backpack_DropItemToPosition_OrderType = keys.order_type
			end

			-- 英雄
			if unit.IsHero and keys.order_type == DOTA_UNIT_ORDER_PICKUP_ITEM and unit:GetNumItemsInInventory() >= 6 then
				local container = EntIndexToHScript(keys.entindex_target)
				if container == nil then return false end
				
				--unit.m_ExecuteOrderFilter_OrderType = DOTA_UNIT_ORDER_PICKUP_ITEM
				--CourierPickupItem(unit,container)
				return true
			end

			
			-- 
			if keys.order_type == DOTA_UNIT_ORDER_ATTACK_TARGET then
				local target = EntIndexToHScript(keys.entindex_target)
				if target and not target:IsNull() and target:GetTeamNumber() == DOTA_TEAM_GOODGUYS then
					keys.order_type = DOTA_UNIT_ORDER_MOVE_TO_TARGET
				end
			end

			
			
			
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

SELECTION_DURATION_LIMIT = 10
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
			--sword:AssignHero( event.PlayerID, event.HeroName )
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