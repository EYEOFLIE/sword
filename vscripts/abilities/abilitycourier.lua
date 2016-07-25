

item_compose_table = {
	["sixiangxianjia"]={
		["index"] = 1,
		["composeItem"] = "item_0106" ,
		["requestItem"] = {"item_0098"},
	},
	
}

item_gem_compose_table = {
	["item_1004"]={
		["index"] = 1,
		["composeItem"] = "item_1004" , 
		["requestItem"] = {"item_1001","item_1001","item_1001"},
	},	
}

function OnCourierComposeSpellStart(keys)
	local caster = keys.caster
	local playerID = caster:GetPlayerOwnerID()

	local player = caster:GetPlayerOwner()
	if player == nil then return end
	local hero = player:GetAssignedHero()
	if hero == nil then return end

    hsj_courier_item_compose(hero)
end

function OnCourierDecomposeSpellStart(keys)
	local caster = keys.caster
	local playerID = caster:GetPlayerOwnerID()

	local player = caster:GetPlayerOwner()
	if player == nil then return end
	local hero = player:GetAssignedHero()
	if hero == nil then return end

	local item = nil
	if keys.item == nil then
		local itemIndex = Backpack:GetItemIndex( hero, 1 )
		item = EntIndexToHScript(itemIndex)
	else
		item = keys.item
	end

    hsj_courier_item_decompose(hero,item)
end

ENHANCE_REASON_SUCCEED = 0
ENHANCE_FAILURE_REASON_LACK_OF_MATERAIL = 1
ENHANCE_FAILURE_REASON_LACK_OF_ITEM = 2
ENHANCE_FAILURE_REASON_DOWN_LEVEL = 3
ENHANCE_FAILURE_REASON_RESET_LEVEL = 4
ENHANCE_FAILURE_REASON_DESTORY = 5
ENHANCE_FAILURE_REASON_LEVEL_MAX = 6
ENHANCE_FAILURE_REASON_SAFE = 7


function OnCourierEnhanceSpellStart(keys)
	local caster = keys.caster
	local playerID = caster:GetPlayerOwnerID()
	local nReason = -1

	local player = caster:GetPlayerOwner()
	if player == nil then return end
	local hero = player:GetAssignedHero()
	if hero == nil then return end

	local item = nil
	if keys.item == nil then
		local itemIndex = Backpack:GetItemIndex( hero, 1 )
		item = EntIndexToHScript(itemIndex)
	else
		item = keys.item
	end

	nReason = hsj_courier_item_enhance(hero,item)

	if nReason == ENHANCE_REASON_SUCCEED then
		CPlayerMessage:SendMessage(hero:GetEntityIndex(),"#hsj_game_ui_strengthen_info_1",{level=tostring(item.level)} )
	elseif nReason == ENHANCE_FAILURE_REASON_LACK_OF_MATERAIL then
		PlayerResource:ModifyGold( playerID, 200 , false, DOTA_ModifyGold_AbilityCost)
		CPlayerMessage:SendMessage(hero:GetEntityIndex(),"#hsj_game_ui_strengthen_info_2")
	elseif nReason == ENHANCE_FAILURE_REASON_LACK_OF_ITEM then
		PlayerResource:ModifyGold( playerID, 200 , false, DOTA_ModifyGold_AbilityCost)
		CPlayerMessage:SendMessage(hero:GetEntityIndex(),"#hsj_game_ui_strengthen_info_3")
	elseif nReason == ENHANCE_FAILURE_REASON_DOWN_LEVEL then
		CPlayerMessage:SendMessage(hero:GetEntityIndex(),"#hsj_game_ui_strengthen_info_4",{level=tostring(item.level)})
	elseif nReason == ENHANCE_FAILURE_REASON_RESET_LEVEL then
		CPlayerMessage:SendMessage(hero:GetEntityIndex(),"#hsj_game_ui_strengthen_info_5",{level=tostring(item.level)})
	elseif nReason == ENHANCE_FAILURE_REASON_DESTORY then
		CPlayerMessage:SendMessage(hero:GetEntityIndex(),"#hsj_game_ui_strengthen_info_6")
	elseif nReason == ENHANCE_FAILURE_REASON_LEVEL_MAX then
		PlayerResource:ModifyGold( playerID, 200 , false, DOTA_ModifyGold_AbilityCost)
		CPlayerMessage:SendMessage(hero:GetEntityIndex(),"#hsj_game_ui_strengthen_info_7",{level=tostring(item.level)})
	elseif nReason == ENHANCE_FAILURE_REASON_SAFE then
		CPlayerMessage:SendMessage(hero:GetEntityIndex(),"#hsj_game_ui_strengthen_info_8")
	end
