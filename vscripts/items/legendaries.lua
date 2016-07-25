function RPCItems:RollNeverlordRingProperty()
    local luck = RandomInt(0,905)
    local luck2 = RandomInt(1, 100)
    local propertyName = ""
    local propertyTitle = ""
    local tier = 0
    if luck2 < 20 then
        value = RandomInt(5, 7)
    elseif luck2 < 50 then
        value = RandomInt(6, 8)
    elseif luck2 < 80 then
        value = RandomInt(7, 9)
    elseif luck2 < 95 then
        value = RandomInt(10, 15)
    elseif luck2 <= 100 then
        value = RandomInt(15, 20)
    end
    if luck < 140 then
        propertyName = "rune_a_a"
        tier = 1
    elseif luck < 240 then
        propertyName = "rune_a_b"
        tier = 1
    elseif luck < 360 then
        propertyName = "rune_a_c"
        tier = 1
    elseif luck < 485 then
        propertyName = "rune_a_d"
        tier = 1
    elseif luck < 590 then
        propertyName = "rune_b_a"
        tier = 2
    elseif luck < 695 then
        propertyName = "rune_b_b"
        tier = 2
    elseif luck < 800 then
        propertyName = "rune_b_c"
        tier = 2
    elseif luck < 910 then
        propertyName = "rune_b_d"
        tier = 2
    end
    return tier, value, propertyName
end

function RPCItems:RollNeverlordRing(xpBounty, deathLocation, rarity, isShop, type, hero)
	local randomHelm = RandomInt(1, 3)
    if isShop then
        randomHelm = type
    end
	local itemVariant = "item_rpc_never_ring"
    local item = CreateItem(itemVariant, nil, nil)



    item.rarity = "immortal"
    local rarityValue = RPCItems:GetRarityFactor(rarity)
    local itemName = "Neverlord's Soul Ring"
    local suffix = ""
    local prefix = ""
    item.slot = "amulet"
    item.gear = true

    local tier, value, propertyName = RPCItems:RollNeverlordRingProperty(item, xpBounty, randomHelm)
    item.property1 = value
    item.property1name = propertyName
    RPCItems:SetPropertyValues(item, item.property1, "rune", "#7DFF12",  1)
    local tier, value, propertyName = RPCItems:RollNeverlordRingProperty(item, xpBounty, randomHelm)
    item.property2 = value
    item.property2name = propertyName
    RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2)
    local tier, value, propertyName = RPCItems:RollNeverlordRingProperty(item, xpBounty, randomHelm)
    item.property3 = value
    item.property3name = propertyName
    RPCItems:SetPropertyValues(item, item.property3, "rune", "#7DFF12",  3)
    local tier, value, propertyName = RPCItems:RollNeverlordRingProperty(item, xpBounty, randomHelm)
    item.property4 = value
    item.property4name = propertyName
    RPCItems:SetPropertyValues(item, item.property4, "rune", "#7DFF12",  4)


    RPCItems:SetTableValues(item, itemName, false, "Slot: Trinket", RPCItems:GetRarityColor(rarity), rarity, "", "", RPCItems:GetRarityFactor(rarity))
    if isShop then
        RPCItems:GiveItemToHero(hero, item)
    else
    	local drop = CreateItemOnPositionSync( deathLocation, item )
    	local position = deathLocation + RandomVector(RandomInt(200, 600))
        RPCItems:DropItem(item, position)
    end
end

function RPCItems:RollSandTombOrb(xpBounty, deathLocation, rarity, isShop, type, hero)
    local itemVariant = "item_rpc_sand_tomb_orb"
    local item = CreateItem(itemVariant, nil, nil)



    item.rarity = "immortal"
    local rarityValue = RPCItems:GetRarityFactor(rarity)
    local itemName = "Fangs of Silithicus"
    local suffix = ""
    local prefix = ""
    item.slot = "amulet"
    item.gear = true

    local tier, value, propertyName = RPCItems:RollSlithicusRingProperty()
    item.property1 = value
    item.property1name = propertyName
    RPCItems:SetPropertyValues(item, item.property1, "rune", "#7DFF12",  1)
    local attr = RandomInt(100,200)
    item.property2 = attr
    item.property2name = "agility"
    RPCItems:SetPropertyValues(item, item.property2, "#item_agility", "#2EB82E",  2)
    item.property3 = attr
    item.property3name = "strength"
    RPCItems:SetPropertyValues(item, item.property3, "#item_strength", "#CC0000",  3)
    item.property4 = RandomInt(20,40)
    item.property4name = "armor"
    RPCItems:SetPropertyValues(item, item.property4, "#item_armor", "#D1D1D1",  4)


    RPCItems:SetTableValues(item, itemName, false, "Slot: Trinket", RPCItems:GetRarityColor(rarity), rarity, "", "", RPCItems:GetRarityFactor(rarity))
    if isShop then
        RPCItems:GiveItemToHero(hero, item)
    else
        local drop = CreateItemOnPositionSync( deathLocation, item )
        local position = deathLocation + RandomVector(RandomInt(200, 400))
        RPCItems:DropItem(item, position)
    end
end

function RPCItems:DropOrGiveItem(hero, item, isShop, deathLocation)
    if isShop then
        RPCItems:GiveItemToHero(hero, item)
    else
        local drop = CreateItemOnPositionSync( deathLocation, item)
        local position = deathLocation
        RPCItems:DropItem(item, position)
    end
end

function RPCItems:RollSlithicusRingProperty()
    local luck = RandomInt(0,400)
    local luck2 = RandomInt(1, 100)
    local propertyName = ""
    local propertyTitle = ""
    local tier = 0
    if luck2 < 20 then
        value = RandomInt(25, 30)
    elseif luck2 < 50 then
        value = RandomInt(30, 35)
    elseif luck2 < 80 then
        value = RandomInt(35, 40)
    elseif luck2 < 95 then
        value = RandomInt(40, 45)
    elseif luck2 <= 100 then
        value = RandomInt(45, 50)
    end
    if luck < 100 then
        propertyName = "rune_a_a"
        tier = 1
    elseif luck < 200 then
        propertyName = "rune_a_b"
        tier = 1
    elseif luck < 300 then
        propertyName = "rune_a_c"
        tier = 1
    elseif luck < 405 then
        propertyName = "rune_a_d"
        tier = 1
    end
    return tier, value, propertyName
end

function RPCItems:CreateVariant(variantName, rarityName, itemNameText, slot, gear, slotText)
    local itemVariant = variantName
    local item = CreateItem(itemVariant, nil, nil)
    item.rarity = rarityName
    local rarityValue = RPCItems:GetRarityFactor(item.rarity)
    local itemName = itemNameText
    local suffix = ""
    local prefix = ""
    item.slot = slot
    item.gear = gear
    RPCItems:SetTableValues(item, itemName, false, slotText, RPCItems:GetRarityColor(item.rarity), item.rarity, "", "", RPCItems:GetRarityFactor(item.rarity))
    return item
end



function RPCItems:RollSteelbarkPlate(hero)

    local item = RPCItems:CreateVariant("item_rpc_steelbark_guard", "immortal", "Steelbark Guard", "body", true, "Slot: Body")
    item.property1 = 1
    item.property1name = "steelbark"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_steelbark", "#ADFF5C",  1, "#property_steelbark_description")

    
    local primaryAttribute = hero:GetPrimaryAttribute()
    item.property2 = RandomInt(80, 120)
    if primaryAttribute == 0 then
        item.property2name = "strength"
        RPCItems:SetPropertyValues(item, item.property2, "#item_strength", "#CC0000",  2)
    elseif primaryAttribute == 1 then
        item.property2name = "agility"
        RPCItems:SetPropertyValues(item, item.property2, "#item_agility", "#2EB82E",  2)
    else
        item.property2name = "intelligence"
        RPCItems:SetPropertyValues(item, item.property2, "#item_intelligence", "#33CCFF",  2)
    end
    RPCItems:RollBodyProperty3(item, 0)
    RPCItems:RollBodyProperty4(item, 0)
    RPCItems:GiveItemToHero(hero, item)
end

function RPCItems:RollBadgeOfHonor(hero)

    local item = RPCItems:CreateVariant("item_rpc_badge_of_honor", "immortal", "Badge of Honor", "amulet", true, "Slot: Trinket")
    local value = RandomInt(10, 15)
    item.property1 = value
    item.property1name = "health_regen"
    RPCItems:SetPropertyValues(item, value, "#item_health_regen", "#6AA364",  1)

    
    local primaryAttribute = hero:GetPrimaryAttribute()
    item.property2 = RandomInt(20, 40)
    if primaryAttribute == 0 then
        item.property2name = "strength"
        RPCItems:SetPropertyValues(item, item.property2, "#item_strength", "#CC0000",  2)
    elseif primaryAttribute == 1 then
        item.property2name = "agility"
        RPCItems:SetPropertyValues(item, item.property2, "#item_agility", "#2EB82E",  2)
    else
        item.property2name = "intelligence"
        RPCItems:SetPropertyValues(item, item.property2, "#item_intelligence", "#33CCFF",  2)
    end
    local value = RandomInt(5, 10)
    item.property3 = value
    item.property3name = "armor"
    RPCItems:SetPropertyValues(item, item.property3, "#item_armor", "#D1D1D1",  3) 

    local tier, value, propertyName = RPCItems:RollSkillProperty()
    if tier > 0 then
        item.property4 = value
        item.property4name = propertyName
        RPCItems:SetPropertyValues(item, item.property4, "rune", "#7DFF12",  4)
    end
    RPCItems:GiveItemToHero(hero, item)
end


