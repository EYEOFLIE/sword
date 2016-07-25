BASE_BODY_TABLE = {"item_rpc_robe", "item_rpc_mantle", "item_rpc_mail"}
BASE_BODY_NAME_TABLE = {"Robes", "Mantle", "Mail"}

function RPCItems:RollBody(xpBounty, deathLocation, rarity, isShop, type, hero, unitLevel)
	local randomHelm = RandomInt(1, 3)
    if isShop then
        randomHelm = type
    end
	local itemVariant = BASE_BODY_TABLE[randomHelm]
    local item = CreateItem(itemVariant, nil, nil)



    item.rarity = rarity
    local rarityValue = RPCItems:GetRarityFactor(rarity)
    local itemName = BASE_BODY_NAME_TABLE[randomHelm]
    if rarityValue == 5 then
        if RPCItems:BodyLegendary(itemVariant, deathLocation) then
            return nil
        end
    end
    item.slot = "body"
    item.gear = true
    local prefix = ""
    local additional_prefix = ""
    local suffix = RPCItems:RollBodyProperty1(item, xpBounty, randomHelm)
    if rarityValue >= 2 then
    	prefix = RPCItems:RollBodyProperty2(item, xpBounty)
    else
    	prefix = ""
    end
    if rarityValue>=3 then
    	RPCItems:RollBodyProperty3(item, xpBounty)
    end
    if rarityValue>=4 then
    	additional_prefix = RPCItems:RollBodyProperty4(item, xpBounty)
    	itemName = additional_prefix.." "..itemName
    end

    RPCItems:SetTableValues(item, itemName, false, "Slot: Body", RPCItems:GetRarityColor(rarity), rarity, prefix, suffix, RPCItems:GetRarityFactor(rarity))
    if isShop then
        RPCItems:GiveItemToHero(hero, item)
    else
    	local drop = CreateItemOnPositionSync( deathLocation, item )
    	local position = deathLocation
        RPCItems:DropItem(item, position)
    end
end

function RPCItems:BodyLegendary(itemVariant, deathLocation)
    if itemVariant == "item_rpc_mantle" then
        local luck = RandomInt(1, 6)
        if luck == 1 then
            RPCItems:RollSecretTempleArmor(deathLocation)
            return true
        elseif luck == 2 then
            RPCItems:RollFeatherwhiteArmor(deathLocation)
            return true
        elseif luck == 3 then
            RPCItems:RollSoulVest(deathLocation)
            return true
        elseif luck == 4 then
            RPCItems:RollVioletGuardArmor(deathLocation)
            return true
        elseif luck == 5 then
            RPCItems:RollHurricaneVest(deathLocation)
            return true
        elseif luck == 6 then
            RPCItems:RollNightmareRiderMantle(deathLocation)
            return true
        end
    elseif itemVariant == "item_rpc_robe" then
        local luck = RandomInt(1, 6)
        if luck == 1 then
            RPCItems:RollDarkArtsVestments(deathLocation)
            return true
        elseif luck == 2 then
            RPCItems:RollDragonCeremonyVestments(deathLocation)
            return true
        elseif luck == 3 then
            RPCItems:RollSpellslingerCoat(deathLocation)
            return true
        elseif luck == 4 then
            RPCItems:RollSorcererRegalia(deathLocation)
            return true
        elseif luck == 5 then
            RPCItems:RollFloodRobe(deathLocation)
            return true
        elseif luck == 6 then
            RPCItems:RollLegionVestments(deathLocation)
            return true
        end      
    elseif itemVariant == "item_rpc_mail" then
        local luck = RandomInt(1, 7)
        if luck == 1 then
            RPCItems:RollVampiricBreastplate(deathLocation)
            return true
        elseif luck == 2 then
            RPCItems:RollIceQuillCarapace(deathLocation)
            return true
        elseif luck == 3 then
            RPCItems:RollDoomplate(deathLocation)
            return true
        elseif luck == 4 then
            RPCItems:RollWatcherPlate(deathLocation)
            return true
        elseif luck == 5 then
            RPCItems:RollAvalanchePlate(deathLocation)
            return true 
        elseif luck == 6 then
            RPCItems:RollSpaceTechVest(deathLocation)
            return true
        elseif luck == 7 then
            RPCItems:RollStormshieldCloak(deathLocation)
            return true
        end   
    end
    return false
end


SUFFIX_PHYSICAL_BLOCK_TABLE = {"of Blocking", "of Resistance", "of Guardians", "of the Sentinel", "of the Watcher"}
SUFFIX_MAGIC_BLOCK_TABLE = {"of Charmed Protection", "of the Whale", "of the Illusionist", "of the Necromancer", "of the Prophet"}

