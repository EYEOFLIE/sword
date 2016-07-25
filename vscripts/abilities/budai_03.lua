function SpaceBarrier( keys )
	local point = keys.target_points[1]
	local caster = keys.caster
	local ability = keys.ability
	local ability_level = ability:GetLevel() - 1
	local barrier_damage = caster:GetIntellect() * ability:GetLevelSpecialValueFor("damage", ability_level) * 0.5
	local intellect = caster:GetIntellect() * 5
	local casterPos = caster:GetAbsOrigin()
	local damageType = keys.ability:GetAbilityDamageType()
	local targetTeam = ability:GetAbilityTargetTeam() -- DOTA_UNIT_TARGET_TEAM_ENEMY
    local targetType = ability:GetAbilityTargetType() -- DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
    local targetFlag = DOTA_UNIT_TARGET_FLAG_NONE
   EmitSoundOn("Hero_Warlock.Rain_of_chaos_cast",keys.caster)
    local  fxIndex = ParticleManager:CreateParticle( "particles/hero_pp/warlock_rain_of_chaos.vpcf", PATTACH_CUSTOMORIGIN, caster )
   
    ParticleManager:SetParticleControl( fxIndex, 0, point )
 
 


	Timers:CreateTimer(
    	function ()
    		local times = 0
        	local interval = 1
        	Timers:CreateTimer(
        	function ()
	        		if times < 10 then
					    local units = FindUnitsInRadius( caster:GetTeamNumber(),point, caster, 400,
			            targetTeam, targetType, targetFlag, 0, false )
			            local  fxIndex = ParticleManager:CreateParticle( "particles/hero_pp/warlock_rain_of_chaos.vpcf", PATTACH_CUSTOMORIGIN, caster )
   
    					ParticleManager:SetParticleControl( fxIndex, 0, point )
					    for k,v in pairs ( units ) do
					     	
					     ability:ApplyDataDrivenModifier(caster, v, "modifier_space_ddd", {duration = 0.75})
					   
					    end
					    times = times + 1
					    return 1.5
	        		end
	        	end	
        	)

    	end	-- body
    )

    
end