function RPCItems:RollMageBaneGloves(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_magebane_gloves", "immortal", "Magebane Gloves", "hands", true, "Slot: Hands")
    item.hasRunePoints = true
    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    value = math.floor(value*1.5)
    item.property1 = value
    item.property1name = propertyName
    RPCItems:SetPropertyValues(item, item.property1, "rune", "#7DFF12",  1)
    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    value = math.floor(value*1.5)
    item.property2 = value
    item.property2name = propertyName
    RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2)

    RPCItems:RollHandProperty3(item, 0)
    RPCItems:RollHandProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollMagebaneRuneProperty()
    local luck = RandomInt(0,905)
    local luck2 = RandomInt(1, 100)
    local propertyName = ""
    local propertyTitle = ""
    local tier = 0
    
        maxFactor = 10
   
    if luck2 < 20 then
        value = RandomInt(3, 4)
    elseif luck2 < 50 then
        value = RandomInt(4, 5)
    elseif luck2 < 80 then
        value = RandomInt(5, 6)
    elseif luck2 < 95 then
        value = RandomInt(6, 7)
    elseif luck2 <= 100 then
        value = RandomInt(7, 10)
    end
    if luck < 140 then
        propertyName = "rune_a_a"
        tier = 1
    elseif luck < 240 then
        propertyName = "rune_a_b"
        tier = 1
    elseif luck < 360 then
        propertyName = "rune_a_c"
        tier = 1
    elseif luck < 485 then
        propertyName = "rune_a_d"
        tier = 1
    elseif luck < 590 then
        propertyName = "rune_b_a"
        tier = 2
    elseif luck < 695 then
        propertyName = "rune_b_b"
        tier = 2
    elseif luck < 800 then
        propertyName = "rune_b_c"
        tier = 2
    elseif luck < 910 then
        propertyName = "rune_b_d"
        tier = 2
    end
    print("VALUE".. value)
    value = value + RandomInt(0, math.floor(maxFactor/5))
    print("ADJUSTED VALUE".. value)
    return tier, value, propertyName
end

