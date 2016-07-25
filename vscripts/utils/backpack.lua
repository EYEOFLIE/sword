

if Backpack == nil then
	Backpack = {}
	BackpackConfig = {}

	-- 存储单位的物品数据
	Backpack.m_UnitItems = {}
	setmetatable(Backpack,Backpack)
end

-- 背包格数
BackpackConfig.MaxItem = 25


function Backpack:GetComposeItemsChildren( unit, pack, composeInfo, items, filter )

	for k1,v1 in pairs(composeInfo) do
		for k2,v2 in pairs(v1["requestItem"]) do

			for i=0,5 do
				local item = unit:GetItemInSlot(i)
				if item and not filter[item:GetEntityIndex()] then
					local itemName = item:GetAbilityName()
					if itemName == v2 then
						filter[item:GetEntityIndex()] = true;

						if items[itemName] == nil then items[itemName] = {} end

						table.insert(items[itemName],item:GetEntityIndex())

						break
					end
				end
			end
		end
	end

	for k1,v1 in pairs(composeInfo) do
		for k2,v2 in pairs(v1["requestItem"]) do

			for _,itemIndex in pairs(pack) do
				local item = EntIndexToHScript(itemIndex)
				if item and not filter[itemIndex] then
					local itemName = item:GetAbilityName()
					if itemName == v2 then
						filter[itemIndex] = true;

						if items[itemName] == nil then items[itemName] = {} end

						table.insert(items[itemName],itemIndex)
						break
					end
				end
			end
		end
	end

end

function Backpack:ComposeItemsRefresh(unit)
	local items = {}
	local hasItem = {}
	local filter = {}
	local pack = self:GetBackpack(unit)
	local unitIndex = unit:GetEntityIndex()

	self:GetComposeItemsChildren( unit, pack, item_compose_table, items, filter )
	self:GetComposeItemsChildren( unit, pack, item_gem_compose_table, items, filter )

	for itemName,info in pairs( items ) do
		for index,itemIndex in pairs(info) do
			hasItem[itemName.."_"..tostring(index)] = itemIndex
		end
	end

	CustomNetTables:SetTableValue("ComposeChildren",tostring(unitIndex),hasItem)
end

-- 更新NetTable
-- @param unit handle 单位
-- 
function Backpack:UpdateNetTable( unit )
	local pack = self:GetBackpack(unit)
	if pack then
		local unitIndex = unit:GetEntityIndex()
		Backpack:ComposeItemsRefresh(unit)
	end
end 

function Backpack:UpdateItem( unit, packIndex )
	
	local pack = self:GetBackpack(unit)
	
	if pack then
		local itemIndex = pack[packIndex][1]
		local itempro = pack[packIndex][2]

		local event = "ui_event_backpack_get_item_return_"..tostring(packIndex)
		CustomGameEventManager:Send_ServerToPlayer(unit:GetPlayerOwner(),event,{packIndex=packIndex,itemIndex=itemIndex,itempro=itempro}) 
	end
end

-- 获取背包
-- @param unit handle 单位
-- 
function Backpack:GetBackpack( unit )
	if type(unit) ~= "table" then return nil end
	if unit:IsNull() then return nil end

	return Backpack.m_UnitItems[unit:GetEntityIndex()]
end

-- 获取背包物品数量
-- @param unit handle 单位
-- 
function Backpack:GetItemsNum( unit )
	if type(unit) ~= "table" then return BackpackConfig.MaxItem end
	if unit:IsNull() then return BackpackConfig.MaxItem end

	if self:HasBackpack(unit) then
		local pack = self:GetBackpack(unit) or {}
		local num = 0

		for _,itemIndex in pairs(pack) do
			if itemIndex[1] ~= -1 then
				num = num + 1
			end
		end

		return num
	end

	return BackpackConfig.MaxItem
end

-- 获取背包某物品数量
-- @param unit handle 单位
-- 
function Backpack:GetItemsNumByItemName( unit,itemName )
	if type(unit) ~= "table" then return 0 end
	if unit:IsNull() then return 0 end

	if self:HasBackpack(unit) then
		local pack = self:GetBackpack(unit) or {}
		local num = 0

		for _,itemIndex in pairs(pack) do
			if itemIndex ~= -1 then
				local item = EntIndexToHScript(itemIndex)
				if item:GetAbilityName() == itemName then
					num = num + 1
				end
			end
		end

		return num
	end

	return 0
