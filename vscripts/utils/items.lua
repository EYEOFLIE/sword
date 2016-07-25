if RPCItems == nil then
  RPCItems = class({})
end
require('items/legendaries')
require('items/rpchood')
function RPCItems:RollDrops(unit, killer)
	local deathLocation = unit:GetAbsOrigin()
	local xpBounty = unit:GetDeathXP()
	local luck = RPCItems:RNG(xpBounty)
	if unit.dropLevel then
		unitLevel = unit.dropLevel
	else
		unitLevel = 0
	end
	
	RPCItems:RollItemtype(xpBounty, deathLocation, 0, unitLevel)
	


end 

function RPCItems:RNG(xpBounty)
	local luckAdjustment = (#MAIN_HERO_TABLE-1)*12
	local luck = RandomInt(0, 530+luckAdjustment)
	return luck
end

function RPCItems:GetSpecialRarity()
	luck = RandomInt(0,100)
	if luck < 60 then
		return "rare"
	elseif luck < 94 then
		return "mythical"
	else
		return "immortal"
	end
end

function RPCItems:RollItemtype(xpBounty, deathLocation, rarityValue, unitLevel)

	rarity = "immortal"
	
	RPCItems:RollBody(xpBounty, deathLocation, rarity, false, 0, nil, unitLevel)
	
end


function RPCItems:RollGold(xpBounty, deathLocation)
	Timers:CreateTimer(1, 
		function()
		item = CreateItem("item_bag_of_gold", nil, nil)
    	local drop = CreateItemOnPositionSync( deathLocation, item )
    	local position = deathLocation
    	item.rarity = "common"
    	RPCItems:DropGold(item, position)
    	local maxFactor = RPCItems:GetMaxFactor()
    	item.gold_amount = RandomInt(100, maxFactor*25) + RandomInt(0, 100)
    	DeepPrintTable(item)
    end)
end

function RPCItems:RollRarity(xpBounty)
	luck = RandomInt(0, 100)
	if luck < 40 then
		return "common"
	elseif luck >= 30 and luck < 65 then
		return "uncommon"
	elseif luck >= 65 and luck < 90 then
		return "rare"
	elseif luck >= 90 and luck < 99 then
		return "mythical"
	elseif luck >= 99 then
		return "immortal"
	end
end

BASE_POTION_TABLE = {"item_potion_green", "item_potion_blue", "item_potion_red"}

function RPCItems:RollBasicPotion(xpBounty, deathLocation, rarity, unitLevel)
	local potion_variant = BASE_POTION_TABLE[RandomInt(1, 3)]
    local item = CreateItem(potion_variant, nil, nil)
    item.rarity = rarity
    local rarityValue = RPCItems:GetRarityFactor(rarity)
    local itemName = "Potion"
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    local suffix = RPCItems:RollPotionProperty1(item, xpBounty)
    local prefix = ""
    if rarityValue >= 2 then
    	prefix = RPCItems:RollPotionProperty2(item, xpBounty)
    else
    	prefix = ""
    end
    if rarityValue>=3 then
    	itemName = RPCItems:RollPotionProperty3(item, xpBounty)
    end
    if rarityValue>=4 then
    	itemName = RPCItems:RollPotionProperty4(item, xpBounty)
    end

    RPCItems:SetTableValues(item, itemName, true, "Can be consumed for bonuses.", RPCItems:GetRarityColor(rarity), rarity, prefix, suffix, RPCItems:GetRarityFactor(rarity))
    RPCItems:DropItem(item, position)
end

SUFFIX_HEAL_TABLE = {"of Healing", "of Restoration", "of Major Healing", "of Life", "of Great Restoration"}
SUFFIX_STRENGTH_TABLE = {"of Might", "of Strength", "of Major Strength", "of Great Power", "of the Colossus"}
SUFFIX_AGILITY_TABLE = {"of Skill", "of Mastery", "of Greater Mastery", "of Expert Craft", "of Master Cunning"}
SUFFIX_INTELLIGENCE_TABLE = {"of Understanding", "of the Wise", "of Greater Intelligence", "of Great Brilliance", "of The Grand Magus"}
SUFFIX_MANA_HEAL_TABLE = {"of Refreshment", "of Greater Refreshment", "of Replenishment", "of Greater Replenishment", "of Grand Replenishment"}
SUFFIX_EXP_TABLE = {"of Training", "of Greater Training", "of Adept Training", "of Expert Training", "of Master Training"}

function RPCItems:RollPotionProperty1(item, xpBounty)
	local luck = RandomInt(0,100)
	value, suffixLevel = RPCItems:RollAttribute(xpBounty, 200, 400, 3, 8, item.rarity, false, nil)
	item.property1 = value
	item.property1name = "heal"
	suffix = SUFFIX_HEAL_TABLE[suffixLevel]
	RPCItems:SetPropertyValues(item, item.property1, "item_health_restore", "#99FF66",  1)
	return suffix
end

function RPCItems:RollPotionProperty(item, xpBounty, property, propertyname, name_table)
end

PREFIX_HEAL_TABLE = {"Healing", "Recovery", "Life", "Tranquil", "Grand Life"}
PREFIX_STRENGTH_TABLE = {"Soldier's", "Warrior's", "Giant's", "Behemoth", "Titan's"}
PREFIX_AGILITY_TABLE = {"Scout's", "Hawk's", "Pathfinder's", "Tracker's", "Ninja"}
PREFIX_INTELLIGENCE_TABLE = {"Intelligence", "Sorcerer's", "Oracle's", "Wizard's", "Grand Far Seer's"}
PREFIX_MANA_HEAL_TABLE = {"Mana", "Greater Mana", "Soul", "Lunar", "Grand Arcane"}
PREFIX_EXP_TABLE = {"Squire's", "Adventurer's", "Quester's", "Explorer's", "Inquisitive"}

function RPCItems:RollPotionProperty2(item, xpBounty)
	local luck = RandomInt(0,100)
	local prefix=""
	if luck < 40 then
		value, prefixLevel = RPCItems:RollAttribute(xpBounty, 200, 400, 3, 8, item.rarity, false, nil)
		item.property2 = value
    	item.property2name = "heal"
    	prefix = PREFIX_HEAL_TABLE[prefixLevel]
    	RPCItems:SetPropertyValues(item, item.property2, "item_health_restore", "#99FF66",  2)
    elseif luck >= 40 and luck < 50 then
		value, prefixLevel = RPCItems:RollAttribute(xpBounty, 1, 2, 0, 0, item.rarity, false, nil)
		item.property2 = value
    	item.property2name = "strength"
		prefix = PREFIX_STRENGTH_TABLE[prefixLevel]
		RPCItems:SetPropertyValues(item, item.property2, "item_perm_strength", "#CC0000",  2)
    elseif luck >= 50 and luck < 60 then
		value, prefixLevel = RPCItems:RollAttribute(xpBounty, 1, 2, 0, 0, item.rarity, false, nil)
		item.property2 = value
    	item.property2name = "agility"
		prefix = PREFIX_AGILITY_TABLE[prefixLevel]
		RPCItems:SetPropertyValues(item, item.property2, "item_perm_agility", "#2EB82E",  2)
    elseif luck >= 60 and luck < 70 then
		value, prefixLevel = RPCItems:RollAttribute(xpBounty, 1, 2, 0, 0, item.rarity, false, nil)
		item.property2 = value
    	item.property2name = "intelligence"
		prefix = PREFIX_INTELLIGENCE_TABLE[prefixLevel]
		RPCItems:SetPropertyValues(item, item.property2, "item_perm_intelligence", "#33CCFF",  2)	
    elseif luck >= 70 and luck < 80 then
		value, prefixLevel = RPCItems:RollAttribute(xpBounty, 50, 150, 2, 4, item.rarity, false, nil)
		item.property2 = value
    	item.property2name = "mana_heal"
		prefix = PREFIX_MANA_HEAL_TABLE[prefixLevel]
		RPCItems:SetPropertyValues(item, item.property2, "item_mana_restore", "#1975FF",  2)	
	else
		value, prefixLevel = RPCItems:RollAttribute(xpBounty, 7, 28, 1, 5, item.rarity, false, nil)
		item.property2 = value
    	item.property2name = "exp"
		prefix = PREFIX_EXP_TABLE[prefixLevel]
		RPCItems:SetPropertyValues(item, item.property2, "item_bonus_exp", "#E6B800",  2)	
	end
	return prefix


end

POTION_NAME_TABLE = {"Godly Potion", "Ultra Potion", "Divine Potion", "Mega Potion", "Super Potion"}

function RPCItems:RollPotionProperty3(item, xpBounty)
	luck = RandomInt(0,100)
	local name =""
	if luck < 20 then
		value, nameLevel = RPCItems:RollAttribute(xpBounty, 100, 300, 3, 8, item.rarity, false, nil)
		item.property3 = value
    	item.property3name = "heal"
    	name = POTION_NAME_TABLE[nameLevel]
    	RPCItems:SetPropertyValues(item, item.property3, "item_health_restore", "#99FF66",  3)
    elseif luck >= 20 and luck < 35 then
		value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 3, 0, 0, item.rarity, false, nil)
		item.property3 = value
    	item.property3name = "strength"
		name = POTION_NAME_TABLE[nameLevel]
		RPCItems:SetPropertyValues(item, item.property3, "item_perm_strength", "#CC0000",  3)
    elseif luck >= 35 and luck < 50 then
		value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 3, 0, 0, item.rarity, false, nil)
		item.property3 = value
    	item.property3name = "agility"
		name = POTION_NAME_TABLE[nameLevel]
		RPCItems:SetPropertyValues(item, item.property3, "item_perm_agility", "#2EB82E",  3)
    elseif luck >= 50 and luck < 65 then
		value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 3, 0, 0, item.rarity, false, nil)
		item.property3 = value
    	item.property3name = "intelligence"
		name = POTION_NAME_TABLE[nameLevel]
		RPCItems:SetPropertyValues(item, item.property3, "item_perm_intelligence", "#33CCFF",  3)	
    elseif luck >= 65 and luck < 80 then
		value, nameLevel = RPCItems:RollAttribute(xpBounty, 50, 150, 2, 4, item.rarity, false, nil)
		item.property3 = value
    	item.property3name = "mana_heal"
		name = POTION_NAME_TABLE[nameLevel]
		RPCItems:SetPropertyValues(item, item.property3, "item_mana_restore", "#1975FF",  3)	
	else
		value, nameLevel = RPCItems:RollAttribute(xpBounty, 7, 30, 4, 8, item.rarity, false, nil)
		item.property3 = value
    	item.property3name = "exp"
		name = POTION_NAME_TABLE[prefixLevel]
		RPCItems:SetPropertyValues(item, item.property3, "item_bonus_exp", "#E6B800",  3)	
	end
	return name
