function begin_splitshot(event)
	local caster = event.caster
	local ability = event.ability
	local abilityLevel = ability:GetLevel()
	local location = caster:GetOrigin() + caster:GetForwardVector()*Vector(80,80,0)
	local forwardVector = caster:GetForwardVector()
	local range=event.range
	ability.fv = forwardVector
	ability.damage = event.damage
	EmitSoundOn("Hero_DrowRanger.FrostArrows", caster)
	
  
	  Timers:CreateTimer(0.20,
	  function()
		for i=-1,1, 1 do 
			rotatedVector = rotateVector(forwardVector, math.pi/40*i)
			arrowOrigin = location
			create_shot2(abilityLevel, caster,  forwardVector, ability, arrowOrigin, rotatedVector, range, damage, event.effect_name)
		end
		local manaCost = ability:GetManaCost(abilityLevel)
		caster:ReduceMana(manaCost)
	 end)
  
  Filters:CastSkillArguments(2, caster)
	
end



function create_shot2(abilityLevel, caster,  fv, arrowAbility, arrowOrigin, rotatedVector, range, damage, projectileParticle)
		local start_radius = 110
		local end_radius = 110
		local speed = 1100

		local info = 
		{
				Ability = arrowAbility,
		    	EffectName = projectileParticle,
		    	vSpawnOrigin = arrowOrigin,
		    	fDistance = range,
		    	fStartRadius = start_radius,
		    	fEndRadius = end_radius,
		    	Source = caster,
		    	StartPosition = "attach_origin",
		    	bHasFrontalCone = true,
		    	bReplaceExisting = false,
		    	iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		    	iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		    	iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		    	fExpireTime = GameRules:GetGameTime() + 5.0,
			bDeleteOnHit = false,
			vVelocity = rotatedVector * speed,
			bProvidesVision = false

		}	
		
		projectile = ProjectileManager:CreateLinearProjectile(info)	
end

function arrow_strike(event)
	local target = event.target
	local caster = event.caster
	local ability = event.ability
	local damage = event.ability.damage

	Filters:TakeArgumentsAndApplyDamage(target, caster, damage, DAMAGE_TYPE_MAGICAL, 2)
	
end

function rotateVector(vector, radians)
   XX = vector.x	
   YY = vector.y
   
   Xprime = math.cos(radians)*XX -math.sin(radians)*YY
   Yprime = math.sin(radians)*XX +math.cos(radians)*YY

   vectorX = Vector(1,0,0)*Xprime
   vectorY = Vector(0,1,0)*Yprime
   rotatedVector = vectorX + vectorY
   return rotatedVector
   
end


function CreateIllusion(keys)
	local ItemAbility = keys.ability
	local Target = keys.caster

	for i=1,keys.illusion_num do
		--create_illusion(keys, illusion_origin, illusion_incoming_damage, illusion_outgoing_damage, illusion_duration)	
		illusion=create_illusion(keys,Target:GetAbsOrigin(),keys.illusion_damage_percent_incoming,keys.illusion_damage_percent_outgoing,keys.illusion_duration)
		if (illusion ~= nil) then
			local CasterAngles = Target:GetAnglesAsVector()
			illusion:SetAngles(CasterAngles.x,CasterAngles.y,CasterAngles.z)
			
			illusion:SetHealth(illusion:GetMaxHealth()*Target:GetHealthPercent()*0.01)
			illusion:SetMana(illusion:GetMaxMana()*Target:GetManaPercent()*0.01)
		end
	end
end

function create_illusion(keys, illusion_origin, illusion_incoming_damage, illusion_outgoing_damage, illusion_duration)	
	local player_id = keys.caster:GetPlayerID()
	local caster_team = keys.caster:GetTeam()
	
	local illusion = CreateUnitByName(keys.caster:GetUnitName(), illusion_origin, true, keys.caster, nil, caster_team)  --handle_UnitOwner needs to be nil, or else it will crash the game.
	illusion:SetPlayerID(player_id)
	illusion:SetControllableByPlayer(player_id, true)

	--Level up the illusion to the caster's level.
	local caster_level = keys.caster:GetLevel()
	for i = 1, caster_level - 1 do
		illusion:HeroLevelUp(false)
	end

	--Set the illusion's available skill points to 0 and teach it the abilities the caster has.
	illusion:SetAbilityPoints(0)
	for ability_slot = 0, 15 do
		local individual_ability = keys.caster:GetAbilityByIndex(ability_slot)
		if individual_ability ~= nil then 
			local illusion_ability = illusion:FindAbilityByName(individual_ability:GetAbilityName())
			if illusion_ability ~= nil then
				illusion_ability:SetLevel(individual_ability:GetLevel())
			end
		end
	end

	--Recreate the caster's items for the illusion.
	--[[for item_slot = 0, 5 do
		local individual_item = keys.caster:GetItemInSlot(item_slot)
		if individual_item ~= nil then
			local illusion_duplicate_item = CreateItem(individual_item:GetName(), illusion, illusion)
			illusion:AddItem(illusion_duplicate_item)
		end
	end]]--
	
	-- modifier_illusion controls many illusion properties like +Green damage not adding to the unit damage, not being able to cast spells and the team-only blue particle 
	illusion:AddNewModifier(keys.caster, keys.ability, "modifier_illusion", {duration = illusion_duration, outgoing_damage = illusion_outgoing_damage, incoming_damage = illusion_incoming_damage})
	
	illusion:MakeIllusion()  --Without MakeIllusion(), the unit counts as a hero, e.g. if it dies to neutrals it says killed by neutrals, it respawns, etc.  Without it, IsIllusion() returns false and IsRealHero() returns true.

	return illusion
end

function createquan(keys)
	local ability = keys.ability
	local caster = keys.caster
	local point=keys.target_points
	local targetTeam = ability:GetAbilityTargetTeam() -- DOTA_UNIT_TARGET_TEAM_ENEMY
	local targetType = ability:GetAbilityTargetType() -- DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
	local targetFlag = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES

	local tt= {}
	visionTracer=CreateUnitByName("npc_flying_dummy_vision", point[1], true, nil, nil, DOTA_TEAM_GOODGUYS)
	visionTracer:AddAbility("dummy_unit"):SetLevel(1)
	visionTracer:AddNewModifier( visionTracer, nil, 'modifier_movespeed_cap', nil )
	particleID= ParticleManager:CreateParticle(keys.effect_name, PATTACH_ABSORIGIN_FOLLOW,visionTracer)
	ParticleManager:SetParticleControl(particleID,7,point[1])
	ParticleManager:SetParticleControl(particleID,10,point[1])
 	table.insert(tt, visionTracer)
 	for k,v in pairs(tt) do
		Timers:CreateTimer(10,function ()
			UTIL_Remove(v)
			-- body
		end
		)

 	end
	

	Timers:CreateTimer(
    	function ()
    		local times = 0
        	local interval = 1
        	Timers:CreateTimer(
        	function ()
	        		if times < 10 then
					    local units = FindUnitsInRadius( caster:GetTeamNumber(),point[1], caster, 400,
			            targetTeam, targetType, targetFlag, 0, false )
					    for k,v in pairs ( units ) do
					     	
					     ability:ApplyDataDrivenModifier(caster, v, "modifierthsh", {duration = 1})
					   
					    end
					    times = times + 1
					    return 1
	        		end
	        	end	
        	)

    	end	-- body
    )
end