
local SpecialHide = {
	["var_type"] = true,
}

local GetSpecialData = function( o )
	if o.AbilitySpecial then
		local t = {}
		for _,special in pairs(o.AbilitySpecial) do
			for k,v in pairs(special) do
				
				if not SpecialHide[k] then
					if type(v) == "number" and math.floor(v) < v then
						t[k] = string.format("%.2f",v)
					else
						t[k] = v
					end
				end
			end
		end
		return t
	end
	return nil
end

local data = function()
	GameRules.m_ItemData_Items = LoadKeyValues("scripts/npc/npc_items_custom.txt")
	GameRules.m_ItemData_GetSpecialData = GetSpecialData
	local itemsSpecials = {}

	-- 存储商店列表
	local shops = LoadKeyValues("scripts/shops.txt")
	local shopsInfo = {}
	for _,v in pairs(shops) do
		for __,itemName in pairs(v) do
			local t = {}
			t.name = itemName
			t.gold = GetItemCost(itemName)

			t.SpecialList = GetSpecialData(GameRules.m_ItemData_Items[itemName])
			
			table.insert(shopsInfo,t)
		end
	end

	table.sort( shopsInfo, function( a,b )
		return a.gold < b.gold
	end )

	for k,v in pairs(item_table) do

		if v.quality == 1 then
			v.gold = 100
		elseif v.quality == 2 then
			v.gold = 100
		elseif v.quality == 3 then
			v.gold = 100
		elseif v.quality == 4 then
			v.gold = 300
		elseif v.quality == 5 then
			v.gold = 300
		elseif v.quality == 6 then
			v.gold = 900
		elseif v.quality == 7 then
			v.gold = 900
		elseif v.quality == 8 then
			v.gold = 900
		end

		CustomNetTables:SetTableValue("Shops", k, v)
	end

	CustomNetTables:SetTableValue("Shops", "ShopsInfo", shopsInfo)
	CustomNetTables:SetTableValue("Shops", "itemsSpecials", {})
end

local unitmagicarmor=function ()
	local unite = LoadKeyValues("scripts/npc/npc_units_custom.txt")
	local uniteInfo = {}
	for o,v in pairs(unite) do
		local t={}
		if type(v)=="table" then
  			if v["jin"] then
				t.jin=v.jin
				t.mu=v.mu
				t.shui=v.shui
				t.huo=v.huo
				t.tu=v.tu
			else
				t.jin=0
				t.mu=0
				t.shui=0
				t.huo=0
				t.tu=0
			end
		 end
   		CustomNetTables:SetTableValue("unite_state", o, t)
	end
	
end
data()
unitmagicarmor()