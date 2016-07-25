if Runes == nil then
  Runes = class({})
end

function Runes:RedirectRunes(hero, runeUnit, runeUnit2, runeUnit3, playerID)
	local heroName = hero:GetName()
	if heroName == "npc_dota_hero_dragon_knight" then
		Runes:CollectHeroRunes(runeUnit, runeUnit2, runeUnit3, playerID, "flamewaker")
	elseif heroName == "npc_dota_hero_phantom_assassin" then
		Runes:CollectHeroRunes(runeUnit, runeUnit2, runeUnit3, playerID, "voltex")
	elseif heroName == "npc_dota_hero_necrolyte" then
		Runes:CollectHeroRunes(runeUnit, runeUnit2, runeUnit3, playerID, "venomort")
	elseif heroName == "npc_dota_hero_axe" then
		Runes:CollectHeroRunes(runeUnit, runeUnit2, runeUnit3, playerID, "axe")
	elseif heroName == "npc_dota_hero_drow_ranger" then
		Runes:CollectHeroRunes(runeUnit, runeUnit2, runeUnit3, playerID, "astral")
	elseif heroName == "npc_dota_hero_obsidian_destroyer" then
		Runes:CollectHeroRunes(runeUnit, runeUnit2, runeUnit3, playerID, "epoch")
	elseif heroName == "npc_dota_hero_omniknight" then
		Runes:CollectHeroRunes(runeUnit, runeUnit2, runeUnit3, playerID, "paladin")
	elseif heroName == "npc_dota_hero_crystal_maiden" then
		Runes:CollectHeroRunes(runeUnit, runeUnit2, runeUnit3, playerID, "sorceress")
	elseif heroName == "npc_dota_hero_invoker" then
		Runes:CollectHeroRunes(runeUnit, runeUnit2, runeUnit3, playerID, "conjuror")
	elseif heroName == "npc_dota_hero_juggernaut" then
		Runes:CollectHeroRunes(runeUnit, runeUnit2, runeUnit3, playerID, "monk")
	elseif heroName == "npc_dota_hero_beastmaster" then
		Runes:CollectHeroRunes(runeUnit, runeUnit2, runeUnit3, playerID, "warlord")
	elseif heroName == "npc_dota_hero_leshrac" then
		Runes:CollectHeroRunes(runeUnit, runeUnit2, runeUnit3, playerID, "bahamut")
	end
    runeUnit:AddAbility("town_unit"):SetLevel(1)
    runeUnit2:AddAbility("town_unit"):SetLevel(1) 
    runeUnit3:AddAbility("town_unit"):SetLevel(1)
    runeUnit.hero = hero
    runeUnit2.hero = hero
    runeUnit3.hero = hero
    runeUnit.owner = playerID
    runeUnit2.owner = playerID
    runeUnit3.owner = playerID
    setRunesBonuses(runeUnit, runeUnit2, runeUnit3)
    Runes:ResetRuneBonuses(hero, "amulet")
    Runes:ResetRuneBonuses(hero, "hand")
    Runes:ResetRuneBonuses(hero, "body")
end

