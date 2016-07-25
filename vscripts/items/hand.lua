if Hand == nil then
  Hand = class({})
end


function Hand:add_modifiers(hero, inventory_unit, item)
	print(item)
	local hand_ability = inventory_unit:FindAbilityByName("hand_slot")
	hand_ability.strength = 0
	hand_ability.agility = 0
	hand_ability.intelligence = 0
	hand_ability.magic_resist = 0
	hand_ability.armor = 0
	hand_ability.health_regen = 0
	hand_ability.mana_regen = 0
	hand_ability.attack_speed = 0
	hand_ability.cooldown_reduce = 0
	hand_ability.respawn_reduce = 0
	hand_ability.max_health = 0
	Hand:action(item.property1name, item.property1, hero, inventory_unit, hand_ability, item)
	Hand:runeProperty(item.property1name, item.property1, hero)
	if item.property2name then
		Hand:action(item.property2name, item.property2, hero, inventory_unit, hand_ability, item)
		Hand:runeProperty(item.property2name, item.property2, hero)
	end
	if item.property3name then
		Hand:action(item.property3name, item.property3, hero, inventory_unit, hand_ability, item)
		Hand:runeProperty(item.property3name, item.property3, hero)
	end
	if item.property4name then
		Hand:action(item.property4name, item.property4, hero, inventory_unit, hand_ability, item)
		Hand:runeProperty(item.property4name, item.property4, hero)
	end
end


function Hand:action(propertyName, propertyValue, hero, inventory_unit, hand_ability, item)
	if propertyName == "strength" then
		hand_ability.strength = hand_ability.strength + propertyValue
		Hand:addBasicModifier(hand_ability.strength, hero, inventory_unit, "modifier_hand_strength", hand_ability)
	elseif propertyName == "agility" then
		hand_ability.agility = hand_ability.agility + propertyValue
		Hand:addBasicModifier(hand_ability.agility, hero, inventory_unit, "modifier_hand_agility", hand_ability)
	elseif propertyName == "intelligence" then
		hand_ability.intelligence = hand_ability.intelligence + propertyValue
		Hand:addBasicModifier(hand_ability.intelligence, hero, inventory_unit, "modifier_hand_intelligence", hand_ability)
	elseif propertyName == "magic_resist" then
		hand_ability.magic_resist = hand_ability.magic_resist + propertyValue
		Hand:addBasicModifier(hand_ability.magic_resist, hero, inventory_unit, "modifier_hand_magic_resist", hand_ability)
	elseif propertyName == "armor" then
		hand_ability.armor = hand_ability.armor + propertyValue
		Hand:addBasicModifier(hand_ability.armor, hero, inventory_unit, "modifier_hand_armor", hand_ability)
	elseif propertyName == "health_regen" then
		hand_ability.health_regen = hand_ability.health_regen + propertyValue
		Hand:addBasicModifier(hand_ability.health_regen, hero, inventory_unit, "modifier_hand_health_regen", hand_ability)
	elseif propertyName == "mana_regen" then
		hand_ability.mana_regen = hand_ability.mana_regen + propertyValue
		Hand:addBasicModifier(hand_ability.mana_regen, hero, inventory_unit, "modifier_hand_mana_regen", hand_ability)
	elseif propertyName == "attack_speed" then
		hand_ability.attack_speed = hand_ability.attack_speed + propertyValue
		Hand:addBasicModifier(hand_ability.attack_speed, hero, inventory_unit, "modifier_hand_attack_speed", hand_ability)
	elseif propertyName == "cooldown_reduction" then
		hand_ability.cooldown_reduce = hand_ability.cooldown_reduce + propertyValue
		Hand:addBasicModifier(hand_ability.cooldown_reduce, hero, inventory_unit, "modifier_hand_cooldown_reduce", hand_ability)
	elseif propertyName == "respawn_reduce" then
		hand_ability.respawn_reduce = hand_ability.respawn_reduce + propertyValue
		Hand:addBasicModifier(hand_ability.respawn_reduce, hero, inventory_unit, "modifier_hand_respawn", hand_ability)
	elseif propertyName == "max_health" then
		hand_ability.max_health = hand_ability.max_health + propertyValue
		Hand:addBasicModifier(hand_ability.max_health, hero, inventory_unit, "modifier_hand_max_health", hand_ability)
	elseif propertyName == "berserker_rage" then
		Hand:addBasicModifier(1, hero, inventory_unit, "modifier_hand_berserker", hand_ability)
	elseif propertyName == "shadow_armlet" then
		Hand:addBasicModifier(1, hero, inventory_unit, "modifier_shadow_armlet", hand_ability)
	elseif propertyName == "boneguard" then
		Hand:addBasicModifier(1, hero, inventory_unit, "modifier_hand_boneguard", hand_ability)
	elseif propertyName == "scorched_gauntlet" then
		hand_ability.scorchDamage = propertyValue
		Hand:addBasicModifier(1, hero, inventory_unit, "modifier_hand_scorched_earth", hand_ability)
	elseif propertyName == "pride" then
		Hand:addBasicModifier(1, hero, inventory_unit, "modifier_hand_pride", hand_ability)		
	elseif propertyName == "azinoth" then
		Hand:addBasicModifier(1, hero, inventory_unit, "modifier_hand_azinoth", hand_ability)
	elseif propertyName == "divine_purity" then
		Hand:addBasicModifier(1, hero, inventory_unit, "modifier_divine_purity", hand_ability)
	elseif propertyName == "marauder" then
		Hand:addItemModifier(0, hero, inventory_unit, "modifier_hand_marauder", item)
	elseif propertyName == "elder_grasp" then
		Hand:addBasicModifier(1, hero, inventory_unit, "modifier_hand_elder", hand_ability)
	elseif propertyName == "midas" then
		Hand:addItemModifier(0, hero, inventory_unit, "modifier_hand_of_midas", item)
	elseif propertyName == "scarecrow" then
		Hand:addItemModifier(0, hero, inventory_unit, "modifier_scarecrow_gloves", item)
	elseif propertyName == "living_gauntlet" then
		Hand:addItemModifier(0, hero, inventory_unit, "modifier_living_gauntlet", item)
	elseif propertyName == "master" then
		Hand:addItemModifier(0, hero, inventory_unit, "modifier_master_gloves", item)
	elseif propertyName == "phoenix" then
		Hand:addItemModifier(0, hero, inventory_unit, "modifier_phoenix_gloves", item)
	elseif propertyName == "spirit" then
		Hand:addItemModifier(0, hero, inventory_unit, "modifier_spirit_glove", item)
	elseif propertyName == "frostburn" then
		hero.frostburnItem = item
		Hand:addItemModifier(0, hero, inventory_unit, "modifier_frostburn_gauntlets", item)
	end