end

POTION_NAME_TABLE2 = {"Godly Elixir", "Ultra Elixir", "Divine Elixir", "Mega Elixir", "Super Elixir"}

function RPCItems:RollPotionProperty4(item, xpBounty)
	luck = RandomInt(0,100)
	if luck < 20 then
		value, nameLevel = RPCItems:RollAttribute(xpBounty, 100, 300, 3, 8, item.rarity, false, nil)
		item.property4 = value
    	item.property4name = "heal"
    	local name = POTION_NAME_TABLE2[nameLevel]
    	RPCItems:SetPropertyValues(item, item.property4, "item_health_restore", "#99FF66",  4)
    elseif luck >= 20 and luck < 35 then
		value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 4, 0, 0, item.rarity, false, nil)
		item.property4 = value
    	item.property4name = "strength"
		local name = POTION_NAME_TABLE2[nameLevel]
		RPCItems:SetPropertyValues(item, item.property4, "item_perm_strength", "#CC0000",  4)
    elseif luck >= 35 and luck < 50 then
		value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 4, 0, 0, item.rarity, false, nil)
		item.property4 = value
    	item.property4name = "agility"
		local name = POTION_NAME_TABLE2[nameLevel]
		RPCItems:SetPropertyValues(item, item.property4, "item_perm_agility", "#2EB82E",  4)
    elseif luck >= 50 and luck < 65 then
		value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 4, 0, 0, item.rarity, false, nil)
		item.property4 = value
    	item.property4name = "intelligence"
		local name = POTION_NAME_TABLE2[nameLevel]
		RPCItems:SetPropertyValues(item, item.property4, "item_perm_intelligence", "#33CCFF",  4)	
    elseif luck >= 65 and luck < 80 then
		value, nameLevel = RPCItems:RollAttribute(xpBounty, 50, 150, 2, 4, item.rarity, false, nil)
		item.property4 = value
    	item.property4name = "mana_heal"
		local name = POTION_NAME_TABLE2[nameLevel]
		RPCItems:SetPropertyValues(item, item.property4, "item_mana_restore", "#1975FF",  4)	
	else
		value, nameLevel = RPCItems:RollAttribute(xpBounty, 10, 30, 5, 10, item.rarity, false, nil)
		item.property4 = value
    	item.property4name = "exp"
		local name = POTION_NAME_TABLE2[prefixLevel]
		RPCItems:SetPropertyValues(item, item.property4, "item_bonus_exp", "#E6B800",  4)	
	end
	return name


