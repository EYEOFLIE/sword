if Weapons == nil then
  Weapons = class({})
end

Weapons.XP_PER_LEVEL_TABLE = {}
for i=1,50, 1 do
	if i <=5 then
		Weapons.XP_PER_LEVEL_TABLE[i] = i*250
	elseif i<=10 then
		Weapons.XP_PER_LEVEL_TABLE[i] = 1250 + (i-5)*1500
	elseif i<=15 then
		Weapons.XP_PER_LEVEL_TABLE[i] = 8750 + (i-10)*1000
	elseif i<=20 then
		Weapons.XP_PER_LEVEL_TABLE[i] = 13750 + (i-15)*2000
	else
		Weapons.XP_PER_LEVEL_TABLE[i] = 23750 + (i-20)*4000
	end
end

--debug
-- for i=1,50, 1 do
-- 	Weapons.XP_PER_LEVEL_TABLE[i] = 200
-- end

function Weapons:weaponRedirect(hero)
	local heroName = hero:GetName()
	if heroName == "npc_dota_hero_dragon_knight" then
		Weapons:InitialWeapon(hero, "item_rpc_basic_sword", "Basic Sword")
	elseif heroName == "npc_dota_hero_phantom_assassin" then
		Weapons:InitialWeapon(hero, "item_rpc_voltex_weapon_00", "Hand Blade")
	elseif heroName == "npc_dota_hero_necrolyte" then
		Weapons:InitialWeapon(hero, "item_rpc_venomort_weapon_00", "Scythe")
	elseif heroName == "npc_dota_hero_axe" then
		Weapons:InitialWeapon(hero, "item_rpc_basic_axe", "Basic Axe")
	elseif heroName == "npc_dota_hero_drow_ranger" then
		Weapons:InitialWeapon(hero, "item_rpc_astral_weapon_00", "Basic Bow")
	elseif heroName == "npc_dota_hero_obsidian_destroyer" then
		Weapons:InitialWeapon(hero, "item_rpc_basic_staff", "Staff")
	elseif heroName == "npc_dota_hero_omniknight" then
		Weapons:InitialWeapon(hero, "item_rpc_basic_hammer", "Hammer")
	elseif heroName == "npc_dota_hero_crystal_maiden" then
		Weapons:InitialWeapon(hero, "item_rpc_basic_staff", "Staff")
	elseif heroName == "npc_dota_hero_invoker" then
		Weapons:InitialWeaponConjuror(hero, "item_rpc_conjuror_weapon_00", "Orb")
	elseif heroName == "npc_dota_hero_juggernaut" then
		Weapons:InitialWeapon(hero, "item_rpc_basic_sword", "Basic Sword")
	elseif heroName == "npc_dota_hero_beastmaster" then
		Weapons:InitialWeapon(hero, "item_rpc_basic_axe", "Basic Axe")
	elseif heroName == "npc_dota_hero_leshrac" then
		Weapons:InitialWeapon(hero, "item_rpc_bahamut_weapon_00", "Base Rune")
	end
end

function Weapons:InitialWeapon(hero, item_variant, itemName)
    local item = RPCItems:CreateVariant(item_variant, "common", itemName, "weapon", true, "Slot: Weapon")
    item.xp = 0
    item.level = 1
    item.upgradeStatus = 0
    item.phase = 0
    item.upgradeIndex = "00"
    hero.weapon = item
    CustomNetTables:SetTableValue("weapons", tostring(hero:GetEntityIndex()), {xp = item.xp, level = item.level, xpNeeded = Weapons.XP_PER_LEVEL_TABLE[item.level], upgradeStatus = item.upgradeStatus, phase = item.phase, upgradeIndex = item.upgradeIndex} )

    item.property1 = 100
    item.property1name = "attack_damage"
    RPCItems:SetPropertyValues(item, item.property1, "#item_bonus_attack_damage", "#343EC9",  1) 

    Weapons:Equip(hero, item)
end

