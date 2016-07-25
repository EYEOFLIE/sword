if Filters == nil then
  Filters = class({})
end

function Filters:CastSkillArguments(slot, caster)
	if slot == 1 then
		Filters:ApplyQskills(caster)
	elseif slot == 2 then
		Filters:ApplyWskills(caster)
	elseif slot == 3 then
		Filters:ApplyEskills(caster)
	elseif slot == 4 then
		Filters:ApplyRskills(caster)
	end
end

function Filters:BeginRChannel(caster)
	local ability = caster:GetAbilityByIndex(3)
	local baseCd = ability:GetCooldownTimeRemaining()
	if caster:HasModifier("modifier_galaxy_orb") then
		caster.galaxy_orb:ApplyDataDrivenModifier(caster.InventoryUnit, caster, "modifier_galaxy_orb_channel", {duration = 3.0})
	end
	if caster:HasModifier("modifier_space_tech") then
		caster.space_tech:ApplyDataDrivenModifier(caster.InventoryUnit, caster, "modifier_space_tech_channel", {duration = 3.0})
	end
	if caster:HasModifier("modifier_signus_charm") then
		ability:EndCooldown()
		baseCd = baseCd*0.6
		ability:StartCooldown(baseCd)
	end
end

function Filters:EndRChannel(caster)
	if caster:HasModifier("modifier_galaxy_orb") then
		caster:RemoveModifierByName("modifier_galaxy_orb_channel")
	end
	if caster:HasModifier("modifier_space_tech") then
		caster:RemoveModifierByName("modifier_space_tech_channel")
	end
end

function Filters:ApplyQskills(caster)
	if caster:HasModifier("modifier_watcher_one") then
		Filters:WatcherOne(caster)
	end
end

function Filters:ApplyWskills(caster)
	if caster:HasModifier("modifier_hand_elder") then
		Filters:ElderGrasp(caster)
	end
	if caster:HasModifier("modifier_body_seraphic") then
		Filters:SeraphicVest(caster)
	end
	if caster:HasModifier("modifier_spellslinger_coat") then
		Filters:SpellslingerCoat(caster)
	end
	if caster:HasModifier("modifier_white_mage_hat") then
		Filters:WhiteMageHat(caster)
	end
	if caster:HasModifier("modifier_witch_hat") then
		Filters:WitchHat(caster)
	end
	if caster:HasModifier("modifier_trickster_mask") then
		Filters:TricksterMask(caster)
	end
	if caster:HasModifier("modifier_frostburn_gauntlets") then
		Filters:FrostburnGauntlet(caster)
	end
	if caster:HasModifier("modifier_cerulean_high_guard") then
		Filters:CeruleanHighguard(caster)
	end
	if caster:HasModifier("modifier_phantom_sorcerer") then
		local ability = caster:GetAbilityByIndex(1)
		ability:EndCooldown()
		ability:StartCooldown(5)
	end
end

function Filters:ApplyEskills(caster)
	local ability = caster:GetAbilityByIndex(2)
	local baseCd = ability:GetCooldownTimeRemaining()
	if caster:HasModifier("modifier_dunetread_boots") then
		ability:EndCooldown()
		baseCd = baseCd - 1
		ability:StartCooldown(baseCd)
	end
	if caster:HasModifier("modifier_violet_boots") then
		Filters:VioletBoot(caster)
	end
	if caster:HasModifier("modifier_sonic_boots") then
		Filters:SonicBoot(caster)
	end
	if caster:HasModifier("modifier_falcon_boots") then
		Filters:FalconBoot(caster)
	end
	if caster:HasModifier("modifier_gem_of_eternal_frost") then
		Filters:EternalFrost(caster)
	end
	if caster:HasModifier("modifier_signus_charm") then
		ability:EndCooldown()
		baseCd = baseCd*2
		ability:StartCooldown(baseCd)
	end
	if caster:HasModifier("modifier_avernus_e_nerf") then
		ability:EndCooldown()
		baseCd = baseCd+15
		ability:StartCooldown(baseCd)		
	end
end