end

-- 判断单位是否有背包
-- @param unit handle 单位
-- 
function Backpack:HasBackpack( unit )
	return self:GetBackpack(unit) ~= nil
end

-- 判断背包是否填满
-- @param unit handle 单位
-- 
function Backpack:IsFull( unit )
	return self:GetItemsNum(unit) == BackpackConfig.MaxItem
end

-- 判断背包中是否有物品
-- @param unit handle 单位
-- @param itemIndex int 物品EntityIndex
-- 
function Backpack:HasItem( unit, itemIndex )
	if self:HasBackpack(unit) then

		local pack = self:GetBackpack(unit)

		for packIndex,index in pairs(pack) do
			if index[1] == itemIndex then
				return true,packIndex
			end
		end
	end

	return false
end

-- 移除物品
-- @param unit handle 单位
-- @param packIndex int 背包中的位置
-- 
function Backpack:RemoveItem( unit, packIndex )

	
	if packIndex > BackpackConfig.MaxItem or packIndex < 0 then return false end

	local pack = self:GetBackpack(unit)

	if pack then
	 	pack[packIndex][1] = -1
	 
	 	self:UpdateItem( unit, packIndex )
	 	
	end
end

-- 消耗物品
-- @param unit handle 单位
-- @param item handle 物品
-- 
function Backpack:ConsumeItem( unit, item )
	local hasItem,packIndex = self:HasItem( unit, item:GetEntityIndex() )

	if hasItem then
		local box = item:GetContainer()
		item:RemoveSelf()

		if box and not box:IsNull() then 
			box:RemoveSelf() 

			local pack = self:GetBackpack(unit)
			pack[packIndex][1] = -1;
		end

		self:RemoveItem( unit, packIndex )

		return true
	end

	return false
end

-- 查找物品
-- @param unit handle 单位
-- @param itemName string 物品名称
-- 
function Backpack:FindItemByName( unit, itemName )
	local pack = self:GetBackpack(unit)

	if pack then
	 	for packIndex,itemIndex in pairs(pack) do
	 		local item = EntIndexToHScript(itemIndex)
	 		if item and item:GetAbilityName() == itemName then
	 			return item,packIndex
	 		end
	 	end
	end

	return nil
end

-- 查看物品是否在背包中
-- @param unit handle 单位
-- @param item handle 物品
-- 
function Backpack:HasItemInBackpack( unit, item )
	if type(item) ~= "table" then return false end
	if item:IsNull() then return false end

	return self:HasItem( unit, item:GetEntityIndex() )
end

-- 获取一个空的物品格
-- @param unit handle 单位
-- 
function Backpack:GetNotUseIndex( unit )
	if not self:IsFull(unit) then
		local pack = self:GetBackpack(unit) or {}

		for packIndex,itemIndex in pairs(pack) do
			if itemIndex[1] == -1 then
				return packIndex
			end
		end
	end

	return -1
end

-- 获取物品
-- @param unit handle 单位
-- @param packIndex int 背包中的位置
-- 
function Backpack:GetItemIndex( unit, packIndex )
	local pack = self:GetBackpack(unit)

	if pack then
	 	local itemIndex = pack[packIndex][1]

	 	if itemIndex then
	 		return itemIndex
	 	end
	end

	return -1
end

-- 添加物品到背包
-- @param unit handle 单位
-- @param item handle 物品
-- 
function Backpack:AddItem( unit, item )
	
	if type(item) ~= "table" then return false end
	if item:IsNull() then return false end

	if self:IsFull(unit) then return false end

	if self:HasItemInBackpack( unit, item ) then return false end

	local box = item:GetContainer()
	if box then box:RemoveSelf() end

	if unit:GetNumItemsInInventory() >= 6 then
		unit:AddItem(item)
	end

	unit:SetContextThink(DoUniqueString("AddItem"), function( )
		local packIndex = self:GetNotUseIndex(unit)

		if packIndex ~= - 1 then
			local pack = self:GetBackpack(unit)

			if pack then
				pack[packIndex]={}
				pack[packIndex][1] = item:GetEntityIndex()
				pack[packIndex][2] = {bonus_damage=item.bonus_damage_random,
				bonus_strength=item.bonus_strength_random,
				bonus_intellect=item.bonus_intellect_random,
				bonus_agility=item.bonus_agility_random,
				bonus_speed=item.bonus_speed_random,
				bonus_armor=item.bonus_armor_random,
				bonus_health=item.bonus_health_random,
				bonus_magicalarmor=item.bonus_magicalarmor_random,
				mana_regen=item.mana_regen_random,
				health_regen=item.health_regen_random
				}

				unit:Script_TakeItem(item)
			 	self:UpdateItem( unit, packIndex )
				
				return nil
			end
		end
				
	end, 0.2)

	return true