function Weapons:InitialWeaponConjuror(hero, item_variant, itemName)
    local item = RPCItems:CreateVariant(item_variant, "common", itemName, "weapon", true, "Slot: Weapon")
    item.xp = 0
    item.level = 1
    item.upgradeStatus = 0
    item.phase = 0
    item.upgradeIndex = "00"
    hero.weapon = item
    CustomNetTables:SetTableValue("weapons", tostring(hero:GetEntityIndex()), {xp = item.xp, level = item.level, xpNeeded = Weapons.XP_PER_LEVEL_TABLE[item.level], upgradeStatus = item.upgradeStatus, phase = item.phase, upgradeIndex = item.upgradeIndex} )

    item.property1 = 1000
    item.property1name = "aspect_health"
    RPCItems:SetPropertyValues(item, item.property1, "#item_aspect_health", "#3D82CC",  1) 

    Weapons:Equip(hero, item)
end

function Weapons:Equip(heroEntity, itemEntity)
	local player = heroEntity:GetPlayerOwner()
	local slot = RPCItems:getGearSlot(itemEntity.slot)
	local oldGearTable = CustomNetTables:GetTableValue("equipment", tostring(player:GetPlayerID()).."-"..tostring(slot))
	local oldGear = false
	local playerID = heroEntity:GetPlayerID()
	local heroId = heroEntity:GetClassname()
	CustomNetTables:SetTableValue("equipment", tostring(player:GetPlayerID()).."-"..tostring(slot), {itemIndex = itemEntity:GetEntityIndex()} )
	-- CustomGameEventManager:Send_ServerToPlayer(player, "InitializeEquipment", {item=itemEntity:GetEntityIndex()} )
	heroEntity:DropItemAtPositionImmediate(itemEntity, Vector(-8000,2000))
	local hero, inventory_unit = RPCItems:GetHeroAndInventoryByID(player:GetPlayerID())
	RPCItems:EquipItem(slot, hero, inventory_unit, itemEntity)
	CustomGameEventManager:Send_ServerToAllClients("PickupPopup", {item=itemEntity:GetEntityIndex(), heroId=heroId, playerId=playerID, pickup="equip"} )
    EmitGlobalSound("ui.treasure_reveal")
    EmitGlobalSound("ui.treasure_reveal")
    EmitGlobalSound("ui.treasure_reveal")
end

function Weapons:UpdateWeaponXP(xpBounty)
	for i = 1, #MAIN_HERO_TABLE, 1 do
		if MAIN_HERO_TABLE[i]:IsAlive() then
			local showLevelup = false
			local hero = MAIN_HERO_TABLE[i]
			local weapon = hero.weapon
			if hero:HasModifier("modifier_blacksmiths_tablet") then
				xpBounty = math.floor(xpBounty*1.2)
			end
			weapon.xp = weapon.xp + xpBounty
			if weapon.xp >= Weapons.XP_PER_LEVEL_TABLE[weapon.level] then
				weapon.xp = xpBounty - (Weapons.XP_PER_LEVEL_TABLE[weapon.level]-weapon.xp)
				weapon.level = weapon.level + 1
				showLevelup = true
				if weapon.level == 5 or weapon.level == 10 or weapon.level == 20 then
					weapon.upgradeStatus = 1
				end
				CustomGameEventManager:Send_ServerToPlayer(hero:GetPlayerOwner(), "WeaponLvlup", {})
				Weapons:LevelUpWeapon(hero, weapon)
			end
			CustomNetTables:SetTableValue("weapons", tostring(hero:GetEntityIndex()), {xp = weapon.xp, level = weapon.level, xpNeeded = Weapons.XP_PER_LEVEL_TABLE[weapon.level], upgradeStatus = weapon.upgradeStatus, phase = weapon.phase, upgradeIndex = weapon.upgradeIndex} )
		end
	end
end

