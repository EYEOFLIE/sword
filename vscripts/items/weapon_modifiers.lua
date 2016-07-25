if Weaponmodifiers == nil then
  Weaponmodifiers = class({})
end


function Weaponmodifiers:add_modifiers(hero, inventory_unit, item)
	print(item)
	local weapon_ability = inventory_unit:FindAbilityByName("weapon_slot")
	weapon_ability.strength = 0
	weapon_ability.agility = 0
	weapon_ability.intelligence = 0
	weapon_ability.attack_damage = 0
	weapon_ability.critical_strike = 0
	weapon_ability.splash_damage = 0
	Weaponmodifiers:action(item.property1name, item.property1, hero, inventory_unit, weapon_ability, item)
	Weaponmodifiers:runeProperty(item.property1name, item.property1, hero)
	if item.property2name then
		Weaponmodifiers:action(item.property2name, item.property2, hero, inventory_unit, weapon_ability, item)
		Weaponmodifiers:runeProperty(item.property2name, item.property2, hero)
	end
	if item.property3name then
		Weaponmodifiers:action(item.property3name, item.property3, hero, inventory_unit, weapon_ability, item)
		Weaponmodifiers:runeProperty(item.property3name, item.property3, hero)
	end
	if item.property4name then
		Weaponmodifiers:action(item.property4name, item.property4, hero, inventory_unit, weapon_ability, item)
		Weaponmodifiers:runeProperty(item.property4name, item.property4, hero)
	end
end


function Weaponmodifiers:action(propertyName, propertyValue, hero, inventory_unit, weapon_ability, item)
	if propertyName == "strength" then
		weapon_ability.strength = weapon_ability.strength + propertyValue
		Weaponmodifiers:addBasicModifier(weapon_ability.strength, hero, inventory_unit, "modifier_weapon_strength", weapon_ability)
	elseif propertyName == "agility" then
		weapon_ability.agility = weapon_ability.agility + propertyValue
		Weaponmodifiers:addBasicModifier(weapon_ability.agility, hero, inventory_unit, "modifier_weapon_agility", weapon_ability)
	elseif propertyName == "intelligence" then
		weapon_ability.intelligence = weapon_ability.intelligence + propertyValue
		Weaponmodifiers:addBasicModifier(weapon_ability.intelligence, hero, inventory_unit, "modifier_weapon_intelligence", weapon_ability)
	elseif propertyName == "attack_damage" then
		weapon_ability.attack_damage = weapon_ability.attack_damage + propertyValue
		Weaponmodifiers:addBasicModifier(weapon_ability.attack_damage, hero, inventory_unit, "modifier_weapon_attack_damage", weapon_ability)
	elseif propertyName == "critical_strike" then
		weapon_ability.critical_strike = weapon_ability.critical_strike + propertyValue
		Weaponmodifiers:addBasicModifier(weapon_ability.critical_strike, hero, inventory_unit, "modifier_weapon_critical_strike", weapon_ability)
	elseif propertyName == "aspect_health" then
		hero.aspectHealthAbility = weapon_ability
		Weaponmodifiers:addBasicModifier(propertyValue, hero, inventory_unit, "modifier_weapon_aspect_health", weapon_ability)
	elseif propertyName == "splash_damage" then
		weapon_ability.splash_damage = weapon_ability.splash_damage + propertyValue
		Weaponmodifiers:addBasicModifier(weapon_ability.splash_damage, hero, inventory_unit, "modifier_weapon_splash_damage", weapon_ability)
	end
end

function Weaponmodifiers:addItemModifier(propertyValue, hero, inventory_unit, modifier_name, weapon_ability)
	weapon_ability:ApplyDataDrivenModifier(inventory_unit, hero, modifier_name, {})
	if propertyValue > 0 then
		hero:SetModifierStackCount( modifier_name, weapon_ability, propertyValue )
	end
end

