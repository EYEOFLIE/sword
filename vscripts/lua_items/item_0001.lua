
if item_0001 == nil then
	item_0001 = class({})
end

LinkLuaModifier( "item_base_modifier", "lua_items/item_base_modifier.lua", LUA_MODIFIER_MOTION_NONE )

function item_0001:Spawn()

	if IsServer() then
		
		self.bonus_damage_random=RandomInt( 1, self:GetSpecialValueFor( "bonus_damage_random" ))
		self.bonus_damage = self:GetSpecialValueFor("bonus_damage") + self.bonus_damage_random
		
		self.bonus_strength_random=RandomInt( 1, self:GetSpecialValueFor( "bonus_strength_random" ))
		self.bonus_strength = self:GetSpecialValueFor( "bonus_strength" )+self.bonus_strength_random
		
		self.bonus_intellect_random=RandomInt( 1, self:GetSpecialValueFor( "bonus_intellect_random" ))
		self.bonus_intellect = self:GetSpecialValueFor( "bonus_intellect" )+self.bonus_intellect_random
		
		self.bonus_agility_random=RandomInt( 1, self:GetSpecialValueFor( "bonus_agility_random" ))
		self.bonus_agility = self:GetSpecialValueFor( "bonus_agility" )+self.bonus_agility_random
		
		CustomNetTables:SetTableValue( "custom_item_state", string.format( "%d", self:GetEntityIndex() ), { bonus_damage = self.bonus_damage,
		 bonus_strength=self.bonus_strength,
		 bonus_intellect=self.bonus_intellect,
		 bonus_agility=self.bonus_agility} )
	else
		local netTable = CustomNetTables:GetTableValue( "custom_item_state", string.format( "%d", self:GetEntityIndex() ) )
		self.bonus_damage = netTable.bonus_damage
		self.bonus_strength =netTable.bonus_strength
		self.bonus_intellect=netTable.bonus_intellect
		self.bonus_agility=netTable.bonus_agility
	end
end

function item_0001:GetIntrinsicModifierName()
	return "item_base_modifier"
end

function item_0001:OnChannelFinish( bInterrupted )
	local caster = self:GetCaster()
	local name=self:GetCursorTarget():GetName()
	print(name)
	local location=self:GetCursorTarget():GetOrigin()
	self:GetCursorTarget():CutDown(-1)
	
	if MAIN_NPC[1].caoyaotable[name] then
		ParticleManager:DestroyParticle(MAIN_NPC[1].caoyaotable[name],true)
		Timers:CreateTimer(10,function ()
			local particle = ParticleManager:CreateParticle("particles/econ/courier/courier_axolotl_ambient/courier_axolotl_ambient_lvl4_head.vpcf", PATTACH_ABSORIGIN, MAIN_NPC[1] )
			ParticleManager:SetParticleControl(particle, 0,location)
			ParticleManager:SetParticleControl(particle, 1,location)
			MAIN_NPC[1].caoyaotable[name]=particle
		end)


	end
	
	
end

function item_0001:OnUpgrade()
		local itemlevel=self:GetLevel()-1
		self.bonus_damage_random=RandomInt( 1, self:GetLevelSpecialValueFor( "bonus_damage_random",itemlevel-1))
		self.bonus_damage = self:GetLevelSpecialValueFor("bonus_damage",itemlevel) + self.bonus_damage_random
		
		self.bonus_strength_random=RandomInt( 1, self:GetLevelSpecialValueFor( "bonus_strength_random",itemlevel ))
		self.bonus_strength = self:GetLevelSpecialValueFor( "bonus_strength",itemlevel )+self.bonus_strength_random
		
		self.bonus_intellect_random=RandomInt( 1, self:GetLevelSpecialValueFor( "bonus_intellect_random",itemlevel ))
		self.bonus_intellect = self:GetLevelSpecialValueFor( "bonus_intellect",itemlevel)+self.bonus_intellect_random
		
		self.bonus_agility_random=RandomInt( 1, self:GetLevelSpecialValueFor( "bonus_agility_random",itemlevel))
		self.bonus_agility = self:GetLevelSpecialValueFor( "bonus_agility",itemlevel )+self.bonus_agility_random
		
		CustomNetTables:SetTableValue( "custom_item_state", string.format("%d", self:GetEntityIndex() ), { bonus_damage = self.bonus_damage,
		 bonus_strength=self.bonus_strength,
		 bonus_intellect=self.bonus_intellect,
		 bonus_agility=self.bonus_agility} )
	-- body
end

function item_0001:new(p)
  p=p or {}     
  --将新对象实例的元表指向Father，这样就可以以Father为模板了
  setmetatable(p,self)
  --将Father的__index字段指向自己，以便新对象在找不到指定的key时可以被重定向，即访问Father拥有的key
  self.__index=self
  return p
end
