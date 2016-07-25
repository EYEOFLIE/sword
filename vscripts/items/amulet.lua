if Amulet == nil then
  Amulet = class({})
end


function Amulet:add_modifiers(hero, inventory_unit, item)
	print(item)
	local trinket_ability = inventory_unit:FindAbilityByName("trinket_slot")
	trinket_ability.strength = 0
	trinket_ability.agility = 0
	trinket_ability.intelligence = 0
	trinket_ability.armor = 0
	trinket_ability.health_regen = 0
	trinket_ability.attack_damage = 0
	trinket_ability.max_health = 0
	trinket_ability.magic_resist = 0
	Amulet:action(item.property1name, item.property1, hero, inventory_unit, trinket_ability, item)
	Amulet:runeProperty(item.property1name, item.property1, hero)
	if item.property2name then
		Amulet:action(item.property2name, item.property2, hero, inventory_unit, trinket_ability, item)
		Amulet:runeProperty(item.property2name, item.property2, hero)
	end
	if item.property3name then
		Amulet:action(item.property3name, item.property3, hero, inventory_unit, trinket_ability, item)
		Amulet:runeProperty(item.property3name, item.property3, hero)
	end
	if item.property4name then
		Amulet:action(item.property4name, item.property4, hero, inventory_unit, trinket_ability, item)
		Amulet:runeProperty(item.property4name, item.property4, hero)
	end
	--CustomGameEventManager:Send_ServerToPlayer(hero:GetPlayerOwner(), "ability_tree_upgrade", {playerId="0"})
end


function Amulet:action(propertyName, propertyValue, hero, inventory_unit, trinket_ability, item)
	if propertyName == "strength" then
		trinket_ability.strength = trinket_ability.strength + propertyValue
		Amulet:addBasicModifier(trinket_ability.strength, hero, inventory_unit, "modifier_trinket_strength", trinket_ability)
	elseif propertyName == "agility" then
		trinket_ability.agility = trinket_ability.agility + propertyValue
		Amulet:addBasicModifier(trinket_ability.agility, hero, inventory_unit, "modifier_trinket_agility", trinket_ability)
	elseif propertyName == "intelligence" then
		trinket_ability.intelligence = trinket_ability.intelligence + propertyValue
		Amulet:addBasicModifier(trinket_ability.intelligence, hero, inventory_unit, "modifier_trinket_intelligence", trinket_ability)
	elseif propertyName == "armor" then
		trinket_ability.armor = trinket_ability.armor + propertyValue
		Amulet:addBasicModifier(trinket_ability.armor, hero, inventory_unit, "modifier_trinket_armor", trinket_ability)
	elseif propertyName == "health_regen" then
		trinket_ability.health_regen = trinket_ability.health_regen + propertyValue
		Amulet:addBasicModifier(trinket_ability.health_regen, hero, inventory_unit, "modifier_trinket_health_regen", trinket_ability)
	elseif propertyName == "attack_damage" then
		trinket_ability.attack_damage = trinket_ability.attack_damage + propertyValue
		Amulet:addBasicModifier(trinket_ability.attack_damage, hero, inventory_unit, "modifier_trinket_attack_damage", trinket_ability)
	elseif propertyName == "max_health" then
		trinket_ability.max_health = trinket_ability.max_health + propertyValue
		Amulet:addBasicModifier(trinket_ability.max_health, hero, inventory_unit, "modifier_trinket_max_health", trinket_ability)
	elseif propertyName == "magic_resist" then
		trinket_ability.magic_resist = trinket_ability.magic_resist + propertyValue
		Amulet:addBasicModifier(trinket_ability.magic_resist, hero, inventory_unit, "modifier_trinket_magic_resist", trinket_ability)
	elseif propertyName == "monkey_paw" then
		Amulet:addItemModifier(0, hero, inventory_unit, "modifier_monkey_paw", item)
		hero.monkey_paw = item
	elseif propertyName == "blacksmith" then
		Amulet:addItemModifier(0, hero, inventory_unit, "modifier_blacksmiths_tablet", item)
	elseif propertyName == "all_attributes" then
		trinket_ability.strength = trinket_ability.strength + propertyValue
		Amulet:addBasicModifier(trinket_ability.strength, hero, inventory_unit, "modifier_trinket_strength", trinket_ability)
		trinket_ability.agility = trinket_ability.agility + propertyValue
		Amulet:addBasicModifier(trinket_ability.agility, hero, inventory_unit, "modifier_trinket_agility", trinket_ability)		
		trinket_ability.intelligence = trinket_ability.intelligence + propertyValue
		Amulet:addBasicModifier(trinket_ability.intelligence, hero, inventory_unit, "modifier_trinket_intelligence", trinket_ability)
	elseif propertyName == "all_runes" then
		for i = 1, #AVAILABLE_RUNE_TABLE, 1 do
			Amulet:runeProperty(AVAILABLE_RUNE_TABLE[i], propertyValue, hero)
		end
	elseif propertyName == "sapphire_lotus" then
		Amulet:addItemModifier(0, hero, inventory_unit, "modifier_sapphire_lotus", item)
	elseif propertyName == "arbor" then
		Amulet:addItemModifier(0, hero, inventory_unit, "modifier_arbor_dragonfly", item)
	elseif propertyName == "eternal_frost" then
		Amulet:addItemModifier(0, hero, inventory_unit, "modifier_gem_of_eternal_frost", item)
		hero.eternal_frost_gem = item
	elseif propertyName == "lifesource" then
		Amulet:addItemModifier(0, hero, inventory_unit, "modifier_lifesource_vessel", item)
	elseif propertyName == "saytaru" then
		Amulet:addItemModifier(0, hero, inventory_unit, "modifier_hope_of_saytaru", item)
	elseif propertyName == "galaxy_orb" then
		Amulet:addItemModifier(0, hero, inventory_unit, "modifier_galaxy_orb", item)
		hero.galaxy_orb = item
	elseif propertyName == "azure_empire" then
		Amulet:addItemModifier(0, hero, inventory_unit, "modifier_azure_empire", item)
	elseif propertyName == "signus" then
		Amulet:addItemModifier(0, hero, inventory_unit, "modifier_signus_charm", item)
	elseif propertyName == "avernus" then
		Amulet:addItemModifier(0, hero, inventory_unit, "modifier_eye_of_avernus", item)
	end