end

-- 立即添加物品
-- 
function Backpack:AddItemImmediate( unit, item )
	print(2)
	if type(item) ~= "table" then return false end
	if item:IsNull() then return false end

	if self:IsFull(unit) then return false end

	if self:HasItemInBackpack( unit, item ) then return false end

	if unit:GetNumItemsInInventory() >= 6 then
		local box = item:GetContainer()
		if box then box:RemoveSelf() end
		
		unit:AddItem(item)
	end

	local packIndex = self:GetNotUseIndex(unit)

	if packIndex ~= - 1 then
		local pack = self:GetBackpack(unit)

		if pack then
			pack[packIndex]={}
			pack[packIndex][1] = item:GetEntityIndex()
			pack[packIndex][2] = {bonus_damage=item.bonus_damage_random,
				bonus_strength=item.bonus_strength_random,
				bonus_intellect=item.bonus_intellect_random,
				bonus_agility=item.bonus_agility_random,
				bonus_speed=item.bonus_speed_random,
				bonus_armor=item.bonus_armor_random,
				bonus_health=item.bonus_health_random,
				bonus_magicalarmor=item.bonus_magicalarmor_random,
				mana_regen=item.mana_regen_random,
				health_regen=item.health_regen_random	
				}
			
			unit:Script_TakeItem(item)
			
			self:UpdateItem( unit, packIndex )
			
		end
	end

	return true
end

-- 掉落物品
-- @param unit handle 单位
-- @param item handle 物品
-- 
function Backpack:DropItem( unit, item )
	if type(item) ~= "table" then return nil end
	if item:IsNull() then return nil end

	local hasItem,packIndex = self:HasItem(unit,item:GetEntityIndex())

	if hasItem then
		local pos = unit:GetOrigin()


		local drop = CreateItemOnPositionSync( pos + RandomVector(RandomFloat(50, 150)) , item)
		if drop then
			drop:SetContainedItem( item )
			
		end

		self:RemoveItem( unit, packIndex )
	end
	
end

-- 掉落物品到其它单位
-- 
function Backpack:DropItemToOtherUnit( parent, unit, item )
	if type(item) ~= "table" then return nil end
	if item:IsNull() then return nil end

	local hasItem,packIndex = self:HasItem(parent,item:GetEntityIndex())

	if hasItem then
		
		local pos = unit:GetOrigin()
		local drop = CreateItemOnPositionSync( pos + RandomVector(RandomFloat(50, 150)) , item)
		if drop then
			drop:SetContainedItem( item )
		end
		self:RemoveItem( parent, packIndex )
	end
	
end

-- 掉落物品到某位置
-- @param unit handle 单位
-- @param item handle 物品
-- @param pos vector 位置
-- 
function Backpack:DropItemToPosition( unit, item, pos )
	if type(item) ~= "table" then return nil end
	if type(pos) ~= "userdata" then return nil end
	if item:IsNull() then return nil end

	local hasItem,packIndex = self:HasItem(unit,item:GetEntityIndex())

	if hasItem then

		ExecuteOrderFromTable
		{
			UnitIndex = unit:GetEntityIndex(),
			OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
			Position = pos,
			Queue = 0
		}

		unit.m_Backpack_DropItemToPosition_OrderType = DOTA_UNIT_ORDER_DROP_ITEM

		unit:SetContextThink(DoUniqueString("DropItemToPosition"), function()

			if unit.m_Backpack_DropItemToPosition_OrderType ~= DOTA_UNIT_ORDER_DROP_ITEM then
				return nil
			end

			if (unit:GetOrigin() - pos):Length2D() <= 150 then
				-- unit:AddItem(item)
				-- unit:DropItemAtPositionImmediate(item,pos)

				local drop = CreateItemOnPositionSync( pos , item)
				if drop then
					drop:SetContainedItem( item )
					-- item:LaunchLoot( false, 100, 0.35, pos )
				end

				unit:Stop()

				self:RemoveItem( unit, packIndex )

				return nil
			end
			
			return 0.2
		end, 0)
			
	end
