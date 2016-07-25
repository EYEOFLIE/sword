BASE_AMULET_TABLE = {"item_rpc_talisman", "item_rpc_ruby_ring", "item_rpc_steel_ring"}
BASE_AMULET_NAME_TABLE = {"Talisman", "Ring", "Loop"}

function RPCItems:RollAmulet(xpBounty, deathLocation, rarity, isShop, type, hero, unitLevel)
	local randomHelm = RandomInt(1, 3)
    if isShop then
        randomHelm = type
    end
	local itemVariant = BASE_AMULET_TABLE[randomHelm]
    local item = CreateItem(itemVariant, nil, nil)



    item.rarity = rarity
    local rarityValue = RPCItems:GetRarityFactor(rarity)
    local itemName = BASE_AMULET_NAME_TABLE[randomHelm]
    local suffix = ""
    local prefix = ""
    item.slot = "amulet"
    item.gear = true
    if rarityValue == 5 then
        if RPCItems:AmuletLegendary(itemVariant, deathLocation) then
            return nil
        end
    end
    local tier, value, propertyName = RPCItems:RollAmuletProperty1(item, xpBounty, randomHelm)
    if tier == 1 then
        suffix = SUFFIX_TIER_1_SKILL_TABLE[RandomInt(1, 5)]
    elseif tier == 2 then
        suffix = SUFFIX_TIER_2_SKILL_TABLE[RandomInt(1, 5)]
    elseif tier == 0 then
        suffix = propertyName
    end
    if tier > 0 then
        item.property1 = value
        item.property1name = propertyName
        RPCItems:SetPropertyValues(item, item.property1, "rune", "#7DFF12",  1)
    end

    if rarityValue >= 2 then
        local tier, value, propertyName = RPCItems:RollAmuletProperty2(item, xpBounty, randomHelm)
        if tier == 1 then
            prefix = PREFIX_TIER_1_SKILL_TABLE[RandomInt(1, 5)]
        elseif tier == 2 then
            prefix = PREFIX_TIER_2_SKILL_TABLE[RandomInt(1, 5)]
        elseif tier == 0 then
            prefix = propertyName
        end
        if tier > 0 then
            item.property2 = value
            item.property2name = propertyName
            RPCItems:SetPropertyValues(item, item.property2, "rune", "#7DFF12",  2)
        end
    end
    if rarityValue>=3 then
        local tier, value, propertyName = RPCItems:RollSkillProperty()
        if tier > 0 then
            item.property3 = value
            item.property3name = propertyName
            RPCItems:SetPropertyValues(item, item.property3, "rune", "#7DFF12",  3)
        end
    end
    if rarityValue>=4 then
        local tier, value, propertyName = RPCItems:RollSkillProperty()
        if tier > 0 then
            item.property4 = value
            item.property4name = propertyName
            RPCItems:SetPropertyValues(item, item.property4, "rune", "#7DFF12",  4)
        end
    end

    RPCItems:SetTableValues(item, itemName, false, "Slot: Trinket", RPCItems:GetRarityColor(rarity), rarity, prefix, suffix, RPCItems:GetRarityFactor(rarity))
    if isShop then
        RPCItems:GiveItemToHero(hero, item)
    else
    	local drop = CreateItemOnPositionSync( deathLocation, item )
    	local position = deathLocation
        RPCItems:DropItem(item, position)
    end
end