function setRunesBonuses(runeUnit, runeUnit2, runeUnit3)
    runeUnit.amulet = {}
    runeUnit.amulet.a_a = 0
    runeUnit.amulet.a_b = 0
    runeUnit.amulet.a_c = 0
    runeUnit.amulet.a_d = 0
    runeUnit2.amulet = {}
    runeUnit2.amulet.b_a = 0
    runeUnit2.amulet.b_b = 0
    runeUnit2.amulet.b_c = 0
    runeUnit2.amulet.b_d = 0
    runeUnit3.amulet = {}
    runeUnit3.amulet.c_a = 0
    runeUnit3.amulet.c_b = 0
    runeUnit3.amulet.c_c = 0
    runeUnit3.amulet.c_d = 0

    runeUnit.hand = {}
    runeUnit.hand.a_a = 0
    runeUnit.hand.a_b = 0
    runeUnit.hand.a_c = 0
    runeUnit.hand.a_d = 0
    runeUnit2.hand = {}
    runeUnit2.hand.b_a = 0
    runeUnit2.hand.b_b = 0
    runeUnit2.hand.b_c = 0
    runeUnit2.hand.b_d = 0
    runeUnit3.hand = {}
    runeUnit3.hand.c_a = 0
    runeUnit3.hand.c_b = 0
    runeUnit3.hand.c_c = 0
    runeUnit3.hand.c_d = 0

    runeUnit.body = {}
    runeUnit.body.a_a = 0
    runeUnit.body.a_b = 0
    runeUnit.body.a_c = 0
    runeUnit.body.a_d = 0
    runeUnit2.body = {}
    runeUnit2.body.b_a = 0
    runeUnit2.body.b_b = 0
    runeUnit2.body.b_c = 0
    runeUnit2.body.b_d = 0
    runeUnit3.body = {}
    runeUnit3.body.c_a = 0
    runeUnit3.body.c_b = 0
    runeUnit3.body.c_c = 0
    runeUnit3.body.c_d = 0

    runeUnit.head = {}
    runeUnit.head.a_a = 0
    runeUnit.head.a_b = 0
    runeUnit.head.a_c = 0
    runeUnit.head.a_d = 0
    runeUnit2.head = {}
    runeUnit2.head.b_a = 0
    runeUnit2.head.b_b = 0
    runeUnit2.head.b_c = 0
    runeUnit2.head.b_d = 0
    runeUnit3.head = {}
    runeUnit3.head.c_a = 0
    runeUnit3.head.c_b = 0
    runeUnit3.head.c_c = 0
    runeUnit3.head.c_d = 0

    runeUnit.weapon = {}
    runeUnit.weapon.a_a = 0
    runeUnit.weapon.a_b = 0
    runeUnit.weapon.a_c = 0
    runeUnit.weapon.a_d = 0
    runeUnit2.weapon = {}
    runeUnit2.weapon.b_a = 0
    runeUnit2.weapon.b_b = 0
    runeUnit2.weapon.b_c = 0
    runeUnit2.weapon.b_d = 0
    runeUnit3.weapon = {}
    runeUnit3.weapon.c_a = 0
    runeUnit3.weapon.c_b = 0
    runeUnit3.weapon.c_c = 0
    runeUnit3.weapon.c_d = 0

    runeUnit.foot = {}
    runeUnit.foot.a_a = 0
    runeUnit.foot.a_b = 0
    runeUnit.foot.a_c = 0
    runeUnit.foot.a_d = 0
    runeUnit2.foot = {}
    runeUnit2.foot.b_a = 0
    runeUnit2.foot.b_b = 0
    runeUnit2.foot.b_c = 0
    runeUnit2.foot.b_d = 0
    runeUnit3.foot = {}
    runeUnit3.foot.c_a = 0
    runeUnit3.foot.c_b = 0
    runeUnit3.foot.c_c = 0
    runeUnit3.foot.c_d = 0
end