function Filters:ApplyRskills(caster)

	if caster:HasModifier("modifier_body_hurricane") then
		Filters:HurricaneVest(caster)	
	elseif caster:HasModifier("modifier_body_flooding") then
		Filters:FloodRobe(caster)
	elseif caster:HasModifier("modifier_body_avalanche") then
		Filters:AvalanchePlate(caster)
	end
	if caster:HasModifier("modifier_secret_temple") then
		Filters:SecretTemple(caster)
	end
	if caster:HasModifier("modifier_ruby_dragon") then
		Filters:RubyDragon(caster)
	end
	if caster:HasModifier("modifier_spirit_glove") then
		Filters:SpiritGlove(caster)
	end
	if caster:HasModifier("modifier_monkey_paw") then
		Filters:MonkeyPaw(caster)
	end
	if caster:HasModifier("modifier_super_ascendency") then
		Filters:AscensionTrigger(caster)
	end
	if caster:HasModifier("modifier_scourge_knight") then
		Filters:ScourgeKnight(caster)
	end
end

function Filters:TakeArgumentsAndApplyDamage(victim, attacker, damage, damage_type, slot)
	local damageMult = 0
	if attacker:HasModifier("modifier_watcher_two") then
		damageMult = damageMult + 0.15
	end
	if attacker:HasModifier("modifier_mugato") then
		damageMult = damageMult + 1
	end
	if attacker:HasModifier("modifier_arbor_dragonfly") then
		damageMult = damageMult + 0.3
	end
	if attacker:HasModifier("modifier_eye_of_avernus") then
		damageMult = damageMult + 1.5
	end
	if slot == 1 then
		if attacker:HasModifier("modifier_body_violet_guard") then
			damageMult = damageMult + 0.35
		end
		if attacker:HasModifier("modifier_death_whisper") then
			Filters:DeathWhisperApply(attacker, victim)
		end
		if attacker:HasModifier("modifier_luma_guard") then
			Filters:LumaGuardStrike(attacker, victim, damage)
		end
		if attacker:HasModifier("modifier_helm_odin") then
			Filters:OdinCrit(attacker, victim, damage, damage_type)
		end
		if attacker:HasModifier("modifier_vampiric_breastplate") then
			Filters:VampiricBreastplate(attacker, damage)
		end
		damage = damage*(1+damageMult)
		Filters:ApplyQdamage(victim, attacker, damage, damage_type)
	elseif slot == 2 then
		if attacker:HasModifier("modifier_watcher_three") then
			damageMult = damageMult + 0.35
		end
		if attacker:HasModifier("modifier_spellslinger_coat") then
			damageMult = damageMult + 0.3
		end
		if attacker:HasModifier("modifier_wild_nature_two") then
			Filters:WildNatureTwo(attacker, victim)
		end
		if attacker:HasModifier("modifier_helm_odin") then
			Filters:OdinCrit(attacker, victim, damage, damage_type)
		end
		if attacker:HasModifier("modifier_phantom_sorcerer") then
			damageMult = damageMult + 7
		end
		if attacker:HasModifier("modifier_cerulean_high_guard") then
			damageMult = damageMult+2
		end
		damage = damage*(1+damageMult)
		Filters:ApplyWdamage(victim, attacker, damage, damage_type)
	elseif slot == 3 then
		if attacker:HasModifier("modifier_helm_odin") then
			Filters:OdinCrit(attacker, victim, damage, damage_type)
		end
		if attacker:HasModifier("modifier_admiral_boots") then
			damageMult = damageMult + 1
		end
		damage = damage*(1+damageMult)
		Filters:ApplyEdamage(victim, attacker, damage, damage_type)
	elseif slot == 4 then
		if attacker:HasModifier("modifier_master_gloves") then
			damageMult = damageMult + 0.6
		end
		if attacker:HasModifier("modifier_watcher_four") then
			damageMult = damageMult + 0.35
		end
		if attacker:HasModifier("modifier_sorcerers_regalia") then
			Filters:SorcerersRegalia(attacker)
		end
		if attacker:HasModifier("modifier_doomplate") then
			Filters:DoomplateApply(attacker, victim)
		end
		if attacker:HasModifier("modifier_helm_odin") then
			Filters:OdinCrit(attacker, victim, damage, damage_type)
		end
		damage = damage*(1+damageMult)
		Filters:ApplyRdamage(victim, attacker, damage, damage_type)
	end
end

function Filters:ApplyQdamage(victim, attacker, damage, damage_type)
	ApplyDamage({ victim = victim, attacker = attacker, damage = damage, damage_type = damage_type })