function RPCItems:RollBerserkerGloves(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_berserker_gloves", "immortal", "Berserker Gloves", "hands", true, "Slot: Hands")

    item.property1 = 1
    item.property1name = "berserker_rage"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_berserker", "#850D0D",  1, "#property_berserker_rage_description")

    local maxFactor = RPCItems:GetMaxFactor()
    local value = RandomInt(maxFactor*12, maxFactor*30)
    item.property2 = value
    item.property2name = "cooldown_reduction"
    RPCItems:SetPropertyValues(item, item.property2, "#item_bonus_attack_damage", "#343EC9",  2) 
    RPCItems:RollHandProperty3(item, 0)
    RPCItems:RollHandProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollShadowArmlet(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_shadow_armlet", "immortal", "Shadow Armlet", "hands", true, "Slot: Hands")

    item.property1 = 1
    item.property1name = "shadow_armlet"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_shadow_armlet", "#54457A",  1, "#property_shadow_armlet_description")

    local maxFactor = RPCItems:GetMaxFactor()
    local value = RandomInt(maxFactor*10, maxFactor*20)
    item.property2 = value
    item.property2name = "strength"
    RPCItems:SetPropertyValues(item, item.property2, "#item_strength", "#CC0000",  2) 
    RPCItems:RollHandProperty3(item, 0)
    RPCItems:RollHandProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollBoneguardGauntlets(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_boneguard_gauntlets", "immortal", "Boneguard Gauntlets", "hands", true, "Slot: Hands")

    item.property1 = 1
    item.property1name = "boneguard"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_boneguard", "#8EA38B",  1, "#property_boneguard_description")

    local maxFactor = RPCItems:GetMaxFactor()
    local value = RandomInt(maxFactor*4, maxFactor*7)
    item.property2 = value
    item.property2name = "armor"
    RPCItems:SetPropertyValues(item, item.property2, "#item_armor", "#D1D1D1",  2) 
    RPCItems:RollHandProperty3(item, 0)
    RPCItems:RollHandProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollScorchedGauntlets(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_scorched_gauntlets", "immortal", "Gloves of the High Flame", "hands", true, "Slot: Hands")
    local maxFactor = RPCItems:GetMaxFactor()
    local scorchDamage = 50 + RandomInt(maxFactor*60, maxFactor*100)
    item.property1 = scorchDamage
    item.property1name = "scorched_gauntlet"
    RPCItems:SetPropertyValuesSpecial(item, item.property1, "#item_property_scorched_gauntlet", "#E8A917",  1, "#property_scorched_gauntlet_description")

    RPCItems:RollHandProperty2(item, 0)
    RPCItems:RollHandProperty3(item, 0)
    RPCItems:RollHandProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollHandOfMidas(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_hand_of_midas", "immortal", "Hand of Midas", "hands", true, "Slot: Hands")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "midas"
    RPCItems:SetPropertyValuesSpecial(item, item.property1, "#item_property_hand_of_midas", "#EFF700",  1, "#property_hand_of_midas_description")

    item.hasRunePoints = true
    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property2 = value*2
    item.property2name = propertyName
    RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2) 

    RPCItems:RollHandProperty3(item, 0)
    RPCItems:RollHandProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollProudGloves(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_kappa_pride_gloves", "immortal", "Proud Gloves", "hands", true, "Slot: Hands")
    item.property1 = 1
    item.property1name = "pride"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_pride", "#D950D6",  1, "#property_pride_description")
    RPCItems:RollHandProperty2(item, 0)
    RPCItems:RollHandProperty3(item, 0)
    RPCItems:RollHandProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollClawOfAzinoth(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_claw_of_azinoth", "immortal", "Claw of Azinoth", "hands", true, "Slot: Hands")
    item.property1 = 1
    item.property1name = "azinoth"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_azinoth", "#543553",  1, "#property_azinoth_description")
    item.hasRunePoints = true
    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property2 = value*4
    item.property2name = propertyName
    RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2)

    RPCItems:RollHandProperty3(item, 0)
    RPCItems:RollHandProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollDivinePurityGauntlets(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_gauntlet_of_divine_purity", "immortal", "Gauntlets of Divine Purity", "hands", true, "Slot: Hands")
    item.property1 = 1
    item.property1name = "divine_purity"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_divine_purity", "#A8D3ED",  1, "#property_divine_purity_description")
    
    local maxFactor = RPCItems:GetMaxFactor()
    local armorRoll = RandomInt(maxFactor*2, maxFactor*3)+5
    item.property2 = armorRoll
    item.property2name = "armor"
    RPCItems:SetPropertyValues(item, item.property2, "#item_armor", "#D1D1D1",  2)

    local magicResistRoll = RandomInt(10, 15)
    item.property3 = magicResistRoll
    item.property3name = "magic_resist"
    RPCItems:SetPropertyValues(item, item.property3, "#item_magic_resist", "#AC47DE",  3)

    RPCItems:RollHandProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollMarauderGloves(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_marauder_gloves", "immortal", "Marauder Gloves", "hands", true, "Slot: Hands")
    item.property1 = 1
    item.property1name = "marauder"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_marauder", "#326E94",  1, "#property_marauder_description")
    
    local maxFactor = RPCItems:GetMaxFactor()
    local healthRoll = RandomInt(maxFactor*50, maxFactor*120)
    item.property2 = healthRoll
    item.property2name = "max_health"
    RPCItems:SetPropertyValues(item, item.property2, "#item_max_health", "#B02020",  2)

    RPCItems:RollHandProperty3(item, 0)
    RPCItems:RollHandProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollElderGrasp(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_grasp_of_elder", "immortal", "Grasp of the Elders", "hands", true, "Slot: Hands")
    item.property1 = 1
    item.property1name = "elder_grasp"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_elder_grasp", "#5A54C4",  1, "#property_elder_grasp_description")
    item.hasRunePoints = true

    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property2 = value*2
    item.property2name = propertyName
    RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2)  

    RPCItems:RollHandProperty3(item, 0)
    RPCItems:RollHandProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollScarecrowGloves(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_scarecrow_gloves", "immortal", "Scarecrow Gloves", "hands", true, "Slot: Hands")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "scarecrow"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_scarecrow", "#2CA8F5",  1, "#property_scarecrow_description")

    value, nameLevel = RPCItems:RollAttribute(0, 8, 12, 0, 0, item.rarity, false, maxFactor*12)
    item.property2 = value
    item.property2name = "intelligence"
    RPCItems:SetPropertyValues(item, item.property2, "#item_intelligence", "#33CCFF",  2)   

    RPCItems:RollHandProperty3(item, 0)
    RPCItems:RollHandProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollLivingGauntlet(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_living_gauntlet", "immortal", "Living Gauntlet", "hands", true, "Slot: Hands")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "living_gauntlet"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_living_gauntlet", "#ADFF5C",  1, "#property_living_gauntlet_description")

    value, nameLevel = RPCItems:RollAttribute(0, 4, 8, 0, 0, item.rarity, false, maxFactor*3)
    item.property2 = value
    item.property2name = "armor"
    RPCItems:SetPropertyValues(item, item.property2, "#item_armor", "#D1D1D1",  2)

    value, prefixLevel = RPCItems:RollAttribute(100, 5, 10, 0, 0, item.rarity, false, maxFactor*5)
    item.property3 = value
    item.property3name = "health_regen"
    RPCItems:SetPropertyValues(item, item.property3, "#item_health_regen", "#6AA364",  3)

    RPCItems:RollHandProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollMasterGloves(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_master_gloves", "immortal", "Master Gloves", "hands", true, "Slot: Hands")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "master"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_master_gloves", "#EDCA3B",  1, "#property_master_gloves_description")

    item.hasRunePoints = true
    if maxFactor < 40 then
        value, nameLevel = RPCItems:RollAttribute(0, 1, 2, 0, 0, item.rarity, false, maxFactor/3 + 4)
        item.property2 = WallPhysics:round(value, 0)
        item.property2name = "rune_a_d"
        RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2)

        value, nameLevel = RPCItems:RollAttribute(0, 1, 2, 0, 0, item.rarity, false, maxFactor/3 + 4)
        item.property3 = WallPhysics:round(value, 0)
        item.property3name = "rune_b_d"
        RPCItems:SetPropertyValues(item, item.property3, "rune", "#7DFF12",  3)
    else
        value, nameLevel = RPCItems:RollAttribute(0, 1, 2, 0, 0, item.rarity, false, maxFactor/3 + 4)
        item.property2 = WallPhysics:round(value, 0)
        item.property2name = "rune_b_d"
        RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2)

        value, nameLevel = RPCItems:RollAttribute(0, 1, 2, 0, 0, item.rarity, false, maxFactor/3 + 4)
        item.property3 = WallPhysics:round(value, 0)
        item.property3name = "rune_c_d"
        RPCItems:SetPropertyValues(item, item.property3, "rune", "#7DFF12",  3)
    end

    RPCItems:RollHandProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollPhoenixGloves(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_phoenix_gloves", "immortal", "Phoenix Gloves", "hands", true, "Slot: Hands")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "phoenix"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_phoenix_gloves", "#EDA65F",  1, "#property_phoenix_gloves_description")

    value, suffixLevel = RPCItems:RollAttribute(100, 2, 7, 0, 1, item.rarity, false, maxFactor*5)
    item.property2 = value
    item.property2name = "attack_speed"
    RPCItems:SetPropertyValues(item, item.property2, "#item_attack_speed", "#B02020",  2)

    RPCItems:RollHandProperty3(item, 0)
    RPCItems:RollHandProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollSpiritGlove(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_spirit_glove", "immortal", "Spirit Glove", "hands", true, "Slot: Hands")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "spirit"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_spirit_glove", "#FFFFFF",  1, "#property_spirit_glove_description")

    value, nameLevel = RPCItems:RollAttribute(0, 7, 14, 0, 0, item.rarity, false, maxFactor*12)
    item.property2 = value
    item.property2name = "intelligence"
    RPCItems:SetPropertyValues(item, item.property2, "#item_intelligence", "#33CCFF",  2)

    RPCItems:RollHandProperty3(item, 0)
    RPCItems:RollHandProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollFrostburnGauntlets(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_frostburn_gauntlets", "immortal", "Frostburn Gauntlets", "hands", true, "Slot: Hands")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "frostburn"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_frostburn_gauntlets", "#7DDAE8",  1, "#property_frostburn_gauntlets_description")

    value, suffixLevel = RPCItems:RollAttribute(100, 5, 10, 0, 0, item.rarity, false, maxFactor*9)
    item.property2 = value
    item.property2name = "mana_regen"
    RPCItems:SetPropertyValues(item, item.property2, "#item_mana_regen", "#649FA3",  2)

    RPCItems:RollHandProperty3(item, 0)
    RPCItems:RollHandProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

--BODY

function RPCItems:RollHurricaneVest(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_hurricane_vest", "immortal", "Hurricane Vest", "body", true, "Slot: Body")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = RandomInt(maxFactor*140, maxFactor*320) + 100
    item.property1name = "hurricane"
    RPCItems:SetPropertyValuesSpecial(item, item.property1, "#item_property_hurricane", "#5A54C4",  1, "#property_hurricane_description")


    value, nameLevel = RPCItems:RollAttribute(0, 8, 15, 0, 0, item.rarity, false, maxFactor*15)
    item.property2 = value
    item.property2name = "agility"
    RPCItems:SetPropertyValues(item, item.property2, "#item_agility", "#2EB82E",  2)

    RPCItems:RollBodyProperty3(item, 0)
    RPCItems:RollBodyProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollFloodRobe(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_robe_of_flooding", "immortal", "Robe of Flooding", "body", true, "Slot: Body")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "flooding"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_flooding", "#57CFFF",  1, "#property_flooding_description")

    value, nameLevel = RPCItems:RollAttribute(0, 8, 15, 0, 0, item.rarity, false, maxFactor*15)
    item.property2 = value
    item.property2name = "intelligence"
    RPCItems:SetPropertyValues(item, item.property2, "#item_intelligence", "#33CCFF",  2)
    RPCItems:RollBodyProperty3(item, 0)
    RPCItems:RollBodyProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollAvalanchePlate(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_avalanche_plate", "immortal", "Avalanche Plate", "body", true, "Slot: Body")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "avalanche"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_avalanche", "#9C8C81",  1, "#property_avalanche_description")


    value, nameLevel = RPCItems:RollAttribute(0, 8, 15, 0, 0, item.rarity, false, maxFactor*15)
    item.property2 = value
    item.property2name = "strength"
    RPCItems:SetPropertyValues(item, item.property2, "#item_strength", "#CC0000",  2)
    RPCItems:RollBodyProperty3(item, 0)
    RPCItems:RollBodyProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollVioletGuardArmor(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_armor_of_violet_guard", "immortal", "Armor of Violet Guard", "body", true, "Slot: Body")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "violet_guard"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_violet_guard_armor", "#A337E6",  1, "#property_violet_guard_armor_description")

    item.hasRunePoints = true
    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property2 = value*3
    item.property2name = propertyName
    RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2)

    local evasionValue = RandomInt(12, 20)
    item.property3 = evasionValue
    item.property3name = "evasion"
    RPCItems:SetPropertyValues(item, item.property3, "#item_evasion", "#759C7C",  3)

    RPCItems:RollBodyProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollSoulVest(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_seraphic_soulvest", "immortal", "Seraphic Soulvest", "body", true, "Slot: Body")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "seraphic"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_seraphic_soulvest", "#C5E7FC",  1, "#property_seraphic_soulvest_description")

    item.hasRunePoints = true
    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property2 = value
    item.property2name = propertyName
    RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2)

    local luck = RandomInt(1, 3)
    if luck == 1 then
        value, nameLevel = RPCItems:RollAttribute(50, 1, 35, 0, 0, item.rarity, false, maxFactor*12)
        item.property3 = value
        item.property3name = "strength"
        RPCItems:SetPropertyValues(item, item.property3, "#item_strength", "#CC0000",  3)
    elseif luck == 2 then
        value, nameLevel = RPCItems:RollAttribute(50, 1, 35, 0, 0, item.rarity, false, maxFactor*12)
        item.property3 = value
        item.property3name = "agility"
        RPCItems:SetPropertyValues(item, item.property3, "#item_agility", "#2EB82E",  3)
    else
        value, nameLevel = RPCItems:RollAttribute(50, 1, 35, 0, 0, item.rarity, false, maxFactor*12)
        item.property3 = value
        item.property3name = "intelligence"
        RPCItems:SetPropertyValues(item, item.property3, "#item_intelligence", "#33CCFF",  3)
    end

    RPCItems:RollBodyProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollWatcherPlate(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_plate_of_the_watcher", "immortal", "Plate of the Watcher", "body", true, "Slot: Body")
    local maxFactor = RPCItems:GetMaxFactor()
    local luck = RandomInt(1, 2)
    if luck == 1 then
        item.property1 = 1
        item.property1name = "watcher1"
        RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_watcher_one", "#64A4CC",  1, "#property_watcher_one_description")
    else
        RPCItems:RollBodyProperty1(item, 0)
    end

    luck = RandomInt(1, 2)
    if luck == 1 then
        item.property2 = 1
        item.property1name = "watcher2"
        RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_watcher_two", "#64A4CC",  2, "#property_watcher_two_description")
    else
        RPCItems:RollBodyProperty2(item, 0)
    end

    luck = RandomInt(1, 2)
    if luck == 1 then
        item.property3 = 1
        item.property3name = "watcher3"
        RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_watcher_three", "#64A4CC",  3, "#property_watcher_three_description")
    else
        RPCItems:RollBodyProperty3(item, 0)
    end

    luck = RandomInt(1, 2)
    if luck == 1 then
        item.property4 = 1
        item.property4name = "watcher4"
        RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_watcher_four", "#64A4CC",  4, "#property_watcher_four_description")
    else
        RPCItems:RollBodyProperty4(item, 0)
    end



    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollSorcererRegalia(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_sorcerers_regalia", "immortal", "Sorcerer's Regalia", "body", true, "Slot: Body")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "sorcerer"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_sorcerers_regalia", "#1996E3",  1, "#property_sorcerers_regalia_description")

    item.hasRunePoints = true
    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property2 = value*3
    local luck = RandomInt(1, 3)
    if luck == 1 then
        propertyName = "rune_a_b"
    elseif luck == 2 then
        propertyName = "rune_b_b"
    elseif luck == 2 then
        propertyName = "rune_c_b"
    end
    item.property2name = propertyName
    RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2)

    value, nameLevel = RPCItems:RollAttribute(0, 10, 13, 0, 0, item.rarity, false, maxFactor*14)
    item.property3 = value
    item.property3name = "intelligence"
    RPCItems:SetPropertyValues(item, item.property3, "#item_intelligence", "#33CCFF",  3)

    RPCItems:RollBodyProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollSpellslingerCoat(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_spellslinger_coat", "immortal", "Spellslinger's Coat", "body", true, "Slot: Body")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "spellslinger"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_spellslinger_coat", "#3FEBC5",  1, "#property_spellslinger_coat_description")

    RPCItems:RollBodyProperty2(item, 0)
    RPCItems:RollBodyProperty3(item, 0)
    RPCItems:RollBodyProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollDoomplate(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_doomplate", "immortal", "Doomplate", "body", true, "Slot: Body")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "doomplate"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_doomplate", "#E85920",  1, "#property_doomplate_description")

    item.hasRunePoints = true
    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property2 = value*2
    local luck = RandomInt(1, 3)
    if luck == 1 then
        propertyName = "rune_a_d"
    elseif luck == 2 then
        propertyName = "rune_b_d"
    elseif luck == 2 then
        propertyName = "rune_c_d"
    end
    item.property2name = propertyName
    RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2)


    RPCItems:RollBodyProperty3(item, 0)
    RPCItems:RollBodyProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollIceQuillCarapace(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_ice_quill_carapace", "immortal", "Ice Quill Carapace", "body", true, "Slot: Body")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "ice_quill"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_ice_quill", "#6FD2F2",  1, "#property_ice_quill_description")

    value, prefixLevel = RPCItems:RollAttribute(300, 100, 500, 0, 1, item.rarity, false, maxFactor*200)
    item.property2 = value
    item.property2name = "max_mana"
    RPCItems:SetPropertyValues(item, item.property2, "#item_max_mana", "#343EC9",  2) 


    value, nameLevel = RPCItems:RollAttribute(100, 5, 10, 0, 0, item.rarity, false, maxFactor*3)
    item.property3 = value
    item.property3name = "armor"
    RPCItems:SetPropertyValues(item, item.property3, "#item_armor", "#D1D1D1",  3)

    RPCItems:RollBodyProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollFeatherwhiteArmor(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_featherwhite_armor", "immortal", "Featherwhite Armor", "body", true, "Slot: Body")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "featherwhite"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_featherwhite_armor", "#FFFFFF",  1, "#property_featherwhite_armor_description")

    item.hasRunePoints = true
    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property2 = WallPhysics:round(value*1.5, 0)
    item.property2name = propertyName
    RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2)

    RPCItems:RollBodyProperty3(item, 0)
    RPCItems:RollBodyProperty4(item, 0)
    
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollDragonCeremonyVestments(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_dragon_ceremony_vestments", "immortal", "Vestments of the Dragon Ceremony", "body", true, "Slot: Body")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "dragon_ceremony"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_dragon_ceremony", "#D4583F",  1, "#property_dragon_ceremony_description")

    item.hasRunePoints = true
    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property2 = WallPhysics:round(value*1.5, 0)
    item.property2name = propertyName
    RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2)

    RPCItems:RollBodyProperty3(item, 0)
    RPCItems:RollBodyProperty4(item, 0)
    
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollSecretTempleArmor(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_armor_of_secret_temple", "immortal", "Armor of the Secret Temple", "body", true, "Slot: Body")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "secret_temple"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_secret_temple", "#CE87E6",  1, "#property_secret_temple_description")

    value, nameLevel = RPCItems:RollAttribute(0, 6, 13, 0, 0, item.rarity, false, maxFactor*13)
    item.property2 = value
    item.property2name = "agility"
    RPCItems:SetPropertyValues(item, item.property2, "#item_agility", "#2EB82E",  2)

    RPCItems:RollBodyProperty3(item, 0)
    RPCItems:RollBodyProperty4(item, 0)
    
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollVampiricBreastplate(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_vampiric_breastplate", "immortal", "Vampiric Breastplate", "body", true, "Slot: Body")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "vampiric_breastplate"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_vampiric_breastplate", "#71EBA3",  1, "#property_varmpiric_breastplate_description")

    value, prefixLevel = RPCItems:RollAttribute(300, 300, 800, 1, 1, item.rarity, false, maxFactor*500)
    item.property2 = value
    item.property2name = "max_health"
    RPCItems:SetPropertyValues(item, item.property2, "#item_max_health", "#B02020",  2)

    RPCItems:RollBodyProperty3(item, 0)
    RPCItems:RollBodyProperty4(item, 0)
    
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollDarkArtsVestments(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_dark_arts_vestments", "immortal", "Vestments of the Dark Arts", "body", true, "Slot: Body")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "dark_arts"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_dark_arts", "#7A3B63",  1, "#property_dark_arts_description")

    item.hasRunePoints = true
    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property2 = value*2
    item.property2name = propertyName
    RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2)

    RPCItems:RollBodyProperty3(item, 0)
    RPCItems:RollBodyProperty4(item, 0)
    
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollLegionVestments(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_legion_vestments", "immortal", "Legion Vestments", "body", true, "Slot: Body")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "legion_vest"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_legion_vestments", "#D45757",  1, "#property_legion_vestments_description")

    RPCItems:RollBodyProperty2(item, 0)
    RPCItems:RollBodyProperty3(item, 0)
    RPCItems:RollBodyProperty4(item, 0)
    
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollNightmareRiderMantle(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_nightmare_rider_mantle", "immortal", "Nightmare Rider Mantle", "body", true, "Slot: Body")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "nightmare_rider"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_nightmare_rider", "#423670",  1, "#property_nightmare_rider_description")

    RPCItems:RollBodyProperty2(item, 0)
    RPCItems:RollBodyProperty3(item, 0)
    RPCItems:RollBodyProperty4(item, 0)
    
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollSpaceTechVest(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_space_tech_vest", "immortal", "Space Tech Vest", "body", true, "Slot: Body")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "space_tech"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_space_tech", "#4843E6",  1, "#property_space_tech_description")

    RPCItems:RollBodyProperty2(item, 0)
    RPCItems:RollBodyProperty3(item, 0)
    RPCItems:RollBodyProperty4(item, 0)
    
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollStormshieldCloak(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_stormshield_cloak", "immortal", "Stormshield Cloak", "body", true, "Slot: Body")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "stormshield"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_stormshield", "#BAD5DE",  1, "#property_stormshield_description")

    local value, nameLevel = RPCItems:RollAttribute(0, 4, 8, 0, 0, item.rarity, false, maxFactor*3)
    item.property2 = value
    item.property2name = "armor"
    RPCItems:SetPropertyValues(item, item.property2, "#item_armor", "#D1D1D1",  2)

    value, nameLevel = RPCItems:RollAttribute(0, 4, 8, 0, 0, item.rarity, false, maxFactor*3)
    item.property3 = value
    item.property3name = "armor"
    RPCItems:SetPropertyValues(item, item.property3, "#item_armor", "#D1D1D1",  3)

    RPCItems:RollBodyProperty4(item, 0)
    
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

--HATS

function RPCItems:RollWhiteMageHat(deathLocation, isShop)
    local item = RPCItems:CreateVariant("item_rpc_white_mage_hat", "immortal", "White Mage Hat", "head", true, "Slot: Head")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "white_mage_hat"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_white_mage_hat", "#FFFFFF",  1, "#property_white_mage_hat_description")


    value, prefixLevel = RPCItems:RollAttribute(100, 6, 12, 0, 0, item.rarity, false, maxFactor*6)
    item.property2 = value
    item.property2name = "health_regen"
    RPCItems:SetPropertyValues(item, item.property2, "#item_health_regen", "#6AA364",  2)


    RPCItems:RollHoodProperty3(item, 0)
    RPCItems:RollHoodProperty4(item, 0)
    RPCItems:DropOrGiveItem(hero, item, isShop, deathLocation)
end

function RPCItems:RollHyperVisor(deathLocation, isShop)
    local item = RPCItems:CreateVariant("item_rpc_hyper_visor", "immortal", "Hyper Visor", "head", true, "Slot: Head")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "hyper_visor"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_hyper_visor", "#3CB7E8",  1, "#property_hyper_visor_description")


    value, nameLevel = RPCItems:RollAttribute(100, 10, 20, 0, 1, item.rarity, false, maxFactor*14)
    item.property2 = value
    item.property2name = "attack_speed"
    RPCItems:SetPropertyValues(item, item.property2, "#item_attack_speed", "#B02020", 2)


    RPCItems:RollHoodProperty3(item, 0)
    RPCItems:RollHoodProperty4(item, 0)
    RPCItems:DropOrGiveItem(hero, item, isShop, deathLocation)
end

function RPCItems:RollRubyDragonCrown(deathLocation, isShop)
    local item = RPCItems:CreateVariant("item_rpc_crown_of_ruby_dragon", "immortal", "Crown of Ruby Dragon", "head", true, "Slot: Head")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "ruby_dragon"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_ruby_dragon", "#BD2A2A",  1, "#property_ruby_dragon_description")


    value, nameLevel = RPCItems:RollAttribute(100, 20, 100, 0, 0, item.rarity, false, maxFactor*16)
    item.property2 = value
    item.property2name = "strength"
    RPCItems:SetPropertyValues(item, item.property2, "#item_strength", "#CC0000",  2)


    RPCItems:RollHoodProperty3(item, 0)
    RPCItems:RollHoodProperty4(item, 0)
    RPCItems:DropOrGiveItem(hero, item, isShop, deathLocation)
end

function RPCItems:RollCentaurHorns(deathLocation, isShop)
    local item = RPCItems:CreateVariant("item_rpc_centaur_horns", "immortal", "Sturdy Centaur Horns", "head", true, "Slot: Head")
    local maxFactor = RPCItems:GetMaxFactor()

    RPCItems:RollHoodProperty1(item, 0)
    RPCItems:RollHoodProperty2(item, 0)
    RPCItems:RollHoodProperty3(item, 0)
    item.property4 = 1
    item.property4name = "centaur_horns"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_centaur_horns", "#876852",  4, "#property_centaur_horns_description")

    RPCItems:DropOrGiveItem(hero, item, isShop, deathLocation)
end

function RPCItems:RollHoodOfChosen(deathLocation, isShop)
    local item = RPCItems:CreateVariant("item_rpc_hood_of_chosen", "immortal", "Hood of the Chosen", "head", true, "Slot: Head")
    local maxFactor = RPCItems:GetMaxFactor()

    item.hasRunePoints = true
    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property1 = value
    item.property1name = propertyName
    RPCItems:SetPropertyValues(item, item.property1, "rune", "#7DFF12",  1)
    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property2 = value*2
    item.property2name = propertyName
    RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2)

    RPCItems:RollHoodProperty3(item, 0)
    RPCItems:RollHoodProperty4(item, 0)

    RPCItems:DropOrGiveItem(hero, item, isShop, deathLocation)
end

function RPCItems:RollDeathWhisperHelm(deathLocation, isShop)
    local item = RPCItems:CreateVariant("item_rpc_death_whisper_helm", "immortal", "Death Whisper Helm", "head", true, "Slot: Head")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "death_whisper"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_death_whisper", "#4A6A8C",  1, "#property_death_whisper_description")

    item.hasRunePoints = true
    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property2 = value*3
    item.property2name = propertyName
    RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2)


    RPCItems:RollHoodProperty3(item, 0)
    RPCItems:RollHoodProperty4(item, 0)
    RPCItems:DropOrGiveItem(hero, item, isShop, deathLocation)