function RPCItems:RollBodyProperty1(item, xpBounty, randomHelm)
    local luck = RandomInt(0,100)
    local maxFactor = RPCItems:GetMaxFactor()
    local value = 0
    local suffixLevel = 1
    if luck < 10 then
    	local bonus = RPCItems:GetHeadBonusRoll(randomHelm, 3, 4)
        value, suffixLevel = RPCItems:RollAttribute(xpBounty, 1, 2+bonus, 0, 0, item.rarity, false, maxFactor*10)
        item.property1 = value
        item.property1name = "strength"
        suffix = SUFFIX_HOOD_STRENGTH_TABLE[suffixLevel]
        RPCItems:SetPropertyValues(item, item.property1, "#item_strength", "#CC0000",  1)
    elseif luck >= 10 and luck < 20 then
    	local bonus = RPCItems:GetHeadBonusRoll(randomHelm, 2, 4)
        value, suffixLevel = RPCItems:RollAttribute(xpBounty, 1, 2+bonus, 0, 0, item.rarity, false, maxFactor*10)
        item.property1 = value
        item.property1name = "agility"
        suffix = SUFFIX_HOOD_AGILITY_TABLE[suffixLevel]
        RPCItems:SetPropertyValues(item, item.property1, "#item_agility", "#2EB82E",  1)
    elseif luck >= 20 and luck < 30 then
    	local bonus = RPCItems:GetHeadBonusRoll(randomHelm, 1, 4)
        value, suffixLevel = RPCItems:RollAttribute(xpBounty, 1, 2+bonus, 0, 0, item.rarity, false, maxFactor*10)
        item.property1 = value
        item.property1name = "intelligence"
        suffix = SUFFIX_HOOD_INTELLIGENCE_TABLE[suffixLevel]
        RPCItems:SetPropertyValues(item, item.property1, "#item_intelligence", "#33CCFF",  1)
    elseif luck >= 30 and luck < 40 then
    	local bonus = RPCItems:GetHeadBonusRoll(randomHelm, 1, 5)
        value, suffixLevel = RPCItems:RollAttribute(xpBounty, 1, 2+bonus, 0, 0, item.rarity, false, 5)
        item.property1 = value
        item.property1name = "magic_resist"
        suffix = SUFFIX_HOOD_MAGIC_RESIST_TABLE[suffixLevel]
        RPCItems:SetPropertyValues(item, item.property1, "#item_magic_resist", "#AC47DE",  1)
    elseif luck >= 40 and luck < 50 then
    	local bonus = RPCItems:GetHeadBonusRoll(randomHelm, 3, 6)
        value, suffixLevel = RPCItems:RollAttribute(xpBounty, 1, 2+bonus, 0, 0, item.rarity, false, maxFactor*3)
        item.property1 = value
        item.property1name = "armor"
        suffix = SUFFIX_HOOD_ARMOR_TABLE[suffixLevel]
        RPCItems:SetPropertyValues(item, item.property1, "#item_armor", "#D1D1D1",  1)
    elseif luck >= 50 and luck < 60 then
    	local bonus = 0
        value, suffixLevel = RPCItems:RollAttribute(xpBounty, 1, 50+bonus, 0, 0, item.rarity, false, maxFactor*20)
        item.property1 = value
        item.property1name = "physical_block"
        suffix = SUFFIX_PHYSICAL_BLOCK_TABLE[suffixLevel]
        RPCItems:SetPropertyValues(item, item.property1, "#item_physical_block", "#B02020",  1)
    elseif luck >= 60 and luck < 70 then
    	local bonus = 0
        value, suffixLevel = RPCItems:RollAttribute(xpBounty, 1, 20+bonus, 0, 0, item.rarity, false, maxFactor*20)
        item.property1 = value
        item.property1name = "magic_block"
        suffix = SUFFIX_MAGIC_BLOCK_TABLE[suffixLevel]
        RPCItems:SetPropertyValues(item, item.property1, "#item_magic_block", "#343EC9",  1)   
    elseif luck >= 70 and luck < 80 then
    	local bonus = RPCItems:GetHeadBonusRoll(randomHelm, 2, 3)
        value, suffixLevel = RPCItems:RollAttribute(xpBounty, 1, 3+bonus, 0, 0, item.rarity, false, maxFactor*3)
        item.property1 = value
        item.property1name = "health_regen"
        suffix = SUFFIX_HEALTH_REGEN_TABLE[suffixLevel]
        RPCItems:SetPropertyValues(item, item.property1, "#item_health_regen", "#6AA364",  1)
    elseif luck >= 80 and luck < 90 then
    	local bonus = RPCItems:GetHeadBonusRoll(randomHelm, 1, 3)
        value, suffixLevel = RPCItems:RollAttribute(xpBounty, 1, 5+bonus, 0, 0, item.rarity, false, maxFactor*3)
        item.property1 = value
        item.property1name = "mana_regen"
        suffix = SUFFIX_MANA_REGEN_TABLE[suffixLevel]
        RPCItems:SetPropertyValues(item, item.property1, "#item_mana_regen", "#649FA3",  1)
    elseif luck >= 90 and luck < 100 then
    	local bonus = RPCItems:GetHeadBonusRoll(randomHelm, 3, 5)
        value, suffixLevel = RPCItems:RollAttribute(xpBounty, 1, 3+bonus, 0, 0, item.rarity, false, maxFactor)
        item.property1 = value
        item.property1name = "respawn_reduce"
        suffix = SUFFIX_RESPAWN_REDUCE_TABLE[suffixLevel]
        RPCItems:SetPropertyValues(item, item.property1, "#item_respawn_reduction", "#F28100",  1)             
    end
    return suffix