end

function RPCItems:RollAttribute(xpBounty, minBase, maxBase, bountyFactorMin, bountyFactorMax, itemRarity, isFloat, maximumValue)
	local rarityFactor = RPCItems:GetRarityFactor(itemRarity)
	local waveFactor = round(10/4, 0)
	local suffixLevel = 0
	local value = 0
	if waveFactor < 1 then
		waveFactor = 1
	end
	
		waveFactor = 10/4
	
	local luck = RandomInt(0, 100)
	if luck < 60 then
		value = RandomInt(minBase, maxBase)*RandomInt(1, rarityFactor+waveFactor) + round(xpBounty/4, 0)*RandomInt(bountyFactorMin, bountyFactorMax)
		suffixLevel = 1
	elseif luck >= 60 and luck < 80 then
		value = RandomInt(minBase, maxBase*2)*RandomInt(1, rarityFactor+waveFactor) + round(xpBounty/4, 0)*RandomInt(bountyFactorMin, bountyFactorMax*2)
		suffixLevel = 2
	elseif luck >= 80 and luck < 90 then
		value = RandomInt(minBase*2, maxBase*3)*RandomInt(1, rarityFactor+waveFactor) + round(xpBounty/4, 0)*RandomInt(bountyFactorMin*2, bountyFactorMax*3)
		suffixLevel = 3
	elseif luck >= 90 and luck < 97 then
		value = RandomInt(minBase*3, maxBase*4)*RandomInt(1, rarityFactor+waveFactor) + round(xpBounty/4, 0)*RandomInt(bountyFactorMin*3, bountyFactorMax*4)
		suffixLevel = 4
	elseif luck >= 97 then
		value = RandomInt(minBase*4, maxBase*5)*RandomInt(1, rarityFactor+waveFactor) + round(xpBounty/4, 0)*RandomInt(bountyFactorMin*4, bountyFactorMax*5)
		suffixLevel = 5
	end
	if maximumValue then
		if value > maximumValue then
			value = maximumValue
		end
	end
	if isFloat then
		if luck < 50 then
			value = RandomInt(10, 30)/10
		elseif luck < 80 then
			value = RandomInt(10, 60)/10
		else
			value = RandomInt(30, 80)/10
		end
		value = round(value, 0)
	end
	print("value: "..value)
	return value, suffixLevel
