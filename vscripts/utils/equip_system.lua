
if EquipSystem == nil then
	EquipSystem = {}
	EquipSystemConfig = {}
	setmetatable(EquipSystem,EquipSystem)
end

-- 武器位置
EquipSystemConfig.WeaponInSlot = 4

-- 鞋
EquipSystemConfig.ShoesInSlot = 5

-- 衣服
EquipSystemConfig.ClothesInSlot = 2

-- 头盔
EquipSystemConfig.HatInSlot = 0

-- 饰品
EquipSystemConfig.TrinketInSlot = 1

-- 护符
EquipSystemConfig.TalismanInSlot = 3

-- 判断武器
-- 
function EquipSystem:IsWeapon( item )
	local part=item:GetSpecialValueFor( "part" )
	return part == EquipSystemConfig.WeaponInSlot
end

-- 判断鞋
-- 
function EquipSystem:IsShoes( item )
	local part=item:GetSpecialValueFor( "part" )
	return part == EquipSystemConfig.ShoesInSlot
end

-- 判断衣服
-- 
function EquipSystem:IsClothes( item )
	local part=item:GetSpecialValueFor( "part" )
	return part == EquipSystemConfig.ClothesInSlot

end

-- 判断头盔
-- 
function EquipSystem:IsHat( item )
	local part=item:GetSpecialValueFor( "part" )
	return part == EquipSystemConfig.HatInSlot
end

-- 判断饰品
-- 
function EquipSystem:IsTrinket( item )
	local part=item:GetSpecialValueFor( "part" )
	return part == EquipSystemConfig.TrinketInSlot
end

-- 判断是否已经装备了物品
function EquipSystem:IsEquip( unit, slot, func )
	if slot > 5 then return false end
	local item = unit:GetItemInSlot(slot)

	if item then
		local itemName = item:GetAbilityName()

		if func and func(self,item) then
			return true
		end
	end

	return false
end

-- 对换物品位置
-- 
function EquipSystem:Swap( unit, item, slot, equipSlot, func )
	
	if slot ~= equipSlot then

		if self:IsEquip( unit, equipSlot, func ) then
			if not Backpack:AddItemImmediate(unit,item) then
				unit:DropItemAtPositionImmediate(item,unit:GetOrigin() + RandomVector( RandomFloat(50, 100)))
			end
		else
			unit:SwapItems(slot,equipSlot)
		end
	end
end

function EquipSystem:Init( hero )
	-- if true then return end
	hero:SetContextThink(DoUniqueString("EquipSystem"), function()
		if GameRules:IsGamePaused() then return 0.2 end

		for i=0,5 do
			local item = hero:GetItemInSlot(i)

			if item then
				
				if self:IsWeapon(item) then
					self:Swap( hero, item, i, EquipSystemConfig.WeaponInSlot, self.IsWeapon )

				elseif self:IsShoes(item) then
					self:Swap( hero, item, i, EquipSystemConfig.ShoesInSlot, self.IsShoes )

				elseif self:IsClothes(item) then
					self:Swap( hero, item, i, EquipSystemConfig.ClothesInSlot, self.IsClothes )

				elseif self:IsHat(item) then
					self:Swap( hero, item, i, EquipSystemConfig.HatInSlot, self.IsHat )

				elseif self:IsTrinket(item) then
					if i ~= EquipSystemConfig.TrinketInSlot and i ~= EquipSystemConfig.TalismanInSlot then

						local item2 = hero:GetItemInSlot(EquipSystemConfig.TrinketInSlot)
						if item2 then
							local item2Name = item2:GetAbilityName()
							if self:IsTrinket(item2Name) then
								self:Swap( hero, item, i, EquipSystemConfig.TalismanInSlot, self.IsTrinket )
							end
						else
							self:Swap( hero, item, i, EquipSystemConfig.TrinketInSlot, self.IsTrinket )
						end
							
					end

				else
					if not Backpack:AddItemImmediate(hero,item) then
						hero:DropItemAtPositionImmediate(item,hero:GetOrigin() + RandomVector( RandomFloat(50, 100)))
					end
				end
			end
		end

		return 0.2
	end, 0.2)

end