end

PREFIX_PHYSICAL_BLOCK_TABLE = {"Vigilant", "Guarded", "Attendant's", "Keeper's", "Champion's"}
PREFIX_MAGIC_BLOCK_TABLE = {"Juggler's", "Enchanter's", "Shaman's", "Corrupted", "Cursed"}

function RPCItems:RollBodyProperty2(item, xpBounty)
    local luck = RandomInt(0,100)
    local maxFactor = RPCItems:GetMaxFactor()
    local value = 0
    local prefixLevel = 1
    if luck < 10 then
    	local bonus = RPCItems:GetHeadBonusRoll(randomHelm, 3, 10)
        value, prefixLevel = RPCItems:RollAttribute(xpBounty, 1, 10+bonus, 0, 0, item.rarity, false, maxFactor*10)
        item.property2 = value
        item.property2name = "strength"
        prefix = PREFIX_HOOD_STRENGTH_TABLE[prefixLevel]
        RPCItems:SetPropertyValues(item, item.property2, "#item_strength", "#CC0000",  2)
    elseif luck >= 10 and luck < 20 then
    	local bonus = RPCItems:GetHeadBonusRoll(randomHelm, 2, 10)
        value, prefixLevel = RPCItems:RollAttribute(xpBounty, 1, 10+bonus, 0, 0, item.rarity, false, maxFactor*10)
        item.property2 = value
        item.property2name = "agility"
        prefix = PREFIX_HOOD_AGILITY_TABLE[prefixLevel]
        RPCItems:SetPropertyValues(item, item.property2, "#item_agility", "#2EB82E",  2)
    elseif luck >= 20 and luck < 30 then
    	local bonus = RPCItems:GetHeadBonusRoll(randomHelm, 1, 10)
        value, prefixLevel = RPCItems:RollAttribute(xpBounty, 1, 10+bonus, 0, 0, item.rarity, false, maxFactor*10)
        item.property2 = value
        item.property2name = "intelligence"
        prefix = PREFIX_HOOD_INTELLIGENCE_TABLE[prefixLevel]
        RPCItems:SetPropertyValues(item, item.property2, "#item_intelligence", "#33CCFF",  2)
    elseif luck >= 30 and luck < 40 then
    	local bonus = RPCItems:GetHeadBonusRoll(randomHelm, 1, 10)
        value, prefixLevel = RPCItems:RollAttribute(xpBounty, 1, 10+bonus, 0, 0, item.rarity, false, 7)
        item.property2 = value
        item.property2name = "magic_resist"
        prefix = PREFIX_HOOD_MAGIC_RESIST_TABLE[prefixLevel]
        RPCItems:SetPropertyValues(item, item.property2, "#item_magic_resist", "#AC47DE",  2)
    elseif luck >= 40 and luck < 50 then
    	local bonus = RPCItems:GetHeadBonusRoll(randomHelm, 3, 6)
        value, prefixLevel = RPCItems:RollAttribute(xpBounty, 1, 2+bonus, 0, 0, item.rarity, false, maxFactor*3)
        item.property2 = value
        item.property2name = "armor"
        prefix = PREFIX_HOOD_ARMOR_TABLE[prefixLevel]
        RPCItems:SetPropertyValues(item, item.property2, "#item_armor", "#D1D1D1",  2)
    elseif luck >= 50 and luck < 60 then
    	local bonus = 0
        value, prefixLevel = RPCItems:RollAttribute(xpBounty, 1, 70+bonus, 0, 0, item.rarity, false, maxFactor*20)
        item.property2 = value
        item.property2name = "physical_block"
       	prefix = PREFIX_PHYSICAL_BLOCK_TABLE[prefixLevel]
        RPCItems:SetPropertyValues(item, item.property2, "#item_physical_block", "#B02020",  2)
    elseif luck >= 60 and luck < 70 then
    	local bonus = 0
        value, prefixLevel = RPCItems:RollAttribute(xpBounty, 1, 20+bonus, 0, 0, item.rarity, false, maxFactor*20)
        item.property2 = value
        item.property2name = "magic_block"
        prefix = PREFIX_MAGIC_BLOCK_TABLE[prefixLevel]
        RPCItems:SetPropertyValues(item, item.property2, "#item_magic_block", "#343EC9",  2)     
    elseif luck >= 70 and luck < 80 then
    	local bonus = RPCItems:GetHeadBonusRoll(randomHelm, 2, 4)
        value, prefixLevel = RPCItems:RollAttribute(xpBounty, 1, 4+bonus, 0, 0, item.rarity, false, maxFactor*3)
        item.property2 = value
        item.property2name = "health_regen"
        prefix = PREFIX_HEALTH_REGEN_TABLE[prefixLevel]
        RPCItems:SetPropertyValues(item, item.property2, "#item_health_regen", "#6AA364",  2)
    elseif luck >= 80 and luck < 90 then
    	local bonus = RPCItems:GetHeadBonusRoll(randomHelm, 1, 5)
        value, prefixLevel = RPCItems:RollAttribute(xpBounty, 1, 7+bonus, 0, 0, item.rarity, false, maxFactor*5)
        item.property2 = value
        item.property2name = "mana_regen"
        prefix = PREFIX_MANA_REGEN_TABLE[prefixLevel]
        RPCItems:SetPropertyValues(item, item.property2, "#item_mana_regen", "#649FA3",  2)
    elseif luck >= 90 and luck < 100 then
    	local bonus = RPCItems:GetHeadBonusRoll(randomHelm, 3, 2)
        value, prefixLevel = RPCItems:RollAttribute(xpBounty, 1, 5+bonus, 0, 0, item.rarity, false, maxFactor)
        item.property2 = value
        item.property2name = "respawn_reduce"
        prefix = PREFIX_RESPAWN_REDUCE_TABLE[prefixLevel]
        RPCItems:SetPropertyValues(item, item.property2, "#item_respawn_reduction", "#F28100",  2)             
    end
    return prefix