end

function round(num, idp)
  return tonumber(string.format("%." .. (idp or 0) .. "f", num))
end

GLOBAL_ITEM_TABLE = {}

function RPCItems:ClearItems()
	local i = 1
	--GameRules:GetGameTime() instead of time
    for k,item in pairs(GLOBAL_ITEM_TABLE) do
        if item and not item:IsNull() then
        	if item.expiryTime then
        		if Time() > item.expiryTime then
					local container = item:GetContainer()
					if container then
						UTIL_Remove(container)
					end
					UTIL_Remove(item)
					table.remove(GLOBAL_ITEM_TABLE, i) 
            	end
            end
        end
        i = i+1
    end
	-- for j = 0, #GLOBAL_ITEM_TABLE, 1 do
	-- 	local i = 0
	-- 	for _,item in pairs(GLOBAL_ITEM_TABLE) do
	-- 		i = i+1
	-- 		if item then
	-- 			if item.expiryTime then
	-- 				if Time() > item.expiryTime then
	-- 					local container = item:GetContainer()
	-- 					if container then
	-- 						UTIL_Remove(container)
	-- 					end
	-- 					if item then
	-- 						UTIL_Remove(item)
	-- 					end
	-- 					table.remove(GLOBAL_ITEM_TABLE, i)
	-- 					break

	-- 				end
	-- 			end
	-- 		end
	-- 	end

	-- end
	-- local numItems = GameRules:NumDroppedItems()
	-- for j = 1, numItems, 1 do
	-- 	local item = GameRules:GetDroppedItem(j)
	-- 		if item.expiryTime then
	-- 			if Time() > item.expiryTime then
	-- 				local container = item:GetContainer()
	-- 				UTIL_Remove(container)
	-- 				UTIL_Remove(item)
	-- 			end
	-- 		end
	-- end
end