end

function Hand:addItemModifier(propertyValue, hero, inventory_unit, modifier_name, hand_ability)
	hand_ability:ApplyDataDrivenModifier(inventory_unit, hero, modifier_name, {})
	if propertyValue > 0 then
		hero:SetModifierStackCount( modifier_name, hand_ability, propertyValue )
	end
end

function Hand:runeProperty(propertyName, propertyValue, hero)
	if propertyName == "rune_a_a" then
		hero.runeUnit.hand.a_a = hero.runeUnit.hand.a_a + propertyValue
		Hand:setRuneBonusNetTable(hero.runeUnit.hand.a_a, propertyName, hero)
	elseif propertyName == "rune_a_b" then
		hero.runeUnit.hand.a_b = hero.runeUnit.hand.a_b + propertyValue
		Hand:setRuneBonusNetTable(hero.runeUnit.hand.a_b, propertyName, hero)
	elseif propertyName == "rune_a_c" then
		hero.runeUnit.hand.a_c = hero.runeUnit.hand.a_c + propertyValue
		Hand:setRuneBonusNetTable(hero.runeUnit.hand.a_c, propertyName, hero)
	elseif propertyName == "rune_a_d" then
		hero.runeUnit.hand.a_d = hero.runeUnit.hand.a_d + propertyValue
		Hand:setRuneBonusNetTable(hero.runeUnit.hand.a_d, propertyName, hero)
	elseif propertyName == "rune_b_a" then
		hero.runeUnit2.hand.b_a = hero.runeUnit2.hand.b_a + propertyValue
		Hand:setRuneBonusNetTable(hero.runeUnit2.hand.b_a, propertyName, hero)
	elseif propertyName == "rune_b_b" then
		hero.runeUnit2.hand.b_b = hero.runeUnit2.hand.b_b + propertyValue
		Hand:setRuneBonusNetTable(hero.runeUnit2.hand.b_b, propertyName, hero)
	elseif propertyName == "rune_b_c" then
		hero.runeUnit2.hand.b_c = hero.runeUnit2.hand.b_c + propertyValue
		Hand:setRuneBonusNetTable(hero.runeUnit2.hand.b_c, propertyName, hero)
	elseif propertyName == "rune_b_d" then
		hero.runeUnit2.hand.b_d = hero.runeUnit2.hand.b_d + propertyValue
		Hand:setRuneBonusNetTable(hero.runeUnit2.hand.b_d, propertyName, hero)
	elseif propertyName == "rune_c_a" then
		hero.runeUnit3.hand.c_a = hero.runeUnit3.hand.c_a + propertyValue
		Hand:setRuneBonusNetTable(hero.runeUnit3.hand.c_a, propertyName, hero)
	elseif propertyName == "rune_c_b" then
		hero.runeUnit3.hand.c_b = hero.runeUnit3.hand.c_b + propertyValue
		Hand:setRuneBonusNetTable(hero.runeUnit3.hand.c_b, propertyName, hero)
	elseif propertyName == "rune_c_c" then
		hero.runeUnit3.hand.c_c = hero.runeUnit3.hand.c_c + propertyValue
		Hand:setRuneBonusNetTable(hero.runeUnit3.hand.c_c, propertyName, hero)
	elseif propertyName == "rune_c_d" then
		hero.runeUnit3.hand.c_d = hero.runeUnit3.hand.c_d + propertyValue
		Hand:setRuneBonusNetTable(hero.runeUnit3.hand.c_d, propertyName, hero)
	end
