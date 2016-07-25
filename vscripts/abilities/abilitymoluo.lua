function OnMoluo01SpellStart(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local target = keys.target
	caster:SetHealth(caster:GetHealth() + caster:GetMaxHealth() * 0.25)
	local deal_damage = GetHsjDealDamage( 
				caster, 
				keys.AttributeType, 
				keys.AttributeDamageIncrease, 
				keys.AttributeBaseDamage, 
				ITEM_KIND_KNIFE, 
				keys.BaseDamage
			)
	local damage_table = {
				victim = keys.target,
				attacker = caster,
				damage = deal_damage,
				damage_type = keys.ability:GetAbilityDamageType(), 
			    damage_flags = keys.ability:GetAbilityTargetFlags()
			}
	UnitDamageTarget(damage_table) 
	caster:SetBaseStrength(caster:GetBaseStrength() + 1)
	local effectIndex = ParticleManager:CreateParticle("particles/heroes/moluo/ability_moluo01_explosion.vpcf",PATTACH_CUSTOMORIGIN,caster)
	ParticleManager:SetParticleControl(effectIndex,0,target:GetOrigin()+Vector(0,0,128))
end

function OnMoluo02Toggle(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local targets = keys.target_entities
	for _,v in pairs(targets) do
		local deal_damage = GetHsjDealDamage( 
				caster, 
				keys.AttributeType, 
				keys.AttributeDamageIncrease, 
				keys.AttributeBaseDamage, 
				ITEM_KIND_KNIFE, 
				keys.BaseDamage
			)
		local damage_table = {
				victim = v,
				attacker = caster,
				damage = deal_damage/10,
				damage_type = keys.ability:GetAbilityDamageType(), 
			    damage_flags = keys.ability:GetAbilityTargetFlags()
			}
		UnitDamageTarget(damage_table) 
	end
	local damage_table_caster = {
		victim = caster,
		attacker = caster,
		damage = keys.HealthDecrease * GetAttributeByAttributeType(caster,keys.AttributeType) /4,
		damage_type = keys.ability:GetAbilityDamageType(), 
		damage_flags = keys.ability:GetAbilityTargetFlags()
	}
	UnitDamageTarget(damage_table_caster) 
end

function OffMoluo02Toggle(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
end

function OnMoluo03SpellStart(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local targets = keys.target_entities

	local deal_damage = GetHsjDealDamage( 
			caster, 
			keys.AttributeType, 
			keys.AttributeDamageIncrease, 
			keys.AttributeBaseDamage, 
			ITEM_KIND_SWORD, 
			keys.BaseDamage
	)

	for _,v in pairs(targets) do
		local damage_table = {
			    victim = v,
			    attacker = caster,
			    damage = deal_damage,
			    damage_type = keys.ability:GetAbilityDamageType(), 
	    	    damage_flags = keys.ability:GetAbilityTargetFlags()
		}
		UnitDamageTarget(damage_table)
		local effectIndex = ParticleManager:CreateParticle("particles/heroes/moluo/ability_moluo03_explosion.vpcf",PATTACH_CUSTOMORIGIN_FOLLOW,v)
		ParticleManager:SetParticleControl(effectIndex,0,v:GetOrigin())
		ParticleManager:SetParticleControl(effectIndex,3,v:GetOrigin())
	end
end

function OnMoluo04SpellStart(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	caster:SetModelScale(1.5)
	caster:SetModel("models/items/terrorblade/endless_purgatory_demon/endless_purgatory_demon.vmdl")
	caster:SetOriginalModel("models/items/terrorblade/endless_purgatory_demon/endless_purgatory_demon.vmdl")

	-- 清除翅膀
	WingsSystem:ClearWings( caster )

	local HeroMultiStateAbility = caster:GetContext("HeroMultiStateAbility")
	HeroMultiStateAbility = HeroMultiStateAbility + keys.HeroStateMulti
	caster:SetContextNum("HeroMultiStateAbility", HeroMultiStateAbility, 0)
	caster:SetBaseStrength(caster:GetBaseStrength()*2)
	caster:SetBaseAgility(caster:GetBaseAgility()*2)
	caster:SetBaseIntellect(caster:GetBaseIntellect()*2)
	Timer.Wait 'ability_lixinning03_sword_release' (keys.Duration,
			function()
				caster:SetModelScale(1.0)
				HeroMultiStateAbility = HeroMultiStateAbility - keys.HeroStateMulti
				caster:SetContextNum("HeroMultiStateAbility", HeroMultiStateAbility, 0)
				caster:SetBaseStrength(caster:GetBaseStrength()/2)
				caster:SetBaseAgility(caster:GetBaseAgility()/2)
				caster:SetBaseIntellect(caster:GetBaseIntellect()/2)
				caster:SetModel("models/hero_mara/mara.vmdl")
				caster:SetOriginalModel("models/hero_mara/mara.vmdl")

				WingsSystem:CreateWingsForHero( caster )
			end
	    )
end