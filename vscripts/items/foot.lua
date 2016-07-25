if Foot == nil then
  Foot = class({})
end


function Foot:add_modifiers(hero, inventory_unit, item)
	print(item)
	local foot_ability = inventory_unit:FindAbilityByName("foot_slot")
	foot_ability.strength = 0
	foot_ability.agility = 0
	foot_ability.intelligence = 0
	foot_ability.magic_resist = 0
	foot_ability.armor = 0
	foot_ability.health_regen = 0
	foot_ability.mana_regen = 0
	foot_ability.movespeed = 0
	foot_ability.movespeed_max = 0
	foot_ability.respawn_reduce = 0
	foot_ability.evasion = 0
	Foot:action(item.property1name, item.property1, hero, inventory_unit, foot_ability, item)
	Foot:runeProperty(item.property1name, item.property1, hero)
	if item.property2name then
		Foot:action(item.property2name, item.property2, hero, inventory_unit, foot_ability, item)
		Foot:runeProperty(item.property2name, item.property2, hero)
	end
	if item.property3name then
		Foot:action(item.property3name, item.property3, hero, inventory_unit, foot_ability, item)
		Foot:runeProperty(item.property3name, item.property3, hero)
	end
	if item.property4name then
		Foot:action(item.property4name, item.property4, hero, inventory_unit, foot_ability, item)
		Foot:runeProperty(item.property4name, item.property4, hero)
	end
end


function Foot:action(propertyName, propertyValue, hero, inventory_unit, foot_ability, item)
	if propertyName == "strength" then
		foot_ability.strength = foot_ability.strength + propertyValue
		Foot:addBasicModifier(foot_ability.strength, hero, inventory_unit, "modifier_foot_strength", foot_ability)
	elseif propertyName == "agility" then
		foot_ability.agility = foot_ability.agility + propertyValue
		Foot:addBasicModifier(foot_ability.agility, hero, inventory_unit, "modifier_foot_agility", foot_ability)
	elseif propertyName == "intelligence" then
		foot_ability.intelligence = foot_ability.intelligence + propertyValue
		Foot:addBasicModifier(foot_ability.intelligence, hero, inventory_unit, "modifier_foot_intelligence", foot_ability)
	elseif propertyName == "magic_resist" then
		foot_ability.magic_resist = foot_ability.magic_resist + propertyValue
		Foot:addBasicModifier(foot_ability.magic_resist, hero, inventory_unit, "modifier_foot_magic_resist", foot_ability)
	elseif propertyName == "armor" then
		foot_ability.armor = foot_ability.armor + propertyValue
		Foot:addBasicModifier(foot_ability.armor, hero, inventory_unit, "modifier_foot_armor", foot_ability)
	elseif propertyName == "health_regen" then
		foot_ability.health_regen = foot_ability.health_regen + propertyValue
		Foot:addBasicModifier(foot_ability.health_regen, hero, inventory_unit, "modifier_foot_health_regen", foot_ability)
	elseif propertyName == "mana_regen" then
		foot_ability.mana_regen = foot_ability.mana_regen + propertyValue
		Foot:addBasicModifier(foot_ability.mana_regen, hero, inventory_unit, "modifier_foot_mana_regen", foot_ability)
	elseif propertyName == "movespeed" then
		foot_ability.movespeed = foot_ability.movespeed + propertyValue
		Foot:addBasicModifier(foot_ability.movespeed, hero, inventory_unit, "modifier_foot_movespeed", foot_ability)
	elseif propertyName == "movespeed_max" then
		foot_ability.movespeed_max = foot_ability.movespeed_max + propertyValue
		Foot:addBasicModifier(foot_ability.movespeed_max, hero, inventory_unit, "modifier_foot_max_movespeed", foot_ability)
	elseif propertyName == "respawn_reduce" then
		foot_ability.respawn_reduce = foot_ability.respawn_reduce + propertyValue
		Foot:addBasicModifier(foot_ability.respawn_reduce, hero, inventory_unit, "modifier_foot_respawn", foot_ability)
	elseif propertyName == "evasion" then
		foot_ability.evasion = foot_ability.evasion + propertyValue
		Foot:addBasicModifier(foot_ability.evasion, hero, inventory_unit, "modifier_foot_evasion", foot_ability)
	elseif propertyName == "ghost_walk" then
		Foot:addBasicModifier(1, hero, inventory_unit, "modifier_foot_unit_walk", foot_ability)
	elseif propertyName == "dunetread" then
		Foot:addItemModifier(0, hero, inventory_unit, "modifier_dunetread_boots", item)
	elseif propertyName == "violet_boots" then
		Foot:addItemModifier(0, hero, inventory_unit, "modifier_violet_boots", item)
		item.hero = hero
		hero.violetBoot = item
	elseif propertyName == "slinger" then
		Foot:addItemModifier(0, hero, inventory_unit, "modifier_slinger_boots", item)
	elseif propertyName == "guardian_greaves" then
		Foot:addItemModifier(0, hero, inventory_unit, "modifier_guardian_greaves", item)
		item.inventory_unit = inventory_unit
	elseif propertyName == "tranquil" then
		Foot:addItemModifier(0, hero, inventory_unit, "modifier_tranquil_boots", item)
	elseif propertyName == "sange" then
		Foot:addItemModifier(0, hero, inventory_unit, "modifier_rpc_sange_boots", item)
	elseif propertyName == "mana_stride" then
		Foot:addItemModifier(0, hero, inventory_unit, "modifier_mana_striders", item)
	elseif propertyName == "yasha" then
		Foot:addItemModifier(0, hero, inventory_unit, "modifier_rpc_yasha_boots", item)
	elseif propertyName == "fire_walker" then
		Foot:addItemModifier(0, hero, inventory_unit, "modifier_fire_walkers", item)
	elseif propertyName == "moon_tech" then
		Foot:addItemModifier(0, hero, inventory_unit, "modifier_moon_techs", item)
	elseif propertyName == "sonic_boot" then
		inventory_unit.foot_item = item
		Foot:addItemModifier(0, hero, inventory_unit, "modifier_sonic_boots", item)
	elseif propertyName == "falcon_boot" then
		Foot:addItemModifier(0, hero, inventory_unit, "modifier_falcon_boots", item)
		item.hero = hero
		item.damage = propertyValue
		hero.falconBoot = item
	elseif propertyName == "admiral" then
		Foot:addItemModifier(0, hero, inventory_unit, "modifier_admiral_boots", item)
	elseif propertyName == "rooted_feet" then
		Foot:addItemModifier(0, hero, inventory_unit, "modifier_rooted_feet", item)
	end
