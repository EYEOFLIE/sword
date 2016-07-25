function steelbark_think(event)
	local caster = event.caster
	local target = event.target
	if target:GetHealth()/target:GetMaxHealth() <= 0.4 then
		local ability = caster:FindAbilityByName("body_slot")
		ability:ApplyDataDrivenModifier(caster, target, "modifier_body_steelbark_effect", {})
	else
		target:RemoveModifierByName("modifier_body_steelbark_effect")
	end
end

function berserker_attack_landed(event)
	local attacker = event.attacker
	local caster = event.caster
	local ability = event.ability
	local luck = RandomInt(1, 10)
	if luck == 1 then
		ability:ApplyDataDrivenModifier(caster, attacker, "modifier_hand_berserker_state", {duration = 5})
	end
end

function shadow_armlet_take_damage(event)
	local ability = event.ability
	local caster = event.caster
	local attack_damage = event.attack_damage
	local target = event.unit
	local luck = RandomInt(1, 20)
	if luck <=3 then
		attack_damage = WallPhysics:round(attack_damage, 0)
		target:Heal(attack_damage, target)
		PopupHealing(target, attack_damage)
		ability:ApplyDataDrivenModifier(caster, target, "modifier_shadow_armlet_effect", {duration = 1})
	end
end

function boneguard_attack_land(event)
	local target = event.target
	local ability = event.ability
	local attacker = event.attacker
	local luck = RandomInt(1, 20)
	if not ability.skeletonLimit then
		ability.skeletonLimit = 0
	end				
	if luck <=3 then
		if ability.skeletonLimit <= 4 then
			ability.skeletonLimit = ability.skeletonLimit + 1
			local skeleton = CreateUnitByName("basic_skeleton", target:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_GOODGUYS)
			skeleton.summonAbility = ability
			skeleton.owner = attacker:GetPlayerOwnerID()
			skeleton:SetOwner(attacker)

			local skeleHealth = 8400
			skeleton:SetMaxHealth(skeleHealth)
			skeleton:SetBaseMaxHealth(skeleHealth)
			skeleton:SetHealth(skeleHealth)
			skeleton:Heal(skeleHealth, skeleton)

	   		skeleton:SetControllableByPlayer(attacker:GetPlayerID(), true)
	   		skeleton:AddAbility("ability_die_after_time_raise_dead"):SetLevel(1)
	   		local summonAbil = skeleton:AddAbility("ability_summoned_unit")
	   		summonAbil:SetLevel(1)
	   		summonAbil:ApplyDataDrivenModifier(skeleton, skeleton, "modifier_summoned_unit_damage_increase", {duration = 30})
	   		skeleton:SetModifierStackCount( "modifier_summoned_unit_damage_increase", summonAbil, 70)
   		end
   	end
end

function scorch_attack_land(event)
	local target = event.target
	local ability = event.ability
	local attacker = event.attacker
	local caster = event.caster
	local luck = RandomInt(1, 5)		
	if luck == 1 then
		ability.attacker = attacker
		ability:ApplyDataDrivenThinker(caster, target:GetAbsOrigin(), "modifier_hand_scorched_earth_thinker", {})
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_batrider/batrider_firefly.vpcf", PATTACH_CUSTOMORIGIN, target)
		ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 2, target:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 3, target:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 4, target:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 5, target:GetAbsOrigin())
	end
end

function scorched_earth_damage(event)
	local target = event.target
	local ability = event.ability
	local attacker = ability.attacker
	local damage = ability.scorchDamage
	ApplyDamage({ victim = target, attacker = attacker, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })	
end

function pride_attack_land(event)
	local luck = RandomInt(1, 100)
	local caster = event.caster
	local ability = event.ability
	if luck <= 3 then
		for i = 1, #MAIN_HERO_TABLE, 1 do
			ability:ApplyDataDrivenModifier(caster, MAIN_HERO_TABLE[i], "modifier_hand_pride_effect", {duration = 5})
			EmitSoundOn("Hero_Gyrocopter.ART_Barrage.Launch", MAIN_HERO_TABLE[i])
		end
	end
end

function marauder_attack_land(event)
	local attacker = event.attacker
	local caster = event.caster
	local ability = event.ability
    ability:ApplyDataDrivenModifier(caster, attacker, "modifier_hand_marauder_effect", {duration = 7})
    local current_stack = attacker:GetModifierStackCount( "modifier_hand_marauder_effect", ability )
    if current_stack < 50 then
    	attacker:SetModifierStackCount( "modifier_hand_marauder_effect", ability, current_stack+1 )
    end
end

function flood_water_elemental_attack(event)
	print("flood attack")
	local attacker = event.attacker
	if attacker.summoner then
		local caster = attacker.summoner
		local particleName = "particles/items3_fx/mango_active.vpcf"
        local pfx = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN_FOLLOW, caster )
  		ParticleManager:SetParticleControlEnt( pfx, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true )
			Timers:CreateTimer(1, function() 
			  ParticleManager:DestroyParticle( pfx, false )
			end)
		local manaRestore = caster:GetMaxMana()*0.05
		manaRestore = WallPhysics:round(manaRestore, 0)
		caster:GiveMana(manaRestore)
		PopupMana(caster, manaRestore)
	end
end

