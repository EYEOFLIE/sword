function abstart( event )
	local point = event.target_points[1]
	local caster = event.caster
	local ability = event.ability
	local ability_level = ability:GetLevel() - 1
	caster.point=point
    
    ability.forwardVector = caster:GetForwardVector()
    ability:ApplyDataDrivenModifier(caster, caster, "modifier_daonv_life_fei", {duration = 1})
    caster.distence=caster.point-caster:GetOrigin()
    StartAnimation(caster, {duration=1, activity=ACT_DOTA_CAST_GHOST_WALK, rate=1})

    ability.liftVelocity=25
  
    partic03 = ParticleManager:CreateParticle( "particles/wenzi.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster )
    ParticleManager:SetParticleControlEnt(partic03, 3, caster, PATTACH_ABSORIGIN_FOLLOW, "attach_head", caster:GetAbsOrigin(), true)
    
    Timers:CreateTimer(1.2,
        function ()
            event.caster:SetAbsOrigin(point)
            FindClearSpaceForUnit(event.caster, point, false)
            ability:ApplyDataDrivenModifier(caster, caster, "modifier_daonv_life_stun", {duration = 0.2})
            StartAnimation(caster, {duration=1, activity=ACT_DOTA_CAST_ICE_WALL, rate=1.5})
            
        end -- body
    )   
    Timers:CreateTimer(1.2,
        function ()
            EmitSoundOn("daonv.stun", caster)
            
            partic02 = ParticleManager:CreateParticle( "particles/units/heroes/hero_earthshaker/earthshaker_echoslam_start_fallback_mid.vpcf", PATTACH_CUSTOMORIGIN, caster )
            ParticleManager:SetParticleControl(partic02, 0, point+ caster:GetForwardVector()*Vector(250,250,0))
     
        end -- body
    )
   
end

function daonv_damage( event )
    local caster = event.caster
    local ability = event.ability
    local ability_level = ability:GetLevel() - 1
    local target = event.target
    local damage = event.damage
   
    Filters:TakeArgumentsAndApplyDamage(target, caster, damage, DAMAGE_TYPE_MAGICAL, 2)
end


function daonv_lifting(event)

    local caster = event.caster
    local ability = event.ability
    ability.liftVelocity = ability.liftVelocity-1
    local position = caster:GetAbsOrigin() + Vector(0,0,ability.liftVelocity)

    if((position.z-caster.point.z)<0 and (caster.point.z-caster:GetOrigin().z)<0) then
        position=caster.point
    
   end

    newPosition = position+caster.distence/50
    caster:SetOrigin(newPosition)
    
end