function Weaponmodifiers:runeProperty(propertyName, propertyValue, hero)
	if propertyName == "rune_a_a" then
		hero.runeUnit.weapon.a_a = hero.runeUnit.weapon.a_a + propertyValue
		Weaponmodifiers:setRuneBonusNetTable(hero.runeUnit.weapon.a_a, propertyName, hero)
	elseif propertyName == "rune_a_b" then
		hero.runeUnit.weapon.a_b = hero.runeUnit.weapon.a_b + propertyValue
		Weaponmodifiers:setRuneBonusNetTable(hero.runeUnit.weapon.a_b, propertyName, hero)
	elseif propertyName == "rune_a_c" then
		hero.runeUnit.weapon.a_c = hero.runeUnit.weapon.a_c + propertyValue
		Weaponmodifiers:setRuneBonusNetTable(hero.runeUnit.weapon.a_c, propertyName, hero)
	elseif propertyName == "rune_a_d" then
		hero.runeUnit.weapon.a_d = hero.runeUnit.weapon.a_d + propertyValue
		Weaponmodifiers:setRuneBonusNetTable(hero.runeUnit.weapon.a_d, propertyName, hero)
	elseif propertyName == "rune_b_a" then
		hero.runeUnit2.weapon.b_a = hero.runeUnit2.weapon.b_a + propertyValue
		Weaponmodifiers:setRuneBonusNetTable(hero.runeUnit2.weapon.b_a, propertyName, hero)
	elseif propertyName == "rune_b_b" then
		hero.runeUnit2.weapon.b_b = hero.runeUnit2.weapon.b_b + propertyValue
		Weaponmodifiers:setRuneBonusNetTable(hero.runeUnit2.weapon.b_b, propertyName, hero)
	elseif propertyName == "rune_b_c" then
		hero.runeUnit2.weapon.b_c = hero.runeUnit2.weapon.b_c + propertyValue
		Weaponmodifiers:setRuneBonusNetTable(hero.runeUnit2.weapon.b_c, propertyName, hero)
	elseif propertyName == "rune_b_d" then
		hero.runeUnit2.weapon.b_d = hero.runeUnit2.weapon.b_d + propertyValue
		Weaponmodifiers:setRuneBonusNetTable(hero.runeUnit2.weapon.b_d, propertyName, hero)
	elseif propertyName == "rune_c_a" then
		hero.runeUnit3.weapon.c_a = hero.runeUnit3.weapon.c_a + propertyValue
		Weaponmodifiers:setRuneBonusNetTable(hero.runeUnit3.weapon.c_a, propertyName, hero)
	elseif propertyName == "rune_c_b" then
		hero.runeUnit3.weapon.c_b = hero.runeUnit3.weapon.c_b + propertyValue
		Weaponmodifiers:setRuneBonusNetTable(hero.runeUnit3.weapon.c_b, propertyName, hero)
	elseif propertyName == "rune_c_c" then
		hero.runeUnit3.weapon.c_c = hero.runeUnit3.weapon.c_c + propertyValue
		Weaponmodifiers:setRuneBonusNetTable(hero.runeUnit3.weapon.c_c, propertyName, hero)
	elseif propertyName == "rune_c_d" then
		hero.runeUnit3.weapon.c_d = hero.runeUnit3.weapon.c_d + propertyValue
		Weaponmodifiers:setRuneBonusNetTable(hero.runeUnit3.weapon.c_d, propertyName, hero)
	end
end

function Weaponmodifiers:setRuneBonusNetTable(value, rune, hero)
	CustomNetTables:SetTableValue("skill_tree", tostring(hero:GetEntityIndex()).."_"..rune.."_weapon", {bonus = value} )
	print("Setting Rune Net Table: ")
	print(tostring(hero:GetEntityIndex()).."_"..rune.."_weapon")
end

function Weaponmodifiers:addBasicModifier(propertyValue, hero, inventory_unit, modifier_name, weapon_ability)
	print(inventory_unit)
	--local stacks = hero:GetModifierStackCount(modifierName, inventory_unit)
	weapon_ability = inventory_unit:FindAbilityByName("weapon_slot")
	weapon_ability:ApplyDataDrivenModifier(inventory_unit, hero, modifier_name, {})
	--hero:SetModifierStackCount( modifier_name, weapon_ability, (propertyValue+stacks) )
	hero:SetModifierStackCount( modifier_name, weapon_ability, propertyValue )
end

function Weaponmodifiers:remove_modifiers(hero)
	hero:RemoveModifierByName("modifier_weapon_strength")
	hero:RemoveModifierByName("modifier_weapon_agility")
	hero:RemoveModifierByName("modifier_weapon_intelligence")
	hero:RemoveModifierByName("modifier_weapon_attack_damage")

	Weaponmodifiers:remove_rune_bonuses(hero)
end

function Weaponmodifiers:remove_rune_bonuses(hero)
	hero.runeUnit.weapon.a_a = 0
	hero.runeUnit.weapon.a_b = 0
	hero.runeUnit.weapon.a_c = 0
	hero.runeUnit.weapon.a_d = 0
	hero.runeUnit2.weapon.b_a = 0
	hero.runeUnit2.weapon.b_b = 0
	hero.runeUnit2.weapon.b_c = 0
	hero.runeUnit2.weapon.b_d = 0
	hero.runeUnit3.weapon.c_a = 0
	hero.runeUnit3.weapon.c_b = 0
	hero.runeUnit3.weapon.c_c = 0
	hero.runeUnit3.weapon.c_d = 0
	Runes:ResetRuneBonuses(hero, "weapon")
end