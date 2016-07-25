if Body == nil then
  Body = class({})
end


function Body:add_modifiers(hero, inventory_unit, item)
	print(item)
	local body_ability = inventory_unit:FindAbilityByName("body_slot")
	body_ability.strength = 0
	body_ability.agility = 0
	body_ability.intelligence = 0
	body_ability.magic_resist = 0
	body_ability.armor = 0
	body_ability.health_regen = 0
	body_ability.mana_regen = 0
	body_ability.physical_block = 0
	body_ability.magic_block = 0
	body_ability.respawn_reduce = 0
	body_ability.evasion = 0
	body_ability.max_mana = 0
	body_ability.max_health = 0
	Body:action(item.property1name, item.property1, hero, inventory_unit, body_ability, item)
	Body:runeProperty(item.property1name, item.property1, hero)
	if item.property2name then
		Body:action(item.property2name, item.property2, hero, inventory_unit, body_ability, item)
		Body:runeProperty(item.property2name, item.property2, hero)
	end
	if item.property3name then
		Body:action(item.property3name, item.property3, hero, inventory_unit, body_ability, item)
		Body:runeProperty(item.property3name, item.property3, hero)
	end
	if item.property4name then
		Body:action(item.property4name, item.property4, hero, inventory_unit, body_ability, item)
		Body:runeProperty(item.property4name, item.property4, hero)
	end
end


