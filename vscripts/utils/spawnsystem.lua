if SpawnSystem == nil then
	SpawnSystem = {}
	SpawnSystem.Spawner = {}
	SpawnSystem.AttackingSpawner = {}
	SpawnSystem.DungeonSpawner = {}
	SpawnSystem.Difficulty = 1
	SpawnSystem.TeamNumber = 1
	SpawnSystem.Line = 2
	SpawnSystem.Base = nil
	SpawnSystem.AST = 0
end
--[[
刷怪难度
1 normal
2 hard
3 impossible
刷怪 分为 两个部分
	1.波数怪
	2.野怪
 玩家人数>3 两路刷怪
  -- AttackingSpawner1 AttackingSpawner2
]]
TotalWave = 0
function SpawnSystem:InitSpawn()
	SpawnSystem.Spawner = LoadKeyValues("scripts/npc/Spawner.txt")
	SpawnSystem.DungeonSpawner = SpawnSystem.Spawner["Dungeon"]
	local PlayerNum  = 0
	for i= 0,9 do
		if PlayerResource:IsValidPlayer(i)  then
			PlayerNum = PlayerNum + 1
		end
	end
	SpawnSystem.TeamNumber = PlayerNum
	ListenToGameEvent( "entity_killed",Dynamic_Wrap(  SpawnSystem,"OnKilled"), self )
	SpawnSystem:InitDungeonSpawn()
end

function SpawnSystem:InitDungeonSpawn()
	PrintTestLog("Init_shuaguai")

	local spawner = SpawnSystem.DungeonSpawner
	for _,Dungeon in pairs(spawner) do

		for ent,unit in pairs(Dungeon) do
	
			if lua_string_split(ent,"_")[1] == "place" then
			
				local place=lua_string_split(unit,",")

				Timers:CreateTimer(tonumber(place[4]),function()
						local unit= CreateUnitByName(place[5], Vector(place[1],place[2],place[3]), true, nil, nil, DOTA_TEAM_BADGUYS )
						unit:SetForwardVector(RandomVector(1))
						unit.spawnplace=Vector(place[1],place[2],place[3])
						unit.spawntime= tonumber(place[4])
					end)
				
			end

		end
	end
end

function SpawnSystem:OnKilled(keys)
	local killedUnit = EntIndexToHScript( keys.entindex_killed )
	if lua_string_split(killedUnit:GetUnitName(),"_")[1]=="fb" then
		local name=killedUnit:GetUnitName()
		local spawnplace=killedUnit.spawnplace
		local spawntime=killedUnit.spawntime
		Timers:CreateTimer(killedUnit.spawntime,function()
			local unit= CreateUnitByName(name, spawnplace, true, nil, nil, DOTA_TEAM_BADGUYS )
			unit:SetForwardVector(RandomVector(1))
			unit.spawnplace=spawnplace
			unit.spawntime=spawntime
		end)
	end
end

function GameOver(keys)
	PrintTestLog("GameOver")
	GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
end
require('Utils.common')