end

function Filters:ApplyWdamage(victim, attacker, damage, damage_type)
	ApplyDamage({ victim = victim, attacker = attacker, damage = damage, damage_type = damage_type })
end

function Filters:ApplyEdamage(victim, attacker, damage, damage_type)
	ApplyDamage({ victim = victim, attacker = attacker, damage = damage, damage_type = damage_type })
end

function Filters:ApplyRdamage(victim, attacker, damage, damage_type)
	ApplyDamage({ victim = victim, attacker = attacker, damage = damage, damage_type = damage_type })
end

function Filters:ElderGrasp(caster)
	local healAmount = caster:GetMaxHealth()*0.02
	healAmount = WallPhysics:round(healAmount, 0)
	caster:Heal(healAmount, caster)
	PopupHealing(caster, healAmount)
	local particleName = "particles/generic_gameplay/generic_lifesteal.vpcf"
    local particleVector = caster:GetAbsOrigin()
    local pfx = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN_FOLLOW, caster )
    ParticleManager:SetParticleControlEnt( pfx, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", particleVector, true )
	Timers:CreateTimer(0.5, function() 
		ParticleManager:DestroyParticle( pfx, false )
	end)
end

function Filters:HurricaneVest(caster)
	local ability = caster.body_ability
	local particleName = "particles/units/heroes/hero_brewmaster/brewmaster_windwalk.vpcf"
    local particleVector = caster:GetAbsOrigin()
    local pfx = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN_FOLLOW, caster )
    ParticleManager:SetParticleControlEnt( pfx, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", particleVector, true )
	Timers:CreateTimer(1.5, function() 
		ParticleManager:DestroyParticle( pfx, false )
	end)	
	local damage = caster:GetModifierStackCount( "modifier_body_hurricane", ability )
	print(damage)
	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, 350, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, FIND_ANY_ORDER, false )
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			ApplyDamage({ victim = enemy, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
		end
	end 	
	ability:ApplyDataDrivenModifier(caster.InventoryUnit, caster, "modifier_body_hurricane_effect", {duration = 2.0})
	EmitSoundOn("Hero_Clinkz.WindWalk", caster)
end

function Filters:FloodRobe(caster)
	local elemental = CreateUnitByName("water_elemental_flood", caster:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_GOODGUYS)
	elemental.owner = caster:GetPlayerOwnerID()
	elemental.summoner = caster
	elemental:SetOwner(caster)
	elemental:SetControllableByPlayer(caster:GetPlayerID(), true)
	elemental.dieTime = 8
	elemental:AddAbility("ability_die_after_time_generic"):SetLevel(1)
	local summonAbil = elemental:AddAbility("ability_summoned_unit")
	summonAbil:SetLevel(1)
	summonAbil:ApplyDataDrivenModifier(elemental, elemental, "modifier_summoned_unit_damage_increase", {duration = 30})
	elemental:SetModifierStackCount( "modifier_summoned_unit_damage_increase", summonAbil, caster:GetIntellect())
end

function Filters:AvalanchePlate(caster)
	local radius = 400
	local splitEarthParticle = "particles/units/heroes/hero_leshrac/leshrac_split_earth.vpcf"
	local position = caster:GetAbsOrigin()
	local pfx = ParticleManager:CreateParticle( splitEarthParticle, PATTACH_CUSTOMORIGIN, caster )
	ParticleManager:SetParticleControl( pfx, 0, position )
	ParticleManager:SetParticleControl( pfx, 1, Vector(radius, radius, radius) )
	Timers:CreateTimer(4, function()
		ParticleManager:DestroyParticle(pfx, false)
	end)
	if bSound then
		EmitSoundOn("Hero_Leshrac.Split_Earth", caster)
	end
	local damage = caster:GetStrength()*60
	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), position, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, FIND_ANY_ORDER, false )
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			ApplyDamage({ victim = enemy, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
			enemy:AddNewModifier(caster, nil, "modifier_stunned", {duration = 1.5})		
		end
	end 	
end

function Filters:SeraphicVest(caster)
	local fv = caster:GetForwardVector()
	local ability = caster.InventoryUnit:FindAbilityByName("body_slot")
	ability.caster = caster
	local projectileParticle = "particles/econ/items/mirana/mirana_crescent_arrow/seraphic_soulvest.vpcf"
	local projectileOrigin = caster:GetAbsOrigin() + fv*10
	local start_radius = 150
	local end_radius = 150
	local range = 1200
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

function Filters:WatcherOne(caster)
	local luck = RandomInt(1, 4)
	if luck == 1 then
		local ability = caster:GetAbilityByIndex(3)
		ability:EndCooldown()
	end
end

function Filters:SorcerersRegalia(caster)
	local particleName = "particles/items3_fx/mango_active.vpcf"
    local pfx = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN_FOLLOW, caster )
		ParticleManager:SetParticleControlEnt( pfx, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true )
		Timers:CreateTimer(1, function() 
		  ParticleManager:DestroyParticle( pfx, false )
		end)
	local manaRestore = caster:GetIntellect()*0.5
	manaRestore = WallPhysics:round(manaRestore, 0)
	caster:GiveMana(manaRestore)
	PopupMana(caster, manaRestore)
end

function Filters:SpellslingerCoat(caster)
	local ability = caster:GetAbilityByIndex(1)
	local manaCost = ability:GetManaCost(-1)
	local manaRestore = manaCost*0.25
	manaRestore = WallPhysics:round(manaRestore, 0)
	caster:GiveMana(manaRestore)
	PopupMana(caster, manaRestore)	
end

function Filters:DoomplateApply(attacker, victim)
	local inventoryUnit = attacker.InventoryUnit
	local ability = inventoryUnit:FindAbilityByName("body_slot")
	victim.doomplateCaster = attacker
	ability:ApplyDataDrivenModifier(inventoryUnit, victim, "modifier_doomplate_effect", {duration = 4})
end

function Filters:WhiteMageHat(caster)
	local allies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, 400, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, 0, FIND_ANY_ORDER, false )
	local healAmount = caster:GetIntellect()
	local inventoryUnit = caster.InventoryUnit
	local ability = inventoryUnit:FindAbilityByName("helm_slot")
	if #allies > 0 then
		for _,ally in pairs(allies) do
			ally:RemoveModifierByName("modifier_white_mage_hat_effect")
			ability:ApplyDataDrivenModifier(inventoryUnit, ally, "modifier_white_mage_hat_effect", {})
			ally:Heal(healAmount, caster)
			PopupHealing(ally, healAmount)
		end
	end  