function BodyProjectileStrike(event)
	local ability = event.ability
	local caster = ability.caster
	local target = event.target
	local primeAttribute = caster:GetPrimaryAttribute()
	local damage = 0
	if primeAttribute == 0 then
		damage = caster:GetStrength()*5
	elseif primeAttribute == 1 then
		damage = caster:GetAgility()*5
	elseif primeAttribute == 2 then
		damage = caster:GetIntellect()*5
	end
	ApplyDamage({ victim = target, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
end

function doomplate_damage(event)
	local target = event.target
	local caster = target.doomplateCaster
	local primeAttribute = caster:GetPrimaryAttribute()
	local damage = 0
	if primeAttribute == 0 then
		damage = caster:GetStrength()*4
	elseif primeAttribute == 1 then
		damage = caster:GetAgility()*4
	elseif primeAttribute == 2 then
		damage = caster:GetIntellect()*4
	end
	ApplyDamage({ victim = target, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_PURE })
end

function hyper_visor_attack_land(event)
	local target = event.target
	local attacker = event.attacker
	local luck = RandomInt(1, 5)
	if luck == 5 then
		local damage = attacker:GetAgility()*4
		local radius = 180
		local enemies = FindUnitsInRadius( attacker:GetTeamNumber(), target:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, FIND_ANY_ORDER, false )
		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				ApplyDamage({ victim = enemy, attacker = attacker, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
			end
		end 	
		local pfx = ParticleManager:CreateParticle( "particles/econ/items/sven/sven_warcry_ti5/hyper_visor.vpcf", PATTACH_CUSTOMORIGIN, target )
		ParticleManager:SetParticleControl( pfx, 0, target:GetAbsOrigin())
		ParticleManager:SetParticleControl( pfx, 1, Vector(radius, 0, 0) )		
		ParticleManager:SetParticleControl( pfx, 3, Vector(0, 0, 0) )	
		Timers:CreateTimer(1.5, function()
			ParticleManager:DestroyParticle(pfx, false)
		end)
		EmitSoundOn("Hero_StormSpirit.Orchid_BallLightning", target)
	end
end

function ruby_dragon_immolation_think(event)
	local caster = event.caster
	local ability = event.ability
	local burnDamage = caster.burnDamage
	local summoner = caster.summoner
		local radius = 180
		local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, FIND_ANY_ORDER, false )
		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				ApplyDamage({ victim = enemy, attacker = summoner, damage = burnDamage, damage_type = DAMAGE_TYPE_MAGICAL })
				ability:ApplyDataDrivenModifier(caster, enemy, "modifier_immolation_burn", {duration = 0.5})
			end
		end 
end

function centaur_horn_think(event)
	local caster = event.target
	caster:RemoveModifierByName("modifier_stunned")
	caster:RemoveModifierByName("modifier_knockback")
end

function wild_nature_struck(event)
	local attacker = event.attacker
	local ability = event.ability
	local caster = event.caster
	local target = event.target
	local luck = RandomInt(1, 10)
	if luck == 10 then
		attacker.entangler = target
		ability:ApplyDataDrivenModifier(caster, attacker, "modifier_wild_nature_entangle_effect", {duration = 3})
	end
end

function wild_nature_entangle_think(event)
	local target = event.target
	local caster = target.entangler
	local primeAttribute = caster:GetPrimaryAttribute()
	local damage = 0
	if primeAttribute == 0 then
		damage = caster:GetStrength()*6
	elseif primeAttribute == 1 then
		damage = caster:GetAgility()*6
	elseif primeAttribute == 2 then
		damage = caster:GetIntellect()*6
	end	
	ApplyDamage({ victim = target, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
end

function odin_attack(event)
	local target = event.target
	local attacker = event.attacker
	local attack_damage = event.attack_damage
	local luck = RandomInt(1, 100)
	if luck >= 98 then
		ApplyDamage({ victim = target, attacker = attacker, damage = attack_damage*9, damage_type = DAMAGE_TYPE_PHYSICAL })
		PopupDamage(target, attack_damage*10)
	end
end

function iron_colossus_think(event)
	local target = event.target
	local ability = event.ability
	local caster = event.caster
	print("colossus think")
	if not ability.attackSpeedLossStacks then
		ability.attackSpeedLossStacks = 0
	end
	if not ability.attackRangeGainStacks then
		ability.attackRangeGainStacks = 0
	end
	if not ability.attackRangeLossStacks then
		ability.attackRangeLossStacks = 0
	end
	local attackSpeedLossIron = ability.attackSpeedLossStacks
	local attackRangeGainIron = ability.attackRangeGainStacks 
	local attackRangeLossIron = ability.attackRangeLossStacks
	print("attackSpeedLoss"..attackSpeedLossIron)
	print("attackRangeGain"..attackRangeGainIron)
	print("attackRangeLoss"..attackRangeLossIron)
	local attackSpeed = WallPhysics:round(target:GetAttackSpeed()*100, 0) + attackSpeedLossIron
	local attackRange = target:GetAttackRange() - attackRangeGainIron + attackRangeLossIron
	print("ATTACK SPEED"..attackSpeed)
	
	if attackRange < 150 then
		if not target:HasModifier("modifier_colossus_attack_range_gain") then
        	ability:ApplyDataDrivenModifier(caster, target, "modifier_colossus_attack_range_gain", {})
    	end
    	target:SetModifierStackCount( "modifier_colossus_attack_range_gain", ability, (150-attackRange))
    	target:RemoveModifierByName("modifier_iron_colossus_attack_range_loss")
    	ability.attackRangeGainStacks = 150-attackRange
	else
		if not target:HasModifier("modifier_iron_colossus_attack_range_loss") then
			ability:ApplyDataDrivenModifier(caster, target, "modifier_iron_colossus_attack_range_loss", {})
		end
    	target:SetModifierStackCount( "modifier_iron_colossus_attack_range_loss", ability, attackRange-150 )
    	target:RemoveModifierByName("modifier_iron_colossus_attack_range_gain")
    	ability.attackRangeLossStacks = attackRange - 150
	end
	if attackSpeed > 120 then
		if not target:HasModifier("modifier_iron_colossus_attack_speed_loss") then
			ability:ApplyDataDrivenModifier(caster, target, "modifier_iron_colossus_attack_speed_loss", {})
		end
    	target:SetModifierStackCount( "modifier_iron_colossus_attack_speed_loss", ability, attackSpeed-120 )
    	ability.attackSpeedLossStacks = attackSpeed - 120
	end
	if attackSpeed < 120 then
		target:RemoveModifierByName("modifier_iron_colossus_attack_speed_loss")
		ability.attackSpeedLossStacks = 0
	end
	if not target:HasModifier("modifier_iron_colossus_attack_damage_increase") then
		ability:ApplyDataDrivenModifier(caster, target, "modifier_iron_colossus_attack_damage_increase", {})
	end
	local damageIncrease = target:GetStrength()*2
	if not (target:GetModifierStackCount( "modifier_iron_colossus_attack_damage_increase", ability ) == damageIncrease) then	
    	target:SetModifierStackCount( "modifier_iron_colossus_attack_damage_increase", ability, damageIncrease)
    	ability.colossus_deltaDamage = damageIncrease
	end
end

function witch_hat_strike(event)
	local ability = event.ability
	local caster = ability.caster
	local target = event.target
	local damage = caster:GetIntellect()*3
	ApplyDamage({ victim = target, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
end

function emerald_douli_damage(event)
	local target = event.unit
	local damage = event.damage
	local manaDamage = WallPhysics:round(damage*0.35,0)
	if target:GetMana() > manaDamage then
		target:Heal(manaDamage, target)
		target:ReduceMana(manaDamage)
	end
end

function tyrius_think(event)
	local target = event.target
	local ability = event.ability
	local caster = event.caster
	if not target:HasModifier("modifier_tyrius_buff") then
		ability:ApplyDataDrivenModifier(caster, target, "modifier_tyrius_buff", {})
	end
	target:SetModifierStackCount( "modifier_tyrius_buff", ability, target:GetStrength() )
end

function ice_quill_spell_cast(event)
	local ability = event.ability
	local target = ability.hero
	local executedAbility = event.event_ability
	if not ability.manaSpent then
		ability.manaSpent = 0
	end
	ability.manaSpent = ability.manaSpent + executedAbility:GetManaCost(executedAbility:GetLevel())
	if ability.manaSpent > 600 then
		ability.manaSpent = 0
		local spikeParticle = "particles/units/heroes/hero_bristleback/ice_quills.vpcf"
		local position = target:GetAbsOrigin()
		local pfx = ParticleManager:CreateParticle( spikeParticle, PATTACH_OVERHEAD_FOLLOW, target )
		ParticleManager:SetParticleControl( pfx, 0, position+Vector(0,0,-100) )
		Timers:CreateTimer(2, function()
			ParticleManager:DestroyParticle(pfx, false)
		end)
		local radius = 550
		local damage = target:GetAttackDamage()*3
		local enemies = FindUnitsInRadius( target:GetTeamNumber(), target:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, FIND_ANY_ORDER, false )
		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				ApplyDamage({ victim = enemy, attacker = target, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
			end
		end 
		EmitSoundOn("Hero_Ancient_Apparition.IceBlastRelease.Tick", target)
	end
end

function gryffin_think(event)
	local caster = event.caster
	local hero = caster.hero
	caster:MoveToPosition(hero:GetAbsOrigin()+RandomVector(RandomInt(50, 200)))
	local allies = FindUnitsInRadius( hero:GetTeamNumber(), caster:GetAbsOrigin(), nil, 440, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, 0, FIND_ANY_ORDER, false )
	if #allies > 0 then
		for _,ally in pairs(allies) do
			local healAmount = WallPhysics:round(ally:GetMaxHealth()*0.02, 0)
			ally:Heal(healAmount, caster)
			PopupHealing(ally, healAmount)
		end
	end  
end

function ceremony_beast_think(event)
	local caster = event.caster
	local hero = caster.hero
	local ability = event.ability
	caster:MoveToPosition(hero:GetAbsOrigin()+RandomVector(RandomInt(50, 200)))
	local position = caster:GetAbsOrigin()
  	local radius = 600
	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), position, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, FIND_ANY_ORDER, false )
	if #enemies > 0 then
		local info = 
		{
			Target = enemies[1],
			Source = caster,
			Ability = ability,	
			EffectName = "particles/units/heroes/hero_lina/lina_base_attack.vpcf",
			StartPosition = "attach_hitloc",
			bDrawsOnMinimap = false, 
		        bDodgeable = true,
		        bIsAttack = false, 
		        bVisibleToEnemies = true,
		        bReplaceExisting = false,
		        flExpireTime = GameRules:GetGameTime() + 4,
			bProvidesVision = true,
			iVisionRadius = 0,
			iMoveSpeed = 400,
			iVisionTeamNumber = caster:GetTeamNumber()
		}
		projectile = ProjectileManager:CreateTrackingProjectile(info)
	end  	
end

function ceremony_beast_projectile_strike(event)
	local target = event.target
	local ability = event.ability
	local caster = event.caster
	local hero = caster.hero
	local primeAttribute = hero:GetPrimaryAttribute()
	local damage = 0
	if primeAttribute == 0 then
		damage = hero:GetStrength()*8
	elseif primeAttribute == 1 then
		damage = hero:GetAgility()*8
	elseif primeAttribute == 2 then
		damage = hero:GetIntellect()*8
	end
	ApplyDamage({ victim = target, attacker = hero, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
end

function refraction_damage(event)
	local target = event.unit
	local stackCount = target:GetModifierStackCount( "modifier_secret_temple_refraction", target.refractionItem )
	if stackCount > 1 then
		target:SetModifierStackCount( "modifier_secret_temple_refraction", target.refractionItem, stackCount-1)
	else
		target:RemoveModifierByName("modifier_secret_temple_refraction")
	end
	local damageTaken = event.attack_damage
	target:Heal(damageTaken, target)
end

function midas_think(event)
	local target = event.target

	local ability = event.ability
	local caster = event.caster
	local gold = PlayerResource:GetGold(target:GetPlayerOwnerID())
	local stacks = gold/200
	if not target:HasModifier("modifier_hand_of_midas_effect") then
		ability:ApplyDataDrivenModifier(caster, target, "modifier_hand_of_midas_effect", {})
	end
	target:SetModifierStackCount( "modifier_hand_of_midas_effect", ability, stacks)
end

function weapon_critical_attack(event)
	local luck = RandomInt(1, 5)
	if luck == 5 then
		local ability = event.ability
		local attacker = event.attacker
		local target = event.target
		local damage = event.attack_damage
		local stacks = attacker:GetModifierStackCount( "modifier_weapon_critical_strike", ability )
		local critBonus = damage*stacks/100
		ApplyDamage({ victim = target, attacker = attacker, damage = critBonus, damage_type = DAMAGE_TYPE_PHYSICAL })
		PopupDamage(target, math.floor(damage+critBonus))
		EmitSoundOn("Hero_PhantomAssassin.CoupDeGrace", target)
	end
end

function weapon_cleave_attack(event)
	local ability = event.ability
	local attacker = event.attacker
	local target = event.target
	local damage = event.attack_damage
	local stacks = attacker:GetModifierStackCount( "modifier_weapon_splash_damage", ability )
	local radius = 240
	damage = damage*stacks/100
	local enemies = FindUnitsInRadius( attacker:GetTeamNumber(), target:GetAbsOrigin()+attacker:GetForwardVector()*50, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, FIND_ANY_ORDER, false )
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			ApplyDamage({ victim = enemy, attacker = attacker, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL })
		end
	end 
end

function dark_arts_think(event)
	local target = event.target
	local ability = event.ability
	local caster = event.caster
	local stacks = WallPhysics:round(target:GetIntellect()*0.35, 0)
	if not target:HasModifier("modifier_dark_arts_effect") then
		ability:ApplyDataDrivenModifier(caster, target, "modifier_dark_arts_effect", {})
	end
	target:SetModifierStackCount( "modifier_dark_arts_effect", ability, stacks)
end

function scarecrow_gloves_think(event)
	local target = event.target
	local ability = event.ability
	local caster = event.caster
	local stacks = WallPhysics:round(target:GetIntellect()*0.5, 0)
	if not target:HasModifier("modifier_scarecrow_gloves_effect") then
		ability:ApplyDataDrivenModifier(caster, target, "modifier_scarecrow_gloves_effect", {})
	end
	target:SetModifierStackCount( "modifier_scarecrow_gloves_effect", ability, stacks)
end

function legion_think(event)
	local target = event.target
	local ability = event.ability
	local caster = event.caster
	local intStacks = WallPhysics:round((target:GetIntellect()-target:GetModifierStackCount( "modifier_legion_vestments_effect_int", ability))*0.2, 0)
	local agiStacks = WallPhysics:round((target:GetAgility()-target:GetModifierStackCount( "modifier_legion_vestments_effect_agi", ability))*0.2, 0)
	local strStacks = WallPhysics:round((target:GetStrength()-target:GetModifierStackCount( "modifier_legion_vestments_effect_str", ability))*0.2, 0) 
	if not target:HasModifier("modifier_legion_vestments_effect_str") then
		ability:ApplyDataDrivenModifier(caster, target, "modifier_legion_vestments_effect_str", {})
	end
	target:SetModifierStackCount( "modifier_legion_vestments_effect_str", ability, strStacks)

	if not target:HasModifier("modifier_legion_vestments_effect_int") then
		ability:ApplyDataDrivenModifier(caster, target, "modifier_legion_vestments_effect_int", {})
	end
	target:SetModifierStackCount( "modifier_legion_vestments_effect_int", ability, intStacks)

	if not target:HasModifier("modifier_legion_vestments_effect_agi") then
		ability:ApplyDataDrivenModifier(caster, target, "modifier_legion_vestments_effect_agi", {})
	end
	target:SetModifierStackCount( "modifier_legion_vestments_effect_agi", ability, agiStacks)
end

function living_gauntlet_think(event)
	local target = event.target
	local ability = event.ability
	local caster = event.caster
	if target:GetMana() <= target:GetMaxMana()*0.25 then
		print(target:GetPhysicalArmorValue())
		print(target:GetModifierStackCount( "modifier_living_gauntlet_effect_armor", ability))
		print(target:GetPhysicalArmorValue()-target:GetModifierStackCount( "modifier_living_gauntlet_effect_armor", ability))
	local armorStacks = target:GetPhysicalArmorValue()-target:GetModifierStackCount( "modifier_living_gauntlet_effect_armor", ability)
	local regenStacks = target:GetHealthRegen()-target:GetModifierStackCount( "modifier_living_gauntlet_effect_regen", ability)
		if not target:HasModifier("modifier_living_gauntlet_effect_regen") then
			ability:ApplyDataDrivenModifier(caster, target, "modifier_living_gauntlet_effect_regen", {})
		end
		target:SetModifierStackCount( "modifier_living_gauntlet_effect_regen", ability, regenStacks)

		if not target:HasModifier("modifier_living_gauntlet_effect_armor") then
			ability:ApplyDataDrivenModifier(caster, target, "modifier_living_gauntlet_effect_armor", {})
		end
		target:SetModifierStackCount( "modifier_living_gauntlet_effect_armor", ability, armorStacks)
	else
		target:RemoveModifierByName("modifier_living_gauntlet_effect_regen")
		target:RemoveModifierByName("modifier_living_gauntlet_effect_armor")
	end

end

function phoenix_gloves_think(event)
	local target = event.target
	local ability = event.ability
	local caster = event.caster
	local stacks = (target:GetMaxHealth() - target:GetHealth())/12
	if not target:HasModifier("modifier_phoenix_gloves_effect") then
		ability:ApplyDataDrivenModifier(caster, target, "modifier_phoenix_gloves_effect", {})
	end
	target:SetModifierStackCount( "modifier_phoenix_gloves_effect", ability, stacks)
end

function violet_boot_impact(event)
	local target = event.target
	local origCaster = event.ability.hero
	local damage = origCaster:GetAgility()*8
	ApplyDamage({ victim = target, attacker = origCaster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
end

function gunslinger_think(event)
	local target = event.target
	local ability = event.ability
	if not ability.lastPos then
		ability.lastPos = target:GetAbsOrigin()
	end
	if not ability.distanceMoved then
		ability.distanceMoved = 0
	end
	ability.newPos = target:GetAbsOrigin()
	ability.hero = target
	local distance = WallPhysics:GetDistance(ability.newPos,ability.lastPos)
	ability.distanceMoved = ability.distanceMoved + distance
	if ability.distanceMoved > 300 then
		for i = 1, ability.distanceMoved/300, 1 do
			gunslingerProjectile(target, true, nil, nil, 0, nil)
			if i > 3 then
				break
			end
		end
		ability.distanceMoved = ability.distanceMoved%300
	end


	ability.lastPos = target:GetAbsOrigin()
end

function gunslingerProjectile(caster, bInitial, slingerAbility, enemies, enemyIndex, dummy)
	if bInitial then
	  	dummy = CreateUnitByName("npc_dummy_unit", caster:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
	  	dummy.owner = caster:GetPlayerOwnerID()

	  	slingerAbility = dummy:AddAbility("bladeslinger_boot_ability")
	  	slingerAbility:SetLevel(1)
	  	dummy:AddAbility("dummy_unit")
	  	dummy:FindAbilityByName("dummy_unit"):SetLevel(1)
	  	slingerAbility.enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, 700, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, FIND_ANY_ORDER, false )
	  	enemies = slingerAbility.enemies
	  	slingerAbility.hero = caster
	end
	local source = enemies[enemyIndex]
	if bInitial then
		source = caster
	end
	if #enemies > enemyIndex then
		local info = 
		{
			Target = enemies[enemyIndex+1],
			Source = source,
			Ability = slingerAbility,	
			EffectName = "particles/units/heroes/hero_bounty_hunter/bounty_hunter_suriken_toss.vpcf",
			StartPosition = "attach_hitloc",
			bDrawsOnMinimap = false, 
		        bDodgeable = true,
		        bIsAttack = false, 
		        bVisibleToEnemies = true,
		        bReplaceExisting = false,
		        flExpireTime = GameRules:GetGameTime() + 4,
			bProvidesVision = true,
			iVisionRadius = 0,
			iMoveSpeed = 1100,
			iVisionTeamNumber = caster:GetTeamNumber()
		}
		projectile = ProjectileManager:CreateTrackingProjectile(info)
	end  	
	slingerAbility.enemyIndex = enemyIndex + 1
 	if enemyIndex == #enemies then
 		UTIL_Remove(dummy)
 	end
end

function gunslinger_impact(event)
	local ability = event.ability
	local caster = event.caster
	local hero = ability.hero
	local target = event.target
	local damage = hero:GetIntellect() + hero:GetStrength() + hero:GetAgility()
	EmitSoundOn("Hero_BountyHunter.Shuriken.Impact", caster)
	if ability.enemyIndex <= 4 then
		gunslingerProjectile(hero, false, ability, ability.enemies, ability.enemyIndex+1, caster) 
	else
		UTIL_Remove(caster)
	end
	ApplyDamage({ victim = target, attacker = hero, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL })	
end

function guardian_greaves_think(event)
	local target = event.target
	local ability = event.ability
	if not ability.lastPos then
		ability.lastPos = target:GetAbsOrigin()
	end
	if not ability.distanceMoved then
		ability.distanceMoved = 0
	end
	ability.newPos = target:GetAbsOrigin()
	ability.hero = target
	local distance = WallPhysics:GetDistance(ability.newPos,ability.lastPos)
	ability.distanceMoved = ability.distanceMoved + distance
	if ability.distanceMoved > 2500 then
		for i = 1, ability.distanceMoved/2500, 1 do
			guardian_greaves_heal(target, ability)
			if i > 1 then
				break
			end
		end
		ability.distanceMoved = ability.distanceMoved%2500
	end


	ability.lastPos = target:GetAbsOrigin()
end

function guardian_greaves_heal(hero, ability)
	local healthRestore = hero:GetStrength()*5
	local manaRestore = hero:GetIntellect()*5
	local armorStacks = hero:GetAgility()/10
	local particleName = "particles/items3_fx/warmage.vpcf"
		local pfx = ParticleManager:CreateParticle( particleName, PATTACH_CUSTOMORIGIN, hero )
		ParticleManager:SetParticleControlEnt(pfx, 0, hero, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", hero:GetAbsOrigin(), true)
		Timers:CreateTimer(3, function() 
		  ParticleManager:DestroyParticle( pfx, false )
		end) 	
	EmitSoundOn("Item.GuardianGreaves.Activate", hero)
	local allies = FindUnitsInRadius( hero:GetTeamNumber(), hero:GetAbsOrigin(), nil, 700, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, 0, FIND_ANY_ORDER, false )
	if #allies > 0 then
		for _,ally in pairs(allies) do
			guardian_heal_ally(ally, healthRestore, manaRestore, armorStacks, ability, hero)
		end
	end  


end

function guardian_heal_ally(ally, healthRestore, manaRestore, armorStacks, ability, hero)
	local particleName = "particles/items3_fx/warmage_recipient.vpcf"
		local pfx = ParticleManager:CreateParticle( particleName, PATTACH_CUSTOMORIGIN, ally )
		ParticleManager:SetParticleControlEnt(pfx, 0, ally, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", ally:GetAbsOrigin(), true)
		Timers:CreateTimer(3, function() 
		  ParticleManager:DestroyParticle( pfx, false )
		end) 	
	EmitSoundOn("Item.GuardianGreaves.Target", ally)
	ally:Heal(healthRestore, hero)
	PopupHealing(ally, healthRestore)
	Timers:CreateTimer(0.1, function()
		PopupMana(ally, manaRestore)
	end)
	ally:GiveMana(manaRestore)
    ability:ApplyDataDrivenModifier(hero.inventory_unit, ally, "modifier_guardian_greaves_armor", {duration = 4})
    ally:SetModifierStackCount( "modifier_guardian_greaves_armor", ability, armorStacks )
end

function tranquil_boots_think(event)
	local target = event.target
	local ability = event.ability
	if not ability.lastPos then
		ability.lastPos = target:GetAbsOrigin()
	end
	if not ability.distanceMoved then
		ability.distanceMoved = 0
	end
	ability.newPos = target:GetAbsOrigin()
	ability.hero = target
	local distance = WallPhysics:GetDistance(ability.newPos,ability.lastPos)
	ability.distanceMoved = ability.distanceMoved + distance
	if ability.distanceMoved > 200 then
		if not ability.active then
			StartSoundEvent("Hero_WitchDoctor.Voodoo_Restoration.Loop", target)
		end
		ability.active = true
		for i = 1, ability.distanceMoved/200, 1 do
			tranquil_boots_heal(target)
			if i > 3 then
				break
			end
		end
		ability.distanceMoved = ability.distanceMoved%200
	else
		if distance < 20 then
			ability.active = false
			StopSoundEvent("Hero_WitchDoctor.Voodoo_Restoration.Loop", target)
		end
	end


	ability.lastPos = target:GetAbsOrigin()
end

function tranquil_boots_heal(hero)
	local healthRestore = WallPhysics:round(hero:GetMaxHealth()*0.01, 0)
	local particleName = "particles/items2_fx/tranquil_boots.vpcf"
	local pfx = ParticleManager:CreateParticle( particleName, PATTACH_CUSTOMORIGIN, hero )
	ParticleManager:SetParticleControlEnt(pfx, 0, hero, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", hero:GetAbsOrigin(), true)
	Timers:CreateTimer(1, function() 
	  ParticleManager:DestroyParticle( pfx, false )
	end) 	
	hero:Heal(healthRestore, hero)
	PopupHealing(hero, healthRestore)
end

function sange_boots_think(event)
	local target = event.target
	local ability = event.ability
	local caster = event.caster
	if not target:HasModifier("modifier_rpc_sange_buff") then
		ability:ApplyDataDrivenModifier(caster, target, "modifier_rpc_sange_buff", {})
	end
	target:SetModifierStackCount( "modifier_rpc_sange_buff", ability, target:GetAgility() )
end

function yasha_boots_think(event)
	local target = event.target
	local ability = event.ability
	local caster = event.caster
	if not target:HasModifier("modifier_rpc_yasha_buff") then
		ability:ApplyDataDrivenModifier(caster, target, "modifier_rpc_yasha_buff", {})
	end
	target:SetModifierStackCount( "modifier_rpc_yasha_buff", ability, target:GetStrength()/15 )
end

function mana_striders_think(event)
	local target = event.target
	local ability = event.ability
	if not ability.lastPos then
		ability.lastPos = target:GetAbsOrigin()
	end
	if not ability.distanceMoved then
		ability.distanceMoved = 0
	end
	ability.newPos = target:GetAbsOrigin()
	ability.hero = target
	local distance = WallPhysics:GetDistance(ability.newPos,ability.lastPos)
	ability.distanceMoved = ability.distanceMoved + distance
	if ability.distanceMoved > 240 then
		if not ability.active then
			-- StartSoundEvent("Hero_Leshrac.Diabolic_Edict_lp", target)
		end
		ability.active = true
		for i = 1, ability.distanceMoved/240, 1 do
			mana_striders_heal(target)
			if i > 3 then
				break
			end
		end
		ability.distanceMoved = ability.distanceMoved%240
	else
		if distance < 20 then
			ability.active = false
			-- StopSoundEvent("Hero_Leshrac.Diabolic_Edict_lp", target)
		end
	end


	ability.lastPos = target:GetAbsOrigin()
end

function mana_striders_heal(hero)
	local manaRestore = WallPhysics:round(hero:GetMaxMana()*0.01, 0)
	local particleName = "particles/units/heroes/hero_obsidian_destroyer/obsidian_death_flash.vpcf"
	local pfx = ParticleManager:CreateParticle( particleName, PATTACH_CUSTOMORIGIN, hero )
	ParticleManager:SetParticleControlEnt(pfx, 0, hero, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", hero:GetAbsOrigin(), true)
	Timers:CreateTimer(1, function() 
	  ParticleManager:DestroyParticle( pfx, false )
	end) 	
	hero:GiveMana(manaRestore)
	PopupMana(hero, manaRestore)
end

function fire_walkers_think(event)
	local caster = event.caster
	local ability = event.ability
	ability.hero = event.target
	ability.damage = ability.hero:GetIntellect() + ability.hero:GetAgility() + ability.hero:GetStrength()
	ability:ApplyDataDrivenThinker(caster, ability.hero:GetAbsOrigin(), "modifier_fire_walker_thinker", {})
end

function fire_walker_damage(event)
	local target = event.target
	local caster = event.ability.hero
	local ability = event.ability
	local damage = ability.damage
	ApplyDamage({ victim = target, attacker = hero, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })	
end

function moon_tech_think(event)
	local caster = event.caster
	local ability = event.ability
	local target = event.target
	ability:ApplyDataDrivenThinker(caster, target:GetAbsOrigin(), "modifier_moon_tech_thinker", {})
end

function falcon_boot_impact(event)
	local target = event.target
	local origCaster = event.ability.hero
	local damage = event.ability.damage
	ApplyDamage({ victim = target, attacker = origCaster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
end

function root_feet_think(event)
	local target = event.target
	local ability = event.ability
	if not ability.lastPos then
		ability.lastPos = target:GetAbsOrigin()
	end
	if not ability.distanceMoved then
		ability.distanceMoved = 0
	end
	ability.newPos = target:GetAbsOrigin()
	ability.hero = target
	local distance = WallPhysics:GetDistance(ability.newPos,ability.lastPos)
	ability.distanceMoved = distance
	if ability.distanceMoved > 10 then
		ability.active = false
		-- StopSoundEvent("Hero_WitchDoctor.Voodoo_Restoration.Loop", target)
		target:RemoveModifierByName("modifier_rooted_feet_health_regen")
		target:RemoveModifierByName("modifier_rooted_feet_armor")
	else
		ability.active = true
		-- StartSoundEvent("Hero_WitchDoctor.Voodoo_Restoration.Loop", target)
		local regenStacks = WallPhysics:round((target:GetHealthRegen())-target:GetModifierStackCount( "modifier_rooted_feet_health_regen", ability), 0)*2
		ability:ApplyDataDrivenModifier(event.caster, target, "modifier_rooted_feet_health_regen", {})
		target:SetModifierStackCount( "modifier_rooted_feet_health_regen", ability, regenStacks)
		local armorStacks = WallPhysics:round((target:GetPhysicalArmorValue())-target:GetModifierStackCount( "modifier_rooted_feet_armor", ability), 0)
		ability:ApplyDataDrivenModifier(event.caster, target, "modifier_rooted_feet_armor", {})
		target:SetModifierStackCount( "modifier_rooted_feet_armor", ability, armorStacks)
	end


	ability.lastPos = target:GetAbsOrigin()
end

function sapphire_lotus_think(event)
	local target = event.target
	local ability = event.ability
	local caster = event.caster
	if not target:HasModifier("modifier_sapphire_lotus_buff") then
		ability:ApplyDataDrivenModifier(caster, target, "modifier_sapphire_lotus_buff", {})
	end
	target:SetModifierStackCount( "modifier_sapphire_lotus_buff", ability, target:GetIntellect() )
end

function lifesource_vessel_think(event)
	local target = event.target
	local ability = event.ability
	local caster = event.caster
	local stacks = math.floor(target:GetStrength()*0.3)
	if not target:HasModifier("modifier_lifesource_vessel_buff") then
		ability:ApplyDataDrivenModifier(caster, target, "modifier_lifesource_vessel_buff", {})
	end
	target:SetModifierStackCount( "modifier_lifesource_vessel_buff", ability, stacks)
end

function saytaru_think(event)
	local target = event.target
	local ability = event.ability
	local caster = event.caster
	if target:GetHealth() <= target:GetMaxHealth()*0.2 then
		ability:ApplyDataDrivenModifier(caster, target, "modifier_hope_of_saytaru_effect", {})
	else
		target:RemoveModifierByName("modifier_hope_of_saytaru_effect")
	end
end

function galaxy_orb_channel_begin(event)
	local caster = event.target
	local ability = event.ability
	local particleName = "particles/units/heroes/hero_enigma/enigma_midnight_pulse.vpcf"
	ability.pfx = ParticleManager:CreateParticle( particleName, PATTACH_WORLDORIGIN, caster )

	local position = caster:GetAbsOrigin()
	local radius = 800
	ParticleManager:SetParticleControl( ability.pfx, 0, position )
	ParticleManager:SetParticleControl( ability.pfx, 1, Vector(radius, 2, radius*2) )

	ability.position = position
end

function galaxy_orb_suction(event)
	local caster = event.target
	local ability = event.ability
	local position = ability.position
	local radius = 800
	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, FIND_ANY_ORDER, false )
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			local enemyPosition = enemy:GetAbsOrigin()
			local movementVector = (position - enemyPosition):Normalized()
			enemy:SetAbsOrigin(enemyPosition + movementVector*16)

		end
	end 
end

function galaxy_orb_channel_end(event)
	local target = event.target
	local ability = event.ability
	ParticleManager:DestroyParticle(ability.pfx, false)
end

function azure_empire_init(event)
	local target = event.target
	local caster = event.caster
	local ability = event.ability
	target.birdTable = {}
	for i = 1, 3, 1 do 
		local bird =  CreateUnitByName("tracer_unit", target:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_GOODGUYS)
		bird.hero = target
		bird.interval = 0
		bird.state = 0
		bird:SetModel("models/items/beastmaster/hawk/fotw_eagle/fotw_eagle.vmdl")
		bird:SetOriginalModel("models/items/beastmaster/hawk/fotw_eagle/fotw_eagle.vmdl")
		bird:SetModelScale(0.5)
		table.insert(target.birdTable, bird)
		ability:ApplyDataDrivenModifier(caster, bird, "modifier_azure_empire_buff", {})
		bird.index = i
	end
end

function azure_hawk_think(event)
	local bird = event.target
	local hero = bird.hero
	local heroPosition = hero:GetAbsOrigin()
	local fv = hero:GetForwardVector()
	local perpFv = WallPhysics:rotateVector(fv,math.pi/2)
	if bird.state == 0 then
		bird.interval = bird.interval + 1
		if bird.interval >= 25+bird.index*3 then
			local enemies = FindUnitsInRadius( hero:GetTeamNumber(), heroPosition, nil, 600, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, FIND_ANY_ORDER, false )
			if #enemies > 0 then
				bird.state = 1
				bird.acquiredTarget = enemies[1]
			end 
			bird.interval = 0
		end
		if bird.index == 1 then
			bird:MoveToPosition(heroPosition+perpFv*90)
		elseif bird.index == 2 then
			bird:MoveToPosition(heroPosition)
		elseif bird.index == 3 then
			bird:MoveToPosition(heroPosition-perpFv*90)
		end
	end
	if bird.state == 1 then
		if bird.acquiredTarget then
			if not bird.acquiredTarget:IsAlive() then
				bird.state = 0
				bird.interval = 0
				return nil
			end
		end
		local birdOrigin = bird:GetAbsOrigin()
		local enemyPosition = bird.acquiredTarget:GetAbsOrigin()
		local movementVector = (enemyPosition - birdOrigin):Normalized()
		local newPosition = birdOrigin+movementVector*27
		if bird.interval > 0 then
			bird:SetAbsOrigin(newPosition)
		end
		local distanceToTarget = WallPhysics:GetDistance(newPosition*Vector(1,1,0),enemyPosition*Vector(1,1,0))
		if distanceToTarget < 100 then
			bird:SetAbsOrigin(newPosition+Vector(0,0,-1)*distanceToTarget/2)
		end
		bird.interval = bird.interval + 1
		if distanceToTarget < 10 then
			bird.interval = 0
			bird.state = 2
			bird.strikeFv = bird:GetForwardVector()
			bird.strikePosition = birdOrigin
			local movementOut = RandomInt(1, 2)
			if movementOut == 1 then
				bird.swoopOut = 1
			else
				bird.swoopOut = -1
			end
			local particleName = "particles/econ/items/antimage/antimage_weapon_basher_ti5_gold/am_basher_manaburn_impact_lightning_gold.vpcf"
			local pfx = ParticleManager:CreateParticle( particleName, PATTACH_CUSTOMORIGIN, bird.acquiredTarget )
			ParticleManager:SetParticleControlEnt(pfx, 0, bird.acquiredTarget, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", bird.acquiredTarget:GetAbsOrigin(), true)
			Timers:CreateTimer(0.7, function() 
			  ParticleManager:DestroyParticle( pfx, false )
			end) 	
			local damage = hero:GetAgility()*15
			ApplyDamage({ victim = bird.acquiredTarget, attacker = hero, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
			EmitSoundOn("hero_Crystal.projectileImpact", bird.acquiredTarget)
		end
	end
	if bird.state == 2 then
		local birdOrigin = bird:GetAbsOrigin()
		bird.strikeFv = WallPhysics:rotateVector(bird.strikeFv,math.pi/24*bird.swoopOut)
		bird:MoveToPosition(birdOrigin+bird.strikeFv*25)
		bird.interval = bird.interval + 1
		if bird.interval >= 15 then
			bird.interval = 0
			bird.state = 0
		end
	end

end

function azure_empire_end(event)
	local target = event.target
	for i = 1, #target.birdTable, 1 do
		UTIL_Remove(target.birdTable[i])
	end
	target.birdTable = false
end

function super_ascension_init(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	target:SetAttackCapability(DOTA_UNIT_CAP_RANGED_ATTACK)
	target:SetRangedProjectileName("particles/units/heroes/hero_phoenix/phoenix_base_attack.vpcf")
	local baseProjectileSpeed = target.baseProjectileSpeed
	ability:ApplyDataDrivenModifier(caster, target, "modifier_ascendency_projectile_speed_stacks", {duration = 7})
	local speedStacks = 1050-baseProjectileSpeed
	-- if baseProjectileSpeed == 0 then
	-- 	ability:ApplyDataDrivenModifier(caster, target, "modifier_ascendency_projectile_speed_stacks", {duration = 7})
	-- end
	if speedStacks > 0 then
		target:SetModifierStackCount( "modifier_ascendency_projectile_speed_stacks", ability, speedStacks)
	end
	local particleName = "particles/units/heroes/hero_sven/sven_spell_gods_strength.vpcf"
	local pfx = ParticleManager:CreateParticle( particleName, PATTACH_CUSTOMORIGIN, target )
	ParticleManager:SetParticleControlEnt(pfx, 0, target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	Timers:CreateTimer(1.5, function() 
	  ParticleManager:DestroyParticle( pfx, false )
	end) 	
end

function super_ascension_end(event)
	local caster = event.caster
	local target = event.target
	target:SetAttackCapability(target.baseAttackCapability)
	target:SetRangedProjectileName(target.originalProjectile)
end

function cascade_hat_think(event)
	local caster = event.target
	local ability = event.ability
	ability.caster = caster
	local manaDrain = caster:GetMaxMana()*0.05
	ability.damage = manaDrain*5
	local fv = caster:GetForwardVector()
	if manaDrain < caster:GetMana() then
		caster:ReduceMana(manaDrain)
		cascade_projectile(ability, caster, fv)
		cascade_projectile(ability, caster, WallPhysics:rotateVector(fv, math.pi))
		cascade_projectile(ability, caster, WallPhysics:rotateVector(fv, 3*math.pi/2))
		cascade_projectile(ability, caster, WallPhysics:rotateVector(fv, math.pi/2))

		cascade_projectile(ability, caster, WallPhysics:rotateVector(fv, math.pi/4))
		cascade_projectile(ability, caster, WallPhysics:rotateVector(fv, 3*math.pi/4))
		cascade_projectile(ability, caster, WallPhysics:rotateVector(fv, 5*math.pi/4))
		cascade_projectile(ability, caster, WallPhysics:rotateVector(fv, 7*math.pi/4))
	end
end

function cascade_projectile(ability, caster, fv)
	local projectileParticle = "particles/units/heroes/hero_dragon_knight/arcane_cascade.vpcf"
	local projectileOrigin = caster:GetAbsOrigin()
	local start_radius = 120
	local end_radius = 220
	local range = 300
	local speed = 850
	local info = 
	{
			Ability = ability,
        	EffectName = projectileParticle,
        	vSpawnOrigin = projectileOrigin+Vector(0,0,60),
        	fDistance = range,
        	fStartRadius = start_radius,
        	fEndRadius = end_radius,
        	Source = caster,
        	StartPosition = "attach_hitloc",
        	bHasFrontalCone = true,
        	bReplaceExisting = false,
        	iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        	iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        	iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        	fExpireTime = GameRules:GetGameTime() + 4.0,
		bDeleteOnHit = false,
		vVelocity = fv * speed,
		bProvidesVision = false,
	}
	projectile = ProjectileManager:CreateLinearProjectile(info)
end

function cascade_hat_impact(event)
	local ability = event.ability
	local caster = ability.caster
	local target = event.target
	local damage = ability.damage
	ApplyDamage({ victim = target, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })	
end

function lifesteal_land(event)
	local attacker = event.attacker
	local ability = attacker.InventoryUnit:FindAbilityByName("helm_slot")
	local damage = event.attack_damage
	local current_stack = attacker:GetModifierStackCount( "modifier_helm_lifesteal", ability )
	local lifesteal = math.floor(damage*current_stack/100)
	attacker:Heal(lifesteal, attacker) 
	local particleName = "particles/units/heroes/hero_skeletonking/wraith_king_vampiric_aura_lifesteal.vpcf"
	local pfx = ParticleManager:CreateParticle( particleName, PATTACH_CUSTOMORIGIN, attacker )
	ParticleManager:SetParticleControlEnt(pfx, 0, attacker, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", attacker:GetAbsOrigin(), true)
	Timers:CreateTimer(1, function() 
	  ParticleManager:DestroyParticle( pfx, false )
	end)  	
end

function nightmare_rider_initialize(event)
	local target = event.target
	local caster = event.caster
	local ability = event.ability
	target.orbTable = {}
	for i = 1, 3, 1 do 
		local orb =  CreateUnitByName("nightmare_rider_orb", target:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_GOODGUYS)
		orb.hero = target
		orb.owner = target:GetPlayerOwnerID()
		orb.interval = 0
		orb.state = 0
		orb:SetModel("models/props_gameplay/rune_arcane.vmdl")
		orb:SetOriginalModel("models/props_gameplay/rune_arcane.vmdl")
		orb:SetModelScale(0.5)
		table.insert(target.orbTable, orb)
		ability:ApplyDataDrivenModifier(caster, orb, "modifier_nightmare_rider_orb_buff", {})
		orb.index = i
		local offsetRadians = (2*math.pi/3)*(i-1)
		orb.offsetVector = WallPhysics:rotateVector(Vector(1,1), offsetRadians)
		orb:SetOwner(target)
   		orb:SetControllableByPlayer(target:GetPlayerID(), true)
	end
end

function nightmare_rider_think(event)
end

function nightmare_rider_orb_think(event)
	local orb = event.target
	local hero = orb.hero
	orb.offsetVector = WallPhysics:rotateVector(orb.offsetVector, math.pi/40)
	orb:SetAbsOrigin(hero:GetAbsOrigin() + orb.offsetVector*120)
	local damage = (hero:GetStrength() +hero:GetAgility() +hero:GetIntellect())/2
	orb:SetBaseDamageMin(damage)
	orb:SetBaseDamageMax(damage)
end

function nightmare_rider_end(event)
	local target = event.target
	for i = 1, #target.orbTable, 1 do
		UTIL_Remove(target.orbTable[i])
	end
	target.orbTable = false
end



function space_tech_channel_think(event)
	local caster = event.target
	local ability = event.ability
	local position = caster:GetAbsOrigin()
	local particleName = "particles/units/heroes/hero_faceless_void/faceless_void_timedialate.vpcf"
	local particle = ParticleManager:CreateParticle(particleName, PATTACH_CUSTOMORIGIN, caster)
	local radius = 640
	ParticleManager:SetParticleControl(particle, 0, position)
	ParticleManager:SetParticleControl(particle, 1, Vector(radius,radius,radius))

	
	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), position, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, FIND_ANY_ORDER, false )
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			ability:ApplyDataDrivenModifier(event.caster, enemy, "modifier_space_tech_slow", {duration = 0.35})
		end
	end 
end


function stormshield_cloak_initialize(event)
	local target = event.target
	local caster = event.caster
	local ability = event.ability
	target.shieldTable = {}
	for i = 1, 3, 1 do 
		local shield =  CreateUnitByName("tracer_unit", target:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_GOODGUYS)
		shield.hero = target
		shield.owner = target:GetPlayerOwnerID()
		shield.interval = 0
		shield.state = 0
		shield:SetModel("models/props_gameplay/status_shield.vmdl")
		shield:SetOriginalModel("models/props_gameplay/status_shield.vmdl")
		shield:SetModelScale(2.0)
		table.insert(target.shieldTable, shield)
		ability:ApplyDataDrivenModifier(caster, shield, "modifier_stormshield_cloak_shield_buff", {})
		shield.index = i
		local offsetRadians = (2*math.pi/3)*(i-1)
		shield.offsetVector = WallPhysics:rotateVector(Vector(1,1), offsetRadians)
		shield:SetOwner(target)
   		shield:SetControllableByPlayer(target:GetPlayerID(), true)
	end
end

function stormshield_main_think(event)
	
	local caster = event.target
	local position = caster:GetAbsOrigin()
	local radius = 200
	local damage = (caster:GetPhysicalArmorValue()*10)/3
	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), position, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, FIND_ANY_ORDER, false )
	if #enemies > 0 then
		EmitSoundOn("ui.inv_equip_metalblade", caster.shieldTable[1])
		if #enemies > 3 then
			EmitSoundOn("ui.inv_equip_metalblade", caster.shieldTable[2])
		end
		if #enemies > 6 then
			EmitSoundOn("ui.inv_equip_metalblade", caster.shieldTable[3])
		end
		for _,enemy in pairs(enemies) do
			ApplyDamage({ victim = enemy, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL })	
		end
	end 
end

function stormshield_cloak_shield_think(event)
	local shield = event.target
	local hero = shield.hero
	shield.offsetVector = WallPhysics:rotateVector(shield.offsetVector, math.pi/10)
	local heroOrigin = hero:GetAbsOrigin()
	local position = heroOrigin + shield.offsetVector*60 - Vector(0,0,65)
	shield:SetAbsOrigin(position)
	local damage = hero:GetPhysicalArmorValue()*10
	local fv = (position-heroOrigin):Normalized()*Vector(1,1,0)
	shield:SetForwardVector(fv)
end

function stormshield_cloak_shield_end(event)
	local target = event.target
	for i = 1, #target.shieldTable, 1 do
		UTIL_Remove(target.shieldTable[i])
	end
	target.shieldTable = false
end

function undertaker_attack(event)
	local attacker = event.attacker
	local ability = event.ability
	local target = event.target
	ability.caster = attacker
	local info = 
	{
		Target = target,
		Source = attacker,
		Ability = ability,	
		EffectName = "particles/econ/items/necrolyte/necrophos_sullen/necro_sullen_pulse_enemy.vpcf",
		StartPosition = "attach_attack1",
		bDrawsOnMinimap = false, 
	        bDodgeable = true,
	        bIsAttack = false, 
	        bVisibleToEnemies = true,
	        bReplaceExisting = false,
	        flExpireTime = GameRules:GetGameTime() + 10,
		bProvidesVision = true,
		iVisionRadius = 100,
		iMoveSpeed = 400,
		iVisionTeamNumber = attacker:GetTeamNumber()
	}
	projectile = ProjectileManager:CreateTrackingProjectile(info)
end

function undertaker_projectile_strike(event)
	local target = event.target
	local caster = event.ability.caster
	local damage = caster:GetIntellect()*3
	ApplyDamage({ victim = target, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
end