

if PylAI == nil then
	PylAI = class({})
end
function PylAI:Init(entity)
	local UnitAI = {}
	UnitAI._entity=entity
	function UnitAI:GoToSpawner(name)
		local spawner = UnitAI._entity.SpawnEnt
		
		local distance=GetDistance(spawner,UnitAI._entity)
		if distance>=200 then
		UnitAI._entity:SetContextThink(DoUniqueString("GoToSpawner"),
			function() 
				local newOrder = {
			 		UnitIndex = UnitAI._entity:entindex(), 
			 		OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
			 		 TargetIndex = nil, --Optional.  Only used when targeting units
			 		AbilityIndex = 0, --Optional.  Only used when casting abilities
			 		Position = spawner:GetOrigin() , --Optional.  Only used when targeting the ground
			 		Queue = 0 --Optional.  Used for queueing up abilities
				 	}
				ExecuteOrderFromTable(newOrder) 
			end,0)

		end
	end

	function UnitAI:CastAbilityRandomUnit(ability)
		UnitAI._entity:SetContextThink(DoUniqueString("CastAbilityRandomUnit"),
			function() 
				local unit = PylAI:FindRadiusOneUnit(UnitAI._entity,300)
				ability:SetLevel(1)
				if unit~=nil and unit:IsNull()==false and ability:IsCooldownReady() then
					PylAI:CastAbility(UnitAI._entity,ability)
				end
			end
		,0)
	end

	function UnitAI:CreateBaseAI(MAXDIS,MAXHATEDIS)
		if UnitAI._entity.IsAIstart == true then
			local spanwer_name
			local SpawnEnt = UnitAI._entity.SpawnEnt
			if SpawnEnt ~= nil and SpawnEnt:GetName()  ~= nil then
				spanwer_name =  SpawnEnt:GetName()
			end

			if spanwer_name~=nil then
				if PylAI:FindRadiusOneUnit(UnitAI._entity,MAXHATEDIS)==nil then
					UnitAI:GoToSpawner(spanwer_name)
				end

				local unitName = UnitAI._entity:GetUnitName()
				local findNum =  string.find(unitName, 'BOSS')

				if findNum ~= nil then
					local ability=UnitAI._entity:GetAbilityByIndex(1)

					if ability ~= nil then
						UnitAI:CastAbilityRandomUnit(ability)
					end
				end
			   
			    local spawnerEnt=Entities:FindByName(nil,spanwer_name)
			    local  distance =GetDistance(spawnerEnt,UnitAI._entity)
			    if distance>=MAXDIS then
			    	UnitAI:GoToSpawner(spanwer_name)
			    end
			end
		end
	end
	return UnitAI
end
--施法
function PylAI:CastAbility( unit,ability)
	
	if ability:IsUnitTarget() then
		print(unit:GetUnitName().." Cast "..ability:GetAbilityName())
		local teams = DOTA_UNIT_TARGET_TEAM_ENEMY
	    local types =  DOTA_UNIT_TARGET_HERO
	    local flags = 0
	    local target = PylAI:FindRadiusOneUnit( unit,ability:GetCastRange(),teams,types,flags)
		if target then
			unit:CastAbilityOnTarget(target,ability,target:GetPlayerOwnerID())
			print("target:",target:GetUnitName())
		end
	elseif ability:IsPoint() or ability:GetBehavior() == 24 then
		print(unit:GetUnitName().." Cast "..ability:GetAbilityName())
		local teams = DOTA_UNIT_TARGET_TEAM_ENEMY
	    local types =  DOTA_UNIT_TARGET_HERO
	    local flags = 0
	    local target = PylAI:FindRadiusOneUnit( unit,ability:GetCastRange(),teams,types,flags)
	    print(target:GetUnitName())
	    if target then
			unit:CastAbilityOnPosition(target:GetOrigin(),ability,target:GetPlayerOwnerID())
		end
	elseif ability:IsNoTarget() then
		print("IsNoTarget()")
		print(unit:GetUnitName().." Cast "..ability:GetAbilityName())
		ability:CastAbility()
	end
end

function PylAI:FindRadiusOneUnit( entity, range)
	local enemies = FindUnitsInRadius( DOTA_TEAM_BADGUYS, entity:GetOrigin(), nil, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, 0, false )
	if #enemies > 0 then
		local index = RandomInt( 1, #enemies )
		return enemies[index]
	else
		return nil
	end
end

function PylAI:WeakestEnemyHeroInRange( entity, range )
	local enemies = FindUnitsInRadius( DOTA_TEAM_BADGUYS, entity:GetOrigin(), nil, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, 0, false )
	if enemies ~= nil then
		local minHP = nil
		local target = nil 

		for _,enemy in pairs(enemies) do
			local distanceToEnemy = (entity:GetOrigin() - enemy:GetOrigin()):Length()
			local HP = enemy:GetHealth()
			if enemy:IsAlive() and (minHP == nil or HP < minHP) and distanceToEnemy < range then
				minHP = HP
				target = enemy
			end
		end
	end

	return target
end


require("Utils.common")