function RPCItems:DropGold(item, position)
	if Dungeons.lootLaunch then
		position = GetGroundPosition(Dungeons.lootLaunch + RandomVector(RandomInt(10, 120)), nil)
	elseif Dungeons.entryPoint then
		position = GetGroundPosition(position+RandomVector(RandomInt(100, 250)), nil)
	else
		position = GetGroundPosition(position+RandomVector(RandomInt(100, 500)), nil)
	end
	item.expiryTime = Time() + 140
	 table.insert(GLOBAL_ITEM_TABLE, item)
	 
	 if Dungeons.lootLaunch then
	 	item:LaunchLoot(true, RandomInt(100,300), 0.75, position)
	 else
	 	item:LaunchLoot(true, RandomInt(100,600), 0.75, position)
	 end

end


function RPCItems:DropItem(item, position)
	if Dungeons.lootLaunch then
		position = GetGroundPosition(Dungeons.lootLaunch + RandomVector(RandomInt(10, 120)), nil)
	elseif Dungeons.entryPoint then
		position = GetGroundPosition(position+RandomVector(RandomInt(100, 220)), nil)
	else
		position = GetGroundPosition(position+RandomVector(RandomInt(100, 500)), nil)
	end
	local rarityFactor = RPCItems:GetRarityFactor(item.rarity)
	item.expiryTime = Time() + 140
	if rarityFactor > 2 then
			local particleName = RPCItems:GetRarityParticle(item.rarity)
			item.particle = ParticleManager:CreateParticle( particleName, PATTACH_CUSTOMORIGIN, item )
			ParticleManager:SetParticleControl( item.particle, 0, position )
			item.expiryTime = Time() + 260
	end

	 table.insert(GLOBAL_ITEM_TABLE, item)
	 
	 if Dungeons.lootLaunch then
	 	item:LaunchLoot(false, RandomInt(100,300), 0.75, position)
	 else
	 	item:LaunchLoot(false, RandomInt(100,600), 0.75, position)
	 end

end

function RPCItems:SetTableValues(item, itemName, consumableBoolean, description, qualityColor, qualityName, prefix, suffix, rarityFactor)
	CustomNetTables:SetTableValue( "item_basics", tostring(item:GetEntityIndex()), {itemName = itemName, consumable = consumableBoolean, itemDescription = description, qualityColor = qualityColor, qualityName = qualityName, itemPrefix = prefix, itemSuffix = suffix, rarityFactor = rarityFactor } )
end

function RPCItems:SetPropertyValues(item, propertyValue, propertyName, propertyColor, propertyNumber)
	print('-----property-adding-to-table-----')
	print(item)
	print(propertyValue) 
	print(propertyName)
	print(propertyColor)
	print(propertyNumber)
	print('-----end-----')
	CustomNetTables:SetTableValue( "item_properties", tostring(item:GetEntityIndex()).."-"..tostring(propertyNumber), {propertyValue = propertyValue, propertyName = propertyName, propertyColor = propertyColor })
end

function RPCItems:SetPropertyValuesSpecial(item, propertyValue, propertyName, propertyColor, propertyNumber, specialDescription)
	print('-----property-adding-to-table-----')
	print(item)
	print(propertyValue) 
	print(propertyName)
	print(propertyColor)
	print(propertyNumber)
	print('-----end-----')
	CustomNetTables:SetTableValue( "item_properties", tostring(item:GetEntityIndex()).."-"..tostring(propertyNumber), {propertyValue = propertyValue, propertyName = propertyName, propertyColor = propertyColor, specialDescription = specialDescription, specialValue = specialValue })
end



function RPCItems:GetRarityColor(rarityName)
	local color = ""
	if rarityName == "common" then
		color = "#B0C3D9"
	elseif rarityName == "uncommon" then
		color = "#99FF33"
	elseif rarityName == "rare" then
		color = "#4B69FF"
	elseif rarityName == "mythical" then
		color = "#8847FF"
	elseif rarityName == "immortal" then
		color = "#E4AE33"
	end
	return color
end

function RPCItems:GetRarityFactor(rarityName)
	local factor = 0
	if rarityName == "common" then
		factor = 1
	elseif rarityName == "uncommon" then
		factor = 2
	elseif rarityName == "rare" then
		factor = 3
	elseif rarityName == "mythical" then
		factor = 4
	elseif rarityName == "immortal" then
		factor = 5
	end
	return factor
end