end

function RPCItems:RollCapOfWildNature(deathLocation, isShop)
    local item = RPCItems:CreateVariant("item_rpc_cap_of_wild_nature", "immortal", "Cap of Wild Nature", "head", true, "Slot: Head")
    local maxFactor = RPCItems:GetMaxFactor()
    local luck = RandomInt(1, 3)
    if luck == 1 then
        item.property1 = 1
        item.property1name = "wild_nature_one"
        RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_wild_nature", "#573E2F",  1, "#property_wild_nature_description")
        RPCItems:RollHoodProperty2(item, 0)
    elseif luck == 2 then
        item.property1 = 1
        item.property1name = "wild_nature_two"
        RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_wild_nature_two", "#573E2F",  1, "#property_wild_nature_two_description")
        RPCItems:RollHoodProperty2(item, 0)
    else
        item.property1 = 1
        item.property1name = "wild_nature_one"
        RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_wild_nature", "#573E2F",  1, "#property_wild_nature_description")
        item.property2 = 1
        item.property2name = "wild_nature_two"
        RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_wild_nature_two", "#573E2F",  2, "#property_wild_nature_two_description")
    end
    RPCItems:RollHoodProperty3(item, 0)
    RPCItems:RollHoodProperty4(item, 0)
    RPCItems:DropOrGiveItem(hero, item, isShop, deathLocation)
