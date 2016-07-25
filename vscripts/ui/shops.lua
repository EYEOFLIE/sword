
if Shops == nil then
	Shops = {}
	setmetatable(Shops,Shops)
end

-- 常量
NW_SHOPS_TYPE_HOME = 0
NW_SHOPS_TYPE_SIDE = 1

-- 数据
local dataTemplate = {
	EntIndex = -1;
	IsSide = false,
	IsHome = false,
}
Shops.m_Data = {}

-- 单位进入商店
-- 
function Shops:Enter( unit, shop_type )

	local player = PlayerResource:GetPlayer(unit:GetPlayerOwnerID());

	local hero = player:GetAssignedHero();
	
	if hero == nil or type(hero) ~= "table" then return end

	local data = self.m_Data[tostring(hero:GetEntityIndex())]
	if not data then return end

	if shop_type == NW_SHOPS_TYPE_HOME then
		data.IsHome = true

	elseif shop_type == NW_SHOPS_TYPE_SIDE then
		data.IsSide = true

	end

	data.EntIndex = hero:GetEntityIndex()

	CustomNetTables:SetTableValue("Shops", "Data", self.m_Data)

	-- DeepPrintTable(CustomNetTables:GetTableValue("Shops", "Data"))
end

-- 单位离开商店
-- 
function Shops:Quit( unit, shop_type )
	
	local player = PlayerResource:GetPlayer(unit:GetPlayerOwnerID());

	local hero = player:GetAssignedHero();
	
	if hero == nil or type(hero) ~= "table" then return end

	local data = self.m_Data[tostring(hero:GetEntityIndex())]
	if not data then return end

	if shop_type == NW_SHOPS_TYPE_HOME then
		data.IsHome = false

	elseif shop_type == NW_SHOPS_TYPE_SIDE then
		data.IsSide = false

	end

	data.EntIndex = -1

	CustomNetTables:SetTableValue("Shops", "Data", self.m_Data)
	
	-- DeepPrintTable(CustomNetTables:SetTableValue("Shops", "Data"))
end

-- 判断单位是否在基地商店
-- 
function Shops:HasInHome( unit )
	
	local player = PlayerResource:GetPlayer(unit:GetPlayerOwnerID());

	local hero = player:GetAssignedHero();

	if hero == nil or type(hero) ~= "table" then return false end

	local data = self.m_Data[tostring(hero:GetEntityIndex())]
	if not data then return false end

	return data.IsHome
end

-- 判断单位是否在路边商店
-- 
function Shops:HasInSide( unit )
	
	local player = PlayerResource:GetPlayer(unit:GetPlayerOwnerID());

	local hero = player:GetAssignedHero();
	
	if hero == nil or type(hero) ~= "table" then return false end

	local data = self.m_Data[tostring(hero:GetEntityIndex())]
	if not data then return false end

	return data.IsSide
end

-- 初始化一个英雄
-- 
function Shops:__call( hero )

	if hero == nil or type(hero) ~= "table" or hero.IsHero == nil then return end
	
	local data = {}

	for k,v in pairs(dataTemplate) do
		
		data[k] = v
	end

	self.m_Data[tostring(hero:GetEntityIndex())] = data

	CustomNetTables:SetTableValue("Shops", "Data", self.m_Data)
end