item_suit_table = {
	["chudaotaozhuang"]={
		["suitAttribute"] = {
				["bonus_strength"] = 5,
				["bonus_agility"]	= 5,
				["bonus_intellect"] = 5,
				["bonus_damage"] = 5,
				["bonus_speed"]=100,
			},
		["requestItem"] = {"item_1009","item_1008","item_1007"},
	},

}

function SetSuitNetTable()
	for k,v in pairs(item_suit_table) do
		for k1,v1 in pairs(v["requestItem"]) do
			local itemData = CustomNetTables:GetTableValue("SuitInfo", "suitAttribute_"..v1)

			if itemData == nil then itemData = {} end

			itemData = {
				bonus_strength = 0,
				bonus_agility = 0,
				bonus_intellect = 0,
				bonus_damage=0,
				bonus_speed=0,
			}

			for k,v in pairs(v["suitAttribute"]) do
				itemData[k] = itemData[k] + v
			end

			itemData.specials = GameRules.m_ItemData_GetSpecialData( GameRules.m_ItemData_Items[v1] )
			itemData.requestItem = v["requestItem"];

			CustomNetTables:SetTableValue("SuitInfo", "suitAttribute_"..v1, itemData)
		end
	end
end




function SetSuitAttribute( hero )
		local item_slot
        local composeItem = {}
        local suitAttributeTable = {
                    bonus_strength = 0,
                    bonus_agility = 0,
                    bonus_intellect = 0,
                    bonus_damage=0,
                    bonus_speed=0,
                }
        local item
        if item_suit_table then
            
            for k,v in pairs(item_suit_table) do
                
                for k1,v1 in pairs(v["requestItem"]) do
                    
                    for item_slot = 0,5 do
                        item = hero:GetItemInSlot(item_slot)
                        if item ~= nil then
                        
                            if item:GetAbilityName() == v1 then

                                table.insert(composeItem,item)
                                break
                            end
                        end
                    end
                end
                if (#composeItem) == (#v["requestItem"]) then

                    for k2,v2 in pairs(v["suitAttribute"]) do
                        suitAttributeTable[k2] = suitAttributeTable[k2] + v2
                        --hasSuit = true
                    end
                end
                composeItem = {}
            end
         CustomNetTables:SetTableValue( "custom_suit_state", string.format( "%d", hero:GetEntityIndex() ), { bonus_damage = suitAttributeTable['bonus_damage'],
         bonus_strength=suitAttributeTable['bonus_strength'],
         bonus_intellect=suitAttributeTable['bonus_intellect'],
         bonus_agility=suitAttributeTable['bonus_agility'],
         bonus_speed=suitAttributeTable['bonus_speed']})

        end


	local modifierlua=hero:FindModifierByName("suit_lua")
	if modifierlua then
		hero:RemoveModifierByName("suit_lua");
		hero:AddNewModifier(hero,nil,"suit_lua",{})
	else
	hero:AddNewModifier(hero,nil,"suit_lua",{})
	end
end
