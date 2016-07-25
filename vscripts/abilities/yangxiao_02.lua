function begin_slice(event)
	local caster = event.caster
	local ability = event.ability
	StartAnimation(caster, {duration=0.84, activity=ACT_DOTA_OVERRIDE_ABILITY_4, rate=0.8})
	ability.liftVelocity = 20
	ability.fallVelocity = 0
	ability.forwardVector = caster:GetForwardVector()
	slice_think(event)
	local a_c_level = 2
	if a_c_level > 0 then
		gust(caster, ability.forwardVector, ability, a_c_level)
		ability.a_c_damage = a_c_level*70
	end
	ability.b_c_level = 2
	ability.c_c_level =2

	Filters:CastSkillArguments(3, caster)
end

function cooldownEnd(event)
	local ability = event.ability
	local caster = event.caster
	local level = caster:FindAbilityByName("odachi_rush"):GetLevel()
  	ability:SetLevel(level)
  	caster:SwapAbilities("odachi_slice", "odachi_rush", true, false)	
end

function gust(caster, fv, ability, a_c_level)
	local start_radius = 200
	local end_radius = 200
	local range = a_c_level*15 + 470
	local casterOrigin = caster:GetAbsOrigin()
	local speed = 900
	local info = 
	{
			Ability = ability,
        	EffectName = "particles/units/heroes/hero_dragon_knight/monk_ulti.vpcf",
        	vSpawnOrigin = casterOrigin+fv*30+Vector(0,0,10),
        	fDistance = range,
        	fStartRadius = start_radius,
        	fEndRadius = end_radius,
        	Source = caster,
        	StartPosition = "attach_sword",
        	bHasFrontalCone = true,
        	bReplaceExisting = false,
        	iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        	iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        	iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        	fExpireTime = GameRules:GetGameTime() + 4.0,
		bDeleteOnHit = false,
		vVelocity = fv * speed,
		bProvidesVision = false,
	}
	projectile = ProjectileManager:CreateLinearProjectile(info)	
end

function gust_hit(event)
	local target = event.target
	local ability = event.ability
	local caster = event.caster
	local damage = ability.a_c_damage
	ApplyDamage({ victim = target, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })	
	ability:ApplyDataDrivenModifier(caster, target, "modifier_odachi_gust", {duration = 2})
end

function slice_think(event)
	local caster = event.caster
	EmitSoundOn("Hero_Juggernaut.PreAttack", caster)
	local casterOrigin = caster:GetAbsOrigin()
	-- caster:SetAbsOrigin(casterOrigin+Vector(0,0,30))
	local position = casterOrigin + caster:GetForwardVector()*160
	local radius = 180
	local damage = event.damage
	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), GetGroundPosition(position, caster), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, FIND_ANY_ORDER, false )
	local modifierKnockback =
	{
		center_x = casterOrigin.x,
		center_y = casterOrigin.y,
		center_z = casterOrigin.z,
		duration = 0.18,
		knockback_duration = 0.18,
		knockback_distance = 80,
		knockback_height = 15,
	}
      
	if #enemies > 0 then
		EmitSoundOn("Hero_Juggernaut.Attack", caster)
		if #enemies > 6 then
			EmitSoundOn("Hero_Juggernaut.Attack", caster)
		end
		if #enemies > 10 then
			EmitSoundOn("Hero_Juggernaut.Attack", caster)
		end
		for _,enemy in pairs(enemies) do
			enemy:AddNewModifier( unit, nil, "modifier_knockback", modifierKnockback )
			if damage then
				Filters:TakeArgumentsAndApplyDamage(enemy, caster, damage, DAMAGE_TYPE_PHYSICAL, 3)	
			end
		end
	end 	
end

function slice_lifting(event)
	local caster = event.caster
	local ability = event.ability
	ability.liftVelocity = ability.liftVelocity-2
	local position = caster:GetAbsOrigin() + Vector(0,0,ability.liftVelocity)

end

