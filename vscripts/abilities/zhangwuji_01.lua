function begin_splitshot(event)
	-- Dungeons:Debug()
	-- local cheats = Convars:GetBool("developer")
	-- print(cheats)
	local caster = event.caster
	local ability = event.ability
	local abilityLevel = ability:GetLevel()
	local location = caster:GetOrigin() + caster:GetForwardVector()*Vector(80,80,0)
	local forwardVector = caster:GetForwardVector()
	local num=event.num
	
	local range=event.range
	ability.fv = forwardVector
	ability.damage = event.damage
	EmitSoundOn("Hero_Invoker.Invoke", caster)
	projectileParticle = event.effect_name
	Timers:CreateTimer(1*0.20,
	  function()
		for i=-math.ceil(num/2-1), math.ceil(num/2-1), 1 do 
			
			rotatedVector = rotateVector(forwardVector, math.pi/20*i)
			arrowOrigin = location
			create_shot2(abilityLevel, caster,  forwardVector, ability, arrowOrigin, rotatedVector, range, damage, projectileParticle)
		end
		local manaCost = ability:GetManaCost(abilityLevel-1)

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

	EmitSoundOn("Hero_EarthSpirit.StoneRemnant.Impact",target)
	particleID=ParticleManager:CreateParticle(event.effect_name, PATTACH_ABSORIGIN_FOLLOW,target)
	ParticleManager:SetParticleControl(particleID,3,target:GetOrigin())
	Filters:TakeArgumentsAndApplyDamage(target, caster, damage, DAMAGE_TYPE_MAGICAL, 2)
	
	local point = target:GetAbsOrigin()-ability.fv*100
	local knockbackDuration = 1*0.05
	local knockbackDistance = 100 + 1*10
	local modifierKnockback =
	{
		center_x = point.x,
		center_y = point.y,
		center_z = point.z,
		duration = knockbackDuration,
		knockback_duration = knockbackDuration,
		knockback_distance = knockbackDistance,
		knockback_height = 120,
	}
	if not target:HasModifier("modifier_knockback_immune") then
    	target:AddNewModifier( caster, nil, "modifier_knockback", modifierKnockback )
    	ability:ApplyDataDrivenModifier(caster, target, "modifier_knockback_immune", {duration = 2.1})
	end
	
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
