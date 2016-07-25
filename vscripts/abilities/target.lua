function targetaddeffect(event)
	local caster=event.caster
	
	partic01 = ParticleManager:CreateParticle( event.effectName, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControlEnt(partic01, 7, caster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
	
	partic02 = ParticleManager:CreateParticle( event.effectName_se, PATTACH_OVERHEAD_FOLLOW, caster )
	ParticleManager:SetParticleControl(partic02, 0, caster:GetOrigin())

	
	caster.partic01=partic01
	caster.partic02=partic02
end

function targetremoveeffect(event)
	local caster=event.caster
	
	ParticleManager:DestroyParticle(caster.partic01, true)
	ParticleManager:DestroyParticle(caster.partic02, true)
end