end



function RPCItems:RollBodyProperty3(item, xpBounty)
    local luck = RandomInt(0,100)
    local maxFactor = RPCItems:GetMaxFactor()
    local value = 0
    local prefixLevel = 1
    if luck < 10 then
        value, prefixLevel = RPCItems:RollAttribute(xpBounty, 1, 15, 0, 0, item.rarity, false, maxFactor*10)
        item.property3 = value
        item.property3name = "strength"
        RPCItems:SetPropertyValues(item, item.property3, "#item_strength", "#CC0000",  3)
    elseif luck >= 10 and luck < 20 then
        value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 15, 0, 0, item.rarity, false, maxFactor*10)
        item.property3 = value
        item.property3name = "agility"
        RPCItems:SetPropertyValues(item, item.property3, "#item_agility", "#2EB82E",  3)
    elseif luck >= 20 and luck < 30 then
        value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 15, 0, 0, item.rarity, false, maxFactor*10)
        item.property3 = value
        item.property3name = "intelligence"
        RPCItems:SetPropertyValues(item, item.property3, "#item_intelligence", "#33CCFF",  3)
    elseif luck >= 30 and luck < 40 then
        value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 30, 0, 0, item.rarity, false, 6)
        item.property3 = value
        item.property3name = "magic_resist"
        RPCItems:SetPropertyValues(item, item.property3, "#item_magic_resist", "#AC47DE",  3)
    elseif luck >= 40 and luck < 50 then
        value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 5, 0, 0, item.rarity, false, maxFactor*3)
        item.property3 = value
        item.property3name = "armor"
        RPCItems:SetPropertyValues(item, item.property3, "#item_armor", "#D1D1D1",  3)
    elseif luck >= 50 and luck < 60 then
        value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 70, 0, 0, item.rarity, false, maxFactor*20)
        item.property3 = value
        item.property3name = "physical_block"
        RPCItems:SetPropertyValues(item, item.property3, "#item_physical_block", "#B02020",  3)
    elseif luck >= 60 and luck < 70 then
        value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 20, 0, 0, item.rarity, false, maxFactor*20)
        item.property3 = value
        item.property3name = "magic_block"
        RPCItems:SetPropertyValues(item, item.property3, "#item_magic_block", "#343EC9",  3)   
    elseif luck >= 70 and luck < 80 then
        value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 4, 0, 0, item.rarity, false, maxFactor*5)
        item.property3 = value
        item.property3name = "health_regen"
        RPCItems:SetPropertyValues(item, item.property3, "#item_health_regen", "#6AA364",  3)
    elseif luck >= 80 and luck < 90 then
        value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 6, 0, 0, item.rarity, false, maxFactor*3)
        item.property3 = value
        item.property3name = "mana_regen"
        RPCItems:SetPropertyValues(item, item.property3, "#item_mana_regen", "#649FA3",  3)
    elseif luck >= 90 and luck < 100 then
        value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 6, 0, 0, item.rarity, false, maxFactor)
        item.property3 = value
        item.property3name = "respawn_reduce"
        RPCItems:SetPropertyValues(item, item.property3, "#item_respawn_reduction", "#F28100",  3)             
    end
