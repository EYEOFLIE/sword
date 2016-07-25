if Head == nil then
  Head = class({})
end


function Head:add_modifiers(hero, inventory_unit, item)
	print(item)
	local head_ability = inventory_unit:FindAbilityByName("helm_slot")
	head_ability.strength = 0
	head_ability.agility = 0
	head_ability.intelligence = 0
	head_ability.magic_resist = 0
	head_ability.armor = 0
	head_ability.health_regen = 0
	head_ability.mana_regen = 0
	head_ability.max_health = 0
	head_ability.max_mana = 0
	head_ability.respawn_reduce = 0
	head_ability.attack_speed = 0
	head_ability.attack_damage = 0
	head_ability.lifesteal = 0
	Head:action(item.property1name, item.property1, hero, inventory_unit, head_ability, item)
	Head:runeProperty(item.property1name, item.property1, hero)
	if item.property2name then
		Head:action(item.property2name, item.property2, hero, inventory_unit, head_ability, item)
		Head:runeProperty(item.property2name, item.property2, hero)
	end
	if item.property3name then
		Head:action(item.property3name, item.property3, hero, inventory_unit, head_ability, item)
		Head:runeProperty(item.property3name, item.property3, hero)
	end
	if item.property4name then
		Head:action(item.property4name, item.property4, hero, inventory_unit, head_ability, item)
		Head:runeProperty(item.property4name, item.property4, hero)
	end
end