-- 装备事件
function EquipSystem:OnEquip( data )
	
	if type(data.packIndex) == "number" and type(data.slot) == "number" then
		local player = PlayerResource:GetPlayer(data.PlayerID)
		if player == nil then return end
		
		local hero = player:GetAssignedHero()
		if hero == nil then return end
		if hero:IsNull() then return end
		
		Backpack:SwapInInventory( hero, data.packIndex, data.slot )
		SetSuitAttribute(hero)
	end
end

-- 双击装备
function EquipSystem:OnDoubleClickEquip( data )
	self=EquipSystem
	if type(data.packIndex) == "number" and type(data.itemIndex) == "number" then
		local player = PlayerResource:GetPlayer(data.PlayerID)
		if player == nil then return end
		
		local hero = player:GetAssignedHero()
		if hero == nil then return end
		if hero:IsNull() then return end

		local item = EntIndexToHScript(data.itemIndex)

		if item == nil then return end

		
		local slot = -1

		if self:IsWeapon(item) then
			slot = EquipSystemConfig.WeaponInSlot

		elseif self:IsShoes(item) then
			slot = EquipSystemConfig.ShoesInSlot

		elseif self:IsClothes(item) then
			slot = EquipSystemConfig.ClothesInSlot

		elseif self:IsHat(item) then
			slot = EquipSystemConfig.HatInSlot

		elseif self:IsTrinket(item) then
			local trinket = hero:GetItemInSlot( EquipSystemConfig.TrinketInSlot )
			local talisman = hero:GetItemInSlot( EquipSystemConfig.TalismanInSlot )
			if trinket then
				if talisman == nil then
					slot = EquipSystemConfig.TalismanInSlot
				else
					slot = EquipSystemConfig.TrinketInSlot
				end
			else
				slot = EquipSystemConfig.TrinketInSlot
			end
		end

		if slot ~= -1 then
			data.slot = slot
			self:OnEquip(data)
		end
	end
end

-- 双击卸载
function EquipSystem:OnDoubleClickUninstall( data )
	self=EquipSystem
	if type(data.itemIndex) == "number" then
		local player = PlayerResource:GetPlayer(data.PlayerID)
		if player == nil then return end
		
		local hero = player:GetAssignedHero()
		if hero == nil then return end
		if hero:IsNull() then return end

		local item = EntIndexToHScript(data.itemIndex)

		Backpack:AddItemImmediate( hero, item )
		SetSuitAttribute(hero)
	end
end

-- 拖拽装备
function EquipSystem:OnDrapEquip( data )
	
	self=EquipSystem
	if type(data.packIndex) == "number" and type(data.slot) == "number" then
		local player = PlayerResource:GetPlayer(data.PlayerID)
		if player == nil then return end
		
		local hero = player:GetAssignedHero()
		if hero == nil then return end
		if hero:IsNull() then return end
		
		local itemIndex = Backpack:GetItemIndex( hero, data.packIndex )
		print(itemIndex)
		local item = EntIndexToHScript(itemIndex)
		
		if item then
			
			
			local slot = -1

			if self:IsWeapon(item) then
				slot = EquipSystemConfig.WeaponInSlot

			elseif self:IsShoes(item) then
				slot = EquipSystemConfig.ShoesInSlot

			elseif self:IsClothes(item) then
				slot = EquipSystemConfig.ClothesInSlot

			elseif self:IsHat(item) then
				slot = EquipSystemConfig.HatInSlot

			elseif self:IsTrinket(item) then
				if data.slot == EquipSystemConfig.TrinketInSlot then
					slot = EquipSystemConfig.TrinketInSlot
				else
					slot = EquipSystemConfig.TalismanInSlot
				end
			end
	
			if slot == data.slot then
				self:OnEquip(data)
			end
		else

			self:OnEquip(data)
		end
	end
end

-- 初始化
function EquipSystem:__call(unit)
	CustomGameEventManager:RegisterListener("ui_event_equip_system_equip",Dynamic_Wrap(EquipSystem,"OnDrapEquip"))

	CustomGameEventManager:RegisterListener("ui_event_equip_system_dblclick_equip",Dynamic_Wrap(EquipSystem,"OnDoubleClickEquip"))
	
	CustomGameEventManager:RegisterListener("ui_event_equip_system_dblclick_uninstall",Dynamic_Wrap(EquipSystem,"OnDoubleClickUninstall"))

	CustomNetTables:SetTableValue("Backpack","EquipSystemConfig",EquipSystemConfig)
end

if EquipSystem then EquipSystem() end

