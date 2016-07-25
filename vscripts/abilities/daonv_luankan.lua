function daonv_chongfeng(event)
	
	local caster = event.caster
	local ability = event.ability
	local target = event.target
	local abilityLevel = ability:GetLevel()
	--caster.targetunite=target
	EmitSoundOn("jineng.chongfeng", caster)
	caster:MoveToTargetToAttack(target)
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_daonv_resetposition", {})
	caster.m_ExecuteOrderFilter_OrderType=0
 	local pfx = ParticleManager:CreateParticle( event.effectname, PATTACH_ABSORIGIN_FOLLOW, caster )
	
	ParticleManager:SetParticleControl(pfx,0,caster:GetOrigin())
	ParticleManager:SetParticleControl(pfx,2,caster:GetOrigin())
	ParticleManager:SetParticleControl(pfx,5,caster:GetOrigin())
	
	--StartAnimation(caster, {duration=10, activity=ACT_DOTA_RUN, rate=0})
   
end
function daonv_think( event )
	 local caster = event.caster
    local ability = event.ability
    local target = event.target
    if caster.m_ExecuteOrderFilter_OrderType==1 then 
    	caster:RemoveModifierByName("modifier_daonv_resetposition")
    	caster:RemoveModifierByName("modifier_daonv_luankan_baoji")
    end
	-- body
end


function daonv_removebaoji( event )
	 local caster = event.caster
    local ability = event.ability

    caster:RemoveModifierByName("modifier_daonv_resetposition")
    caster:RemoveModifierByName("modifier_daonv_luankan_baoji")
    
	-- body
end


function daonv_resetposition(event)

    local caster = event.caster
    local ability = event.ability
    local target = event.target
	local targetTeam = ability:GetAbilityTargetTeam() -- DOTA_UNIT_TARGET_TEAM_ENEMY
	local targetType = ability:GetAbilityTargetType() -- DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
	local targetFlag = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
    local position = caster:GetAbsOrigin() 
    
    if(not(target:IsAlive()))then
    	EndAnimation(caster)
    	caster:RemoveModifierByName("modifier_daonv_resetposition")
    	return 
    end


    local forword=(target:GetOrigin()-caster:GetOrigin()):Normalized()
 	

    newPosition = position +forword*Vector(20,20,40)
    if((target:GetOrigin()-caster:GetOrigin()):Length2D()<200)then 
    	
    	target:RemoveModifierByName("modifier_daonv_resetposition")
    	ability:ApplyDataDrivenModifier(caster, caster, "modifier_daonv_luankan_stun", {duration=2})
    	ability:ApplyDataDrivenModifier(caster, target, "modifier_daonv_luankan_stun", {duration=2})
    	ability:ApplyDataDrivenModifier(caster, target, "modifier_daonv_luankan_taiqi", {duration=2})
		
		
	else
 		caster:SetOrigin(newPosition)
    end

    local units = FindUnitsInRadius(caster:GetTeamNumber(),caster:GetAbsOrigin(), caster, 100,
					            targetTeam, targetType, targetFlag, 0, false )
    for o,t in pairs ( units ) do

    	t:SetOrigin(t:GetOrigin()+forword*Vector(20,20,40))
   		FindClearSpaceForUnit(t, t:GetAbsOrigin(), false)
    end
    
end
function daonv_freshposition(event)
	if 1==1 then return end
    local caster = event.caster
    local ability = event.ability
    FindClearSpaceForUnit(event.caster, caster:GetAbsOrigin(), false)
    
end

function daonv_taiqi(event)
	local caster = event.caster
    local ability = event.ability
    local target = event.target
    	StartAnimation(caster, {duration=2, activity=ACT_DOTA_CAST_COLD_SNAP, rate=1})
		partic = ParticleManager:CreateParticle( "particles/econ/items/rubick/rubick_force_gold_ambient/rubick_telekinesis_force_gold.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	    ParticleManager:SetParticleControlEnt(partic, 0, target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(partic, 1, target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
		ParticleManager:SetParticleControl(partic, 2, Vector(2,0,0))
        target:SetOrigin(target:GetOrigin()+Vector(0,0,100))
    
        Timers:CreateTimer(0.5,
	    	function ()
	    		ability:ApplyDataDrivenModifier(caster, target, "modifier_daonv_luankan_shanghai", {duration=0.1})
				
			end-- body
    	)	

    	Timers:CreateTimer(1,
	    	function ()
	    		ability:ApplyDataDrivenModifier(caster, target, "modifier_daonv_luankan_shanghai", {duration=0.1})
			end	-- body
    	)
    	Timers:CreateTimer(2,
	    	function ()

	    		ability:ApplyDataDrivenModifier(caster, target, "modifier_daonv_luankan_shanghai", {duration=0.1})
	 			
			end	-- body
    	)
		   
    
end

function daonv_damage(event)
	local caster = event.caster
	local target = event.target
    local ability = event.ability
    local damage= caster:GetAttackDamage()*2
    local effectName=event.effectName
	if(not(target:IsAlive())) then

		caster:RemoveModifierByName("modifier_daonv_luankan_stun")
		EndAnimation(caster)
		return
	end
    EmitSoundOn("daonv.attack", caster)
	partic = ParticleManager:CreateParticle( effectName, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControlEnt(partic, 0, target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(partic, 1, target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	local damageTable = 
			     	{
		     			victim = target,
			            attacker = caster,
			            damage = damage,
			            damage_type = DAMAGE_TYPE_PURE
			        }
	ApplyDamage( damageTable )
	
	if(target:IsNull()) then
		StartAnimation(caster, {duration=1, activity=ACT_DOTA_IDLE, rate=1})
		
	end

end


function daonv_fangxia(event)
	local caster = event.caster
    local ability = event.ability
	local target = event.target
    target:SetOrigin(target:GetOrigin()+Vector(0,0,-100))
    partic = ParticleManager:CreateParticle( "particles/econ/items/rubick/rubick_force_gold_ambient/rubick_telekinesis_land_force_gold.vpcf", PATTACH_CUSTOMORIGIN, caster.target )
    ParticleManager:SetParticleControl(partic, 0, target:GetOrigin())
end