function RPCItems:AmuletLegendary(itemVariant, deathLocation)
    if itemVariant == "item_rpc_talisman" then
        local luck = RandomInt(1, 3)
        if luck == 1 then
            RPCItems:RollMonkeyPaw(deathLocation)
            return true
        elseif luck == 2 then
            RPCItems:RollSapphireLotus(deathLocation)
            return true
        elseif luck == 3 then
            RPCItems:RollFrostGem(deathLocation)
            return true
        end
    elseif itemVariant == "item_rpc_ruby_ring" then
        local luck = RandomInt(1, 4)
        if luck == 1 then
            RPCItems:RollStoneOfGordon(deathLocation)
            return true
        elseif luck == 2 then
            RPCItems:RollArborDragonfly(deathLocation)
            return true
        elseif luck == 3 then
            RPCItems:RollHopeOfSaytaru(deathLocation)
            return true
        elseif luck == 4 then
            RPCItems:RollAzureEmpire(deathLocation)
            return true
        end
    elseif itemVariant == "item_rpc_steel_ring" then
        local luck = RandomInt(1, 4)
        if luck == 1 then
            RPCItems:RollBlacksmithsTablet(deathLocation)
            return true
        elseif luck == 2 then
            RPCItems:RollLifesourceVessel(deathLocation)
            return true
        elseif luck == 3 then
            RPCItems:RollGalaxyOrb(deathLocation)
            return true
        elseif luck == 4 then
            RPCItems:RollSignusCharm(deathLocation)
            return true
        end
    end
    return false
end

function RPCItems:AmuletPickup(heroEntity, itemEntity)
    local heroName = heroEntity:GetName()
    local rarityFactor = RPCItems:GetRarityFactor(itemEntity.rarity)
    print("did we pick up")
    for i = 1, rarityFactor, 1 do
        if heroName == "npc_dota_hero_dragon_knight" then
            RPCItems:SkillTranslateFlamewaker(heroEntity, itemEntity, i)
        elseif heroName == "npc_dota_hero_phantom_assassin" then
            RPCItems:SkillTranslateVoltex(heroEntity, itemEntity, i)
        elseif heroName == "npc_dota_hero_necrolyte" then
            RPCItems:SkillTranslateVenomort(heroEntity, itemEntity, i)
        elseif heroName == "npc_dota_hero_axe" then
            RPCItems:SkillTranslateAxe(heroEntity, itemEntity, i)
        elseif heroName == "npc_dota_hero_drow_ranger" then
            RPCItems:SkillTranslateAstral(heroEntity, itemEntity, i)
        elseif heroName == "npc_dota_hero_obsidian_destroyer" then
            RPCItems:SkillTranslateEpoch(heroEntity, itemEntity, i)
        elseif heroName == "npc_dota_hero_omniknight" then
            RPCItems:SkillTranslatePaladin(heroEntity, itemEntity, i)
        elseif heroName == "npc_dota_hero_crystal_maiden" then
            RPCItems:SkillTranslateSorceress(heroEntity, itemEntity, i)
        elseif heroName == "npc_dota_hero_invoker" then
            RPCItems:SkillTranslateConjuror(heroEntity, itemEntity, i)
        elseif heroName == "npc_dota_hero_juggernaut" then
            RPCItems:SkillTranslateMonk(heroEntity, itemEntity, i)
        elseif heroName == "npc_dota_hero_beastmaster" then
            RPCItems:SkillTranslateBasic(heroEntity, itemEntity, i, "#DOTA_Tooltip_ability_warlord_")
        elseif heroName == "npc_dota_hero_leshrac" then
            RPCItems:SkillTranslateBasic(heroEntity, itemEntity, i, "#DOTA_Tooltip_ability_bahamut_")
        end
    end
    itemEntity.translated = true
end

function RPCItems:SetBaseValue(slot, itemEntity, propertyValue)
    if not itemEntity.translated then
        if slot == 1 then
            itemEntity.baseValue1 = itemEntity.property1
        elseif slot == 2 then
            itemEntity.baseValue2 = itemEntity.property2
        elseif slot == 3 then
            itemEntity.baseValue3 = itemEntity.property3
        elseif slot == 4 then
            itemEntity.baseValue4 = itemEntity.property4
        end
        return propertyValue
    else
        return 0
    end
end