function Body:action(propertyName, propertyValue, hero, inventory_unit, body_ability, item)
	if propertyName == "strength" then
		body_ability.strength = body_ability.strength + propertyValue
		Body:addBasicModifier(body_ability.strength, hero, inventory_unit, "modifier_body_strength", body_ability)
	elseif propertyName == "agility" then
		body_ability.agility = body_ability.agility + propertyValue
		Body:addBasicModifier(body_ability.agility, hero, inventory_unit, "modifier_body_agility", body_ability)
	elseif propertyName == "intelligence" then
		body_ability.intelligence = body_ability.intelligence + propertyValue
		Body:addBasicModifier(body_ability.intelligence, hero, inventory_unit, "modifier_body_intelligence", body_ability)
	elseif propertyName == "magic_resist" then
		body_ability.magic_resist = body_ability.magic_resist + propertyValue
		Body:addBasicModifier(body_ability.magic_resist, hero, inventory_unit, "modifier_body_magic_resist", body_ability)
	elseif propertyName == "armor" then
		body_ability.armor = body_ability.armor + propertyValue
		Body:addBasicModifier(body_ability.armor, hero, inventory_unit, "modifier_body_armor", body_ability)
	elseif propertyName == "health_regen" then
		body_ability.health_regen = body_ability.health_regen + propertyValue
		Body:addBasicModifier(body_ability.health_regen, hero, inventory_unit, "modifier_body_health_regen", body_ability)
	elseif propertyName == "mana_regen" then
		body_ability.mana_regen = body_ability.mana_regen + propertyValue
		Body:addBasicModifier(body_ability.mana_regen, hero, inventory_unit, "modifier_body_mana_regen", body_ability)
	elseif propertyName == "physical_block" then
		body_ability.physical_block = body_ability.physical_block + propertyValue
		Body:addBasicModifier(body_ability.physical_block, hero, inventory_unit, "modifier_body_physical_block", body_ability)
	elseif propertyName == "magic_block" then
		body_ability.magic_block = body_ability.magic_block + propertyValue
		Body:addBasicModifier(body_ability.magic_block, hero, inventory_unit, "modifier_body_magic_block", body_ability)
	elseif propertyName == "respawn_reduce" then
		body_ability.respawn_reduce = body_ability.respawn_reduce + propertyValue
		Body:addBasicModifier(body_ability.respawn_reduce, hero, inventory_unit, "modifier_body_respawn", body_ability)
	elseif propertyName == "evasion" then
		body_ability.evasion = body_ability.evasion + propertyValue
		Body:addBasicModifier(body_ability.evasion, hero, inventory_unit, "modifier_body_evasion", body_ability)
	elseif propertyName == "max_mana" then
		body_ability.max_mana = body_ability.max_mana + propertyValue
		Body:addBasicModifier(body_ability.max_mana, hero, inventory_unit, "modifier_body_max_mana", body_ability)
	elseif propertyName == "max_health" then
		body_ability.max_health = body_ability.max_health + propertyValue
		Body:addBasicModifier(body_ability.max_health, hero, inventory_unit, "modifier_body_max_health", body_ability)
	elseif propertyName == "steelbark" then
		Body:addBasicModifier(1, hero, inventory_unit, "modifier_body_steelbark", body_ability)
	elseif propertyName == "hurricane" then
		hero.body_ability = body_ability
		Body:addBasicModifier(propertyValue, hero, inventory_unit, "modifier_body_hurricane", body_ability)
	elseif propertyName == "flooding" then
		Body:addBasicModifier(propertyValue, hero, inventory_unit, "modifier_body_flooding", body_ability)
	elseif propertyName == "avalanche" then
		Body:addBasicModifier(propertyValue, hero, inventory_unit, "modifier_body_avalanche", body_ability)	
	elseif propertyName == "violet_guard" then
		Body:addBasicModifier(propertyValue, hero, inventory_unit, "modifier_body_violet_guard", body_ability)				
	elseif propertyName == "seraphic" then
		Body:addBasicModifier(propertyValue, hero, inventory_unit, "modifier_body_seraphic", body_ability)	
	elseif propertyName == "watcher1" then
		Body:addBasicModifier(propertyValue, hero, inventory_unit, "modifier_watcher_one", body_ability)
	elseif propertyName == "watcher2" then
		Body:addBasicModifier(propertyValue, hero, inventory_unit, "modifier_watcher_two", body_ability)
	elseif propertyName == "watcher3" then
		Body:addBasicModifier(propertyValue, hero, inventory_unit, "modifier_watcher_three", body_ability)
	elseif propertyName == "watcher4" then
		Body:addBasicModifier(propertyValue, hero, inventory_unit, "modifier_watcher_four", body_ability)	
	elseif propertyName == "sorcerer" then
		Body:addBasicModifier(propertyValue, hero, inventory_unit, "modifier_sorcerers_regalia", body_ability)
	elseif propertyName == "spellslinger" then
		Body:addBasicModifier(propertyValue, hero, inventory_unit, "modifier_spellslinger_coat", body_ability)
	elseif propertyName == "doomplate" then
		Body:addBasicModifier(propertyValue, hero, inventory_unit, "modifier_doomplate", body_ability)
	elseif propertyName == "ice_quill" then
		Body:addItemModifier(0, hero, inventory_unit, "modifier_ice_quill_carapace", item)
		item.hero = hero
	elseif propertyName == "featherwhite" then
		Body:SummonFollower(hero, "ivory_gryffin")
	elseif propertyName == "dragon_ceremony" then
		Body:SummonFollower(hero, "beast_of_ceremony")
	elseif propertyName == "secret_temple" then
		Body:addItemModifier(0, hero, inventory_unit, "modifier_secret_temple", item)
		hero.refractionItem = item
	elseif propertyName == "vampiric_breastplate" then
		Body:addItemModifier(0, hero, inventory_unit, "modifier_vampiric_breastplate", item)
	elseif propertyName == "dark_arts" then
		Body:addItemModifier(0, hero, inventory_unit, "modifier_dark_arts", item)
	elseif propertyName == "legion_vest" then
		Body:addItemModifier(0, hero, inventory_unit, "modifier_legion_vestments", item)
	elseif propertyName == "nightmare_rider" then
		Body:addItemModifier(0, hero, inventory_unit, "modifier_nightmare_rider", item)
	elseif propertyName == "space_tech" then
		Body:addItemModifier(0, hero, inventory_unit, "modifier_space_tech", item)
		hero.space_tech = item
	elseif propertyName == "stormshield" then
		Body:addItemModifier(0, hero, inventory_unit, "modifier_stormshield_cloak", item)
	end
end

