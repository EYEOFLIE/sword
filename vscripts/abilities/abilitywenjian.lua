function OnWenjian01SpellStart(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local targets = keys.target_entities

	local deal_damage = 
	(
		( 	  GetAttributeByAttributeType(caster,keys.AttributeType)
	    	* keys.AttributeDamageIncrease
	    	+ keys.AttributeBaseDamage
	    )
	    	* GetEquipMulti(caster,ITEM_KIND_SWORD)
	    	+ keys.BaseDamage
	    	* (caster:GetLevel()/10+1)
	)* math.pow(2,GetHeroMultiState(caster))

	for _,v in pairs(targets) do
		local damage_table = {
			    victim = v,
			    attacker = caster,
			    damage = deal_damage,
			    damage_type = keys.ability:GetAbilityDamageType(), 
	    	    damage_flags = keys.ability:GetAbilityTargetFlags()
		}
		UnitDamageTarget(damage_table)
		local effectIndex = ParticleManager:CreateParticle("particles/heroes/wenjian/wenjian_01_effect_explosion.vpcf",PATTACH_CUSTOMORIGIN_FOLLOW,v)
		ParticleManager:SetParticleControl(effectIndex,0,v:GetOrigin())
		ParticleManager:SetParticleControl(effectIndex,2,v:GetOrigin())
		ParticleManager:SetParticleControl(effectIndex,3,v:GetOrigin())
	end
end

function OnWenjian02SpellStart(keys)
	--PrintTable(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	caster.EquipMultiAbility = caster.EquipMultiAbility + keys.EquipMulti
	caster:SetContextThink("ability_wenjian02_modifier_timer", 
			function()
				caster.EquipMultiAbility = caster.EquipMultiAbility - keys.EquipMulti
				return nil
			end, 
		keys.Duration
	)
end

function OnWenjian03AttackLanded(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local target = keys.target
	local deal_damage = 
	(
		( 	  GetAttributeByAttributeType(caster,keys.AttributeType)
	    	* keys.AttributeDamageIncrease
	    	+ keys.AttributeBaseDamage
	    )
	    	* GetEquipMulti(caster,ITEM_KIND_SWORD)
	    	+ keys.BaseDamage
	    	* (caster:GetLevel()/10+1)
	)* math.pow(2,GetHeroMultiState(caster))
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

function OnWenjian03Kill(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	if(caster.ability_wenjian03_kill_count==nil)then
		caster.ability_wenjian03_kill_count = 0
	else
		caster.ability_wenjian03_kill_count = caster.ability_wenjian03_kill_count + 1
	end

	if(caster.ability_wenjian03_kill_count >= 10) then
		caster.ability_wenjian03_kill_count = 0
		caster:SetBaseAgility(caster:GetBaseAgility()+1)
	end
end