end

function RPCItems:RollLumaGuard(deathLocation, isShop)
    local item = RPCItems:CreateVariant("item_rpc_guard_of_luma", "immortal", "Guard of Luma", "head", true, "Slot: Head")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "luma_guard"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_luma", "#B8A3E3",  1, "#property_luma_description")

    local visionBonus = RandomInt(400, 700)
    item.property2 = visionBonus
    item.property2name = "vision"
    RPCItems:SetPropertyValues(item, item.property2, "#item_vision_bonus", "#96D1D9",  2)


    RPCItems:RollHoodProperty3(item, 0)
    RPCItems:RollHoodProperty4(item, 0)
    RPCItems:DropOrGiveItem(hero, item, isShop, deathLocation)
end

function RPCItems:RollOdinHelmet(deathLocation, isShop)
    local item = RPCItems:CreateVariant("item_rpc_odin_helmet", "immortal", "Odin Helmet", "head", true, "Slot: Head")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "odin"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_odin", "#82A6B3",  1, "#property_odin_description")

    item.hasRunePoints = true
    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property2 = value*2
    item.property2name = propertyName
    RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2)

    RPCItems:RollHoodProperty3(item, 0)
    RPCItems:RollHoodProperty4(item, 0)
    RPCItems:DropOrGiveItem(hero, item, isShop, deathLocation)
end

function RPCItems:RollIronColossus(deathLocation, isShop)
    local item = RPCItems:CreateVariant("item_rpc_iron_colussus", "immortal", "Helm of the Iron Colossus", "head", true, "Slot: Head")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "iron_colossus"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_iron_colossus", "#874E4D",  1, "#property_iron_colossus_description")

    value, prefixLevel = RPCItems:RollAttribute(100, 5, 18, 0, 0, item.rarity, false, maxFactor*12)
    item.property2 = value
    item.property2name = "strength"
    RPCItems:SetPropertyValues(item, item.property2, "#item_strength", "#CC0000",  2)


    value, nameLevel = RPCItems:RollAttribute(100, 5, 12, 0, 0, item.rarity, false, maxFactor*4)
    item.property3 = value
    item.property3name = "armor"
    RPCItems:SetPropertyValues(item, item.property3, "#item_armor", "#D1D1D1",  3)

    RPCItems:RollHoodProperty4(item, 0)

    RPCItems:DropOrGiveItem(hero, item, isShop, deathLocation)
end

function RPCItems:RollMugatoMask(deathLocation, isShop)
    local item = RPCItems:CreateVariant("item_rpc_mask_of_mugato", "immortal", "Mask of Mugato", "head", true, "Slot: Head")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "mugato"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_mugato", "#26E0C1",  1, "#property_mugato_description")

    item.hasRunePoints = true
    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property2 = WallPhysics:round(value*1.5, 0)
    item.property2name = propertyName
    RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2)


    RPCItems:RollHoodProperty3(item, 0)
    RPCItems:RollHoodProperty4(item, 0)
    RPCItems:DropOrGiveItem(hero, item, isShop, deathLocation)
end

function RPCItems:RollWitchHat(deathLocation, isShop)
    local item = RPCItems:CreateVariant("item_rpc_swamp_witch_hat", "immortal", "Swamp Witch's Hat", "head", true, "Slot: Head")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "swamp_witch"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_swamp_witch", "#7300DE",  1, "#property_swamp_witch_description")

    value, nameLevel = RPCItems:RollAttribute(0, 8, 15, 0, 0, item.rarity, false, maxFactor*15)
    item.property2 = value
    item.property2name = "intelligence"
    RPCItems:SetPropertyValues(item, item.property2, "#item_intelligence", "#33CCFF",  2)


    RPCItems:RollHoodProperty3(item, 0)
    RPCItems:RollHoodProperty4(item, 0)
    RPCItems:DropOrGiveItem(hero, item, isShop, deathLocation)
end

function RPCItems:RollTricksterMask(deathLocation, isShop)
    local item = RPCItems:CreateVariant("item_rpc_tricksters_mask", "immortal", "Trickster's Mask", "head", true, "Slot: Head")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "trickster"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_trickster", "#FFFB17",  1, "#property_trickster_description")

    value, nameLevel = RPCItems:RollAttribute(0, 5, 16, 0, 0, item.rarity, false, maxFactor*17)
    item.property2 = value
    item.property2name = "agility"
    RPCItems:SetPropertyValues(item, item.property2, "#item_agility", "#2EB82E",  2)


    item.hasRunePoints = true
    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property3 = value*2
    item.property3name = propertyName
    RPCItems:SetPropertyValues(item, item.property3, "rune", "#7DFF12",  3)

    RPCItems:RollHoodProperty4(item, 0)
    RPCItems:DropOrGiveItem(hero, item, isShop, deathLocation)
end

function RPCItems:RollEmeraldDouli(deathLocation, isShop)
    local item = RPCItems:CreateVariant("item_rpc_emerald_douli", "immortal", "Emerald Douli", "head", true, "Slot: Head")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "emerald_douli"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_emerald_douli", "#1DDB49",  1, "#property_emerald_douli_description")

    value, prefixLevel = RPCItems:RollAttribute(300, 300, 800, 1, 1, item.rarity, false, maxFactor*500)
    item.property2 = value
    item.property2name = "max_health"
    RPCItems:SetPropertyValues(item, item.property2, "#item_max_health", "#B02020",  2)


    value, prefixLevel = RPCItems:RollAttribute(300, 100, 500, 0, 1, item.rarity, false, maxFactor*200)
    item.property3 = value
    item.property3name = "max_mana"
    RPCItems:SetPropertyValues(item, item.property3, "#item_max_mana", "#343EC9",  3)   

    RPCItems:RollHoodProperty4(item, 0)
    RPCItems:DropOrGiveItem(hero, item, isShop, deathLocation)
end

function RPCItems:RollMaskOfTyrius(deathLocation, isShop)
    local item = RPCItems:CreateVariant("item_rpc_mask_of_tyrius", "immortal", "Mask of Tyrius", "head", true, "Slot: Head")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "tyrius"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_tyrius", "#D6693A",  1, "#property_tyrius_description")

    item.hasRunePoints = true
    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property2 = WallPhysics:round(value*1.5, 0)
    item.property2name = propertyName
    RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2)


    value, nameLevel = RPCItems:RollAttribute(100, 20, 60, 0, 0, item.rarity, false, maxFactor*14)
    item.property3 = value
    item.property3name = "strength"
    RPCItems:SetPropertyValues(item, item.property3, "#item_strength", "#CC0000",  3)

    RPCItems:RollHoodProperty4(item, 0)
    RPCItems:DropOrGiveItem(hero, item, isShop, deathLocation)
end