function RPCItems:SkillTranslateFlamewaker(heroEntity, itemEntity, slot)
    local propertyName = ""
    local runeName = ""
    local propertyValue = 0
    local baseValue = 0
    RPCItems:SetBaseValue(slot, itemEntity, propertyValue)
    if slot == 1 then
        propertyName = itemEntity.property1name
        propertyValue = itemEntity.property1
        baseValue = itemEntity.baseValue1
    elseif slot == 2 then
        propertyName = itemEntity.property2name
        propertyValue = itemEntity.property2
        baseValue = itemEntity.baseValue2
    elseif slot == 3 then
        propertyName = itemEntity.property3name
        propertyValue = itemEntity.property3
        baseValue = itemEntity.baseValue3
    elseif slot == 4 then
        propertyName = itemEntity.property4name
        propertyValue = itemEntity.property4
        baseValue = itemEntity.baseValue4
    end

    if propertyName == "rune_a_a" then
        propertyValue = RandomInt(1,2)
    elseif propertyName == "rune_a_d" then
        propertyValue = round(baseValue/3, 0)
    else
        propertyValue = baseValue
    end
    if propertyValue < 1 then
        propertyValue = 1
    end

    if slot == 1 then
        itemEntity.property1 = propertyValue
    elseif slot == 2 then
        itemEntity.property2 = propertyValue
    elseif slot == 3 then
        itemEntity.property3 = propertyValue
    elseif slot == 4 then
        itemEntity.property4 = propertyValue
    end
    local runeCheck = string.find(propertyName, "rune_")
    if runeCheck then
        runeName = "#DOTA_Tooltip_ability_flamewaker_"..propertyName
        RPCItems:SetPropertyValues(itemEntity, propertyValue, runeName, "#7DFF12",  slot)
    end 
end

function RPCItems:SkillTranslateVoltex(heroEntity, itemEntity, slot)
    local propertyName = ""
    local runeName = ""
    local propertyValue = 0
    local baseValue = 0
    RPCItems:SetBaseValue(slot, itemEntity, propertyValue)
    if slot == 1 then
        propertyName = itemEntity.property1name
        propertyValue = itemEntity.property1
        baseValue = itemEntity.baseValue1
    elseif slot == 2 then
        propertyName = itemEntity.property2name
        propertyValue = itemEntity.property2
        baseValue = itemEntity.baseValue2
    elseif slot == 3 then
        propertyName = itemEntity.property3name
        propertyValue = itemEntity.property3
        baseValue = itemEntity.baseValue3
    elseif slot == 4 then
        propertyName = itemEntity.property4name
        propertyValue = itemEntity.property4
        baseValue = itemEntity.baseValue4
    end
    if propertyName == "rune_a_a" then
        propertyValue = 1
    else
        propertyValue = baseValue
    end
    if propertyValue < 1 then
        propertyValue = 1
    end

    if slot == 1 then
        itemEntity.property1 = propertyValue
    elseif slot == 2 then
        itemEntity.property2 = propertyValue
    elseif slot == 3 then
        itemEntity.property3 = propertyValue
    elseif slot == 4 then
        itemEntity.property4 = propertyValue
    end
    local runeCheck = string.find(propertyName, "rune_")
    if runeCheck then
        runeName = "#DOTA_Tooltip_ability_voltex_"..propertyName
        RPCItems:SetPropertyValues(itemEntity, propertyValue, runeName, "#7DFF12",  slot)
    end 
end