function RPCItems:GetRarityParticle(rarityName)
	local color = ""
	if rarityName == "common" then
		return "particles/units/heroes/hero_silencer/itemdropcommon.vpcf"
	elseif rarityName == "uncommon" then
		return "particles/units/heroes/hero_silencer/itemdropmythical.vpcf"
	elseif rarityName == "rare" then
		return "particles/units/heroes/hero_silencer/silencer_last_word_status.vpcf"
	elseif rarityName == "mythical" then
		color = "particles/units/heroes/hero_silencer/itemdroprare.vpcf"
	elseif rarityName == "immortal" then
		color = "particles/units/heroes/hero_silencer/itemdropimmortal.vpcf"
	end
	return color
end

function RPCItems:GearPickup(heroEntity, itemEntity)
	local player = heroEntity:GetPlayerOwner()
	local slot = RPCItems:getGearSlot(itemEntity.slot)
	local oldGearTable = CustomNetTables:GetTableValue("equipment", tostring(player:GetPlayerID()).."-"..tostring(slot))
	local oldGear = false
	if oldGearTable then
		oldGear = EntIndexToHScript(oldGearTable.itemIndex)
	end
	if oldGear then
		CustomGameEventManager:Send_ServerToPlayer(player, "new_item_with_slot", {newItem=itemEntity:GetEntityIndex(), oldItem=oldGear:GetEntityIndex()} )
		heroEntity:DropItemAtPositionImmediate(itemEntity, Vector(-8000,2000))
	else
		local playerID = heroEntity:GetPlayerID()
		local heroId = heroEntity:GetClassname()
		CustomNetTables:SetTableValue("equipment", tostring(player:GetPlayerID()).."-"..tostring(slot), {itemIndex = itemEntity:GetEntityIndex()} )
		-- CustomGameEventManager:Send_ServerToPlayer(player, "InitializeEquipment", {item=itemEntity:GetEntityIndex()} )
  		heroEntity:DropItemAtPositionImmediate(itemEntity, Vector(-8000,2000))
 		local hero = heroEntity
 		local inventory_unit = heroEntity.InventoryUnit
		RPCItems:EquipItem(slot, hero, inventory_unit, itemEntity)
		CustomGameEventManager:Send_ServerToAllClients("PickupPopup", {item=itemEntity:GetEntityIndex(), heroId=heroId, playerId=playerID, pickup="equip"} )
        EmitGlobalSound("ui.treasure_reveal")
        EmitGlobalSound("ui.treasure_reveal")
        EmitGlobalSound("ui.treasure_reveal")
	end
	
end

function RPCItems:EquipItem(slot, hero, inventory_unit, itemEntity)
	
	if slot == 0 then
		Head:remove_modifiers(hero)
	 	Timers:CreateTimer(1, 
	 	function()
			Head:add_modifiers(hero, inventory_unit, itemEntity)
		end)
	end
	if slot == 1 then
		Weaponmodifiers:remove_modifiers(hero)
	 	Timers:CreateTimer(1, 
	 	function()
			Weaponmodifiers:add_modifiers(hero, inventory_unit, itemEntity)
		end)
	end
	if slot == 2 then
		Hand:remove_modifiers(hero)
	 	Timers:CreateTimer(1, 
	 	function()
			Hand:add_modifiers(hero, inventory_unit, itemEntity)
		end)
	end
	if slot == 3 then
		Foot:remove_modifiers(hero)
	 	Timers:CreateTimer(1, 
	 	function()
			Foot:add_modifiers(hero, inventory_unit, itemEntity)
		end)
	end
	if slot == 4 then
		Body:remove_modifiers(hero)
	 	Timers:CreateTimer(1, 
	 	function()
			Body:add_modifiers(hero, inventory_unit, itemEntity)
		end)
	end
	if slot == 5 then
		Amulet:remove_modifiers(hero)
	 	Timers:CreateTimer(1, 
	 	function()
			Amulet:add_modifiers(hero, inventory_unit, itemEntity)
		end)
	end
	Timers:CreateTimer(2, function()
		CustomGameEventManager:Send_ServerToAllClients("update_runes", {})
	end)
end