end

function OnCourierEnhanceInterrupted(keys)
	local caster = keys.caster
	local playerID = caster:GetPlayerOwnerID()
	PlayerResource:ModifyGold( playerID, 200 , false, DOTA_ModifyGold_AbilityCost)
end

function GetItemMaterialName(item)
	local itemKind = GetItemKind(item)
	if itemKind ~= nil then
		local materialType = nil

		if itemKind >= ITEM_KIND_SWORD and itemKind <= ITEM_KIND_BOW then
			materialType =  1
		end
		if itemKind >= ITEM_KIND_SHOES and itemKind <= ITEM_KIND_HAT then
			materialType =  2
		end
		if itemKind >= ITEM_KIND_TRINKET and itemKind <= ITEM_KIND_TALISMAN then
			materialType =  3
		end

		local quality = GetItemQuality(item)
		local materialItem = nil

		if quality ~= nil and materialType ~= nil then
			if quality <= 3 and quality >= 1 then
				materialItem = "item_100"..tostring(materialType)
			elseif quality <= 5 and quality >= 4 then
				materialItem = "item_100"..tostring(materialType + 3)
			elseif quality <= 8 and quality >= 6 then
				materialItem = "item_100"..tostring(materialType + 6)
			end

			return materialItem
		end
	end
	return nil
end

function hsj_courier_item_decompose(courier, item)
	local playerID = courier:GetPlayerOwnerID()
	if item ~= nil then
		local materialItem = GetItemMaterialName(item) 
		if materialItem ~= nil then


			if UIHasItem(courier,item) then
				courier:RemoveItem(item)
			else
				Backpack:ConsumeItem(courier,item)
			end

			Backpack:CreateItem( courier, materialItem )

			-- CustomGameEventManager:Send_ServerToPlayer(courier:GetPlayerOwner(),"hsj_ui_event_decompose_item_return",{itemname=materialItem})
		end
	end
end

function hsj_courier_item_enhance(courier,item)

	if item == nil then 
		return ENHANCE_FAILURE_REASON_LACK_OF_ITEM
	end

	local materialItemName = GetItemMaterialName(item) 
	local itemInslot
	local materialItem = nil

	-- if materialItemName ~= nil then
	-- 	for item_slot = 0,5 do
	-- 		itemInslot = courier:GetItemInSlot(item_slot)
	-- 		if itemInslot ~= nil then
	-- 			if itemInslot:GetAbilityName() == materialItemName then
	-- 				materialItem = itemInslot
	-- 				break
	-- 			end
	-- 		end
	-- 	end
	-- end

	-- 遍历背包
	Backpack:Traverse( courier, function(pack,packIndex,itemIndex)
		local packItem = EntIndexToHScript(itemIndex)
		if packItem then
			local itemName = packItem:GetAbilityName()
			if itemName == materialItemName then
				materialItem = packItem
				return true
			end
		end
	end )

	if materialItem ~= nil then
		-- courier:RemoveItem(materialItem)
		Backpack:ConsumeItem( courier, materialItem )
		local itemKind = GetItemKind(item)
		local randomInt = RandomInt(0,100)

		local cap = Backpack:FindItemByName( courier, "item_1024" )

		if cap then
			randomInt = randomInt - 15
		end

		if item.level == nil then
			item.level = 0
		end
		if item.level >=0 and item.level <= 3 then
			item.level = item.level + 1
		elseif item.level >= 4 and item.level <= 6 then
			if randomInt >= 75 then
				
				--
				local stone = Backpack:FindItemByName( courier, "item_1010" )
				if stone then
					Backpack:ConsumeItem( courier, stone )
					return ENHANCE_FAILURE_REASON_SAFE
				end

				item.level = item.level - 1
				return ENHANCE_FAILURE_REASON_DOWN_LEVEL
			else
				item.level = item.level + 1
			end
		elseif item.level >= 6 and item.level <= 8  then
			if randomInt >= 50 then

				-- 
				local stone = Backpack:FindItemByName( courier, "item_1010" )
				if stone then
					Backpack:ConsumeItem( courier, stone )
					return ENHANCE_FAILURE_REASON_SAFE
				end

				item.level = 0
				return ENHANCE_FAILURE_REASON_RESET_LEVEL
			else
				item.level = item.level + 1
			end
		elseif item.level >= 8 and item.level <= 12  then
			if randomInt >= 40 then

				-- 
				local stone = Backpack:FindItemByName( courier, "item_1010" )
				if stone and item.level < 10 then
					Backpack:ConsumeItem( courier, stone )
					return ENHANCE_FAILURE_REASON_SAFE
				end
				
				courier:RemoveItem(item)
				return ENHANCE_FAILURE_REASON_DESTORY
			else
				item.level = item.level + 1
			end
		elseif item.level >= 13 and item.level < 15  then
			if randomInt >= 33 then
				courier:RemoveItem(item)
				return ENHANCE_FAILURE_REASON_DESTORY
			else
				item.level = item.level + 1
			end
		elseif item.level == 15 then
			return ENHANCE_FAILURE_REASON_LEVEL_MAX
		end
	else
		return ENHANCE_FAILURE_REASON_LACK_OF_MATERAIL
	end
	return ENHANCE_REASON_SUCCEED