function slice_falling(event)
	local caster = event.caster
	local ability = event.ability
	ability.fallVelocity = ability.fallVelocity + 2
	local position = caster:GetAbsOrigin() - Vector(0,0,ability.fallVelocity)

	if position.z - GetGroundPosition(position, caster).z < 26 then
		caster:RemoveModifierByName("modifier_odachi_falling")
	end
end

function falling_end(event)
	local caster = event.caster
	local ability = event.ability
	FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), false)
	if ability.b_c_level > 0 then
	  	local rush = caster:FindAbilityByName("odachi_rush")
	  	if not rush then
	  		rush = caster:AddAbility("odachi_rush")
	  	end
	  	local cooldown = ability:GetCooldownTimeRemaining()
	  	ability:ApplyDataDrivenModifier(caster, caster, "modifier_odachi_slice_cooldown", {duration = cooldown})
	  	rush:SetLevel(ability:GetLevel())
	  	rush:SetAbilityIndex(2)
	  	rush.b_c_level = ability.b_c_level
	  	caster:SwapAbilities("odachi_slice", "odachi_rush", false, true)	
	end
	if ability.c_c_level > 0 then
		 ability:ApplyDataDrivenModifier(caster, caster, "modifier_c_c_spin", {duration = 0.5})
		 StartAnimation(caster, {duration=0.48, activity=ACT_DOTA_OVERRIDE_ABILITY_1, rate=1.2})
		 EmitSoundOn("Hero_Juggernaut.BladeFuryStop", caster)
	end
	-- Timers:CreateTimer(0.7, function()
	-- 	caster:RemoveModifierByName("modifier_rune_c_c")
	-- end)
end

function c_c_think(event)
	local ability = event.ability
	local caster = event.target
	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, 280, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, FIND_ANY_ORDER, false )
	local damage = ability.c_c_level*100 + 100
	for _,enemy in pairs(enemies) do
		ApplyDamage({ victim = enemy, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL })
	end
	if #enemies > 0 then
		EmitSoundOn("Hero_Juggernaut.Attack", caster)
	else
		EmitSoundOn("Hero_Juggernaut.PreAttack", caster)
	end
end

function odachi_rush(event)
	local caster = event.caster
	local ability = event.ability
	local searchPosition = event.caster:GetAbsOrigin() + event.caster:GetForwardVector()*330
	local searchRadius = 350
	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), searchPosition, nil, searchRadius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, FIND_FARTHEST, false )
	if #enemies > 0 then
		local enemy = enemies[1]
		FindClearSpaceForUnit(caster, enemy:GetAbsOrigin()+RandomVector(20), false)
		local newFV = (caster:GetAbsOrigin() - enemy:GetAbsOrigin()):Normalized()
		caster:SetForwardVector(Vector(newFV.x, newFV.y))
		StartAnimation(caster, {duration=0.2, activity=ACT_DOTA_ATTACK, rate=2, translate="odachi"})
		EmitSoundOn("Hero_Juggernaut.Attack", caster)
		ability:ApplyDataDrivenModifier(caster, enemy, "modifier_odachi_rush", {duration = 0.4})
		local damage = ability.b_c_level*0.1*caster:GetAttackDamage()
		ApplyDamage({ victim = enemy, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL })

		local playerID = caster:GetPlayerOwnerID()
		local particleName = "particles/frostivus_herofx/juggernaut_fs_omnislash_tgt.vpcf"
		local pfx = ParticleManager:CreateParticle( particleName, PATTACH_CUSTOMORIGIN, enemy )
		ParticleManager:SetParticleControlEnt(pfx, 0, enemy, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
		PlayerResource:SetCameraTarget(playerID, caster)
		Timers:CreateTimer(0.1, function()
			PlayerResource:SetCameraTarget(playerID, nil)
		end)
		Timers:CreateTimer(0.7, function() 
		  ParticleManager:DestroyParticle( pfx, false )
		end) 	

		
	end
end