function Runes:RunesOnRespawn(hero)
	local heroName = hero:GetName()
	if heroName == "npc_dota_hero_crystal_maiden" then
		  local runeUnit = hero.runeUnit2
		  local runeAbility = runeUnit:FindAbilityByName("sorceress_rune_b_a")
		  local abilityLevel = runeAbility:GetLevel()
		  local bonusLevel = Runes:GetTotalBonus(runeUnit, "b_a")
		  local totalLevel = abilityLevel + bonusLevel
		  if totalLevel > 0 then
		  	runeAbility:ApplyDataDrivenModifier(runeUnit, hero, "modifier_frost_nova_up", {})
		  	hero:RemoveModifierByName("modifier_frost_nova_down")
		  end
		  runeUnit = hero.runeUnit3
		  runeAbility = runeUnit:FindAbilityByName("sorceress_rune_c_d")
		  abilityLevel = runeAbility:GetLevel()
		  bonusLevel = Runes:GetTotalBonus(runeUnit, "c_d")
		  totalLevel = abilityLevel + bonusLevel
		  if totalLevel > 0 then
		  	runeAbility:ApplyDataDrivenModifier(runeUnit, hero, "modifier_ring_of_fire_up", {})
		  	hero:RemoveModifierByName("modifier_ring_of_fire_down")
		  end
	end
	if heroName == "npc_dota_hero_omniknight" then
		  local runeUnit = hero.runeUnit3
		  local runeAbility = runeUnit:FindAbilityByName("paladin_rune_c_a")
		  local abilityLevel = runeAbility:GetLevel()
		  local bonusLevel = Runes:GetTotalBonus(runeUnit, "c_a")
		  local totalLevel = abilityLevel + bonusLevel
		  if totalLevel > 0 then
		  	runeAbility:ApplyDataDrivenModifier(runeUnit, hero, "modifier_paladin_rune_c_a", {})
		  	hero:RemoveModifierByName("modifier_paladin_rune_c_a_cooling_down")
		  end
	end
	if heroName == "npc_dota_hero_juggernaut" then
		-- if hero:HasAbility("odachi_rush") then
		-- 	hero:SwapAbilities("odachi_slice", "odachi_rush", true, false)	
		-- end
		-- if hero:HasAbility("monk_ultima_blade_heal_alt") then
		-- 	hero:SwapAbilities("monk_ultima_blade", "monk_ultima_blade_heal_alt", true, false)
		-- end
	end
end

function Runes:ResetRuneBonuses(hero, slotName)
	CustomNetTables:SetTableValue("skill_tree", tostring(hero:GetEntityIndex()).."_rune_a_a_"..slotName, {bonus = 0} )
    CustomNetTables:SetTableValue("skill_tree", tostring(hero:GetEntityIndex()).."_rune_a_b_"..slotName, {bonus = 0} )
    CustomNetTables:SetTableValue("skill_tree", tostring(hero:GetEntityIndex()).."_rune_a_c_"..slotName, {bonus = 0} )
    CustomNetTables:SetTableValue("skill_tree", tostring(hero:GetEntityIndex()).."_rune_a_d_"..slotName, {bonus = 0} )
    CustomNetTables:SetTableValue("skill_tree", tostring(hero:GetEntityIndex()).."_rune_b_a_"..slotName, {bonus = 0} )
    CustomNetTables:SetTableValue("skill_tree", tostring(hero:GetEntityIndex()).."_rune_b_b_"..slotName, {bonus = 0} )
    CustomNetTables:SetTableValue("skill_tree", tostring(hero:GetEntityIndex()).."_rune_b_c_"..slotName, {bonus = 0} )
    CustomNetTables:SetTableValue("skill_tree", tostring(hero:GetEntityIndex()).."_rune_b_d_"..slotName, {bonus = 0} )
end