end

function Amulet:addItemModifier(propertyValue, hero, inventory_unit, modifier_name, amulet_ability)
	amulet_ability:ApplyDataDrivenModifier(inventory_unit, hero, modifier_name, {})
	if propertyValue > 0 then
		hero:SetModifierStackCount( modifier_name, amulet_ability, propertyValue )
	end
end

function Amulet:runeProperty(propertyName, propertyValue, hero)
	if propertyName == "rune_a_a" then
		hero.runeUnit.amulet.a_a = hero.runeUnit.amulet.a_a + propertyValue
		Amulet:setRuneBonusNetTable(hero.runeUnit.amulet.a_a, propertyName, hero)
	elseif propertyName == "rune_a_b" then
		hero.runeUnit.amulet.a_b = hero.runeUnit.amulet.a_b + propertyValue
		Amulet:setRuneBonusNetTable(hero.runeUnit.amulet.a_b, propertyName, hero)
	elseif propertyName == "rune_a_c" then
		hero.runeUnit.amulet.a_c = hero.runeUnit.amulet.a_c + propertyValue
		Amulet:setRuneBonusNetTable(hero.runeUnit.amulet.a_c, propertyName, hero)
	elseif propertyName == "rune_a_d" then
		hero.runeUnit.amulet.a_d = hero.runeUnit.amulet.a_d + propertyValue
		Amulet:setRuneBonusNetTable(hero.runeUnit.amulet.a_d, propertyName, hero)
	elseif propertyName == "rune_b_a" then
		hero.runeUnit2.amulet.b_a = hero.runeUnit2.amulet.b_a + propertyValue
		Amulet:setRuneBonusNetTable(hero.runeUnit2.amulet.b_a, propertyName, hero)
	elseif propertyName == "rune_b_b" then
		hero.runeUnit2.amulet.b_b = hero.runeUnit2.amulet.b_b + propertyValue
		Amulet:setRuneBonusNetTable(hero.runeUnit2.amulet.b_b, propertyName, hero)
	elseif propertyName == "rune_b_c" then
		hero.runeUnit2.amulet.b_c = hero.runeUnit2.amulet.b_c + propertyValue
		Amulet:setRuneBonusNetTable(hero.runeUnit2.amulet.b_c, propertyName, hero)
	elseif propertyName == "rune_b_d" then
		hero.runeUnit2.amulet.b_d = hero.runeUnit2.amulet.b_d + propertyValue
		Amulet:setRuneBonusNetTable(hero.runeUnit2.amulet.b_d, propertyName, hero)
	elseif propertyName == "rune_c_a" then
		hero.runeUnit3.amulet.c_a = hero.runeUnit3.amulet.c_a + propertyValue
		Amulet:setRuneBonusNetTable(hero.runeUnit3.amulet.c_a, propertyName, hero)
	elseif propertyName == "rune_c_b" then
		hero.runeUnit3.amulet.c_b = hero.runeUnit3.amulet.c_b + propertyValue
		Amulet:setRuneBonusNetTable(hero.runeUnit3.amulet.c_b, propertyName, hero)
	elseif propertyName == "rune_c_c" then
		hero.runeUnit3.amulet.c_c = hero.runeUnit3.amulet.c_c + propertyValue
		Amulet:setRuneBonusNetTable(hero.runeUnit3.amulet.c_c, propertyName, hero)
	elseif propertyName == "rune_c_d" then
		hero.runeUnit3.amulet.c_d = hero.runeUnit3.amulet.c_d + propertyValue
		Amulet:setRuneBonusNetTable(hero.runeUnit3.amulet.c_d, propertyName, hero)
	end