end

function Filters:RubyDragon(caster)
	local dragon = CreateUnitByName("ruby_dragon_summon", caster:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_GOODGUYS)
	dragon.owner = caster:GetPlayerOwnerID()
	dragon.summoner = caster
	dragon:SetOwner(caster)
	dragon:SetControllableByPlayer(caster:GetPlayerID(), true)
	dragon.dieTime = 8
	dragon:AddAbility("ability_die_after_time_generic"):SetLevel(1)
	local summonAbil = dragon:AddAbility("ability_summoned_unit")
	summonAbil:SetLevel(1)
	dragon.burnDamage = caster:GetStrength()*4
end

function Filters:DeathWhisperApply(attacker, victim)
	local inventoryUnit = attacker.InventoryUnit
	local ability = inventoryUnit:FindAbilityByName("helm_slot")
	ability:ApplyDataDrivenModifier(inventoryUnit, victim, "modifier_death_whisper_effect", {duration = 5})
end

function Filters:WildNatureTwo(attacker, victim)
	local luck = RandomInt(1, 20)
	if luck == 20 then
		local inventoryUnit = attacker.InventoryUnit
		victim.entangler = attacker
		local ability = inventoryUnit:FindAbilityByName("helm_slot")
		ability:ApplyDataDrivenModifier(inventoryUnit, victim, "modifier_wild_nature_entangle_effect", {duration = 3})
	end
end