function RPCItems:RollCeruleanHighguard(deathLocation, isShop)
    local item = RPCItems:CreateVariant("item_rpc_veil_of_the_cerulean_high_guard", "immortal", "Veil of the Cerulean Highguard", "head", true, "Slot: Head")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "cerulean_highguard"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_cerulean_highguard", "#1D35D1",  1, "#property_cerulean_highguard_description")

    local value, nameLevel = RPCItems:RollAttribute(0, 5, 11, 0, 0, item.rarity, false, maxFactor*10)
    item.property2 = value
    item.property2name = "all_attributes"
    RPCItems:SetPropertyValues(item, item.property2, "#item_all_attributes", "#FFFFFF",  2)


    RPCItems:RollHoodProperty3(item, 0)
    RPCItems:RollHoodProperty4(item, 0)

    RPCItems:DropOrGiveItem(hero, item, isShop, deathLocation)
end

function RPCItems:RollSuperAscendency(deathLocation, isShop)
    local item = RPCItems:CreateVariant("item_rpc_super_ascendency_mask", "immortal", "Super Ascendency Mask", "head", true, "Slot: Head")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "super_ascendency"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_super_ascendency", "#E89300",  1, "#property_super_ascendency_description")

    local value, nameLevel = RPCItems:RollAttribute(0, 5, 8, 0, 0, item.rarity, false, maxFactor*9)
    item.property2 = value
    item.property2name = "all_attributes"
    RPCItems:SetPropertyValues(item, item.property2, "#item_all_attributes", "#FFFFFF",  2)



    local value = RandomInt(maxFactor*15, maxFactor*36)
    item.property3 = value
    item.property3name = "attack_damage"
    RPCItems:SetPropertyValues(item, item.property3, "#item_bonus_attack_damage", "#343EC9",  3)   

    RPCItems:RollHoodProperty4(item, 0)

    RPCItems:DropOrGiveItem(hero, item, isShop, deathLocation)
end

function RPCItems:RollPhantomSorcererMask(deathLocation, isShop)
    local item = RPCItems:CreateVariant("item_rpc_mask_of_the_phantom_sorcerer", "immortal", "Mask of the Phantom Sorcerer", "head", true, "Slot: Head")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "phantom_sorcerer"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_phantom_sorcerer", "#02F21E",  1, "#property_phantom_sorcerer_description")

    item.hasRunePoints = true
    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property2 = WallPhysics:round(value*1.5, 0)
    item.property2name = propertyName
    RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2)

 
    RPCItems:RollHoodProperty3(item, 0)
    RPCItems:RollHoodProperty4(item, 0)

    RPCItems:DropOrGiveItem(hero, item, isShop, deathLocation)
end

function RPCItems:RollArcaneCascadeHat(deathLocation, isShop)
    local item = RPCItems:CreateVariant("item_rpc_arcane_cascade_hat", "immortal", "Arcane Cascade Hat", "head", true, "Slot: Head")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "arcane_cascade"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_arcane_cascade", "#E558F5",  1, "#property_arcane_cascade_description")

    local value, prefixLevel = RPCItems:RollAttribute(300, 100, 500, 0, 1, item.rarity, false, maxFactor*200)
    item.property2 = value
    item.property2name = "max_mana"
    RPCItems:SetPropertyValues(item, item.property2, "#item_max_mana", "#343EC9",  2) 

 
    local value, nameLevel = RPCItems:RollAttribute(0, 8, 15, 0, 0, item.rarity, false, maxFactor*15)
    item.property3 = value
    item.property3name = "intelligence"
    RPCItems:SetPropertyValues(item, item.property3, "#item_intelligence", "#33CCFF",  3)

    RPCItems:RollHoodProperty4(item, 0)

    RPCItems:DropOrGiveItem(hero, item, isShop, deathLocation)
end

function RPCItems:RollSamuraiHelmet(deathLocation, isShop)
    local item = RPCItems:CreateVariant("item_rpc_adamantine_samurai_helmet", "immortal", "Adamantine Samurai Helmet", "head", true, "Slot: Head")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "samurai_helmet"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_samurai_helmet", "#FF2427",  1, "#property_samurai_helmet_description")

    value, nameLevel = RPCItems:RollAttribute(0, 4, 8, 0, 0, item.rarity, false, maxFactor*3)
    item.property2 = value
    item.property2name = "armor"
    RPCItems:SetPropertyValues(item, item.property2, "#item_armor", "#D1D1D1",  2)

 
    local value = RandomInt(maxFactor*15, maxFactor*36)
    item.property3 = value
    item.property3name = "attack_damage"
    RPCItems:SetPropertyValues(item, item.property3, "#item_bonus_attack_damage", "#343EC9",  3)  

    RPCItems:RollHoodProperty4(item, 0)

    RPCItems:DropOrGiveItem(hero, item, isShop, deathLocation)
end

function RPCItems:RollScourgeKnightHelm(deathLocation, isShop)
    local item = RPCItems:CreateVariant("item_rpc_scourge_knights_helm", "immortal", "Scourge Knight's Helm", "head", true, "Slot: Head")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "scourge_knight"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_scourge_knight", "#2A194F",  1, "#property_scourge_knight_description")
    local value = 0
    local luck = RandomInt(1, 5)
    if luck > 4 then
        value = RandomInt(20, 30)
    elseif luck > 3 then
        value = RandomInt(15, 25)
    else
        value = RandomInt(10, 20)
    end
    item.property2 = value
    item.property2name = "lifesteal"
    RPCItems:SetPropertyValues(item, item.property2, "#item_lifesteal", "#B1E3B9",  2)

 
    local value = RandomInt(maxFactor*15, maxFactor*36)
    item.property3 = value
    item.property3name = "attack_damage"
    RPCItems:SetPropertyValues(item, item.property3, "#item_bonus_attack_damage", "#343EC9",  3)  

    RPCItems:RollHoodProperty4(item, 0)

    RPCItems:DropOrGiveItem(hero, item, isShop, deathLocation)
end

function RPCItems:RollUndertakersHood(deathLocation, isShop)
    local item = RPCItems:CreateVariant("item_rpc_undertakers_hood", "immortal", "Undertaker's Hood", "head", true, "Slot: Head")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "undertaker"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_undertaker", "#3E8A2B",  1, "#property_undertaker_description")

    local value = RandomInt(maxFactor*15, maxFactor*36)
    item.property2 = value
    item.property2name = "attack_damage"
    RPCItems:SetPropertyValues(item, item.property2, "#item_bonus_attack_damage", "#343EC9",  2)  

 
    local value, nameLevel = RPCItems:RollAttribute(0, 8, 15, 0, 0, item.rarity, false, maxFactor*15)
    item.property3 = value
    item.property3name = "intelligence"
    RPCItems:SetPropertyValues(item, item.property3, "#item_intelligence", "#33CCFF",  3)

    RPCItems:RollHoodProperty4(item, 0)

    RPCItems:DropOrGiveItem(hero, item, isShop, deathLocation)
end




--FEET

function RPCItems:RollDunetreadBoots(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_dunetread_boots", "immortal", "Dunetreads", "feet", true, "Slot: Feet")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "dunetread"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_dunetread", "#8A8546",  1, "#property_dunetread_description")

    RPCItems:RollFootProperty2(item, 0)
    RPCItems:RollFootProperty3(item, 0)
    RPCItems:RollFootProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollVioletTreads(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_boots_of_the_violet_guard", "immortal", "Boots of the Violet Guard", "feet", true, "Slot: Feet")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "violet_boots"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_violet_boot", "#A337E6",  1, "#property_violet_boot_description")

    local value, nameLevel = RPCItems:RollAttribute(0, 7, 13, 0, 0, item.rarity, false, maxFactor*13)
    item.property2 = value
    item.property2name = "agility"
    RPCItems:SetPropertyValues(item, item.property2, "#item_agility", "#2EB82E",  2)

    RPCItems:RollFootProperty3(item, 0)
    RPCItems:RollFootProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:SlingerBoots(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_slinger_boots", "immortal", "Bladeslinger Boots", "feet", true, "Slot: Feet")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "slinger"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_slinger_boot", "#D6D2D2",  1, "#property_slinger_boots_description")

    RPCItems:RollFootProperty2(item, 0)
    RPCItems:RollFootProperty3(item, 0)
    RPCItems:RollFootProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollGuardianGreaves(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_guardian_greaves", "immortal", "Guardian Greaves", "feet", true, "Slot: Feet")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "guardian_greaves"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_guardian_greaves", "#8FE051",  1, "#property_guardien_greaves_description")

    RPCItems:RollFootProperty2(item, 0)
    RPCItems:RollFootProperty3(item, 0)
    RPCItems:RollFootProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollSangeBoots(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_sange_boots", "immortal", "Sange Boots", "feet", true, "Slot: Feet")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "sange"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_sange", "#CC1104",  1, "#property_sange_description")

    value, nameLevel = RPCItems:RollAttribute(0, 7, 12, 0, 0, item.rarity, false, maxFactor*12)
    item.property2 = value
    item.property2name = "agility"
    RPCItems:SetPropertyValues(item, item.property2, "#item_agility", "#2EB82E",  2)

    RPCItems:RollFootProperty3(item, 0)
    RPCItems:RollFootProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollYashaBoots(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_yasha_boots", "immortal", "Yasha Boots", "feet", true, "Slot: Feet")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "yasha"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_yasha", "#4FD65A",  1, "#property_yasha_description")

    value, prefixLevel = RPCItems:RollAttribute(100, 4, 12, 0, 0, item.rarity, false, maxFactor*10)
    item.property2 = value
    item.property2name = "strength"
    RPCItems:SetPropertyValues(item, item.property2, "#item_strength", "#CC0000",  2)

    RPCItems:RollFootProperty3(item, 0)
    RPCItems:RollFootProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end