function Head:action(propertyName, propertyValue, hero, inventory_unit, head_ability, item)
	if propertyName == "strength" then
		head_ability.strength = head_ability.strength + propertyValue
		Head:addBasicModifier(head_ability.strength, hero, inventory_unit, "modifier_helm_strength", head_ability)
	elseif propertyName == "agility" then
		head_ability.agility = head_ability.agility + propertyValue
		Head:addBasicModifier(head_ability.agility, hero, inventory_unit, "modifier_helm_agility", head_ability)
	elseif propertyName == "intelligence" then
		head_ability.intelligence = head_ability.intelligence + propertyValue
		Head:addBasicModifier(head_ability.intelligence, hero, inventory_unit, "modifier_helm_intelligence", head_ability)
	elseif propertyName == "magic_resist" then
		head_ability.magic_resist = head_ability.magic_resist + propertyValue
		Head:addBasicModifier(head_ability.magic_resist, hero, inventory_unit, "modifier_helm_magic_resist", head_ability)
	elseif propertyName == "armor" then
		head_ability.armor = head_ability.armor + propertyValue
		Head:addBasicModifier(head_ability.armor, hero, inventory_unit, "modifier_helm_armor", head_ability)
	elseif propertyName == "health_regen" then
		head_ability.health_regen = head_ability.health_regen + propertyValue
		Head:addBasicModifier(head_ability.health_regen, hero, inventory_unit, "modifier_helm_health_regen", head_ability)
	elseif propertyName == "mana_regen" then
		head_ability.mana_regen = head_ability.mana_regen + propertyValue
		Head:addBasicModifier(head_ability.mana_regen, hero, inventory_unit, "modifier_helm_mana_regen", head_ability)
	elseif propertyName == "max_health" then
		head_ability.max_health = head_ability.max_health + propertyValue
		Head:addBasicModifier(head_ability.max_health, hero, inventory_unit, "modifier_helm_max_health", head_ability)
	elseif propertyName == "max_mana" then
		head_ability.max_mana = head_ability.max_mana + propertyValue
		Head:addBasicModifier(head_ability.max_mana, hero, inventory_unit, "modifier_helm_max_mana", head_ability)
	elseif propertyName == "respawn_reduce" then
		head_ability.respawn_reduce = head_ability.respawn_reduce + propertyValue
		Head:addBasicModifier(head_ability.respawn_reduce, hero, inventory_unit, "modifier_helm_respawn", head_ability)
	elseif propertyName == "white_mage_hat" then
		Head:addBasicModifier(1, hero, inventory_unit, "modifier_white_mage_hat", head_ability)
	elseif propertyName == "attack_speed" then
		head_ability.attack_speed = head_ability.attack_speed + propertyValue
		Head:addBasicModifier(head_ability.attack_speed, hero, inventory_unit, "modifier_helm_attack_speed", head_ability)
	elseif propertyName == "attack_damage" then
		head_ability.attack_damage = head_ability.attack_damage + propertyValue
		Head:addBasicModifier(head_ability.attack_damage, hero, inventory_unit, "modifier_helm_attack_damage", head_ability)
	elseif propertyName == "lifesteal" then
		head_ability.lifesteal = head_ability.lifesteal + propertyValue
		Head:addBasicModifier(head_ability.lifesteal, hero, inventory_unit, "modifier_helm_lifesteal", head_ability)
	elseif propertyName == "vision" then
		Head:addBasicModifier(propertyValue, hero, inventory_unit, "modifier_helm_vision", head_ability)
	elseif propertyName == "hyper_visor" then
		Head:addBasicModifier(1, hero, inventory_unit, "modifier_hyper_visor", head_ability)
	elseif propertyName == "ruby_dragon" then
		Head:addBasicModifier(1, hero, inventory_unit, "modifier_ruby_dragon", head_ability)
	elseif propertyName == "centaur_horns" then
		Head:addBasicModifier(1, hero, inventory_unit, "modifier_centaur_horns", head_ability)
	elseif propertyName == "death_whisper" then
		Head:addBasicModifier(1, hero, inventory_unit, "modifier_death_whisper", head_ability)
	elseif propertyName == "wild_nature_one" then
		Head:addBasicModifier(1, hero, inventory_unit, "modifier_wild_nature_one", head_ability)
	elseif propertyName == "wild_nature_two" then
		Head:addBasicModifier(1, hero, inventory_unit, "modifier_wild_nature_two", head_ability)
	elseif propertyName == "luma_guard" then
		Head:addBasicModifier(1, hero, inventory_unit, "modifier_luma_guard", head_ability)
	elseif propertyName == "odin" then
		Head:addBasicModifier(1, hero, inventory_unit, "modifier_helm_odin", head_ability)
	elseif propertyName == "iron_colossus" then
		Head:addItemModifier(0, hero, inventory_unit, "modifier_iron_colossus", item)
		hero:SetModelScale(hero.origModelScale*1.15)
	elseif propertyName == "mugato" then
		Head:addItemModifier(0, hero, inventory_unit, "modifier_mugato", item)
	elseif propertyName == "swamp_witch" then
		hero.witchHat = item
		Head:addItemModifier(0, hero, inventory_unit, "modifier_witch_hat", item)
	elseif propertyName == "trickster" then
		Head:addItemModifier(0, hero, inventory_unit, "modifier_trickster_mask", item)
		hero.tricksterItem = item
	elseif propertyName == "emerald_douli" then
		Head:addItemModifier(0, hero, inventory_unit, "modifier_emerald_douli", item)
	elseif propertyName == "tyrius" then
		Head:addItemModifier(0, hero, inventory_unit, "modifier_mask_of_tyrius", item)
	elseif propertyName == "cerulean_highguard" then
		Head:addItemModifier(0, hero, inventory_unit, "modifier_cerulean_high_guard", item)
	elseif propertyName == "all_attributes" then
		Head:action("strength", propertyValue, hero, inventory_unit, head_ability, item)
		Head:action("agility", propertyValue, hero, inventory_unit, head_ability, item)
		Head:action("intelligence", propertyValue, hero, inventory_unit, head_ability, item)
	elseif propertyName == "super_ascendency" then
		Head:addItemModifier(0, hero, inventory_unit, "modifier_super_ascendency", item)
		hero.InventoryUnit.ascendancy = item
	elseif propertyName == "phantom_sorcerer" then
		Head:addItemModifier(0, hero, inventory_unit, "modifier_phantom_sorcerer", item)
	elseif propertyName == "arcane_cascade" then
		Head:addItemModifier(0, hero, inventory_unit, "modifier_arcane_cascade_hat", item)
	elseif propertyName == "samurai_helmet" then
		Head:addItemModifier(0, hero, inventory_unit, "modifier_samurai_helmet", item)
	elseif propertyName == "scourge_knight" then
		Head:addItemModifier(0, hero, inventory_unit, "modifier_scourge_knight", item)
	elseif propertyName == "undertaker" then
		Head:addItemModifier(0, hero, inventory_unit, "modifier_undertakers_hood", item)
	end
end

function Head:addItemModifier(propertyValue, hero, inventory_unit, modifier_name, head_ability)
	head_ability:ApplyDataDrivenModifier(inventory_unit, hero, modifier_name, {})
	if propertyValue > 0 then
		hero:SetModifierStackCount( modifier_name, head_ability, propertyValue )
	end
end