function Weapons:LevelUpWeapon(hero, weapon)
    local origValues = CustomNetTables:GetTableValue( "item_properties", tostring(weapon:GetEntityIndex()).."-"..tostring(1))
	weapon.property1 = weapon.property1+WallPhysics:round(weapon.property1*0.1,0)
	RPCItems:SetPropertyValues(weapon, weapon.property1, origValues.propertyName, origValues.propertyColor,  1)
    if weapon.property2 then
	    local origValues = CustomNetTables:GetTableValue( "item_properties", tostring(weapon:GetEntityIndex()).."-"..tostring(2))
    	weapon.property2 = weapon.property2+WallPhysics:round(weapon.property2*0.1,0)
    	RPCItems:SetPropertyValues(weapon, weapon.property2, origValues.propertyName, origValues.propertyColor,  2)
    end
    if weapon.property3 then
	    local origValues = CustomNetTables:GetTableValue( "item_properties", tostring(weapon:GetEntityIndex()).."-"..tostring(3))
    	weapon.property3 = weapon.property3+WallPhysics:round(weapon.property3*0.1,0)
    	RPCItems:SetPropertyValues(weapon, weapon.property3, origValues.propertyName, origValues.propertyColor,  3)
    end
    if weapon.property4 then
	    local origValues = CustomNetTables:GetTableValue( "item_properties", tostring(weapon:GetEntityIndex()).."-"..tostring(4))
    	weapon.property4 = weapon.property4+WallPhysics:round(weapon.property4*0.1,0)
    	RPCItems:SetPropertyValues(weapon, weapon.property4, origValues.propertyName, origValues.propertyColor,  4)
    end
    Weapons:Equip(hero, weapon)
end

function Weapons:WeaponUpgrade(keys)
	local hero = EntIndexToHScript(keys.hero)
	local upgradeIndex = keys.index
	local itemVariant = keys.itemVariant
	local itemName = keys.weaponName
	local property = keys.propertyCode
	local propertyValue = keys.value
	local propertyTitle = keys.propertyTitle
	local propertyColor = keys.propertyColor	
	Weapons:NewWeapon(hero, itemVariant, itemName, hero.weapon, property, propertyValue, upgradeIndex, propertyTitle, propertyColor)
	print("upgrade_to: "..upgradeIndex)
end