function RPCItems:SkillTranslateVenomort(heroEntity, itemEntity, slot)
    local propertyName = ""
    local runeName = ""
    local propertyValue = 0
    local baseValue = 0
    RPCItems:SetBaseValue(slot, itemEntity, propertyValue)
    if slot == 1 then
        propertyName = itemEntity.property1name
        propertyValue = itemEntity.property1
        baseValue = itemEntity.baseValue1
    elseif slot == 2 then
        propertyName = itemEntity.property2name
        propertyValue = itemEntity.property2
        baseValue = itemEntity.baseValue2
    elseif slot == 3 then
        propertyName = itemEntity.property3name
        propertyValue = itemEntity.property3
        baseValue = itemEntity.baseValue3
    elseif slot == 4 then
        propertyName = itemEntity.property4name
        propertyValue = itemEntity.property4
        baseValue = itemEntity.baseValue4
    end
    if propertyName == "rune_a_d" then
        propertyValue = RandomInt(1, 3)
    elseif propertyName == "rune_b_a" then
        propertyValue = RandomInt(1, 3)
    else
        propertyValue = baseValue
    end
    if propertyValue < 1 then
        propertyValue = 1
    end

    if slot == 1 then
        itemEntity.property1 = propertyValue
    elseif slot == 2 then
        itemEntity.property2 = propertyValue
    elseif slot == 3 then
        itemEntity.property3 = propertyValue
    elseif slot == 4 then
        itemEntity.property4 = propertyValue
    end
    local runeCheck = string.find(propertyName, "rune_")
    if runeCheck then
        runeName = "#DOTA_Tooltip_ability_venomort_"..propertyName
        RPCItems:SetPropertyValues(itemEntity, propertyValue, runeName, "#7DFF12",  slot)
    end 
end

function RPCItems:SkillTranslateAxe(heroEntity, itemEntity, slot)
    local propertyName = ""
    local runeName = ""
    local propertyValue = 0
    local baseValue = 0
    RPCItems:SetBaseValue(slot, itemEntity, propertyValue)
    if slot == 1 then
        propertyName = itemEntity.property1name
        propertyValue = itemEntity.property1
        baseValue = itemEntity.baseValue1
    elseif slot == 2 then
        propertyName = itemEntity.property2name
        propertyValue = itemEntity.property2
        baseValue = itemEntity.baseValue2
    elseif slot == 3 then
        propertyName = itemEntity.property3name
        propertyValue = itemEntity.property3
        baseValue = itemEntity.baseValue3
    elseif slot == 4 then
        propertyName = itemEntity.property4name
        propertyValue = itemEntity.property4
        baseValue = itemEntity.baseValue4
    end

    if propertyValue < 1 then
        propertyValue = 1
    end

    if slot == 1 then
        itemEntity.property1 = propertyValue
    elseif slot == 2 then
        itemEntity.property2 = propertyValue
    elseif slot == 3 then
        itemEntity.property3 = propertyValue
    elseif slot == 4 then
        itemEntity.property4 = propertyValue
    end
    local runeCheck = string.find(propertyName, "rune_")
    if runeCheck then
        runeName = "#DOTA_Tooltip_ability_axe_"..propertyName
        RPCItems:SetPropertyValues(itemEntity, propertyValue, runeName, "#7DFF12",  slot)
    end 
end

function RPCItems:SkillTranslateAstral(heroEntity, itemEntity, slot)
    local propertyName = ""
    local runeName = ""
    local propertyValue = 0
    local baseValue = 0
    RPCItems:SetBaseValue(slot, itemEntity, propertyValue)
    if slot == 1 then
        propertyName = itemEntity.property1name
        propertyValue = itemEntity.property1
        baseValue = itemEntity.baseValue1
    elseif slot == 2 then
        propertyName = itemEntity.property2name
        propertyValue = itemEntity.property2
        baseValue = itemEntity.baseValue2
    elseif slot == 3 then
        propertyName = itemEntity.property3name
        propertyValue = itemEntity.property3
        baseValue = itemEntity.baseValue3
    elseif slot == 4 then
        propertyName = itemEntity.property4name
        propertyValue = itemEntity.property4
        baseValue = itemEntity.baseValue4
    end

    if propertyValue < 1 then
        propertyValue = 1
    end

    if slot == 1 then
        itemEntity.property1 = propertyValue
    elseif slot == 2 then
        itemEntity.property2 = propertyValue
    elseif slot == 3 then
        itemEntity.property3 = propertyValue
    elseif slot == 4 then
        itemEntity.property4 = propertyValue
    end
    local runeCheck = string.find(propertyName, "rune_")
    if runeCheck then
        runeName = "#DOTA_Tooltip_ability_astral_"..propertyName
        RPCItems:SetPropertyValues(itemEntity, propertyValue, runeName, "#7DFF12",  slot)
    end 