function Head:runeProperty(propertyName, propertyValue, hero)
	if propertyName == "rune_a_a" then
		hero.runeUnit.head.a_a = hero.runeUnit.head.a_a + propertyValue
		Head:setRuneBonusNetTable(hero.runeUnit.head.a_a, propertyName, hero)
	elseif propertyName == "rune_a_b" then
		hero.runeUnit.head.a_b = hero.runeUnit.head.a_b + propertyValue
		Head:setRuneBonusNetTable(hero.runeUnit.head.a_b, propertyName, hero)
	elseif propertyName == "rune_a_c" then
		hero.runeUnit.head.a_c = hero.runeUnit.head.a_c + propertyValue
		Head:setRuneBonusNetTable(hero.runeUnit.head.a_c, propertyName, hero)
	elseif propertyName == "rune_a_d" then
		hero.runeUnit.head.a_d = hero.runeUnit.head.a_d + propertyValue
		Head:setRuneBonusNetTable(hero.runeUnit.head.a_d, propertyName, hero)
	elseif propertyName == "rune_b_a" then
		hero.runeUnit2.head.b_a = hero.runeUnit2.head.b_a + propertyValue
		Head:setRuneBonusNetTable(hero.runeUnit2.head.b_a, propertyName, hero)
	elseif propertyName == "rune_b_b" then
		hero.runeUnit2.head.b_b = hero.runeUnit2.head.b_b + propertyValue
		Head:setRuneBonusNetTable(hero.runeUnit2.head.b_b, propertyName, hero)
	elseif propertyName == "rune_b_c" then
		hero.runeUnit2.head.b_c = hero.runeUnit2.head.b_c + propertyValue
		Head:setRuneBonusNetTable(hero.runeUnit2.head.b_c, propertyName, hero)
	elseif propertyName == "rune_b_d" then
		hero.runeUnit2.head.b_d = hero.runeUnit2.head.b_d + propertyValue
		Head:setRuneBonusNetTable(hero.runeUnit2.head.b_d, propertyName, hero)
	end
end

function Head:setRuneBonusNetTable(value, rune, hero)
	CustomNetTables:SetTableValue("skill_tree", tostring(hero:GetEntityIndex()).."_"..rune.."_head", {bonus = value} )
	print("Setting Rune Net Table: ")
	print(tostring(hero:GetEntityIndex()).."_"..rune.."_head")
end

function Head:addBasicModifier(propertyValue, hero, inventory_unit, modifier_name, head_ability)
	print(inventory_unit)
	--local stacks = hero:GetModifierStackCount(modifierName, inventory_unit)
	head_ability = inventory_unit:FindAbilityByName("helm_slot")
	head_ability:ApplyDataDrivenModifier(inventory_unit, hero, modifier_name, {})
	--hero:SetModifierStackCount( modifier_name, head_ability, (propertyValue+stacks) )
	hero:SetModifierStackCount( modifier_name, head_ability, propertyValue )
end

function Head:remove_modifiers(hero)
	local headModifierTable = {"modifier_helm_strength", "modifier_helm_agility", "modifier_helm_intelligence", "modifier_helm_magic_resist", "modifier_helm_armor", "modifier_helm_health_regen", "modifier_helm_mana_regen","modifier_helm_max_health","modifier_helm_max_mana", "modifier_hyper_visor", "modifier_helm_respawn","modifier_white_mage_hat", "attack_speed", "modifier_ruby_dragon", "modifier_centaur_horns", "modifier_death_whisper", "modifier_wild_nature_one", "modifier_wild_nature_two", "modifier_luma_guard", "modifier_helm_odin", "modifier_mugato", "modifier_witch_hat", "modifier_trickster_mask", "modifier_emerald_douli", "modifier_mask_of_tyrius", "modifier_tyrius_buff", "modifier_cerulean_high_guard", "modifier_helm_attack_damage", "modifier_super_ascendency", "modifier_phantom_sorcerer", "modifier_arcane_cascade_hat", "modifier_samurai_helmet", "modifier_helm_lifesteal", "modifier_scourge_knight", "modifier_undertakers_hood"}
	for i = 1, #headModifierTable, 1 do
		hero:RemoveModifierByName(headModifierTable[i])
	end
	if hero:HasModifier("modifier_iron_colossus") then
		hero:RemoveModifierByName("modifier_iron_colossus")
		hero:RemoveModifierByName("modifier_iron_colossus_attack_speed_loss")
		hero:RemoveModifierByName("modifier_colossus_attack_range_gain")
		hero:RemoveModifierByName("modifier_iron_colossus_attack_range_loss")
		hero:RemoveModifierByName("modifier_iron_colossus_attack_damage_increase")
		hero:SetModelScale(hero.origModelScale)
	end
	Head:remove_rune_bonuses(hero)
end

function Head:remove_rune_bonuses(hero)
	hero.runeUnit.head.a_a = 0
	hero.runeUnit.head.a_b = 0
	hero.runeUnit.head.a_c = 0
	hero.runeUnit.head.a_d = 0
	hero.runeUnit2.head.b_a = 0
	hero.runeUnit2.head.b_b = 0
	hero.runeUnit2.head.b_c = 0
	hero.runeUnit2.head.b_d = 0
	hero.runeUnit3.head.c_a = 0
	hero.runeUnit3.head.c_b = 0
	hero.runeUnit3.head.c_c = 0
	hero.runeUnit3.head.c_d = 0
	Runes:ResetRuneBonuses(hero, "head")
end