end

function Hand:setRuneBonusNetTable(value, rune, hero)
	CustomNetTables:SetTableValue("skill_tree", tostring(hero:GetEntityIndex()).."_"..rune.."_hand", {bonus = value} )
	print("Setting Rune Net Table: ")
	print(tostring(hero:GetEntityIndex()).."_"..rune.."_hand")
end

function Hand:addBasicModifier(propertyValue, hero, inventory_unit, modifier_name, hand_ability)
	print(inventory_unit)
	--local stacks = hero:GetModifierStackCount(modifierName, inventory_unit)
	hand_ability = inventory_unit:FindAbilityByName("hand_slot")
	hand_ability:ApplyDataDrivenModifier(inventory_unit, hero, modifier_name, {})
	--hero:SetModifierStackCount( modifier_name, hand_ability, (propertyValue+stacks) )
	hero:SetModifierStackCount( modifier_name, hand_ability, propertyValue )
end

function Hand:remove_modifiers(hero)
	hero:RemoveModifierByName("modifier_hand_strength")
	hero:RemoveModifierByName("modifier_hand_agility")
	hero:RemoveModifierByName("modifier_hand_intelligence")
	hero:RemoveModifierByName("modifier_hand_magic_resist")
	hero:RemoveModifierByName("modifier_hand_armor")
	hero:RemoveModifierByName("modifier_hand_health_regen")
	hero:RemoveModifierByName("modifier_hand_mana_regen")
	hero:RemoveModifierByName("modifier_hand_attack_speed")
	hero:RemoveModifierByName("modifier_hand_cooldown_reduce")
	hero:RemoveModifierByName("modifier_hand_respawn")
	hero:RemoveModifierByName("modifier_hand_respawn")
	hero:RemoveModifierByName("modifier_hand_berserker")
	hero:RemoveModifierByName("modifier_shadow_armlet")
	hero:RemoveModifierByName("modifier_hand_boneguard")
	hero:RemoveModifierByName("modifier_hand_scorched_earth")
	hero:RemoveModifierByName("modifier_hand_pride")
	hero:RemoveModifierByName("modifier_hand_azinoth")
	hero:RemoveModifierByName("modifier_divine_purity")
	hero:RemoveModifierByName("modifier_hand_max_health")
	hero:RemoveModifierByName("modifier_hand_elder")
	hero:RemoveModifierByName("modifier_hand_of_midas")
	hero:RemoveModifierByName("modifier_hand_of_midas_effect")
	hero:RemoveModifierByName("modifier_scarecrow_gloves")
	hero:RemoveModifierByName("modifier_scarecrow_gloves_effect")
	hero:RemoveModifierByName("modifier_living_gauntlet")
	hero:RemoveModifierByName("modifier_living_gauntlet_effect_regen")
	hero:RemoveModifierByName("modifier_living_gauntlet_effect_armor")
	hero:RemoveModifierByName("modifier_master_gloves")
	hero:RemoveModifierByName("modifier_phoenix_gloves")
	hero:RemoveModifierByName("modifier_phoenix_gloves_effect")
	hero:RemoveModifierByName("modifier_spirit_glove")
	hero:RemoveModifierByName("modifier_frostburn_gauntlets")



	Hand:remove_rune_bonuses(hero)
end

function Hand:remove_rune_bonuses(hero)
	hero.runeUnit.hand.a_a = 0
	hero.runeUnit.hand.a_b = 0
	hero.runeUnit.hand.a_c = 0
	hero.runeUnit.hand.a_d = 0
	hero.runeUnit2.hand.b_a = 0
	hero.runeUnit2.hand.b_b = 0
	hero.runeUnit2.hand.b_c = 0
	hero.runeUnit2.hand.b_d = 0
	hero.runeUnit3.hand.c_a = 0
	hero.runeUnit3.hand.c_b = 0
	hero.runeUnit3.hand.c_c = 0
	hero.runeUnit3.hand.c_d = 0
	Runes:ResetRuneBonuses(hero, "hand")
end