function Weapons:NewWeapon(hero, itemVariant, itemName, weapon, property, propertyValue, index, propertyTitle, propertyColor)
	if weapon.phase == 0 then
		print(itemVariant)
	    local newWeapon = RPCItems:CreateVariant(itemVariant, "uncommon", itemName, "weapon", true, "Slot: Weapon")
	    newWeapon.xp = 0
	    newWeapon.level = 5
	    newWeapon.upgradeStatus = 0
	    newWeapon.phase = 1
	    newWeapon.upgradeIndex = index
	    hero.weapon = newWeapon
	    CustomNetTables:SetTableValue("weapons", tostring(hero:GetEntityIndex()), {xp = newWeapon.xp, level = newWeapon.level, xpNeeded = Weapons.XP_PER_LEVEL_TABLE[newWeapon.level], upgradeStatus = newWeapon.upgradeStatus, phase = newWeapon.phase, index = newWeapon.index} )

	    newWeapon.property1 = weapon.property1
	    newWeapon.property1name = weapon.property1name
	    local origValues = CustomNetTables:GetTableValue( "item_properties", tostring(weapon:GetEntityIndex()).."-"..tostring(1))
	    RPCItems:SetPropertyValues(newWeapon, newWeapon.property1, origValues.propertyName, origValues.propertyColor,  1)
	    newWeapon.property2 = propertyValue

    	newWeapon.property2name = property
    	RPCItems:SetPropertyValues(newWeapon, newWeapon.property2, propertyTitle, propertyColor,  2)
    	RPCItems:AmuletPickup(hero, newWeapon)
	   	Weapons:Equip(hero, newWeapon)
	elseif weapon.phase == 1 then
	    local newWeapon = RPCItems:CreateVariant(itemVariant, "rare", itemName, "weapon", true, "Slot: Weapon")
	    newWeapon.xp = 0
	    newWeapon.level = 10
	    newWeapon.upgradeStatus = 0
	    newWeapon.phase = 2
	    newWeapon.upgradeIndex = index
	    hero.weapon = newWeapon
	    CustomNetTables:SetTableValue("weapons", tostring(hero:GetEntityIndex()), {xp = newWeapon.xp, level = newWeapon.level, xpNeeded = Weapons.XP_PER_LEVEL_TABLE[newWeapon.level], upgradeStatus = newWeapon.upgradeStatus, phase = newWeapon.phase, index = newWeapon.index} )

	    newWeapon.property1 = weapon.property1
	    newWeapon.property1name = weapon.property1name
	    local origValues = CustomNetTables:GetTableValue( "item_properties", tostring(weapon:GetEntityIndex()).."-"..tostring(1))
	    RPCItems:SetPropertyValues(newWeapon, newWeapon.property1, origValues.propertyName, origValues.propertyColor, 1)

	    newWeapon.property2 = weapon.property2
	    newWeapon.property2name = weapon.property2name
	    origValues = CustomNetTables:GetTableValue( "item_properties", tostring(weapon:GetEntityIndex()).."-"..tostring(2))
	    RPCItems:SetPropertyValues(newWeapon, newWeapon.property2, origValues.propertyName, origValues.propertyColor, 2)
	    
	    newWeapon.property3 = propertyValue
    	newWeapon.property3name = property
    	RPCItems:SetPropertyValues(newWeapon, newWeapon.property3, propertyTitle, propertyColor, 3)
    	RPCItems:AmuletPickup(hero, newWeapon)
	   	Weapons:Equip(hero, newWeapon)
	elseif weapon.phase == 2 then
	    local newWeapon = RPCItems:CreateVariant(itemVariant, "mythical", itemName, "weapon", true, "Slot: Weapon")
	    newWeapon.xp = 0
	    newWeapon.level = 20
	    newWeapon.upgradeStatus = 0
	    newWeapon.phase = 3
	    newWeapon.upgradeIndex = index
	    hero.weapon = newWeapon
	    CustomNetTables:SetTableValue("weapons", tostring(hero:GetEntityIndex()), {xp = newWeapon.xp, level = newWeapon.level, xpNeeded = Weapons.XP_PER_LEVEL_TABLE[newWeapon.level], upgradeStatus = newWeapon.upgradeStatus, phase = newWeapon.phase, index = newWeapon.index} )

	    newWeapon.property1 = weapon.property1
	    newWeapon.property1name = weapon.property1name
	    local origValues = CustomNetTables:GetTableValue( "item_properties", tostring(weapon:GetEntityIndex()).."-"..tostring(1))
	    RPCItems:SetPropertyValues(newWeapon, newWeapon.property1, origValues.propertyName, origValues.propertyColor, 1)

	    newWeapon.property2 = weapon.property2
	    newWeapon.property2name = weapon.property2name
	    origValues = CustomNetTables:GetTableValue( "item_properties", tostring(weapon:GetEntityIndex()).."-"..tostring(2))
	    RPCItems:SetPropertyValues(newWeapon, newWeapon.property2, origValues.propertyName, origValues.propertyColor, 2)

	    newWeapon.property3 = weapon.property3
	    newWeapon.property3name = weapon.property3name
	    origValues = CustomNetTables:GetTableValue( "item_properties", tostring(weapon:GetEntityIndex()).."-"..tostring(3))
	    RPCItems:SetPropertyValues(newWeapon, newWeapon.property3, origValues.propertyName, origValues.propertyColor, 3)
	    
	    newWeapon.property4 = propertyValue
    	newWeapon.property4name = property
    	RPCItems:SetPropertyValues(newWeapon, newWeapon.property4, propertyTitle, propertyColor, 4)
    	RPCItems:AmuletPickup(hero, newWeapon)
	   	Weapons:Equip(hero, newWeapon)
	end
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(hero:GetPlayerOwnerID()), "update_inventory", {} )
	UTIL_Remove(weapon) 
end

function Weapons:Debug()
	Weapons:InitialSword(MAIN_HERO_TABLE[1])
end