function Body:SummonFollower(hero, unitName)
	local summon = CreateUnitByName(unitName, hero:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_GOODGUYS)
	summon.owner = hero:GetPlayerOwnerID()
	summon.summoner = hero
	summon:SetOwner(hero)
	summon:SetControllableByPlayer(hero:GetPlayerID(), true)
	summon.hero = hero
	if not hero.summonTable then
		hero.summonTable = {}
	end
	table.insert(hero.summonTable, summon)
end

function Body:addItemModifier(propertyValue, hero, inventory_unit, modifier_name, head_ability)
	head_ability:ApplyDataDrivenModifier(inventory_unit, hero, modifier_name, {})
	if propertyValue > 0 then
		hero:SetModifierStackCount( modifier_name, head_ability, propertyValue )
	end
end


function Body:runeProperty(propertyName, propertyValue, hero)
	if propertyName == "rune_a_a" then
		hero.runeUnit.body.a_a = hero.runeUnit.body.a_a + propertyValue
		Body:setRuneBonusNetTable(hero.runeUnit.body.a_a, propertyName, hero)
	elseif propertyName == "rune_a_b" then
		hero.runeUnit.body.a_b = hero.runeUnit.body.a_b + propertyValue
		Body:setRuneBonusNetTable(hero.runeUnit.body.a_b, propertyName, hero)
	elseif propertyName == "rune_a_c" then
		hero.runeUnit.body.a_c = hero.runeUnit.body.a_c + propertyValue
		Body:setRuneBonusNetTable(hero.runeUnit.body.a_c, propertyName, hero)
	elseif propertyName == "rune_a_d" then
		hero.runeUnit.body.a_d = hero.runeUnit.body.a_d + propertyValue
		Body:setRuneBonusNetTable(hero.runeUnit.body.a_d, propertyName, hero)
	elseif propertyName == "rune_b_a" then
		hero.runeUnit2.body.b_a = hero.runeUnit2.body.b_a + propertyValue
		Body:setRuneBonusNetTable(hero.runeUnit2.body.b_a, propertyName, hero)
	elseif propertyName == "rune_b_b" then
		hero.runeUnit2.body.b_b = hero.runeUnit2.body.b_b + propertyValue
		Body:setRuneBonusNetTable(hero.runeUnit2.body.b_b, propertyName, hero)
	elseif propertyName == "rune_b_c" then
		hero.runeUnit2.body.b_c = hero.runeUnit2.body.b_c + propertyValue
		Body:setRuneBonusNetTable(hero.runeUnit2.body.b_c, propertyName, hero)
	elseif propertyName == "rune_b_d" then
		hero.runeUnit2.body.b_d = hero.runeUnit2.body.b_d + propertyValue
		Body:setRuneBonusNetTable(hero.runeUnit2.body.b_d, propertyName, hero)
	elseif propertyName == "rune_c_a" then
		hero.runeUnit3.body.b_a = hero.runeUnit3.body.c_a + propertyValue
		Body:setRuneBonusNetTable(hero.runeUnit3.body.c_a, propertyName, hero)
	elseif propertyName == "rune_c_b" then
		hero.runeUnit3.body.b_b = hero.runeUnit3.body.c_b + propertyValue
		Body:setRuneBonusNetTable(hero.runeUnit3.body.c_b, propertyName, hero)
	elseif propertyName == "rune_c_c" then
		hero.runeUnit3.body.b_c = hero.runeUnit3.body.c_c + propertyValue
		Body:setRuneBonusNetTable(hero.runeUnit3.body.c_c, propertyName, hero)
	elseif propertyName == "rune_c_d" then
		hero.runeUnit3.body.b_d = hero.runeUnit3.body.c_d + propertyValue
		Body:setRuneBonusNetTable(hero.runeUnit3.body.c_d, propertyName, hero)
	end
end

function Body:setRuneBonusNetTable(value, rune, hero)
	CustomNetTables:SetTableValue("skill_tree", tostring(hero:GetEntityIndex()).."_"..rune.."_body", {bonus = value} )
	print("Setting Rune Net Table: ")
	print(tostring(hero:GetEntityIndex()).."_"..rune.."_body")
