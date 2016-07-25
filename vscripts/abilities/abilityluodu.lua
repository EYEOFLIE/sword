function OnLuodu01DealDamage(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local targets = keys.target_entities
	for _,v in pairs(targets) do
		local deal_damage = GetHsjDealDamage( 
				caster, 
				keys.AttributeType, 
				keys.AttributeDamageIncrease, 
				keys.AttributeBaseDamage, 
				ITEM_KIND_STICK, 
				keys.BaseDamage
			)
		local damage_table = {
				victim = v,
				attacker = caster,
				damage = deal_damage,
				damage_type = keys.ability:GetAbilityDamageType(), 
			    damage_flags = keys.ability:GetAbilityTargetFlags()
			}
		UnitDamageTarget(damage_table) 
	end
end

function OnLuodu02DealDamage(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local target = keys.target
	local deal_damage = GetHsjDealDamage( 
				caster, 
				keys.AttributeType, 
				keys.AttributeDamageIncrease, 
				keys.AttributeBaseDamage, 
				ITEM_KIND_STICK, 
				keys.BaseDamage
			)
    local damage_table = {
				victim = target,
				attacker = caster,
				damage = deal_damage/10,
				damage_type = keys.ability:GetAbilityDamageType(), 
			    damage_flags = keys.ability:GetAbilityTargetFlags()
	}
	UnitDamageTarget(damage_table)
end

function OnLuodu03AttackLanded(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local target = keys.target
	local deal_damage = GetHsjDealDamage( 
				caster, 
				keys.AttributeType, 
				keys.AttributeDamageIncrease, 
				keys.AttributeBaseDamage, 
				ITEM_KIND_STICK, 
				keys.BaseDamage
			)
    local damage_table = {
				victim = target,
				attacker = caster,
				damage = deal_damage,
				damage_type = keys.ability:GetAbilityDamageType(), 
			    damage_flags = keys.ability:GetAbilityTargetFlags()
	}
	UnitDamageTarget(damage_table)
	local effectIndex = ParticleManager:CreateParticle("particles/heroes/byakuren/ability_byakuren_02.vpcf",PATTACH_CUSTOMORIGIN_FOLLOW,target)
	ParticleManager:SetParticleControl(effectIndex,0,target:GetOrigin())
	ParticleManager:SetParticleControl(effectIndex,1,target:GetOrigin())
	ParticleManager:SetParticleControl(effectIndex,2,target:GetOrigin())
end

function OnLuodu04Think(keys)
	local caster = keys.caster
	local targets = keys.target_entities
	local deal_damage = GetHsjDealDamage( 
				caster, 
				keys.AttributeType, 
				keys.AttributeDamageIncrease, 
				keys.AttributeBaseDamage, 
				ITEM_KIND_STICK, 
				keys.BaseDamage
			)
	for _,v in pairs(targets) do
		local damage_table = {
				victim = v,
				attacker = caster,
				damage = deal_damage/5,
				damage_type = keys.ability:GetAbilityDamageType(), 
			    damage_flags = keys.ability:GetAbilityTargetFlags()
			}
		UnitDamageTarget(damage_table) 
		local effectIndex = ParticleManager:CreateParticle("particles/units/heroes/hero_omniknight/omniknight_purification_b.vpcf",PATTACH_CUSTOMORIGIN,v)
		ParticleManager:SetParticleControl(effectIndex,0,v:GetOrigin())
		ParticleManager:SetParticleControl(effectIndex,1,v:GetOrigin())
	end
end