end

AVAILABLE_RUNE_TABLE = {"rune_a_a", "rune_a_b", "rune_a_c", "rune_a_d", "rune_b_a", "rune_b_b", "rune_b_c", "rune_b_d", "rune_c_a", "rune_c_b", "rune_c_c", "rune_c_d"}

function Amulet:setRuneBonusNetTable(value, rune, hero)
	CustomNetTables:SetTableValue("skill_tree", tostring(hero:GetEntityIndex()).."_"..rune.."_amulet", {bonus = value} )
	print("Setting Rune Net Table: ")
	print(tostring(hero:GetEntityIndex()).."_"..rune.."_amulet")
end

function Amulet:addBasicModifier(propertyValue, hero, inventory_unit, modifier_name, trinket_ability)
	print(inventory_unit)
	--local stacks = hero:GetModifierStackCount(modifierName, inventory_unit)
	local amulet_ability = inventory_unit:FindAbilityByName("trinket_slot")
	amulet_ability:ApplyDataDrivenModifier(inventory_unit, hero, modifier_name, {})
	--hero:SetModifierStackCount( modifier_name, trinket_ability, (propertyValue+stacks) )
	hero:SetModifierStackCount( modifier_name, amulet_ability, propertyValue )
end

function Amulet:remove_modifiers(hero)
	hero:RemoveModifierByName("modifier_trinket_strength")
	hero:RemoveModifierByName("modifier_trinket_agility")
	hero:RemoveModifierByName("modifier_trinket_intelligence")
	hero:RemoveModifierByName("modifier_trinket_armor")
	hero:RemoveModifierByName("modifier_trinket_attack_damage")
	hero:RemoveModifierByName("modifier_trinket_health_regen")
	hero:RemoveModifierByName("modifier_trinket_max_health")
	hero:RemoveModifierByName("modifier_trinket_magic_resist")
	hero:RemoveModifierByName("modifier_monkey_paw")
	hero:RemoveModifierByName("modifier_blacksmiths_tablet")
	hero:RemoveModifierByName("modifier_sapphire_lotus")
	hero:RemoveModifierByName("modifier_sapphire_lotus_buff")
	hero:RemoveModifierByName("modifier_arbor_dragonfly")
	hero:RemoveModifierByName("modifier_gem_of_eternal_frost")
	hero:RemoveModifierByName("modifier_lifesource_vessel")
	hero:RemoveModifierByName("modifier_lifesource_vessel_buff")
	hero:RemoveModifierByName("modifier_hope_of_saytaru")
	hero:RemoveModifierByName("modifier_hope_of_saytaru_effect")
	hero:RemoveModifierByName("modifier_galaxy_orb")
	hero:RemoveModifierByName("modifier_azure_empire")
	hero:RemoveModifierByName("modifier_signus_charm")
	hero.monkey_paw = false
	hero.birdTable = false
	hero.eternal_frost_gem = false
	hero.galaxy_orb = false
	hero.runeUnit.amulet.a_a = 0
	hero.runeUnit.amulet.a_b = 0
	hero.runeUnit.amulet.a_c = 0
	hero.runeUnit.amulet.a_d = 0
	hero.runeUnit2.amulet.b_a = 0
	hero.runeUnit2.amulet.b_b = 0
	hero.runeUnit2.amulet.b_c = 0
	hero.runeUnit2.amulet.b_d = 0
	hero.runeUnit3.amulet.c_a = 0
	hero.runeUnit3.amulet.c_b = 0
	hero.runeUnit3.amulet.c_c = 0
	hero.runeUnit3.amulet.c_d = 0
	Runes:ResetRuneBonuses(hero, "amulet")
end