end

function Body:addBasicModifier(propertyValue, hero, inventory_unit, modifier_name, body_ability)
	print(inventory_unit)
	--local stacks = hero:GetModifierStackCount(modifierName, inventory_unit)
	body_ability = inventory_unit:FindAbilityByName("body_slot")
	body_ability:ApplyDataDrivenModifier(inventory_unit, hero, modifier_name, {})
	--hero:SetModifierStackCount( modifier_name, body_ability, (propertyValue+stacks) )
	hero:SetModifierStackCount( modifier_name, body_ability, propertyValue )
end

function Body:remove_modifiers(hero)
	hero:RemoveModifierByName("modifier_body_strength")
	hero:RemoveModifierByName("modifier_body_agility")
	hero:RemoveModifierByName("modifier_body_intelligence")
	hero:RemoveModifierByName("modifier_body_magic_resist")
	hero:RemoveModifierByName("modifier_body_armor")
	hero:RemoveModifierByName("modifier_body_health_regen")
	hero:RemoveModifierByName("modifier_body_mana_regen")
	hero:RemoveModifierByName("modifier_body_physical_block")
	hero:RemoveModifierByName("modifier_body_magic_block")
	hero:RemoveModifierByName("modifier_body_max_mana")
	hero:RemoveModifierByName("modifier_body_max_health")
	hero:RemoveModifierByName("modifier_body_respawn")
	hero:RemoveModifierByName("modifier_body_steelbark")
	hero:RemoveModifierByName("modifier_body_hurricane")
	hero:RemoveModifierByName("modifier_body_flooding")
	hero:RemoveModifierByName("modifier_body_avalanche")
	hero:RemoveModifierByName("modifier_body_violet_guard")
	hero:RemoveModifierByName("modifier_body_seraphic")
	hero:RemoveModifierByName("modifier_watcher_one")
	hero:RemoveModifierByName("modifier_watcher_two")
	hero:RemoveModifierByName("modifier_watcher_three")
	hero:RemoveModifierByName("modifier_watcher_four")
	hero:RemoveModifierByName("modifier_sorcerers_regalia")
	hero:RemoveModifierByName("modifier_spellslinger_coat")
	hero:RemoveModifierByName("modifier_doomplate")

	hero:RemoveModifierByName("modifier_ice_quill_carapace")
	hero:RemoveModifierByName("modifier_secret_temple")
	hero:RemoveModifierByName("modifier_vampiric_breastplate")
	hero:RemoveModifierByName("modifier_dark_arts")
	hero:RemoveModifierByName("modifier_dark_arts_effect")
	hero:RemoveModifierByName("modifier_legion_vestments")
	hero:RemoveModifierByName("modifier_legion_vestments_effect_str")
	hero:RemoveModifierByName("modifier_legion_vestments_effect_int")
	hero:RemoveModifierByName("modifier_legion_vestments_effect_agi")
	hero:RemoveModifierByName("modifier_nightmare_rider")
	hero:RemoveModifierByName("modifier_space_tech")
	hero:RemoveModifierByName("modifier_stormshield_cloak")

	hero.space_tech = nil
	if hero.summonTable then
		for i = 1, #hero.summonTable, 1 do
			if not hero.summonTable[i]:IsNull() then
				UTIL_Remove(hero.summonTable[i])
			end
		end
	end
	Body:remove_rune_bonuses(hero)
end

function Body:remove_rune_bonuses(hero)
	hero.runeUnit.body.a_a = 0
	hero.runeUnit.body.a_b = 0
	hero.runeUnit.body.a_c = 0
	hero.runeUnit.body.a_d = 0
	hero.runeUnit2.body.b_a = 0
	hero.runeUnit2.body.b_b = 0
	hero.runeUnit2.body.b_c = 0
	hero.runeUnit2.body.b_d = 0
	hero.runeUnit3.body.c_a = 0
	hero.runeUnit3.body.c_b = 0
	hero.runeUnit3.body.c_c = 0
	hero.runeUnit3.body.c_d = 0
	Runes:ResetRuneBonuses(hero, "body")
end