function RPCItems:RollTranquilBoots(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_tranquil_boots", "immortal", "Tranquil Boots", "feet", true, "Slot: Feet")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "tranquil"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_tranquil_boots", "#30E691",  1, "#property_tranquil_boots_description")

    RPCItems:RollFootProperty2(item, 0)
    RPCItems:RollFootProperty3(item, 0)
    RPCItems:RollFootProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollFireWalkers(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_fire_walkers", "immortal", "Fire Walkers", "feet", true, "Slot: Feet")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "fire_walker"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_fire_walkers", "#DE4318",  1, "#property_fire_walkers_description")

    RPCItems:RollFootProperty2(item, 0)
    RPCItems:RollFootProperty3(item, 0)
    RPCItems:RollFootProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollManaStriders(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_mana_striders", "immortal", "Mana Striders", "feet", true, "Slot: Feet")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "mana_stride"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_mana_striders", "#55A4CF",  1, "#property_mana_striders_description")

    value, nameLevel = RPCItems:RollAttribute(0, 8, 15, 0, 0, item.rarity, false, maxFactor*15)
    item.property2 = value
    item.property2name = "intelligence"
    RPCItems:SetPropertyValues(item, item.property2, "#item_intelligence", "#33CCFF",  2)

    RPCItems:RollFootProperty3(item, 0)
    RPCItems:RollFootProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end



