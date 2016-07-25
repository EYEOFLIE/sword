function sword_create(event)
	local point=event.target_points[1]
	local caster = event.caster
	local ability = event.ability
	local abilityLevel = ability:GetLevel()-1
	local location = caster:GetOrigin() + caster:GetForwardVector()*Vector(80,80,0)
	

	
	EmitSoundOn("Ability.LagunaBlade", caster)
	StartAnimation(caster, {duration=0.4, activity=ACT_DOTA_CAST_CHAOS_METEOR, rate=0.8})
	partic01 = ParticleManager:CreateParticle( event.effect_name_se, PATTACH_ABSORIGIN, caster )
	
	ParticleManager:SetParticleControl( partic01, 0, Vector(location.x,location.y,2000) )
	ParticleManager:SetParticleControl( partic01, 6, Vector(location.x,location.y,location.z-300) )
	--ParticleManager:SetParticleControl( fxIndex2, 1, Vector(poilocationnt.x,location.y,point.z+300)  )
Timers:CreateTimer(0.25,function ()
	
		 partic02= ParticleManager:CreateParticle( event.effect_name, PATTACH_ABSORIGIN, caster )
		
		 ParticleManager:SetParticleControl( partic02, 0, Vector(point.x,point.y,point.z+300) )
		 ParticleManager:SetParticleControl( partic02, 1, Vector(point.x,point.y,point.z+300)  )

	
		Timers:CreateTimer(0.25,function ( )
			create_effect(event)
		end)	 
	end)	
	 
	
	
	local manaCost = ability:GetManaCost(abilityLevel-1)
	caster:ReduceMana(manaCost)


	Filters:CastSkillArguments(2, caster)
	
end


function create_effect(event)
	
	local caster = event.caster
	local point = event.target_points[1]
	
	local ability = event.ability
	local abilityLevel = ability:GetLevel()-1
	local damageType = ability:GetAbilityDamageType()
	local targetTeam = ability:GetAbilityTargetTeam() -- DOTA_UNIT_TARGET_TEAM_ENEMY
    local targetType = ability:GetAbilityTargetType() -- DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
    local targetFlag = DOTA_UNIT_TARGET_FLAG_NONE
	local damage = ability:GetLevelSpecialValueFor("damage", abilityLevel)
	local duration = ability:GetLevelSpecialValueFor("duration", abilityLevel)
		Timers:CreateTimer(	    	
					function ()
		    		local times = 0
		        	Timers:CreateTimer(
		        	function ()
			        		if times < duration then
								EmitSoundOn("Hero_ElderTitan.EchoStomp",caster)
							    fxIndex = ParticleManager:CreateParticle( event.effect_name_th, PATTACH_CUSTOMORIGIN, caster )
			   					ParticleManager:SetParticleControl( fxIndex, 0, point )
			   					ParticleManager:SetParticleControl( fxIndex, 1, point )
			   					local units = FindUnitsInRadius( caster:GetTeamNumber(), point, caster,300,
					            targetTeam, targetType, targetFlag, 0, false )
				        		for k, v in pairs( units ) do
							        local damageTable =
							        {
							            victim = v,
							            attacker = caster,
							            damage = damage,
							            damage_type = damageType
							        }
							        ability:ApplyDataDrivenModifier(caster, v, "modifier_yangxiao_swordstun", nil)
							        ApplyDamage( damageTable )
					    		end 
			   					
			   					times = times + 1
							    return 1
			        		end
			        	end	
		        	)

		    	end	
	    	)
	
	
		
end
function Destroy(event)

 PrintTable(event)
end