end

PREFIX_BODY_TABLE2 = {"Archmage", "Renegade", "Runic", "Heretic", "Zealot"}

function RPCItems:RollBodyProperty4(item, xpBounty)
   local luck = RandomInt(0,100)
   local maxFactor = RPCItems:GetMaxFactor()
    local value = 0
    local nameLevel = 1
    if luck < 10 then
        value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 35, 0, 0, item.rarity, false, maxFactor*12)
        item.property4 = value
        item.property4name = "strength"
        RPCItems:SetPropertyValues(item, item.property4, "#item_strength", "#CC0000",  4)
    elseif luck >= 10 and luck < 20 then
        value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 35, 0, 0, item.rarity, false, maxFactor*12)
        item.property4 = value
        item.property4name = "agility"
        RPCItems:SetPropertyValues(item, item.property4, "#item_agility", "#2EB82E",  4)
    elseif luck >= 20 and luck < 30 then
        value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 35, 0, 0, item.rarity, false, maxFactor*12)
        item.property4 = value
        item.property4name = "intelligence"
        RPCItems:SetPropertyValues(item, item.property4, "#item_intelligence", "#33CCFF",  4)
    elseif luck >= 30 and luck < 40 then
        value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 10, 0, 0, item.rarity, false, 5)
        item.property4 = value
        item.property4name = "magic_resist"
        RPCItems:SetPropertyValues(item, item.property4, "#item_magic_resist", "#AC47DE",  4)
    elseif luck >= 40 and luck < 50 then
        value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 5, 0, 0, item.rarity, false, maxFactor*5)
        item.property4 = value
        item.property4name = "armor"
        RPCItems:SetPropertyValues(item, item.property4, "#item_armor", "#D1D1D1",  4)
    elseif luck >= 50 and luck < 60 then
        value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 70, 0, 0, item.rarity, false, maxFactor*20)
        item.property4 = value
        item.property4name = "physical_block"
        RPCItems:SetPropertyValues(item, item.property4, "#item_physical_block", "#B02020",  4)
    elseif luck >= 60 and luck < 70 then
        value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 20, 0, 0, item.rarity, false, maxFactor*20)
        item.property4 = value
        item.property4name = "magic_block"
        RPCItems:SetPropertyValues(item, item.property4, "#item_magic_block", "#343EC9",  4)  
    elseif luck >= 70 and luck < 80 then
        value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 10, 0, 0, item.rarity, false, maxFactor*6)
        item.property4 = value
        item.property4name = "health_regen"
        RPCItems:SetPropertyValues(item, item.property4, "#item_health_regen", "#6AA364",  4)
    elseif luck >= 80 and luck < 90 then
        value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 6, 0, 0, item.rarity, false, maxFactor*4)
        item.property4 = value
        item.property4name = "mana_regen"
        RPCItems:SetPropertyValues(item, item.property4, "#item_mana_regen", "#649FA3",  4)
    elseif luck >= 90 and luck < 100 then
        value, nameLevel = RPCItems:RollAttribute(xpBounty, 1, 7, 1, 0, item.rarity, false, maxFactor)
        item.property4 = value
        item.property4name = "respawn_reduce"
        RPCItems:SetPropertyValues(item, item.property4, "#item_respawn_reduction", "#F28100",  4)             
    end
    local name = PREFIX_BODY_TABLE2[nameLevel]
    return name
end