function Runes:GetTotalBonus(RuneUnit, rune)
	if rune == "a_a" then
		return RuneUnit.amulet.a_a + RuneUnit.hand.a_a + RuneUnit.body.a_a + RuneUnit.head.a_a + RuneUnit.weapon.a_a + RuneUnit.foot.a_a
	elseif rune == "a_b" then
		return RuneUnit.amulet.a_b + RuneUnit.hand.a_b + RuneUnit.body.a_b + RuneUnit.head.a_b + RuneUnit.weapon.a_b + RuneUnit.foot.a_b
	elseif rune == "a_c" then
		return RuneUnit.amulet.a_c + RuneUnit.hand.a_c + RuneUnit.body.a_c + RuneUnit.head.a_c + RuneUnit.weapon.a_c + RuneUnit.foot.a_c
	elseif rune == "a_d" then
		return RuneUnit.amulet.a_d + RuneUnit.hand.a_d + RuneUnit.body.a_d + RuneUnit.head.a_d + RuneUnit.weapon.a_d + RuneUnit.foot.a_d
	elseif rune == "b_a" then
		return RuneUnit.amulet.b_a + RuneUnit.hand.b_a + RuneUnit.body.b_a + RuneUnit.head.b_a + RuneUnit.weapon.b_a + RuneUnit.foot.b_a
	elseif rune == "b_b" then
		return RuneUnit.amulet.b_b + RuneUnit.hand.b_b + RuneUnit.body.b_b + RuneUnit.head.b_b + RuneUnit.weapon.b_b + RuneUnit.foot.b_b
	elseif rune == "b_c" then
		return RuneUnit.amulet.b_c + RuneUnit.hand.b_c + RuneUnit.body.b_c + RuneUnit.head.b_c + RuneUnit.weapon.b_c + RuneUnit.foot.b_c 
	elseif rune == "b_d" then
		return RuneUnit.amulet.b_d + RuneUnit.hand.b_d + RuneUnit.body.b_d + RuneUnit.head.b_d + RuneUnit.weapon.b_d + RuneUnit.foot.b_d
	elseif rune == "c_a" then
		return RuneUnit.amulet.c_a + RuneUnit.hand.c_a + RuneUnit.body.c_a + RuneUnit.head.c_a + RuneUnit.weapon.c_a + RuneUnit.foot.c_a  
	elseif rune == "c_b" then
		return RuneUnit.amulet.c_b + RuneUnit.hand.c_b + RuneUnit.body.c_b + RuneUnit.head.c_b + RuneUnit.weapon.c_b + RuneUnit.foot.c_b   
	elseif rune == "c_c" then
		return RuneUnit.amulet.c_c + RuneUnit.hand.c_c + RuneUnit.body.c_c + RuneUnit.head.c_c + RuneUnit.weapon.c_c + RuneUnit.foot.c_c
	elseif rune == "c_d" then
		return RuneUnit.amulet.c_d + RuneUnit.hand.c_d + RuneUnit.body.c_d + RuneUnit.head.c_d + RuneUnit.weapon.c_d + RuneUnit.foot.c_d
	end
end

function Runes:CollectHeroRunes(runeUnit, runeUnit2, runeUnit3, player, heroString)
	runeUnit:AddAbility(heroString.."_rune_a_a")
	runeUnit:AddAbility(heroString.."_rune_a_b")
	runeUnit:AddAbility(heroString.."_rune_a_c")
	runeUnit:AddAbility(heroString.."_rune_a_d")

	runeUnit2:AddAbility(heroString.."_rune_b_a")
	runeUnit2:AddAbility(heroString.."_rune_b_b")
	runeUnit2:AddAbility(heroString.."_rune_b_c")
	runeUnit2:AddAbility(heroString.."_rune_b_d")

	runeUnit3:AddAbility(heroString.."_rune_c_a")
	runeUnit3:AddAbility(heroString.."_rune_c_b")
	runeUnit3:AddAbility(heroString.."_rune_c_c")
	runeUnit3:AddAbility(heroString.."_rune_c_d")
end

function Runes:Procs(runeLevel, chancePerLevel, mod)
	chancePerLevel = chancePerLevel/mod
	local procs = ((runeLevel*chancePerLevel)-((runeLevel*chancePerLevel)%100))/100
	local lucky = RandomInt(0, 100)
	if lucky < (runeLevel*chancePerLevel)%100 then
		procs = procs + 1
	end

	return procs
end

function Runes:GetTotalRuneLevel(caster, tier, runeID, heroName)
	local runeUnit = ""
	if tier == 1 then
		runeUnit = caster.runeUnit
	elseif tier == 2 then
		runeUnit = caster.runeUnit2
	elseif tier == 3 then
		runeUnit = caster.runeUnit3
	end
	local runeAbility = runeUnit:FindAbilityByName(heroName.."_rune_"..runeID)
	local abilityLevel = runeAbility:GetLevel()
	local bonusLevel = Runes:GetTotalBonus(runeUnit, runeID)
	local totalLevel = abilityLevel + bonusLevel
	return totalLevel
end