end

function hsj_hero_item_extra_attribute(hero)
	local itemExtraAttributeTable = {
				str = 0,
				agi	= 0,
				int = 0,
				hp = 0,
				mana = 0,
				armor = 0,
				magic_armor = 0,
				health_regen = 0,
				mana_regen = 0,
				attack_speed = 0,
				move_speed = 0,
				move_speed_percent = 0,
				equip_state = 0,
				sword_equip_state = 0,
				blade_equip_state = 0,
				stick_equip_state = 0,
				magic_equip_state = 0,
				bow_equip_state = 0,
				cooldown = 0,
				energy = 0,
				avoid = 0,
		}

	for i=0,5 do
		local item = hero:GetItemInSlot(i)
		if item ~= nil and item.level ~= nil and item.level > 0 then
			local heroItemExtraAttributeTable = {
					str = 0,
					agi	= 0,
					int = 0,
					hp = 0,
					mana = 0,
					armor = 0,
					magic_armor = 0,
					health_regen = 0,
					mana_regen = 0,
					attack_speed = 0,
					move_speed = 0,
					move_speed_percent = 0,
					equip_state = 0,
					sword_equip_state = 0,
					blade_equip_state = 0,
					stick_equip_state = 0,
					magic_equip_state = 0,
					bow_equip_state = 0,
					cooldown = 0,
					energy = 0,
					avoid = 0,
			}
			hsj_AddItemExtraAttribute( itemExtraAttributeTable , item )
			hsj_AddItemExtraAttribute( heroItemExtraAttributeTable , item )

			local itemNetIndex = "itemsSpecials"..tostring(item:GetEntityIndex());
			local itemsSpecials = CustomNetTables:GetTableValue("Shops", itemNetIndex);

			if itemsSpecials == nil then 
				CustomNetTables:SetTableValue("Shops", itemNetIndex, {}) 
				itemsSpecials = CustomNetTables:GetTableValue("Shops", itemNetIndex)
			end

			itemsSpecials.specials = GameRules.m_ItemData_GetSpecialData( GameRules.m_ItemData_Items[item:GetAbilityName()] )
			itemsSpecials.itemExtraAttributeTable = heroItemExtraAttributeTable;
			itemsSpecials.level = item.level

			CustomNetTables:SetTableValue("Shops", itemNetIndex, itemsSpecials)
		end
	end

	Backpack:Traverse( hero, function(pack,packIndex,itemIndex)
		local item = EntIndexToHScript(itemIndex)
		if item ~= nil and item.level ~= nil and item.level > 0 then
			local heroItemExtraAttributeTable = {
					str = 0,
					agi	= 0,
					int = 0,
					hp = 0,
					mana = 0,
					armor = 0,
					magic_armor = 0,
					health_regen = 0,
					mana_regen = 0,
					attack_speed = 0,
					move_speed = 0,
					move_speed_percent = 0,
					equip_state = 0,
					sword_equip_state = 0,
					blade_equip_state = 0,
					stick_equip_state = 0,
					magic_equip_state = 0,
					bow_equip_state = 0,
					cooldown = 0,
					energy = 0,
					avoid = 0,
			}
			hsj_AddItemExtraAttribute( heroItemExtraAttributeTable , item )

			local itemNetIndex = "itemsSpecials"..tostring(item:GetEntityIndex());
			local itemsSpecials = CustomNetTables:GetTableValue("Shops", itemNetIndex);

			if itemsSpecials == nil then 
				CustomNetTables:SetTableValue("Shops", itemNetIndex, {}) 
				itemsSpecials = CustomNetTables:GetTableValue("Shops", itemNetIndex)
			end

			itemsSpecials.specials = GameRules.m_ItemData_GetSpecialData( GameRules.m_ItemData_Items[item:GetAbilityName()] )
			itemsSpecials.itemExtraAttributeTable = heroItemExtraAttributeTable;
			itemsSpecials.level = item.level

			CustomNetTables:SetTableValue("Shops", itemNetIndex, itemsSpecials)

			return true
		end
	end )

	hsj_SetItemExtraAttribute( hero,itemExtraAttributeTable )