end

-- 掉落物品其它单位的某位置
-- 
function Backpack:DropItemToOtherUnitPosition( parent, unit, item, pos )
	if type(item) ~= "table" then return nil end
	if type(pos) ~= "userdata" then return nil end
	if item:IsNull() then return nil end

	local hasItem,packIndex = self:HasItem(parent,item:GetEntityIndex())

	if hasItem then

		ExecuteOrderFromTable
		{
			UnitIndex = unit:GetEntityIndex(),
			OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
			Position = pos,
			Queue = 0
		}

		unit.m_Backpack_DropItemToPosition_OrderType = DOTA_UNIT_ORDER_DROP_ITEM

		local itemIndex = item:GetEntityIndex()
		local pack = self:GetBackpack(parent)

		unit:SetContextThink(DoUniqueString("DropItemToPosition"), function()

			if unit.m_Backpack_DropItemToPosition_OrderType ~= DOTA_UNIT_ORDER_DROP_ITEM then
				return nil
			end

			if (unit:GetOrigin() - pos):Length2D() <= 150 then
				

				if pack[packIndex][1] ~= itemIndex then
					return nil
				end

				local drop = CreateItemOnPositionSync( pos , item)
				if drop then
					drop:SetContainedItem( item )
					-- item:LaunchLoot( false, 100, 0.35, pos )
				end

				unit:Stop()

				self:RemoveItem( parent, packIndex )

				return nil
			end
			
			return 0.2
		end, 0)
			
	end
end

-- 对换位置
-- @param unit handle 单位
-- @param packIndex1 int 背包中的位置
-- @param packIndex2 int 背包中的位置
-- 
function Backpack:SwapItem( unit, packIndex1, packIndex2 )
	
	if packIndex1 > BackpackConfig.MaxItem or packIndex1 < 0 then return false end
	if packIndex2 > BackpackConfig.MaxItem or packIndex2 < 0 then return false end

	local pack = self:GetBackpack(unit)

	if pack then
	 	local temp = pack[packIndex1]
	 	pack[packIndex1] = pack[packIndex2]
	 	pack[packIndex2] = temp

	 	self:UpdateItem( unit, packIndex1 )
	 	self:UpdateItem( unit, packIndex2 )
	 	
	end
end

-- 与物品栏位置对换
function Backpack:SwapInInventory( unit, packIndex, slot )

	if self:HasBackpack(unit) then
		if slot > 5 then return false end

		local pack = self:GetBackpack(unit)
		local item = unit:GetItemInSlot(slot)

		if item == nil and pack[packIndex][1] == -1 then return false end

		local packItem = EntIndexToHScript(pack[packIndex][1])

		if item then
			
			pack[packIndex][1] = item:GetEntityIndex()
			pack[packIndex][2] = {bonus_damage=item.bonus_damage_random,
				bonus_strength=item.bonus_strength_random,
				bonus_intellect=item.bonus_intellect_random,
				bonus_agility=item.bonus_agility_random,
				bonus_speed=item.bonus_speed_random,
				bonus_armor=item.bonus_armor_random,
				bonus_health=item.bonus_health_random,
				bonus_magicalarmor=item.bonus_magicalarmor_random,
				mana_regen=item.mana_regen_random,
				health_regen=item.health_regen_random	
				}
			unit:Script_TakeItem(item)
		else

			pack[packIndex][1] = -1
			pack[packIndex][2] =""
		end

		if packItem then
			unit:AddItem(packItem)

			local s = 0
			for i=0,5 do
				local item = unit:GetItemInSlot(i)
				if item == packItem then
					s = i
				end
			end
			unit:SwapItems(s,slot)
			local item=unit:GetItemInSlot(slot)
			local itempro={}
			if item then
				
				itempro={bonus_damage=item.bonus_damage_random,
				bonus_strength=item.bonus_strength_random,
				bonus_intellect=item.bonus_intellect_random,
				bonus_agility=item.bonus_agility_random,
				bonus_speed=item.bonus_speed_random,
				bonus_armor=item.bonus_armor_random,
				bonus_health=item.bonus_health_random,
				bonus_magicalarmor=item.bonus_magicalarmor_random,
				mana_regen=item.mana_regen_random,
				health_regen=item.health_regen_random			
				}
			end
			
			local event = "ui_event_inventory_get_item_return_"..tostring(slot)
			CustomGameEventManager:Send_ServerToPlayer(unit:GetPlayerOwner(),event,{itempro=itempro}) 
		end

		self:UpdateItem( unit, packIndex )
		
	end