function RPCItems:RollMoonTechs(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_moon_tech_runners", "immortal", "Moon Tech Runners", "feet", true, "Slot: Feet")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "moon_tech"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_moon_techs", "#3700CF",  1, "#property_moon_techs_description")

    local evasionValue = RandomInt(10, 15)
    item.property2 = evasionValue
    item.property2name = "evasion"
    RPCItems:SetPropertyValues(item, item.property2, "#item_evasion", "#759C7C",  2)

    RPCItems:RollFootProperty3(item, 0)
    RPCItems:RollFootProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollSonicBoots(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_sonic_boots", "immortal", "Sonic Boots", "feet", true, "Slot: Feet")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "sonic_boot"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_sonic_boots", "#AACFE6",  1, "#property_sonic_boots_description")


    RPCItems:RollFootProperty2(item, 0)
    RPCItems:RollFootProperty3(item, 0)
    RPCItems:RollFootProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollFalconBoots(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_falcon_boots", "immortal", "Falcon Boots", "feet", true, "Slot: Feet")
    local maxFactor = RPCItems:GetMaxFactor()
    local value, nameLevel = RPCItems:RollAttribute(0, 140, 280, 0, 0, item.rarity, false, maxFactor*300)
    local falconDamage = value
    item.property1 = falconDamage
    item.property1name = "falcon_boot"

    RPCItems:SetPropertyValuesSpecial(item, falconDamage, "#item_property_falcon_boot", "#AACFE6",  1, "#property_falcon_boot_description")


    item.property2name = "ghost_walk"
    item.property2 = 1
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_unit_walking", "#9B72C4", 2, "#property_unit_walking_description")

    RPCItems:RollFootProperty3(item, 0)
    RPCItems:RollFootProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollAdmiralBoot(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_admiral_boots", "immortal", "Admiral's Boots", "feet", true, "Slot: Feet")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "admiral"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_admiral_boots", "#A66829",  1, "#property_admiral_boots_description")

    item.hasRunePoints = true
    if maxFactor < 40 then
        value, nameLevel = RPCItems:RollAttribute(0, 1, 2, 0, 0, item.rarity, false, maxFactor/3 + 4)
        item.property2 = WallPhysics:round(value, 0)
        item.property2name = "rune_a_c"
        RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2)

        value, nameLevel = RPCItems:RollAttribute(0, 1, 2, 0, 0, item.rarity, false, maxFactor/3 + 4)
        item.property3 = WallPhysics:round(value, 0)
        item.property3name = "rune_b_c"
        RPCItems:SetPropertyValues(item, item.property3, "rune", "#7DFF12",  3)
    else
        value, nameLevel = RPCItems:RollAttribute(0, 1, 2, 0, 0, item.rarity, false, maxFactor/3 + 4)
        item.property2 = WallPhysics:round(value, 0)
        item.property2name = "rune_b_c"
        RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2)

        value, nameLevel = RPCItems:RollAttribute(0, 1, 2, 0, 0, item.rarity, false, maxFactor/3 + 4)
        item.property3 = WallPhysics:round(value, 0)
        item.property3name = "rune_c_c"
        RPCItems:SetPropertyValues(item, item.property3, "rune", "#7DFF12",  3)
    end

    RPCItems:RollFootProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollRootedFeet(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_rooted_feet", "immortal", "Rooted Feet", "feet", true, "Slot: Feet")
    local maxFactor = RPCItems:GetMaxFactor()
    item.property1 = 1
    item.property1name = "rooted_feet"
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_rooted_feet", "#ADFF5C",  1, "#property_rooted_feet_description")

    value, nameLevel = RPCItems:RollAttribute(0, 4, 8, 0, 0, item.rarity, false, maxFactor*3)
    item.property2 = value
    item.property2name = "armor"
    RPCItems:SetPropertyValues(item, item.property2, "#item_armor", "#D1D1D1",  2)

    value, prefixLevel = RPCItems:RollAttribute(100, 5, 10, 0, 0, item.rarity, false, maxFactor*6)
    item.property3 = value
    item.property3name = "health_regen"
    RPCItems:SetPropertyValues(item, item.property3, "#item_health_regen", "#6AA364",  3)

    RPCItems:RollFootProperty4(item, 0)
    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollMonkeyPaw(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_monkey_paw", "immortal", "Monkey Paw", "amulet", true, "Slot: Trinket")
    local maxFactor = RPCItems:GetMaxFactor()
    
    item.property1name = "monkey_paw"
    local value = 1
    local luck = RandomInt(1, 20)
    if luck > 18 then
        value = 3
    elseif luck > 15 then
        value = 2
    end
    item.property1 = value

    RPCItems:SetPropertyValuesSpecial(item, item.property1, "#item_property_monkey_paw", "#E4AE33",  1, "#property_monkey_paw_description")

    item.hasRunePoints = true
    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property2 = math.floor(value*1.5)
    item.property2name = propertyName
    RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2) 


    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property3 = math.floor(value*1.5)
    item.property3name = propertyName
    RPCItems:SetPropertyValues(item, item.property3, "rune", "#7DFF12",  3) 


    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property4 = value*2
    item.property4name = propertyName
    RPCItems:SetPropertyValues(item, item.property4, "rune", "#7DFF12",  4) 

    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollBlacksmithsTablet(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_blacksmiths_tablet", "immortal", "Blacksmith's Tablet", "amulet", true, "Slot: Trinket")
    local maxFactor = RPCItems:GetMaxFactor()
    
    item.property1name = "blacksmith"
    item.property1 = 1

    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_blacksmiths_tablet", "#C1C7C9",  1, "#property_blacksmiths_tablet_description")

    local value = RandomInt(maxFactor*12, maxFactor*30)
    local value = RandomInt(maxFactor*12, maxFactor*30)
    item.property2 = value
    item.property2name = "attack_damage"
    RPCItems:SetPropertyValues(item, item.property2, "#item_bonus_attack_damage", "#343EC9",  2)   
    item.property2 = value
    item.property2name = "attack_damage"
    RPCItems:SetPropertyValues(item, item.property2, "#item_bonus_attack_damage", "#343EC9",  2)   


    local tier, value, propertyName = RPCItems:RollSkillProperty()
    if tier > 0 then
        item.property3 = value
        item.property3name = propertyName
        RPCItems:SetPropertyValues(item, item.property3, "rune", "#7DFF12",  3)
    end

    local tier, value, propertyName = RPCItems:RollSkillProperty()
    if tier > 0 then
        item.property4 = value
        item.property4name = propertyName
        RPCItems:SetPropertyValues(item, item.property4, "rune", "#7DFF12",  4)
    end

    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollStoneOfGordon(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_stone_of_gordon", "immortal", "Stone of Gordon", "amulet", true, "Slot: Trinket")
    local maxFactor = RPCItems:GetMaxFactor()
    local luck = RandomInt(1, 10)
    local value = 1
    if luck < 5 then
        value = RandomInt(4, 6)
    elseif luck < 9 then
        value = RandomInt(5, 8)
    else
        value = RandomInt(6, 10)
    end
    item.property1name = "all_runes"
    item.property1 = value

    RPCItems:SetPropertyValues(item, item.property1, "#item_all_runes", "#7DFF12",  1)

    local value, nameLevel = RPCItems:RollAttribute(0, 6, 10, 0, 0, item.rarity, false, maxFactor*10)
    item.property2 = value
    item.property2name = "all_attributes"
    RPCItems:SetPropertyValues(item, item.property2, "#item_all_attributes", "#FFFFFF",  2)

    local tier, value, propertyName = RPCItems:RollSkillProperty()
    if tier > 0 then
        item.property3 = value
        item.property3name = propertyName
        RPCItems:SetPropertyValues(item, item.property3, "rune", "#7DFF12",  3)
    end

    local tier, value, propertyName = RPCItems:RollSkillProperty()
    if tier > 0 then
        item.property4 = value
        item.property4name = propertyName
        RPCItems:SetPropertyValues(item, item.property4, "rune", "#7DFF12",  4)
    end

    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollSapphireLotus(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_sapphire_lotus", "immortal", "Sapphire Lotus", "amulet", true, "Slot: Trinket")
    local maxFactor = RPCItems:GetMaxFactor()
    
    item.property1name = "sapphire_lotus"
    item.property1 = 1
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_sapphire_lotus", "#008CFF",  1, "#property_sapphire_lotus_description")

    local value, nameLevel = RPCItems:RollAttribute(0, 8, 12, 0, 0, item.rarity, false, maxFactor*12)
    item.property2 = value
    item.property2name = "intelligence"
    RPCItems:SetPropertyValues(item, item.property2, "#item_intelligence", "#33CCFF",  2) 

    local tier, value, propertyName = RPCItems:RollSkillProperty()
    if tier > 0 then
        item.property3 = value
        item.property3name = propertyName
        RPCItems:SetPropertyValues(item, item.property3, "rune", "#7DFF12",  3)
    end

    local tier, value, propertyName = RPCItems:RollSkillProperty()
    if tier > 0 then
        item.property4 = value
        item.property4name = propertyName
        RPCItems:SetPropertyValues(item, item.property4, "rune", "#7DFF12",  4)
    end

    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollArborDragonfly(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_arbor_dragonfly", "immortal", "Arbor Dragonfly", "amulet", true, "Slot: Trinket")
    local maxFactor = RPCItems:GetMaxFactor()
    
    item.property1name = "arbor"
    item.property1 = 1
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_arbor_dragonfly", "#B59B77",  1, "#property_arbor_dragonfly_description")

    local value, nameLevel = RPCItems:RollAttribute(0, 6, 11, 0, 0, item.rarity, false, maxFactor*11)
    item.property2 = value
    item.property2name = "all_attributes"
    RPCItems:SetPropertyValues(item, item.property2, "#item_all_attributes", "#FFFFFF",  2)

    local tier, value, propertyName = RPCItems:RollSkillProperty()
    if tier > 0 then
        item.property3 = value
        item.property3name = propertyName
        RPCItems:SetPropertyValues(item, item.property3, "rune", "#7DFF12",  3)
    end

    local tier, value, propertyName = RPCItems:RollSkillProperty()
    if tier > 0 then
        item.property4 = value
        item.property4name = propertyName
        RPCItems:SetPropertyValues(item, item.property4, "rune", "#7DFF12",  4)
    end

    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollFrostGem(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_gem_of_eternal_frost", "immortal", "Gem of Eternal Frost", "amulet", true, "Slot: Trinket")
    local maxFactor = RPCItems:GetMaxFactor()
    
    item.property1name = "eternal_frost"
    item.property1 = 1
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_eternal_frost", "#9FE9F5",  1, "#property_eternal_frost_description")

    local value, nameLevel = RPCItems:RollAttribute(0, 8, 12, 0, 0, item.rarity, false, maxFactor*12)
    item.property2 = value
    item.property2name = "intelligence"
    RPCItems:SetPropertyValues(item, item.property2, "#item_intelligence", "#33CCFF",  2) 

    local tier, value, propertyName = RPCItems:RollSkillProperty()
    if tier > 0 then
        item.property3 = value
        item.property3name = propertyName
        RPCItems:SetPropertyValues(item, item.property3, "rune", "#7DFF12",  3)
    end

    local tier, value, propertyName = RPCItems:RollSkillProperty()
    if tier > 0 then
        item.property4 = value
        item.property4name = propertyName
        RPCItems:SetPropertyValues(item, item.property4, "rune", "#7DFF12",  4)
    end

    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollLifesourceVessel(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_lifesource_vessel", "immortal", "Lifesource Vessel", "amulet", true, "Slot: Trinket")
    local maxFactor = RPCItems:GetMaxFactor()
    
    item.property1name = "lifesource"
    item.property1 = 1
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_lifesource_vessel", "#E31459",  1, "#property_lifesource_vessel_description")

    local value, prefixLevel = RPCItems:RollAttribute(300, 220, 600, 1, 1, item.rarity, false, maxFactor*400)
    item.property2 = value
    item.property2name = "max_health"
    RPCItems:SetPropertyValues(item, item.property2, "#item_max_health", "#B02020",  2)

    local value, prefixLevel = RPCItems:RollAttribute(100, 5, 10, 0, 0, item.rarity, false, maxFactor*5)
    item.property3 = value
    item.property3name = "health_regen"
    RPCItems:SetPropertyValues(item, item.property3, "#item_health_regen", "#6AA364",  3)

    local tier, value, propertyName = RPCItems:RollSkillProperty()
    if tier > 0 then
        item.property4 = value
        item.property4name = propertyName
        RPCItems:SetPropertyValues(item, item.property4, "rune", "#7DFF12",  4)
    end

    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollHopeOfSaytaru(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_hope_of_saytaru", "immortal", "Hope of Saytaru", "amulet", true, "Slot: Trinket")
    local maxFactor = RPCItems:GetMaxFactor()
    
    item.property1name = "saytaru"
    item.property1 = 1
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_saytaru", "#EDE618",  1, "#property_saytaru_description")

    local magicResistRoll = RandomInt(5, 10)
    item.property2 = magicResistRoll
    item.property2name = "magic_resist"
    RPCItems:SetPropertyValues(item, item.property2, "#item_magic_resist", "#AC47DE",  2)

    local tier, value, propertyName = RPCItems:RollSkillProperty()
    if tier > 0 then
        item.property3 = value
        item.property3name = propertyName
        RPCItems:SetPropertyValues(item, item.property3, "rune", "#7DFF12",  3)
    end

    local tier, value, propertyName = RPCItems:RollSkillProperty()
    if tier > 0 then
        item.property4 = value
        item.property4name = propertyName
        RPCItems:SetPropertyValues(item, item.property4, "rune", "#7DFF12",  4)
    end

    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollGalaxyOrb(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_galaxy_orb", "immortal", "Galaxy Orb", "amulet", true, "Slot: Trinket")
    local maxFactor = RPCItems:GetMaxFactor()
    
    item.property1name = "galaxy_orb"
    item.property1 = 1

    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_galaxy_orb", "#FF9100",  1, "#property_galaxy_orb_description")

    local tier, value, propertyName = RPCItems:RollAmuletProperty2(item, 300, 1)
    if tier > 0 then
        item.property2 = value
        item.property2name = propertyName
        RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2)
    end


    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property3 = value
    item.property3name = propertyName
    RPCItems:SetPropertyValues(item, item.property3, "rune", "#7DFF12",  3) 


    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property4 = value*2
    item.property4name = propertyName
    RPCItems:SetPropertyValues(item, item.property4, "rune", "#7DFF12",  4) 

    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollAzureEmpire(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_azure_empire", "immortal", "Pendant of the Azure Empire", "amulet", true, "Slot: Trinket")
    local maxFactor = RPCItems:GetMaxFactor()
    
    item.property1name = "azure_empire"
    item.property1 = 1

    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_azure_empire", "#7AD2F0",  1, "#property_azure_empire_description")

    value, nameLevel = RPCItems:RollAttribute(0, 6, 11, 0, 0, item.rarity, false, maxFactor*11)
    item.property2 = value
    item.property2name = "agility"
    RPCItems:SetPropertyValues(item, item.property2, "#item_agility", "#2EB82E",  2)


    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property3 = value
    item.property3name = propertyName
    RPCItems:SetPropertyValues(item, item.property3, "rune", "#7DFF12",  3) 


    local tier, value, propertyName = RPCItems:RollMagebaneRuneProperty()
    item.property4 = value
    item.property4name = propertyName
    RPCItems:SetPropertyValues(item, item.property4, "rune", "#7DFF12",  4) 

    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollSignusCharm(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_signus_charm", "immortal", "Signus Charm", "amulet", true, "Slot: Trinket")
    local maxFactor = RPCItems:GetMaxFactor()
    
    item.property1name = "signus"
    item.property1 = 1
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_signus", "#ED217D",  1, "#property_signus_description")

    local value, nameLevel = RPCItems:RollAttribute(0, 6, 11, 0, 0, item.rarity, false, maxFactor*11)
    item.property2 = value
    item.property2name = "all_attributes"
    RPCItems:SetPropertyValues(item, item.property2, "#item_all_attributes", "#FFFFFF",  2)

    local tier, value, propertyName = RPCItems:RollSkillProperty()
    if tier > 0 then
        item.property3 = value
        item.property3name = propertyName
        RPCItems:SetPropertyValues(item, item.property3, "rune", "#7DFF12",  3)
    end

    local tier, value, propertyName = RPCItems:RollSkillProperty()
    if tier > 0 then
        item.property4 = value
        item.property4name = propertyName
        RPCItems:SetPropertyValues(item, item.property4, "rune", "#7DFF12",  4)
    end

    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end

function RPCItems:RollEyeOfAvernus(deathLocation)
    local item = RPCItems:CreateVariant("item_rpc_eye_of_avernus", "immortal", "Eye of Avernus", "amulet", true, "Slot: Trinket")
    local maxFactor = RPCItems:GetMaxFactor()
    
    item.property1name = "avernus"
    item.property1 = 1
    RPCItems:SetPropertyValuesSpecial(item, "★", "#item_property_avernus", "#E85F31",  1, "#property_avernus_description")

    local value, nameLevel = RPCItems:RollAttribute(0, 10, 15, 0, 0, item.rarity, false, maxFactor*15)
    item.property2 = value
    item.property2name = "all_attributes"
    RPCItems:SetPropertyValues(item, item.property2, "#item_all_attributes", "#FFFFFF",  2)

    local magicResistRoll = RandomInt(15, 25)
    item.property3 = magicResistRoll
    item.property3name = "magic_resist"
    RPCItems:SetPropertyValues(item, item.property3, "#item_magic_resist", "#AC47DE",  3)

    local tier, value, propertyName = RPCItems:RollSkillProperty()
    if tier > 0 then
        value = math.floor(value*1.5)
        item.property4 = value
        item.property4name = propertyName
        RPCItems:SetPropertyValues(item, item.property4, "rune", "#7DFF12",  4)
    end

    local drop = CreateItemOnPositionSync( deathLocation, item )
    local position = deathLocation
    RPCItems:DropItem(item, position)
end