end

function hsj_AddItemExtraAttribute( itemExtraAttributeTable , item )
	local itemKind = GetItemKind(item)
	local stageTable = {
		stage1 = {},
		stage2 = {},
		stage3 = {},
		stage4 = {},
		stage5 = {}
	}

	if itemKind == ITEM_KIND_SWORD then
		stageTable.stage1 = {
				str = 5,
				agi = 5,
			  	int = 5
			}
		stageTable.stage2 = {
			  	str = 5,
				agi = 10,
			  	int = 5
			}
		stageTable.stage3 = {
				str = 10,
				agi = 20,
			  	int = 10,
			  	attack_speed = 30,
			  	sword_equip_state = 1
			}
		stageTable.stage4 = {
				str = 20,
				agi = 40,
			  	int = 20,
			  	attack_speed = 50,
			  	sword_equip_state = 3
			}
		stageTable.stage5 = {
				str = 40,
				agi = 80,
			  	int = 40,
			  	attack_speed = 70,
			  	sword_equip_state = 5
			}
	elseif itemKind == ITEM_KIND_KNIFE then
		stageTable.stage1 = {
				str = 5,
				agi = 5,
			  	int = 5
			}
		stageTable.stage2 = {
			  	str = 10,
				agi = 5,
			  	int = 5
			}
		stageTable.stage3 = {
				str = 20,
				agi = 10,
			  	int = 10,
			  	attack_speed = 30,
			  	blade_equip_state = 1
			}
		stageTable.stage4 = {
				str = 40,
				agi = 20,
			  	int = 20,
			  	attack_speed = 50,
			  	blade_equip_state = 3
			}
		stageTable.stage5 = {
				str = 40,
				agi = 80,
			  	int = 40,
			  	attack_speed = 70,
			  	blade_equip_state = 5
			}
	elseif itemKind == ITEM_KIND_STICK then
		stageTable.stage1 = {
				str = 5,
				agi = 5,
			  	int = 5
			}
		stageTable.stage2 = {
			  	str = 10,
				agi = 5,
			  	int = 5
			}
		stageTable.stage3 = {
				str = 20,
				agi = 10,
			  	int = 10,
			  	attack_speed = 30,
			  	stick_equip_state = 1
			}
		stageTable.stage4 = {
				str = 40,
				agi = 20,
			  	int = 20,
			  	attack_speed = 50,
			  	stick_equip_state = 3
			}
		stageTable.stage5 = {
				str = 40,
				agi = 80,
			  	int = 40,
			  	attack_speed = 70,
			  	stick_equip_state = 5
			}
	elseif itemKind == ITEM_KIND_MAGIC then
		stageTable.stage1 = {
				str = 5,
				agi = 5,
			  	int = 5
			}
		stageTable.stage2 = {
			  	str = 5,
				agi = 5,
			  	int = 10
			}
		stageTable.stage3 = {
				str = 10,
				agi = 10,
			  	int = 20,
			  	attack_speed = 30,
			  	magic_equip_state = 1
			}
		stageTable.stage4 = {
				str = 20,
				agi = 20,
			  	int = 40,
			  	attack_speed = 50,
			  	magic_equip_state = 3
			}
		stageTable.stage5 = {
				str = 40,
				agi = 40,
			  	int = 80,
			  	attack_speed = 70,
			  	magic_equip_state = 5
			}
	elseif itemKind == ITEM_KIND_BOW then
		stageTable.stage1 = {
				str = 5,
				agi = 5,
			  	int = 5
			}
		stageTable.stage2 = {
			  	str = 5,
				agi = 10,
			  	int = 5
			}
		stageTable.stage3 = {
				str = 10,
				agi = 20,
			  	int = 10,
			  	attack_speed = 30,
			  	bow_equip_state = 1
			}
		stageTable.stage4 = {
				str = 20,
				agi = 40,
			  	int = 20,
			  	attack_speed = 50,
			  	bow_equip_state = 3
			}
		stageTable.stage5 = {
				str = 40,
				agi = 80,
			  	int = 40,
			  	attack_speed = 70,
			  	bow_equip_state = 5
			}
	elseif itemKind == ITEM_KIND_SHOES then
		stageTable.stage1 = {
			  	armor = 5,
			  	move_speed = 5
			}
		stageTable.stage2 = {
			  	armor = 10,
			  	move_speed = 10
			}
		stageTable.stage3 = {
				armor = 15,
			  	move_speed = 20,
			  	avoid = 3,
			  	move_speed_percent = 5
			}
		stageTable.stage4 = {
				armor = 20,
			  	move_speed = 25,
			  	avoid = 5,
			  	move_speed_percent = 7
			}
		stageTable.stage5 = {
				armor = 40,
			  	move_speed = 30,
			  	avoid = 7,
			  	move_speed_percent = 9
			}
	elseif itemKind == ITEM_KIND_CLOTHES then
		stageTable.stage1 = {
			  	armor = 10,
			  	hp = 250
			}
		stageTable.stage2 = {
			  	armor = 15,
			  	hp = 500
			}
		stageTable.stage3 = {
				armor = 20,
			  	hp = 750
			}
		stageTable.stage4 = {
				armor = 25,
			  	hp = 1500
			}
		stageTable.stage5 = {
				armor = 30,
			  	hp = 3000
			}
	elseif itemKind == ITEM_KIND_HAT then
		stageTable.stage1 = {
			  	armor = 5,
			  	health_regen = 25
			}
		stageTable.stage2 = {
			  	armor = 10,
			  	health_regen = 50
			}
		stageTable.stage3 = {
				armor = 15,
			  	health_regen = 100
			}
		stageTable.stage4 = {
				armor = 20,
			  	health_regen = 200
			}
		stageTable.stage5 = {
				armor = 25,
			  	health_regen = 400
			}
	elseif itemKind == ITEM_KIND_TRINKET then
		stageTable.stage1 = {
				str = 5,
				agi = 5,
			  	int = 5
			}
		stageTable.stage2 = {
			  	str = 7,
				agi = 7,
			  	int = 7
			}
		stageTable.stage3 = {
				str = 10,
				agi = 10,
			  	int = 10,
			}
		stageTable.stage4 = {
				str = 20,
				agi = 20,
			  	int = 20,
			  	equip_state = 1
			}
		stageTable.stage5 = {
				str = 40,
				agi = 40,
			  	int = 40,
			  	equip_state = 2
			}
	elseif itemKind == ITEM_KIND_TALISMAN then
		
		stageTable.stage1 = {
				str = 5,
				agi = 5,
				int = 5,
			}
		stageTable.stage2 = {
			 	str = 7,
				agi = 7,
				int = 7
			}
		stageTable.stage3 = {
				str = 10,
				agi = 10,
			  	int = 10,
			}
		stageTable.stage4 = {
				str = 20,
				agi = 20,
			  	int = 20,
			  	equip_state = 1
			}
		stageTable.stage5 = {
				str = 40,
				agi = 40,
			  	int = 40,
			  	equip_state = 2
			}
	end
	if item.level > 0 then
		for k1,v1 in pairs(stageTable.stage1) do
			itemExtraAttributeTable[k1] = itemExtraAttributeTable[k1] + v1 * math.min(3,item.level)
		end
	end
	if item.level >= 4 then
		for k2,v2 in pairs(stageTable.stage2) do
			itemExtraAttributeTable[k2] = itemExtraAttributeTable[k2] + v2 * (math.min(6,item.level) - 3)
		end
	end
	if item.level >= 6 then
		for k3,v3 in pairs(stageTable.stage3) do
			itemExtraAttributeTable[k3] = itemExtraAttributeTable[k3] + v3 * (math.min(8,item.level) - 6)
		end
	end
	if item.level >= 8 then
		for k4,v4 in pairs(stageTable.stage4) do
			itemExtraAttributeTable[k4] = itemExtraAttributeTable[k4] + v4 * (math.min(12,item.level) - 8)
		end
	end
	if item.level >= 12 then
		for k5,v5 in pairs(stageTable.stage5) do
			itemExtraAttributeTable[k5] = itemExtraAttributeTable[k5] + v5 * (math.min(15,item.level) - 12)
		end
	end