function RPCItems:EquipAllRespawn(player)
	local hero, inventory_unit = RPCItems:GetHeroAndInventoryByID(player:GetPlayerID())
	Head:remove_modifiers(hero)
	Hand:remove_modifiers(hero)
	Foot:remove_modifiers(hero)
	Body:remove_modifiers(hero)
	Amulet:remove_modifiers(hero)
	local oldGearTable = CustomNetTables:GetTableValue("equipment", tostring(player:GetPlayerID()).."-"..tostring(0))
	local oldGear = false
	local itemEntity = false
	if oldGearTable then
		oldGear = EntIndexToHScript(oldGearTable.itemIndex)
		itemEntity = EntIndexToHScript(oldGear)
	end
	if itemEntity then
		Head:add_modifiers(hero, inventory_unit, itemEntity)
	end
	oldGearTable = false
	oldGearTable = CustomNetTables:GetTableValue("equipment", tostring(player:GetPlayerID()).."-"..tostring(1))
	oldGear = false
	local itemEntity = false
	if oldGearTable then
		oldGear = EntIndexToHScript(oldGearTable.itemIndex)
		itemEntity = EntIndexToHScript(oldGear)
	end
	if itemEntity then
		Hand:add_modifiers(hero, inventory_unit, itemEntity)
	end
	oldGearTable = false
	oldGearTable = CustomNetTables:GetTableValue("equipment", tostring(player:GetPlayerID()).."-"..tostring(2))
	oldGear = false
	local itemEntity = false
	if oldGearTable then
		oldGear = EntIndexToHScript(oldGearTable.itemIndex)
		itemEntity = EntIndexToHScript(oldGear)
	end
	if itemEntity then
		Foot:add_modifiers(hero, inventory_unit, itemEntity)
	end
	oldGearTable = false
	oldGearTable = CustomNetTables:GetTableValue("equipment", tostring(player:GetPlayerID()).."-"..tostring(3))
	oldGear = false
	local itemEntity = false
	if oldGearTable then
		oldGear = EntIndexToHScript(oldGearTable.itemIndex)
		itemEntity = EntIndexToHScript(oldGear)
	end
	if itemEntity then
		Body:add_modifiers(hero, inventory_unit, itemEntity)
	end
end

function RPCItems:FindPickupSlot(itemEntity, inventory_unit)
	local gear0 = inventory_unit:GetItemInSlot(0)
	local gear1 = inventory_unit:GetItemInSlot(1)
	local gear2 = inventory_unit:GetItemInSlot(2)
	local gear3 = inventory_unit:GetItemInSlot(3)
	local gear4 = inventory_unit:GetItemInSlot(4)
	local gear5 = inventory_unit:GetItemInSlot(5)
	if gear0 == itemEntity then
		return 0
	elseif gear1 == itemEntity then
		return 1
	elseif gear2 == itemEntity then
		return 2
	elseif gear3 == itemEntity then
		return 3
	elseif gear4 == itemEntity then
		return 4
	elseif gear5 == itemEntity then
		return 5
	end
end

function RPCItems:getGearSlot(gearType)
	if gearType == "head" then
		return 0
	elseif gearType == "weapon" then
		return 1
	elseif gearType == "hands" then
		return 2
	elseif gearType == "feet" then
		return 3
	elseif gearType == "body" then
		return 4
	elseif gearType == "amulet" then
		return 5
	end
end

function RPCItems:AcceptNewItem(keys)
	local playerID = keys.PlayerID
	local oldItem = EntIndexToHScript(keys.oldItem)
	local newItem = EntIndexToHScript(keys.newItem)
	print("item accepted")
	DeepPrintTable(keys)
	local slot = RPCItems:getGearSlot(newItem.slot)
	CustomNetTables:SetTableValue("equipment", tostring(playerID).."-"..tostring(slot), {itemIndex = newItem:GetEntityIndex()} )
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "update_inventory", {} )
	
	if oldItem then
		 UTIL_Remove( oldItem ) 
	end
	local hero, inventory_unit = RPCItems:GetHeroAndInventoryByID(keys.PlayerID)
      EmitGlobalSound("ui.treasure_reveal")
      EmitGlobalSound("ui.treasure_reveal")
      EmitGlobalSound("ui.treasure_reveal")
      local player = hero:GetPlayerOwner()
      local heroId = hero:GetClassname()
      if newItem then
	      CustomGameEventManager:Send_ServerToAllClients("PickupPopup", {item=newItem:GetEntityIndex(), heroId=heroId, playerId=playerID, pickup="equip"} )
	      RPCItems:EquipItem(slot, hero, inventory_unit, newItem)
  	end
end

function RPCItems:RejectNewItem(keys)
	local playerID = keys.PlayerID
	local oldItem = EntIndexToHScript(keys.oldItem)
	local newItem = EntIndexToHScript(keys.newItem)
	UTIL_Remove( newItem ) 
	print("item rejected")