function Filters:LumaGuardStrike(attacker, victim, damage)
	local luck = RandomInt(1, 5)
	if luck == 5 then
		local inventoryUnit = attacker.InventoryUnit
		local ability = inventoryUnit:FindAbilityByName("helm_slot")
		ability:ApplyDataDrivenModifier(inventoryUnit, victim, "modifier_luma_guard_moonbeam", {duration = 4})
		-- local moonParticle = "particles/units/heroes/hero_luna/luna_lucent_beam.vpcf"
		-- local position = victim:GetAbsOrigin()
		-- local pfx = ParticleManager:CreateParticle( "particles/units/heroes/hero_luna/luna_lucent_beam.vpcf", PATTACH_CUSTOMORIGIN, victim )
		-- ParticleManager:SetParticleControl( pfx, 0, position )
		AddFOWViewer(attacker:GetTeamNumber(), victim:GetAbsOrigin(), 500, 4, false)
		
		-- Timers:CreateTimer(4, function()
		-- 	ParticleManager:DestroyParticle(pfx, false)
		-- end)
		damage = damage*1.5
		ApplyDamage({ victim = victim, attacker = attacker, damage = damage, damage_type = DAMAGE_TYPE_PURE })	
		print("MOONBEAM HAS FIRED")
	end
end

function Filters:OdinCrit(attacker, victim, damage, damage_type)
	local luck = RandomInt(1, 100)
	if luck >= 96 then
		ApplyDamage({ victim = victim, attacker = attacker, damage = damage*9, damage_type = damage_type })
		PopupDamage(victim, damage*10)
	end
end

function Filters:WitchHat(caster)
	local fv = caster:GetForwardVector()
	local ability = caster.witchHat
	ability.caster = caster
	local projectileParticle = "particles/econ/items/death_prophet/death_prophet_acherontia/death_prophet_acher_swarm.vpcf"
	local projectileOrigin = caster:GetAbsOrigin() + fv*10
	local start_radius = 120
	local end_radius = 400
	local range = 900
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

function Filters:TricksterMask(caster)
	local casterOrigin = caster:GetAbsOrigin()
	local randomPosition = casterOrigin+RandomVector(380)
	randomPosition = WallPhysics:WallSearch(casterOrigin, randomPosition)
	FindClearSpaceForUnit(caster, randomPosition, false)
	caster:RemoveModifierByName("modifier_trickster_mask_effect")
	caster.tricksterItem:ApplyDataDrivenModifier(caster.InventoryUnit, caster, "modifier_trickster_mask_effect", {duration = 0.5})
end

function Filters:SecretTemple(caster)
	local inventoryUnit = caster.InventoryUnit
	caster.refractionItem:ApplyDataDrivenModifier(inventoryUnit, caster, "modifier_secret_temple_refraction", {duration = 30})
	caster:SetModifierStackCount( "modifier_secret_temple_refraction", caster.refractionItem, 7)
	caster.refractionItem:ApplyDataDrivenModifier(inventoryUnit, caster, "modifier_secret_temple_damage_increase", {duration = 30})
	local damageStackCount = caster:GetModifierStackCount( "modifier_secret_temple_damage_increase", caster.refractionItem )
	caster:SetModifierStackCount( "modifier_secret_temple_damage_increase", caster.refractionItem, caster:GetAttackDamage()-damageStackCount)
end