end

function Foot:addItemModifier(propertyValue, hero, inventory_unit, modifier_name, foot_ability)
	foot_ability:ApplyDataDrivenModifier(inventory_unit, hero, modifier_name, {})
	if propertyValue > 0 then
		hero:SetModifierStackCount( modifier_name, foot_ability, propertyValue )
	end
end

function Foot:addBasicModifier(propertyValue, hero, inventory_unit, modifier_name, foot_ability)
	print(inventory_unit)
	--local stacks = hero:GetModifierStackCount(modifierName, inventory_unit)
	foot_ability = inventory_unit:FindAbilityByName("foot_slot")
	foot_ability:ApplyDataDrivenModifier(inventory_unit, hero, modifier_name, {})
	--hero:SetModifierStackCount( modifier_name, foot_ability, (propertyValue+stacks) )
	hero:SetModifierStackCount( modifier_name, foot_ability, propertyValue )
end

function Foot:remove_modifiers(hero)
	hero:RemoveModifierByName("modifier_foot_strength")
	hero:RemoveModifierByName("modifier_foot_agility")
	hero:RemoveModifierByName("modifier_foot_intelligence")
	hero:RemoveModifierByName("modifier_foot_magic_resist")
	hero:RemoveModifierByName("modifier_foot_armor")
	hero:RemoveModifierByName("modifier_foot_health_regen")
	hero:RemoveModifierByName("modifier_foot_mana_regen")
	hero:RemoveModifierByName("modifier_foot_movespeed")
	hero:RemoveModifierByName("modifier_foot_max_movespeed")
	hero:RemoveModifierByName("modifier_foot_respawn")
	hero:RemoveModifierByName("modifier_foot_evasion")
	hero:RemoveModifierByName("modifier_foot_unit_walk")

	hero:RemoveModifierByName("modifier_dunetread_boots")
	hero:RemoveModifierByName("modifier_violet_boots")
	hero:RemoveModifierByName("modifier_slinger_boots")
	hero:RemoveModifierByName("modifier_guardian_greaves")
	hero:RemoveModifierByName("modifier_tranquil_boots")
	hero:RemoveModifierByName("modifier_rpc_sange_boots")
	hero:RemoveModifierByName("modifier_mana_striders")
	hero:RemoveModifierByName("modifier_rpc_yasha_boots")
	hero:RemoveModifierByName("modifier_fire_walkers")
	hero:RemoveModifierByName("modifier_falcon_boots")
	hero:RemoveModifierByName("modifier_moon_techs")
	hero:RemoveModifierByName("modifier_sonic_boots")
	hero:RemoveModifierByName("modifier_admiral_boots")
	hero:RemoveModifierByName("modifier_rooted_feet")
	Foot:remove_rune_bonuses(hero)