end

function RPCItems:SkillTranslateEpoch(heroEntity, itemEntity, slot)
    local propertyName = ""
    local runeName = ""
    local propertyValue = 0
    local baseValue = 0
    RPCItems:SetBaseValue(slot, itemEntity, propertyValue)
    if slot == 1 then
        propertyName = itemEntity.property1name
        propertyValue = itemEntity.property1
        baseValue = itemEntity.baseValue1
    elseif slot == 2 then
        propertyName = itemEntity.property2name
        propertyValue = itemEntity.property2
        baseValue = itemEntity.baseValue2
    elseif slot == 3 then
        propertyName = itemEntity.property3name
        propertyValue = itemEntity.property3
        baseValue = itemEntity.baseValue3
    elseif slot == 4 then
        propertyName = itemEntity.property4name
        propertyValue = itemEntity.property4
        baseValue = itemEntity.baseValue4
    end
    if propertyName == "rune_b_c" then
        propertyValue = round(baseValue/2, 0)
    else
        propertyValue = baseValue
    end
    if propertyValue < 1 then
        propertyValue = 1
    end

    if slot == 1 then
        itemEntity.property1 = propertyValue
    elseif slot == 2 then
        itemEntity.property2 = propertyValue
    elseif slot == 3 then
        itemEntity.property3 = propertyValue
    elseif slot == 4 then
        itemEntity.property4 = propertyValue
    end
    local runeCheck = string.find(propertyName, "rune_")
    if runeCheck then
        runeName = "#DOTA_Tooltip_ability_epoch_"..propertyName
        RPCItems:SetPropertyValues(itemEntity, propertyValue, runeName, "#7DFF12",  slot)
    end 
end

function RPCItems:SkillTranslatePaladin(heroEntity, itemEntity, slot)
    local propertyName = ""
    local runeName = ""
    local propertyValue = 0
    local baseValue = 0
    RPCItems:SetBaseValue(slot, itemEntity, propertyValue)
    if slot == 1 then
        propertyName = itemEntity.property1name
        propertyValue = itemEntity.property1
        baseValue = itemEntity.baseValue1
    elseif slot == 2 then
        propertyName = itemEntity.property2name
        propertyValue = itemEntity.property2
        baseValue = itemEntity.baseValue2
    elseif slot == 3 then
        propertyName = itemEntity.property3name
        propertyValue = itemEntity.property3
        baseValue = itemEntity.baseValue3
    elseif slot == 4 then
        propertyName = itemEntity.property4name
        propertyValue = itemEntity.property4
        baseValue = itemEntity.baseValue4
    end
    propertyValue = baseValue
    if propertyValue < 1 then
        propertyValue = 1
    end

    if slot == 1 then
        itemEntity.property1 = propertyValue
    elseif slot == 2 then
        itemEntity.property2 = propertyValue
    elseif slot == 3 then
        itemEntity.property3 = propertyValue
    elseif slot == 4 then
        itemEntity.property4 = propertyValue
    end
    local runeCheck = string.find(propertyName, "rune_")
    if runeCheck then
        runeName = "#DOTA_Tooltip_ability_paladin_"..propertyName
        RPCItems:SetPropertyValues(itemEntity, propertyValue, runeName, "#7DFF12",  slot)
    end 
end