function Filters:VampiricBreastplate(caster, damage)
	local heal = damage*0.3
	caster:Heal(heal, caster) 
	print("heal for"..heal)
	local particleName = "particles/units/heroes/hero_skeletonking/wraith_king_vampiric_aura_lifesteal.vpcf"
		local pfx = ParticleManager:CreateParticle( particleName, PATTACH_CUSTOMORIGIN, caster )
		ParticleManager:SetParticleControlEnt(pfx, 0, caster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
		Timers:CreateTimer(1, function() 
		  ParticleManager:DestroyParticle( pfx, false )
		end)  
end

function Filters:SpiritGlove(caster)
	local allies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, 600, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, 0, FIND_ANY_ORDER, false )
	local healAmount = caster:GetIntellect()*15
	if #allies > 0 then
		for _,ally in pairs(allies) do
			local particleName = "particles/units/heroes/hero_oracle/white_mage_healheal.vpcf"
			local pfx = ParticleManager:CreateParticle( particleName, PATTACH_CUSTOMORIGIN, caster )
			ParticleManager:SetParticleControlEnt(pfx, 0, caster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", ally:GetAbsOrigin(), true)
			Timers:CreateTimer(1.5, function() 
			  ParticleManager:DestroyParticle( pfx, false )
			end)  
			ally:Heal(healAmount, caster)
			PopupHealing(ally, healAmount)
		end
	end  
end

function Filters:FrostburnGauntlet(caster)
	local icePoint = caster:GetAbsOrigin() + caster:GetForwardVector()*300
	local radius = 240
	EmitSoundOnLocationWithCaster(icePoint, "hero_Crystal.freezingField.explosion", caster)
	local particle = "particles/units/heroes/hero_crystalmaiden/maiden_crystal_nova.vpcf"
	local pfx = ParticleManager:CreateParticle( particle, PATTACH_WORLDORIGIN, caster )
	ParticleManager:SetParticleControl( pfx, 0, icePoint )
	ParticleManager:SetParticleControl( pfx, 1, Vector(radius, 2, radius*2) )
	Timers:CreateTimer(2.5, function()
		ParticleManager:DestroyParticle(pfx, false)
	end)
	local damage = Filters:GetPrimaryAttributeMultiple(caster, 2)
	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), icePoint, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, FIND_ANY_ORDER, false )
	if #enemies > 0 then	
		for _,enemy in pairs(enemies) do
			caster.frostburnItem:ApplyDataDrivenModifier(caster, enemy, "modifier_frostburn_gauntlets_slow", {duration = 2.5})
			ApplyDamage({ victim = enemy, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
		end
	end
end

function Filters:GetPrimaryAttributeMultiple(hero, multiple)
	local primeAttribute = hero:GetPrimaryAttribute()
	local damage = 0
	if primeAttribute == 0 then
		damage = hero:GetStrength()*multiple
	elseif primeAttribute == 1 then
		damage = hero:GetAgility()*multiple
	elseif primeAttribute == 2 then
		damage = hero:GetIntellect()*multiple
	end
	return damage
end

function Filters:VioletBoot(caster)
	local fv = caster:GetForwardVector()
	fv = WallPhysics:rotateVector(fv,math.pi)
	Filters:VioletProjectile(caster, fv)
	Filters:VioletProjectile(caster, WallPhysics:rotateVector(fv,math.pi/9))
	Filters:VioletProjectile(caster, WallPhysics:rotateVector(fv,-math.pi/9))
	EmitSoundOnLocationWithCaster(caster:GetAbsOrigin(), "Hero_Tinker.LaserImpact", caster)
end

function Filters:VioletProjectile(caster, fv)
	local projectileParticle = "particles/econ/items/mirana/mirana_crescent_arrow/violet_boots.vpcf"

	local projectileOrigin = caster:GetAbsOrigin()
	local start_radius = 160
	local end_radius = 160
	local range = 1200
	local speed = 850
	local info = 
	{
			Ability = caster.violetBoot,
        	EffectName = projectileParticle,
        	vSpawnOrigin = projectileOrigin+Vector(0,0,200),
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

function Filters:SonicBoot(caster)
	local inventoryUnit = caster.InventoryUnit
	local ability = inventoryUnit.foot_item
	ability:ApplyDataDrivenModifier(inventoryUnit, caster, "modifier_sonic_boots_effect", {duration = 6})
end

function Filters:FalconBoot(caster)
	print("falcon boot?")
	local fv = caster:GetForwardVector()
	local point = caster:GetAbsOrigin() + fv*120
	Filters:FalconProjectile(caster, fv, point)
	Filters:FalconProjectile(caster, fv, point+WallPhysics:rotateVector(fv,math.pi/2)*90-fv*80)
	Filters:FalconProjectile(caster, fv, point-WallPhysics:rotateVector(fv,math.pi/2)*90-fv*80)
	Filters:FalconProjectile(caster, fv, point+WallPhysics:rotateVector(fv,math.pi/2)*180-fv*160)
	Filters:FalconProjectile(caster, fv, point-WallPhysics:rotateVector(fv,math.pi/2)*180-fv*160)
	EmitSoundOnLocationWithCaster(caster:GetAbsOrigin(), "Hero_SkywrathMage.ArcaneBolt.Cast", caster)
end

function Filters:FalconProjectile(caster, fv, projectileOrigin)
	local projectileParticle = "particles/units/heroes/hero_skywrath_mage/falcon_boot_arcane_bolt.vpcf"

	local start_radius = 120
	local end_radius = 120
	local range = 1400
	local speed = 600
	local info = 
	{
			Ability = caster.falconBoot,
        	EffectName = projectileParticle,
        	vSpawnOrigin = projectileOrigin+Vector(0,0,75),
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

function Filters:MonkeyPaw(caster)
	local item = caster.monkey_paw
	local wishes = item.property1
	if wishes == 1 then
		caster:RemoveModifierByName("modifier_monkey_paw")
		item.property1 = "-"
		RPCItems:SetPropertyValuesSpecial(item, item.property1, "#item_broken_slot", "#444444",  1, "#property_monkey_paw_description")		
	else
		local newWishes = wishes - 1
		item.property1 = newWishes
		RPCItems:SetPropertyValuesSpecial(item, item.property1, "#item_property_monkey_paw", "#E4AE33",  1, "#property_monkey_paw_description")
	end
	RPCItems:RollItemtype(1, caster:GetAbsOrigin(), 5, 1)
end

function Filters:EternalFrost(caster)
		local particle = "particles/units/heroes/hero_crystalmaiden/maiden_crystal_nova.vpcf"
		local pfx = ParticleManager:CreateParticle( particle, PATTACH_WORLDORIGIN, caster )
		local position = caster:GetAbsOrigin()
		local radius = 500
		ParticleManager:SetParticleControl( pfx, 0, position )
		ParticleManager:SetParticleControl( pfx, 1, Vector(radius, 2, radius*2) )
		Timers:CreateTimer(3, function()
			ParticleManager:DestroyParticle(pfx, false)
		end)
      	local ability = caster.eternal_frost_gem
      	EmitSoundOn("Hero_Ancient_Apparition.IceBlast.Target", caster)
      	
      	local damage = caster:GetIntellect()*8
		local enemies = FindUnitsInRadius( caster:GetTeamNumber(), position, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, FIND_ANY_ORDER, false )
		local freezeDuration = 2.5
		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				ApplyDamage({ victim = enemy, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
				ability:ApplyDataDrivenModifier(caster, enemy, "modifier_eternal_frost_nova", {duration = freezeDuration})
			end
		end 
end

function Filters:CeruleanHighguard(caster)
	local ability = caster:GetAbilityByIndex(1)
	local manaCost = ability:GetManaCost(ability:GetLevel())
	caster:ReduceMana(manaCost*4)
end

function Filters:AscensionTrigger(caster)
	local ability = caster.InventoryUnit.ascendancy
	ability:ApplyDataDrivenModifier(caster.InventoryUnit, caster, "modifier_super_ascendency_trigger", {duration = 7})
end

function Filters:ScourgeKnight(caster)
	local fv = caster:GetForwardVector()
	local casterOrigin = caster:GetAbsOrigin()
	local perpFv = WallPhysics:rotateVector(fv, math.pi/2)
	local spawnPosition = casterOrigin-fv*180
	local vectorTable = {spawnPosition-perpFv*240, spawnPosition-perpFv*120, spawnPosition, spawnPosition+perpFv*120, spawnPosition+perpFv*240}
	for i = 1, #vectorTable, 1 do
		local archer = CreateUnitByName("skeleton_archer", vectorTable[i], true, nil, nil, DOTA_TEAM_GOODGUYS)
		archer.owner = caster:GetPlayerOwnerID()
		archer.summoner = caster
		archer:SetOwner(caster)
		archer:SetControllableByPlayer(caster:GetPlayerID(), true)
		archer.dieTime = 12
		archer:AddAbility("ability_die_after_time_generic"):SetLevel(1)
		local summonAbil = archer:AddAbility("ability_summoned_unit")
		summonAbil:SetLevel(1)
		summonAbil:ApplyDataDrivenModifier(archer, archer, "modifier_summoned_unit_damage_increase", {duration = 30})
		archer:SetModifierStackCount( "modifier_summoned_unit_damage_increase", summonAbil, caster:GetAttackDamage()/10)	
		archer:SetForwardVector(fv)

		local skeleHealth = math.floor(caster:GetMaxHealth()*0.15)
		archer:SetMaxHealth(skeleHealth)
		archer:SetBaseMaxHealth(skeleHealth)
		archer:SetHealth(skeleHealth)
		archer:Heal(skeleHealth, archer)
		archer:SetMoveCapability(DOTA_UNIT_CAP_MOVE_NONE)
		archer:SetModelScale(0.7)
		archer:SetPhysicalArmorBaseValue(10)
	end
end

function Filters:SummonUnit(caster, position, damageIncrease, maxHealth, lifeDuration)
end