end

function hsj_SetItemExtraAttribute( hero,itemExtraAttribute )
	local ability = hero:FindAbilityByName("ability_custom_hero_state")

	for k,v in pairs(itemExtraAttribute) do 
		if v ~= 0 then
			if not hero:HasModifier("passive_hsj_item_extra_"..k ) then
				ability:ApplyDataDrivenModifier(hero, hero, "passive_hsj_item_extra_"..k, nil)
			end
			if hero:GetModifierStackCount("passive_hsj_item_extra_"..k,hero) ~= v then
				hero:SetModifierStackCount("passive_hsj_item_extra_"..k , ability, v)
			end
		else
			if hero:HasModifier("passive_hsj_item_extra_"..k ) then
				hero:RemoveModifierByName("passive_hsj_item_extra_"..k )
			end
		end
	end
end

function hsj_courier_item_compose(courier)
	local playerID = courier:GetPlayerOwnerID()
	local isComposed = false
	local item_slot
	local composeItem = {}
	local item
	for k,v in pairs(item_compose_table) do
		for k1,v1 in pairs(v["requestItem"]) do

			Backpack:Traverse( courier, function(pack,packIndex,itemIndex)
				local packItem = EntIndexToHScript(itemIndex)
				if packItem then
					local isChecked = false
					for k3,v3 in pairs(composeItem) do
						if packItem == v3 then
							isChecked = true
						end
					end
					if packItem:GetAbilityName() == v1 and (not isChecked) then
						table.insert(composeItem,packItem)
						return true
					end
				end
			end )
		end

		if (#composeItem) == (#v["requestItem"]) then
				
			for k2,v2 in pairs(composeItem) do
				if UIHasItem(courier,v2) then
					courier:RemoveItem(v2)
				else
					Backpack:ConsumeItem(courier,v2)
				end
			end

			-- local addItem = CreateItem(v["composeItem"], courier:GetOwner(), courier:GetOwner())
			-- courier:AddItem(addItem)
			Backpack:CreateItem( courier, v["composeItem"] )

			isComposed = true
		end
		composeItem = {}
	end
	if isComposed == false then
		PlayerResource:ModifyGold( playerID, 2000 , false, DOTA_ModifyGold_AbilityCost)
	end
end

function hsj_courier_item_compose_gem(keys)
	local caster = keys.caster

	local player = caster:GetPlayerOwner()
	if player == nil then return end
	local courier = player:GetAssignedHero()
	if courier == nil then return end

	local playerID = courier:GetPlayerOwnerID()
	local isComposed = false
	local item_slot
	local composeItem = {}
	local item
	for k,v in pairs(item_gem_compose_table) do
		for k1,v1 in pairs(v["requestItem"]) do

			Backpack:Traverse( courier, function(pack,packIndex,itemIndex)
				local packItem = EntIndexToHScript(itemIndex)
				if packItem then
					local isChecked = false
					for k3,v3 in pairs(composeItem) do
						if packItem == v3 then
							isChecked = true
						end
					end
					if packItem:GetAbilityName() == v1 and (not isChecked) then
						table.insert(composeItem,packItem)
						return true
					end
				end
			end )
		end

		if (#composeItem) == (#v["requestItem"]) then
				
			for k2,v2 in pairs(composeItem) do
				if UIHasItem(courier,v2) then
					courier:RemoveItem(v2)
				else
					Backpack:ConsumeItem(courier,v2)
				end
			end

			-- local addItem = CreateItem(v["composeItem"], courier:GetOwner(), courier:GetOwner())
			-- courier:AddItem(addItem)
			Backpack:CreateItem( courier, v["composeItem"] )

			isComposed = true
		end
		composeItem = {}
	end
end

local BaseBuildingLevel = 1
function OnCourierUpgradeBaseSpellStart(keys)
	if BaseBuildingLevel>=20 then
		PlayerResource:ModifyGold( keys.caster:GetPlayerOwnerID(), 2000 , false, DOTA_ModifyGold_AbilityCost)
		
		CustomGameEventManager:Send_ServerToPlayer(
			keys.caster:GetPlayerOwner(),
			"avalon_game_ui_show_bottom_message",
			{text="#limit_base_building_level",r=255,g=0,b=0})
		return
	end
	local caster = keys.caster
	local base = Entities:FindByName(nil, "dota_goodguys_fort")
	local ability = base:FindAbilityByName("ability_custom_base_state")
	local hp = base:GetMaxHealth() + 2000 --base:GetModifierStackCount("passive_hsj_base_hp",base)
	local armor = base:GetModifierStackCount("passive_hsj_base_armor",base)
	local health_regen = base:GetModifierStackCount("passive_hsj_base_health_regen",base)

	--base:SetModifierStackCount("passive_hsj_base_hp", ability, hp + 2000)
	base:SetBaseMaxHealth(hp)
	base:SetMaxHealth(hp)
	base:SetHealth(base:GetHealth() + 2000)
	base:SetModifierStackCount("passive_hsj_base_armor", ability, armor + 50)
	base:SetModifierStackCount("passive_hsj_base_health_regen", ability, health_regen + 10)

	BaseBuildingLevel = BaseBuildingLevel + 1
	
	local BaseInfo = CustomNetTables:GetTableValue("HeroInfo", "BaseBuilding")
	BaseInfo.Level = BaseBuildingLevel
	CustomNetTables:SetTableValue("HeroInfo", "BaseBuilding", BaseInfo)

end

function OnCourierPauseSpawnSpellStart(keys)
	local caster = keys.caster
    local GameMode = GameRules:GetGameModeEntity() 
    GameMode.SpawnPauseTime = true
    local couriers = Entities:FindAllByClassname("npc_dota_creature")
    for k,v in pairs(couriers) do
    	local ability = v:FindAbilityByName("ability_courier_pause_spawn") 
    	if ability ~= nil then
    		ability:StartCooldown(600)
    	end
    end
end

function SaveComposeTableToNetTable()

	local count = 0
	for k,v in pairs(item_compose_table) do
		local t = {}

		t.source = k
		t.composeItem = v.composeItem
		t.value = {
			composeItem = v.composeItem,
			requestItem = v.requestItem
		}

		count = count + 1

		CustomNetTables:SetTableValue("ComposeInfo","Compose"..tostring(v.index),t)
	end
	
	local gem_count = 0
	for k,v in pairs(item_gem_compose_table) do
		local t = {}

		t.isGem = 1
		t.source = k
		t.value = {
			composeItem = v.composeItem,
			requestItem = v.requestItem
		}

		gem_count = gem_count + 1

		CustomNetTables:SetTableValue("ComposeInfo","GemCompose"..tostring(v.index),t)
	end

	CustomNetTables:SetTableValue("ComposeInfo","Count",{ComposeCount=count,GemComposeCount=gem_count})

end
SaveComposeTableToNetTable()
