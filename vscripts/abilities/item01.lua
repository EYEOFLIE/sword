function addeffect( event )
	local caster = event.caster
	
	local caoyao_01_1=Entities:FindByName(nil, "caoyao_01_1")
	local caoyao_01_2=Entities:FindByName(nil, "caoyao_01_2")
	local caoyao_01_3=Entities:FindByName(nil, "caoyao_01_3")
	local caoyao_01_4=Entities:FindByName(nil, "caoyao_01_4")
	local caoyao_01_5=Entities:FindByName(nil, "caoyao_01_5")
	local caoyao_01_6=Entities:FindByName(nil, "caoyao_01_6")
	
	if GameRules:GetGameTime()>10 then
		local caoyaotable={}
		caster.caoyaotable=caoyaotable
		caster:RemoveModifierByName("caoyao_ability_unit")
		local particle_caoyao_01_1 = ParticleManager:CreateParticle("particles/econ/courier/courier_axolotl_ambient/courier_axolotl_ambient_lvl4_head.vpcf", PATTACH_ABSORIGIN, caster )
		ParticleManager:SetParticleControl(particle_caoyao_01_1, 0,caoyao_01_1:GetOrigin())
		ParticleManager:SetParticleControl(particle_caoyao_01_1, 1,caoyao_01_1:GetOrigin())
		caster.caoyaotable["caoyao_01_1"]=particle_caoyao_01_1
		
		local particle_caoyao_01_1 = ParticleManager:CreateParticle("particles/econ/courier/courier_axolotl_ambient/courier_axolotl_ambient_lvl4_head.vpcf", PATTACH_ABSORIGIN, caster )
		ParticleManager:SetParticleControl(particle_caoyao_01_1, 0,caoyao_01_2:GetOrigin())
		ParticleManager:SetParticleControl(particle_caoyao_01_1, 1,caoyao_01_2:GetOrigin())
		caster.caoyaotable["caoyao_01_2"]=particle_caoyao_01_1

		local particle_caoyao_01_1 = ParticleManager:CreateParticle("particles/econ/courier/courier_axolotl_ambient/courier_axolotl_ambient_lvl4_head.vpcf", PATTACH_ABSORIGIN, caster )
		ParticleManager:SetParticleControl(particle_caoyao_01_1, 0,caoyao_01_3:GetOrigin())
		ParticleManager:SetParticleControl(particle_caoyao_01_1, 1,caoyao_01_3:GetOrigin())
		caster.caoyaotable["caoyao_01_3"]=particle_caoyao_01_1

		local particle_caoyao_01_1 = ParticleManager:CreateParticle("particles/econ/courier/courier_axolotl_ambient/courier_axolotl_ambient_lvl4_head.vpcf", PATTACH_ABSORIGIN, caster )
		ParticleManager:SetParticleControl(particle_caoyao_01_1, 0,caoyao_01_4:GetOrigin())
		ParticleManager:SetParticleControl(particle_caoyao_01_1, 1,caoyao_01_4:GetOrigin())
		caster.caoyaotable["caoyao_01_4"]=particle_caoyao_01_1

		local particle_caoyao_01_1 = ParticleManager:CreateParticle("particles/econ/courier/courier_axolotl_ambient/courier_axolotl_ambient_lvl4_head.vpcf", PATTACH_ABSORIGIN, caster )
		ParticleManager:SetParticleControl(particle_caoyao_01_1, 0,caoyao_01_5:GetOrigin())
		ParticleManager:SetParticleControl(particle_caoyao_01_1, 1,caoyao_01_5:GetOrigin())
		caster.caoyaotable["caoyao_01_5"]=particle_caoyao_01_1

		local particle_caoyao_01_1 = ParticleManager:CreateParticle("particles/econ/courier/courier_axolotl_ambient/courier_axolotl_ambient_lvl4_head.vpcf", PATTACH_ABSORIGIN, caster )
		ParticleManager:SetParticleControl(particle_caoyao_01_1, 0,caoyao_01_6:GetOrigin())
		ParticleManager:SetParticleControl(particle_caoyao_01_1, 1,caoyao_01_6:GetOrigin())
		caster.caoyaotable["caoyao_01_6"]=particle_caoyao_01_1

		
	end
	-- body
end
