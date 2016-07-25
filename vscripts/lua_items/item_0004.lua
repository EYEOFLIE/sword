if item_0004 == nil then
	item_0004 = class({})
end

LinkLuaModifier( "item_base_modifier", "lua_items/item_base_modifier.lua", LUA_MODIFIER_MOTION_NONE )

function item_0004:Spawn()

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

function item_0004:GetIntrinsicModifierName()
	return "item_base_modifier"
end

function item_0004:OnChannelFinish( bInterrupted )
	local caster = self:GetCaster()
	self:GetCursorTarget():CutDownRegrowAfter(10,-1)
	
end