function RPCItems:SkillTranslateSorceress(heroEntity, itemEntity, slot)
    local propertyName = ""
    local runeName = ""
    local propertyValue = 0
    local baseValue = 0
    RPCItems:SetBaseValue(slot, itemEntity, propertyValue)
    if slot == 1 then
        propertyName = itemEntity.property1name
        propertyValue = itemEntity.property1
        baseValue = itemEntity.baseValue1
    elseif slot == 2 then
        propertyName = itemEntity.property2name
        propertyValue = itemEntity.property2
        baseValue = itemEntity.baseValue2
    elseif slot == 3 then
        propertyName = itemEntity.property3name
        propertyValue = itemEntity.property3
        baseValue = itemEntity.baseValue3
    elseif slot == 4 then
        propertyName = itemEntity.property4name
        propertyValue = itemEntity.property4
        baseValue = itemEntity.baseValue4
    end

    if propertyValue < 1 then
        propertyValue = 1
    end

    if slot == 1 then
        itemEntity.property1 = propertyValue
    elseif slot == 2 then
        itemEntity.property2 = propertyValue
    elseif slot == 3 then
        itemEntity.property3 = propertyValue
    elseif slot == 4 then
        itemEntity.property4 = propertyValue
    end
    local runeCheck = string.find(propertyName, "rune_")
    if runeCheck then
        runeName = "#DOTA_Tooltip_ability_sorceress_"..propertyName
        RPCItems:SetPropertyValues(itemEntity, propertyValue, runeName, "#7DFF12",  slot)
    end 
end

function RPCItems:SkillTranslateConjuror(heroEntity, itemEntity, slot)
    local propertyName = ""
    local runeName = ""
    local propertyValue = 0
    local baseValue = 0
    RPCItems:SetBaseValue(slot, itemEntity, propertyValue)
    if slot == 1 then
        propertyName = itemEntity.property1name
        propertyValue = itemEntity.property1
        baseValue = itemEntity.baseValue1
    elseif slot == 2 then
        propertyName = itemEntity.property2name
        propertyValue = itemEntity.property2
        baseValue = itemEntity.baseValue2
    elseif slot == 3 then
        propertyName = itemEntity.property3name
        propertyValue = itemEntity.property3
        baseValue = itemEntity.baseValue3
    elseif slot == 4 then
        propertyName = itemEntity.property4name
        propertyValue = itemEntity.property4
        baseValue = itemEntity.baseValue4
    end
    if propertyName == "rune_b_d" then
        propertyValue = RandomInt(1, 3)
    else
        propertyValue = baseValue
    end

    if propertyValue < 1 then
        propertyValue = 1
    end

    if slot == 1 then
        itemEntity.property1 = propertyValue
    elseif slot == 2 then
        itemEntity.property2 = propertyValue
    elseif slot == 3 then
        itemEntity.property3 = propertyValue
    elseif slot == 4 then
        itemEntity.property4 = propertyValue
    end
    local runeCheck = string.find(propertyName, "rune_")
    if runeCheck then
        runeName = "#DOTA_Tooltip_ability_conjuror_"..propertyName
        RPCItems:SetPropertyValues(itemEntity, propertyValue, runeName, "#7DFF12",  slot)
    end 
end

function RPCItems:SkillTranslateMonk(heroEntity, itemEntity, slot)
    local propertyName = ""
    local runeName = ""
    local propertyValue = 0
    local baseValue = 0
    RPCItems:SetBaseValue(slot, itemEntity, propertyValue)
    if slot == 1 then
        propertyName = itemEntity.property1name
        propertyValue = itemEntity.property1
        baseValue = itemEntity.baseValue1
    elseif slot == 2 then
        propertyName = itemEntity.property2name
        propertyValue = itemEntity.property2
        baseValue = itemEntity.baseValue2
    elseif slot == 3 then
        propertyName = itemEntity.property3name
        propertyValue = itemEntity.property3
        baseValue = itemEntity.baseValue3
    elseif slot == 4 then
        propertyName = itemEntity.property4name
        propertyValue = itemEntity.property4
        baseValue = itemEntity.baseValue4
    end

    if propertyValue < 1 then
        propertyValue = 1
    end

    if slot == 1 then
        itemEntity.property1 = propertyValue
    elseif slot == 2 then
        itemEntity.property2 = propertyValue
    elseif slot == 3 then
        itemEntity.property3 = propertyValue
    elseif slot == 4 then
        itemEntity.property4 = propertyValue
    end
    local runeCheck = string.find(propertyName, "rune_")
    if runeCheck then
        runeName = "#DOTA_Tooltip_ability_monk_"..propertyName
        RPCItems:SetPropertyValues(itemEntity, propertyValue, runeName, "#7DFF12",  slot)
    end 
