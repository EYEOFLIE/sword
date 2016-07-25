if WallPhysics == nil then
  WallPhysics = class({})
end

function WallPhysics:FindNearestObstruction(point)
	local eventBlocker = WallPhysics:FindEventObstructions(point)
	if not eventBlocker then
		return Entities:FindByNameNearest("wallObstruction", point, 1500)
	else
		return eventBlocker
	end
end

function WallPhysics:FindEventObstructions(point)
	point = point*Vector(1,1,0)
	if Dungeons.blocker1 then
		local blockerPos = Dungeons.blocker1:GetAbsOrigin()*Vector(1,1,0)
		if (point - blockerPos):Length2D() < 90 then			
			return Dungeons.blocker1
		end
	end
	if Dungeons.blocker2 then
		local blockerPos = Dungeons.blocker2:GetAbsOrigin()*Vector(1,1,0)
		if (point - blockerPos):Length2D() < 90 then			
			return Dungeons.blocker2
		end
	end
	if Dungeons.blocker3 then
		local blockerPos = Dungeons.blocker3:GetAbsOrigin()*Vector(1,1,0)
		if (point - blockerPos):Length2D() < 90 then			
			return Dungeons.blocker3
		end
	end
	if Dungeons.blocker4 then
		local blockerPos = Dungeons.blocker4:GetAbsOrigin()*Vector(1,1,0)
		if (point - blockerPos):Length2D() < 90 then			
			return Dungeons.blocker4
		end
	end
	if Dungeons.blocker5 then
		local blockerPos = Dungeons.blocker5:GetAbsOrigin()*Vector(1,1,0)
		if (point - blockerPos):Length2D() < 90 then			
			return Dungeons.blocker5
		end
	end

	return false
end

function WallPhysics:ShouldBlockUnit(obstruction, point)
	if obstruction then
		local distance = WallPhysics:GetDistance(obstruction:GetAbsOrigin()*Vector(1,1,0), point)
		print(obstruction:GetAbsOrigin())
		print(point)
		print("distance to wall"..distance)
		if distance > 100 then
			return false
		else
			return true
		end
	else
		return false
	end
end

function WallPhysics:GetDistance(a,b)
    local x, y, z = a.x-b.x, a.y-b.y, a.z-b.z
    return math.sqrt(x*x+y*y+z*z)
end

function WallPhysics:WallSearch(startPoint, endPoint)
	startPointNoZ = startPoint*Vector(1,1,0)
	endPointNoZ = endPoint*Vector(1,1,0)
	local distance = WallPhysics:GetDistance(startPointNoZ, endPointNoZ)
	local normal = (endPoint-startPoint):Normalized()*Vector(1,1,0)
	local checkCount = distance/95
	for i = 1, checkCount, 1 do
		print(startPointNoZ+normal*i*95)
		local obstruction = WallPhysics:FindNearestObstruction(startPointNoZ+normal*i*95)
		local block = WallPhysics:ShouldBlockUnit(obstruction, startPointNoZ+normal*i*95) 
		if block then
			return startPoint+normal*(i-1)*95
		end
	end
	return endPoint
end

function WallPhysics:SetAllWallObstructions()
	local walls = Entities:FindAllByName("wallObstruction")
	for i = 1, #walls, 1 do
		walls[i]:SetAbsOrigin(walls[i]:GetAbsOrigin()*Vector(1,1,0))
	end
end

function WallPhysics:round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function WallPhysics:ShouldBlockUnitTwo(point)
	local walls = Entities:FindByNameNearest("wallObstruction", point, 90)
	if walls then
		if #walls > 0 then
			return true
		else
			return false
		end
	else
		return false
	end
end

function WallPhysics:rotateVector(vector, radians)
   XX = vector.x	
   YY = vector.y
   
   Xprime = math.cos(radians)*XX -math.sin(radians)*YY
   Yprime = math.sin(radians)*XX +math.cos(radians)*YY

   vectorX = Vector(1,0,0)*Xprime
   vectorY = Vector(0,1,0)*Yprime
   rotatedVector = vectorX + vectorY
   return rotatedVector
   
end

function WallPhysics:Jump(unit, forwardVector, propulsion, liftForce, liftDuration, gravity)
	local gameMaster = Events.GameMaster
	local gameMasterAbil = gameMaster:FindAbilityByName("npc_abilities")
	local jumpingModifier = "modifier_jumping"
	gameMasterAbil:ApplyDataDrivenModifier(gameMaster, unit, "modifier_jumping", {duration = 5})
	for i = 1, liftDuration, 1 do
		Timers:CreateTimer(0.03*i, function()
			local currentPosition = unit:GetAbsOrigin()
			local newPosition = currentPosition+forwardVector*propulsion+Vector(0,0,liftForce-i*gravity)
			unit:SetAbsOrigin(newPosition)
		end)
	end
	local fallLoop = 0
	Timers:CreateTimer(0.03*liftDuration+0.03, function()
		Timers:CreateTimer(0.03*fallLoop, function()
			fallLoop = fallLoop + 1
			local currentPosition = unit:GetAbsOrigin()
			local newPosition = currentPosition+forwardVector*propulsion-Vector(0,0,fallLoop*gravity)
			unit:SetAbsOrigin(newPosition)
			if newPosition.z - GetGroundPosition(newPosition, unit).z < 10 then
				unit:RemoveModifierByName("modifier_jumping")
				FindClearSpaceForUnit(unit, newPosition, false)
				WallPhysics:UnitLand(unit)
			else
				return 0.03
			end
		end)
	end)
end

function WallPhysics:UnitLand(unit)
	local caster = unit
	if caster.jumpEnd then
		if caster.jumpEnd == "catapult" then
			EmitSoundOn("Hero_Gyrocopter.CallDown.Damage", caster)
			particleName = "particles/units/heroes/hero_warlock/warlock_rain_of_chaos.vpcf"
			local particle1 = ParticleManager:CreateParticle( particleName, PATTACH_CUSTOMORIGIN, caster )
			ParticleManager:SetParticleControl( particle1, 0, caster:GetAbsOrigin() )
			Timers:CreateTimer(5, 
				function()
				ParticleManager:DestroyParticle( particle1, false )
			end)
			caster:SetModel("models/development/invisiblebox.vmdl")
			caster:SetOriginalModel("models/development/invisiblebox.vmdl")			
			Timers:CreateTimer(1, function()
				UTIL_Remove(caster)
			end)
			local casterPos = caster:GetAbsOrigin()
			local modifierKnockback =
			{
				center_x = casterPos.x,
				center_y = casterPos.y,
				center_z = casterPos.z,
				duration = 0.4,
				knockback_duration = 0.4,
				knockback_distance = 280,
				knockback_height = 220
			}
      
			local enemies = FindUnitsInRadius( caster:GetTeamNumber(), casterPos, nil, 400, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, FIND_ANY_ORDER, false )
			if #enemies > 0 then
				for _,enemy in pairs(enemies) do
					enemy:AddNewModifier( unit, nil, "modifier_knockback", modifierKnockback )
					ApplyDamage({ victim = enemy, attacker = caster, damage = 500, damage_type = DAMAGE_TYPE_MAGICAL })
				end
			end 
		end
	end
end