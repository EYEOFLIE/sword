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
    local duration_k=ability:GetLevelSpecialValueFor("duration", ability_level)
    EmitSoundOn("Hero_FacelessVoid.Chronosphere",keys.caster)
    local  fxIndex = ParticleManager:CreateParticle( "particles/hero_pp/qiankun.vpcf", PATTACH_CUSTOMORIGIN, caster )
   
    ParticleManager:SetParticleControl( fxIndex, 0, point )
    ParticleManager:SetParticleControl( fxIndex, 1, Vector(400,400,0) )
    Timers:CreateTimer(duration_k,
        function()
        	ParticleManager:DestroyParticle(fxIndex,false)
        end
    )
    Timers:CreateTimer(2,
        function()
        	local times = 0
        	Timers:CreateTimer(
		        function()
		        	if times < duration_k-2 then

				    local fxIndex2 = ParticleManager:CreateParticle( "particles/hero_pp/ember_spirit_hit_warp.vpcf", PATTACH_CUSTOMORIGIN, caster )
				     ParticleManager:SetParticleControl( fxIndex2, 0, point )
					end
					times=times+1
					return 1
				end
				)
        end
    )

    Timers:CreateTimer(1,
        function()
        	local times = 0
        	Timers:CreateTimer(
		        function()
		        	if times < duration_k*10 then
		        		local units = FindUnitsInRadius(caster:GetTeamNumber(), point, nil, 420, targetTeam, targetType, targetFlag, FIND_CLOSEST, false)
		        		for _,unit in ipairs(units) do
					        local unit_location = unit:GetAbsOrigin()
					        local vector_distance = point - unit_location
					        local distance = (vector_distance):Length2D()
					        local direction = (vector_distance):Normalized()
					        local speed = distance / 20
							ability:ApplyDataDrivenModifier(caster, unit, "modifier_space_barrier", {duration = 0.2})
							    unit:SetAbsOrigin(unit_location + direction * speed)
							    unit:AddNewModifier(nil, nil, "modifier_phased", {duration=0.2})
					    end
		        		times = times + 1
		        		return 0.1
		        	end
		        end
		    )
        end
    )
    Timers:CreateTimer(1,
        function()
        	local times = 0
        	Timers:CreateTimer(
		        function()
		        	if times < duration_k*2 then
		        		local barrierunits = FindUnitsInRadius( caster:GetTeamNumber(), point, caster, 400,
					            targetTeam, targetType, targetFlag, 0, false )
		        		for k, v in pairs( barrierunits ) do
					        local damageTable =
					        {
					            victim = v,
					            attacker = caster,
					            damage = barrier_damage,
					            damage_type = damageType
					        }
					        ApplyDamage( damageTable )
					    end
		        		
						local castDistance = RandomInt( 10, 350 )
					    local angle = RandomInt( 0, 90 )
					    local dy = castDistance * math.sin( angle )
					    local dx = castDistance * math.cos( angle )
					    local attackPoint = Vector( 0, 0, 0 )
					    attackPoint = Vector( point.x - dx, point.y + dy, point.z )
				   	    local fxIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_sanity_eclipse_area_embers_orbit.vpcf", PATTACH_CUSTOMORIGIN, caster )
					    ParticleManager:SetParticleControl( fxIndex, 0, attackPoint )
					    Timers:CreateTimer(2,
					        function()
					        	ParticleManager:DestroyParticle(fxIndex,false)
					        end
					    )
					    EmitSoundOn("Hero_ObsidianDestroyer.SanityEclipse.Cast",keys.caster)
		        		times = times + 1
		        		return 0.5
		        	end
		        end
		    )
        end
    )
end