end

function Foot:runeProperty(propertyName, propertyValue, hero)
	if propertyName == "rune_a_a" then
		hero.runeUnit.foot.a_a = hero.runeUnit.foot.a_a + propertyValue
		Foot:setRuneBonusNetTable(hero.runeUnit.foot.a_a, propertyName, hero)
	elseif propertyName == "rune_a_b" then
		hero.runeUnit.foot.a_b = hero.runeUnit.foot.a_b + propertyValue
		Foot:setRuneBonusNetTable(hero.runeUnit.foot.a_b, propertyName, hero)
	elseif propertyName == "rune_a_c" then
		hero.runeUnit.foot.a_c = hero.runeUnit.foot.a_c + propertyValue
		Foot:setRuneBonusNetTable(hero.runeUnit.foot.a_c, propertyName, hero)
	elseif propertyName == "rune_a_d" then
		hero.runeUnit.foot.a_d = hero.runeUnit.foot.a_d + propertyValue
		Foot:setRuneBonusNetTable(hero.runeUnit.foot.a_d, propertyName, hero)
	elseif propertyName == "rune_b_a" then
		hero.runeUnit2.foot.b_a = hero.runeUnit2.foot.b_a + propertyValue
		Foot:setRuneBonusNetTable(hero.runeUnit2.foot.b_a, propertyName, hero)
	elseif propertyName == "rune_b_b" then
		hero.runeUnit2.foot.b_b = hero.runeUnit2.foot.b_b + propertyValue
		Foot:setRuneBonusNetTable(hero.runeUnit2.foot.b_b, propertyName, hero)
	elseif propertyName == "rune_b_c" then
		hero.runeUnit2.foot.b_c = hero.runeUnit2.foot.b_c + propertyValue
		Foot:setRuneBonusNetTable(hero.runeUnit2.foot.b_c, propertyName, hero)
	elseif propertyName == "rune_b_d" then
		hero.runeUnit2.foot.b_d = hero.runeUnit2.foot.b_d + propertyValue
		Foot:setRuneBonusNetTable(hero.runeUnit2.foot.b_d, propertyName, hero)
	elseif propertyName == "rune_c_a" then
		hero.runeUnit3.hand.c_a = hero.runeUnit3.foot.c_a + propertyValue
		Foot:setRuneBonusNetTable(hero.runeUnit3.foot.c_a, propertyName, hero)
	elseif propertyName == "rune_c_b" then
		hero.runeUnit3.hand.c_b = hero.runeUnit3.foot.c_b + propertyValue
		Foot:setRuneBonusNetTable(hero.runeUnit3.foot.c_b, propertyName, hero)
	elseif propertyName == "rune_c_c" then
		hero.runeUnit3.hand.c_c = hero.runeUnit3.foot.c_c + propertyValue
		Foot:setRuneBonusNetTable(hero.runeUnit3.foot.c_c, propertyName, hero)
	elseif propertyName == "rune_c_d" then
		hero.runeUnit3.hand.c_d = hero.runeUnit3.foot.c_d + propertyValue
		Foot:setRuneBonusNetTable(hero.runeUnit3.foot.c_d, propertyName, hero)
	end
end

function Foot:setRuneBonusNetTable(value, rune, hero)
	CustomNetTables:SetTableValue("skill_tree", tostring(hero:GetEntityIndex()).."_"..rune.."_foot", {bonus = value} )
	print("Setting Rune Net Table: ")
	print(tostring(hero:GetEntityIndex()).."_"..rune.."_foot")
end

function Foot:remove_rune_bonuses(hero)
	hero.runeUnit.foot.a_a = 0
	hero.runeUnit.foot.a_b = 0
	hero.runeUnit.foot.a_c = 0
	hero.runeUnit.foot.a_d = 0
	hero.runeUnit2.foot.b_a = 0
	hero.runeUnit2.foot.b_b = 0
	hero.runeUnit2.foot.b_c = 0
	hero.runeUnit2.foot.b_d = 0
	hero.runeUnit3.foot.c_a = 0
	hero.runeUnit3.foot.c_b = 0
	hero.runeUnit3.foot.c_c = 0
	hero.runeUnit3.foot.c_d = 0
	Runes:ResetRuneBonuses(hero, "foot")
end