function Runes:apply_runes(ability, unit, PlayerID)
	local hero = PlayerResource:GetSelectedHeroEntity(PlayerID)
	if ability:GetName() == "flamewaker_rune_a_a" then
		ability:ApplyDataDrivenModifier(unit, hero, "modifier_flamewaker_rune_a_a", {})
	end
	if ability:GetName() == "flamewaker_rune_a_b" then
		ability:ApplyDataDrivenModifier(unit, hero, "modifier_flamewaker_rune_a_b", {})
	end
	if ability:GetName() == "voltex_rune_b_a" then
		ability:ApplyDataDrivenModifier(unit, hero, "modifier_voltex_rune_b_a", {})
	end
	if ability:GetName() == "venomort_rune_a_b" then
		ability:ApplyDataDrivenModifier(unit, hero, "modifier_venomort_rune_a_b", {})
	end
	if ability:GetName() == "venomort_rune_b_c" then
		ability:ApplyDataDrivenModifier(unit, hero, "modifier_venomort_rune_b_c", {})
	end
	if ability:GetName() == "venomort_rune_b_a" then
		ability:ApplyDataDrivenModifier(unit, hero, "modifier_venomort_rune_b_a", {})
	end
	if ability:GetName() == "axe_rune_b_a" then
		ability:ApplyDataDrivenModifier(unit, hero, "modifier_axe_rune_b_a_base", {})
	end
	if ability:GetName() == "astral_rune_a_b" then
		ability:ApplyDataDrivenModifier(unit, hero, "modifier_astral_rune_a_b", {})
	end
	if ability:GetName() == "paladin_rune_a_a" then
		ability:ApplyDataDrivenModifier(unit, hero, "modifier_paladin_rune_a_a", {})
	end
	if ability:GetName() == "paladin_rune_a_c" and not hero:HasModifier("modifier_paladin_rune_a_c_revive_cooldown") then
		ability:ApplyDataDrivenModifier(unit, hero, "modifier_paladin_rune_a_c_revivable", {})
	end
	if ability:GetName() == "paladin_rune_b_c" then
		ability:ApplyDataDrivenModifier(unit, hero, "modifier_paladin_rune_b_c", {})
	end
	if ability:GetName() == "paladin_rune_c_a" and not hero:HasModifier("modifier_paladin_rune_c_a_cooling_down") and not hero:HasModifier("modifier_paladin_rune_c_a") then
		ability:ApplyDataDrivenModifier(unit, hero, "modifier_paladin_rune_c_a", {})
	end
	if ability:GetName() == "sorceress_rune_b_a" then
		ability:ApplyDataDrivenModifier(unit, hero, "modifier_frost_nova_up", {})
	end
	if ability:GetName() == "sorceress_rune_c_b" then
		ability:ApplyDataDrivenModifier(unit, hero, "modifier_arcane_intellect_aura", {})
		hero:SetModifierStackCount( "modifier_arcane_intellect_aura", ability, ability:GetLevel())
	end
	if ability:GetName() == "sorceress_rune_c_d" then
		ability:ApplyDataDrivenModifier(unit, hero, "modifier_ring_of_fire_up", {})
	end
	if ability:GetName() == "conjuror_rune_a_a" then
		ability:ApplyDataDrivenModifier(unit, hero, "modifier_earth_guardian", {})
	end
	if ability:GetName() == "conjuror_rune_a_b" then
		if hero.fireAspect then
			ability.totalLevel = ability:GetLevel()
			ability:ApplyDataDrivenModifier(unit, hero.fireAspect , "modifier_permanent_immolation", {})
		end
	end
	if ability:GetName() == "monk_rune_b_b" and not hero:HasModifier("modifier_monk_b_b_down") then
		ability:ApplyDataDrivenModifier(unit, hero, "modifier_monk_b_b_up", {})
	end
	if ability:GetName() == "monk_rune_c_b" then
		ability:ApplyDataDrivenModifier(unit, hero, "modifier_monk_rune_c_b", {})
	end
	
end