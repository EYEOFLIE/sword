function addeffect(event)
	
	local caster = event.caster
	local ability = event.ability
	local partic02 = ParticleManager:CreateParticle( "particles/econ/items/disruptor/disruptor_resistive_pinfold/disruptor_ecage_kineticfield.vpcf", PATTACH_CUSTOMORIGIN, caster )
	ParticleManager:SetParticleControl(partic02, 0,Vector(-13764,-7856,2604))
	ParticleManager:SetParticleControl(partic02, 1, Vector(200,1,1))
	ParticleManager:SetParticleControl(partic02, 2, Vector(9999,1,1))
	caster.partic=partic02
	ability:ApplyDataDrivenModifier(caster, caster, "langanshengying", nil)
end

function bofangshenyin(event)
	local caster = event.caster
	local ability = event.ability

	local baojian_path = Entities:FindByName(nil,"baojian_path")
	EmitSoundOn("jineng.langan",baojian_path)
end