end

function RPCItems:GetHeroAndInventoryByID(playerID)
	local hero = PlayerResource:GetSelectedHeroEntity(playerID)

	return hero, hero.InventoryUnit

end

function RPCItems:GiveItemToHero(hero, item)
	hero:AddItem(item)
	Events:PickUpTest(hero, item)
end

function RPCItems:BuyItem(keys)
	local playerID = keys.playerID
	local player = PlayerResource:GetPlayer(playerID)
	local itemtype = keys.itemtype
	local price = keys.price
	local rarity = keys.rarity
	local hero, inventory_unit = RPCItems:GetHeroAndInventoryByID(playerID)
	print(itemtype)
	print("BUY ITEM")
	local gold = PlayerResource:GetGold(playerID)
	print(price)
	if gold < price then
		EmitSoundOnClient("General.NoGold", player)
		Notifications:Top(playerID, {text="Not Enough Gold", duration=2, style={color="red"}, continue=true})
	elseif not hero:HasAnyAvailableInventorySpace() then
		EmitSoundOnClient("General.NoGold", player)
		Notifications:Top(playerID, {text="Need Inventory Space", duration=2, style={color="red"}, continue=true})
	else
		print(price)
		local newGold = gold-price
		PlayerResource:SetGold(playerID, newGold, false)
		EmitSoundOnClient("General.Buy", player)
		if itemtype == 1 then
			RPCItems:RollHood(5+Events.WaveNumber*5, hero:GetAbsOrigin(), rarity, true, 2, hero)
		elseif itemtype == 2 then
			RPCItems:RollHood(5+Events.WaveNumber*5, hero:GetAbsOrigin(), rarity, true, 3, hero)
		elseif itemtype == 3 then
			RPCItems:RollHood(5+Events.WaveNumber*5, hero:GetAbsOrigin(), rarity, true, 1, hero)
		elseif itemtype == 4 then
			RPCItems:RollBody(5+Events.WaveNumber*5, hero:GetAbsOrigin(), rarity, true, 2, hero)
		elseif itemtype == 5 then
			RPCItems:RollBody(5+Events.WaveNumber*5, hero:GetAbsOrigin(), rarity, true, 3, hero)
		elseif itemtype == 6 then
			RPCItems:RollBody(5+Events.WaveNumber*5, hero:GetAbsOrigin(), rarity, true, 1, hero)
		elseif itemtype == 7 then
			RPCItems:RollFoot(5+Events.WaveNumber*5, hero:GetAbsOrigin(), rarity, true, 2, hero)
		elseif itemtype == 8 then
			RPCItems:RollFoot(5+Events.WaveNumber*5, hero:GetAbsOrigin(), rarity, true, 3, hero)
		elseif itemtype == 9 then
			RPCItems:RollFoot(5+Events.WaveNumber*5, hero:GetAbsOrigin(), rarity, true, 1, hero)
		elseif itemtype == 10 then
			RPCItems:RollHand(5+Events.WaveNumber*5, hero:GetAbsOrigin(), rarity, true, 2, hero)
		elseif itemtype == 11 then
			RPCItems:RollHand(5+Events.WaveNumber*5, hero:GetAbsOrigin(), rarity, true, 3, hero)
		elseif itemtype == 12 then
			RPCItems:RollHand(5+Events.WaveNumber*5, hero:GetAbsOrigin(), rarity, true, 1, hero)
		elseif itemtype == 13 then
			RPCItems:RollBlaster(5+Events.WaveNumber*5, hero:GetAbsOrigin(), rarity, true, 2, hero)
		elseif itemtype == 14 then
			RPCItems:RollBlaster(5+Events.WaveNumber*5, hero:GetAbsOrigin(), rarity, true, 3, hero)
		elseif itemtype == 15 then
			RPCItems:RollBlaster(5+Events.WaveNumber*5, hero:GetAbsOrigin(), rarity, true, 1, hero)
		elseif itemtype == "immortal_helm" then
			RPCItems:RollHood(300, hero:GetAbsOrigin(), rarity, true, RandomInt(1, 3), hero)
			hero.legendHelm = true
			CustomGameEventManager:Send_ServerToPlayer(player, "CloseRareShop", {player=playerID} )
		end
	end
end

function RPCItems:GetMaxFactor()

    return 10
end