end

function RPCItems:SkillTranslateBasic(heroEntity, itemEntity, slot, tooltipName)
    local propertyName = ""
    local runeName = ""
    local propertyValue = 0
    local baseValue = 0
    RPCItems:SetBaseValue(slot, itemEntity, propertyValue)
    if slot == 1 then
        propertyName = itemEntity.property1name
        propertyValue = itemEntity.property1
        baseValue = itemEntity.baseValue1
    elseif slot == 2 then
        propertyName = itemEntity.property2name
        propertyValue = itemEntity.property2
        baseValue = itemEntity.baseValue2
    elseif slot == 3 then
        propertyName = itemEntity.property3name
        propertyValue = itemEntity.property3
        baseValue = itemEntity.baseValue3
    elseif slot == 4 then
        propertyName = itemEntity.property4name
        propertyValue = itemEntity.property4
        baseValue = itemEntity.baseValue4
    end

    if propertyValue < 1 then
        propertyValue = 1
    end

    if slot == 1 then
        itemEntity.property1 = propertyValue
    elseif slot == 2 then
        itemEntity.property2 = propertyValue
    elseif slot == 3 then
        itemEntity.property3 = propertyValue
    elseif slot == 4 then
        itemEntity.property4 = propertyValue
    end
    local runeCheck = string.find(propertyName, "rune_")
    if runeCheck then
        runeName = tooltipName..propertyName
        print(runeName)
        RPCItems:SetPropertyValues(itemEntity, propertyValue, runeName, "#7DFF12", slot)
    end 
end


SUFFIX_TIER_1_SKILL_TABLE = {"of Temperament", "of the Twilight Gaze", "of Heroes", "of Champions", "of the Light"}
SUFFIX_TIER_2_SKILL_TABLE = {"of the Dark Arts", "of the Old Master", "of the Wild Reach", "of the Silent Watch", "of the Secret Order"}

PREFIX_TIER_1_SKILL_TABLE = {"Ivory", "Spirit", "Sanctified", "Dire", "Radiant"}
PREFIX_TIER_2_SKILL_TABLE = {"Stormsoul", "Bloodstone", "Goldstone", "Red Sky", "Wildtouch"}