end

-- 遍历
-- @param unit handle 单位
-- @param func function 函数，每遍历一个物品调用一次，空的格子不遍历，返回true终止遍历，固有参数(pack,packIndex,itemIndex)
-- 
function Backpack:Traverse( unit, func )
	if self:HasBackpack(unit) then
		local pack = self:GetBackpack(unit)

		for packIndex,itemIndex in pairs(pack) do
			if itemIndex ~= -1 then
				if func(pack,packIndex,itemIndex[1]) then return end
			end
		end
	end
end

-- 创建物品
-- 
function Backpack:CreateItem( unit, itemName )
	
	if self:HasBackpack(unit) then
		if self:IsFull(unit) then
			local pos = unit:GetOrigin()
			local addItem = CreateItem(itemName, nil, nil)
			local drop = CreateItemOnPositionSync( pos + RandomVector(RandomFloat(50, 150)) , addItem)
			if drop then
				drop:SetContainedItem( addItem )
				-- addItem:LaunchLoot( false, 100, 0.35, pos + RandomVector( RandomFloat( 50, 150 ) ) )
			end
			return addItem
		else
			local addItem = CreateItem(itemName, nil, nil)
			Backpack:AddItemImmediate( unit, addItem )
			return addItem
		end
	end
end

-- 出售物品
-- 
function Backpack:SellItem( unit, item )
	if type(item) ~= "table" then return nil end
	if item:IsNull() then return nil end

	local cost = item:GetCost(); 

	local itemName = item:GetAbilityName()
	local itemInfo = item_table[itemName]
	
	if itemInfo then
		cost = itemInfo.gold
	end

	if cost == 0 then return end

	if Backpack:ConsumeItem( unit, item ) then

		PlayerResource:ModifyGold(unit:GetPlayerOwnerID(),cost,false,DOTA_ModifyGold_SellItem)
		EmitSoundOnClient("General.Coins",unit:GetPlayerOwner())

		local p = ParticleManager:CreateParticle("particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf",PATTACH_CUSTOMORIGIN,unit)
		ParticleManager:SetParticleControl(p,1,unit:GetOrigin())
		ParticleManager:ReleaseParticleIndex(p)
	end
end

-- 放置末尾
-- 
function Backpack:ItemPosToEnd( unit, packIndex )
	if packIndex > BackpackConfig.MaxItem or packIndex < 0 then return false end

	local pack = self:GetBackpack(unit)

	if pack then
		for i=BackpackConfig.MaxItem,1,-1 do
			if pack[i][1] == -1 then
				Backpack:SwapItem( unit, packIndex, i )
				break
			end
		end

	 
	end
end

-- 初始化
function Backpack:__call( unit )
	if type(unit) ~= "table" then return end
	if unit:IsNull() then return end
	if not unit:HasInventory() then return end

	local unitIndex = unit:GetEntityIndex()

	local data = {}

	for i=1,BackpackConfig.MaxItem do
		data[i] = {}
		data[i][1] = -1
		data[i][2] = {}
	end
				

	Backpack.m_UnitItems[unitIndex] = data

	unit:SetContextThink(DoUniqueString("Backpack"), function( )--包裹列表
		
		local pack = self:GetBackpack(unit)

		for packIndex,itemIndex in pairs(pack) do
			if itemIndex[1] ~= -1 then
				local item = EntIndexToHScript(itemIndex[1])
				if item == nil then
					pack[packIndex] = -1
				end
			end
		end
		return 3
	end, 3)


end

CustomNetTables:SetTableValue("Backpack","Config",BackpackConfig)
