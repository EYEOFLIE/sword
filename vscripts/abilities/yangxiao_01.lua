function begin_splitshot(event)

	local caster = event.caster
	local ability = event.ability
	local abilityLevel = ability:GetLevel()
	local location = caster:GetOrigin() + caster:GetForwardVector()*Vector(80,80,0)
	local forwardVector = caster:GetForwardVector()

	local range=event.range
	
	ability.fv = forwardVector
	ability.damage = event.damage
	StartAnimation(caster, {duration=0.6, activity=ACT_DOTA_ATTACK, rate=1.1})
	
	EmitSoundOn("jiannan.jineng1", caster)
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_yangxiao_01", {})
	projectileParticle = event.effect_name
	rotatedVector = rotateVector(forwardVector, 0)
	arrowOrigin = location
	Timers:CreateTimer(0.5,function ()
		EmitSoundOn("Hero_Magnataur.ShockWave.Particle", caster)
		ability:ApplyDataDrivenModifier(caster, caster, "modifier_yangxiao_02", {})
		create_shot2(abilityLevel, caster,  forwardVector, ability, arrowOrigin, rotatedVector, range, damage, projectileParticle)
		-- body
	end)
	

	local manaCost = ability:GetManaCost(abilityLevel-1)
	caster:ReduceMana(manaCost)
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

function jianrenfengbao(keys)
	local ability = keys.ability
	local caster = keys.caster
	local target = keys.target
	local targetTeam = ability:GetAbilityTargetTeam() -- DOTA_UNIT_TARGET_TEAM_ENEMY
	local targetType = ability:GetAbilityTargetType() -- DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
	local targetFlag = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
	local damageType = ability:GetAbilityDamageType()
	local ability_level = ability:GetLevel() - 1 --等级从0开始取
	local abilityDamage = ability:GetLevelSpecialValueFor("damage", ability_level)
	local casterPos = caster:GetAbsOrigin()
	local duration=keys.duration
	
	EmitSoundOn("Hero_Juggernaut.BladeFuryStart", caster)
	StartAnimation(caster, {duration=duration, activity=ACT_DOTA_OVERRIDE_ABILITY_1, rate=1.0})
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_yangxiao_02", {duration =duration})
	local range=ability:GetLevelSpecialValueFor("range", ability_level)
	
		   Timers:CreateTimer(
    	function ()
    		local times = 0
        	local interval = 1
        	Timers:CreateTimer(
        	function ()
	        		if times < duration then
					     local units = FindUnitsInRadius( caster:GetTeamNumber(),caster:GetAbsOrigin(), caster, range,
			            targetTeam, targetType, targetFlag, 0, false )


					    for k,v in pairs( units ) do
					     	local damageTable = 
					     	{
				     			victim = v,
					            attacker = caster,
					            damage = abilityDamage,
					            damage_type = damageType
					        }
					     
					     ApplyDamage( damageTable )
					    EmitSoundOn("Hero_Juggernaut.OmniSlash.Damage", caster)
					     ability:ApplyDataDrivenModifier(caster, v, "modifier_yangxiao_03", {duration = 1})
					   
					    end
					    times = times + 1
					    return 1
	        		end
	        	end	
        	)

    	end	
    )	
 
end

function create(keys )
	local caster = keys.caster
	local casterPos = caster:GetAbsOrigin()
	particleID= ParticleManager:CreateParticle(keys.effect_name, PATTACH_CUSTOMORIGIN_FOLLOW,caster)
	ParticleManager:SetParticleControl(particleID,0,casterPos)
	caster.particleID=particleID
	-- body
end

function destroy(keys )
	local caster = keys.caster
	
	caster:StopSound("Hero_Juggernaut.BladeFuryStart")
	if caster.particleID then
		ParticleManager:DestroyParticle(caster.particleID,true)

	end
	
	-- body
end