function RPCItems:RollAmuletProperty1(item, xpBounty, randomHelm)
    local statOrSkill = RandomInt(0,100)
    if statOrSkill < 80 then
    if Dungeons.itemLevel > 0 then
        maxFactor = Dungeons.itemLevel
    else
        maxFactor = Events.WaveNumber
    end
    local luck = RandomInt(0,100)
        if luck < 34 then
        	local bonus = RPCItems:GetHeadBonusRoll(randomHelm, 3, 4)
            value, suffixLevel = RPCItems:RollAttribute(xpBounty, 1, 3+bonus, 0, 0, item.rarity, false, maxFactor*10)
            item.property1 = value
            item.property1name = "strength"
            suffix = SUFFIX_HOOD_STRENGTH_TABLE[suffixLevel]
            RPCItems:SetPropertyValues(item, item.property1, "#item_strength", "#CC0000",  1)
        elseif luck >= 34 and luck < 67 then
        	local bonus = RPCItems:GetHeadBonusRoll(randomHelm, 2, 4)
            value, suffixLevel = RPCItems:RollAttribute(xpBounty, 1, 3+bonus, 0, 0, item.rarity, false, maxFactor*10)
            item.property1 = value
            item.property1name = "agility"
            suffix = SUFFIX_HOOD_AGILITY_TABLE[suffixLevel]
            RPCItems:SetPropertyValues(item, item.property1, "#item_agility", "#2EB82E",  1)
        elseif luck >= 67 then
        	local bonus = RPCItems:GetHeadBonusRoll(randomHelm, 1, 4)
            value, suffixLevel = RPCItems:RollAttribute(xpBounty, 1, 3+bonus, 0, 0, item.rarity, false, maxFactor*10)
            item.property1 = value
            item.property1name = "intelligence"
            suffix = SUFFIX_HOOD_INTELLIGENCE_TABLE[suffixLevel]
            RPCItems:SetPropertyValues(item, item.property1, "#item_intelligence", "#33CCFF",  1)
        end
        return 0, 0, suffix
    else
        return RPCItems:RollSkillProperty()
    end
end

function RPCItems:RollAmuletProperty2(item, xpBounty, randomHelm)
    local statOrSkill = RandomInt(0,100)
    if statOrSkill < 70 then
    if Dungeons.itemLevel > 0 then
        maxFactor = Dungeons.itemLevel
    else
        maxFactor = Events.WaveNumber
    end
    local luck = RandomInt(0,100)
        if luck < 34 then
            local bonus = 2
            value, prefixLevel = RPCItems:RollAttribute(xpBounty, 1, 3+bonus, 0, 0, item.rarity, false, maxFactor*10)
            item.property2 = value
            item.property2name = "strength"
            prefix = PREFIX_HOOD_STRENGTH_TABLE[prefixLevel]
            RPCItems:SetPropertyValues(item, item.property2, "#item_strength", "#CC0000",  2)
        elseif luck >= 34 and luck < 67 then
            local bonus = 2
            value, prefixLevel = RPCItems:RollAttribute(xpBounty, 1, 3+bonus, 0, 0, item.rarity, false, maxFactor*10)
            item.property2 = value
            item.property2name = "agility"
            prefix = PREFIX_HOOD_AGILITY_TABLE[prefixLevel]
            RPCItems:SetPropertyValues(item, item.property2, "#item_agility", "#2EB82E",  2)
        elseif luck >= 67 then
            local bonus = 2
            value, prefixLevel = RPCItems:RollAttribute(xpBounty, 1, 3+bonus, 0, 0, item.rarity, false, maxFactor*10)
            item.property2 = value
            item.property2name = "intelligence"
            prefix = PREFIX_HOOD_INTELLIGENCE_TABLE[prefixLevel]
            RPCItems:SetPropertyValues(item, item.property2, "#item_intelligence", "#33CCFF",  2)
        end
        return 0, 0, prefix
    else
        return RPCItems:RollSkillProperty()
    end
end

function RPCItems:RollSkillProperty()
    local luck = RandomInt(0,905)
    local luck2 = RandomInt(1, 100)
    local propertyName = ""
    local propertyTitle = ""
    local tier = 0
    if Dungeons.itemLevel > 0 then
        maxFactor = Dungeons.itemLevel
    else
        maxFactor = Events.WaveNumber
    end
    if luck2 < 20 then
        value = RandomInt(1, 3)
    elseif luck2 < 50 then
        value = RandomInt(2, 4)
    elseif luck2 < 80 then
        value = RandomInt(3, 5)
    elseif luck2 < 95 then
        value = RandomInt(4, 7)
    elseif luck2 <= 100 then
        value = RandomInt(4, 10)
    end
    if luck < 120 then
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
    value = value + RandomInt(0, math.floor(maxFactor/4))
    return tier, value, propertyName
end



