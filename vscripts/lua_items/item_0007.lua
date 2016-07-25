if item_0007 == nil then
	item_0007 = class({})
end

LinkLuaModifier( "item_base_modifier", "lua_items/item_base_modifier.lua", LUA_MODIFIER_MOTION_NONE )

function item_0007:Spawn()

	if IsServer() then
		
		self.bonus_damage_random=RandomInt( 1, self:GetSpecialValueFor( "bonus_damage_random" ))
		self.bonus_damage = self:GetSpecialValueFor("bonus_damage") + self.bonus_damage_random
		
		self.bonus_strength_random=RandomInt( 1, self:GetSpecialValueFor( "bonus_strength_random" ))
		self.bonus_strength = self:GetSpecialValueFor( "bonus_strength" )+self.bonus_strength_random
		
		self.bonus_intellect_random=RandomInt( 1, self:GetSpecialValueFor( "bonus_intellect_random" ))
		self.bonus_intellect = self:GetSpecialValueFor( "bonus_intellect" )+self.bonus_intellect_random
		
		self.bonus_agility_random=RandomInt( 1, self:GetSpecialValueFor( "bonus_agility_random" ))
		self.bonus_agility = self:GetSpecialValueFor( "bonus_agility" )+self.bonus_agility_random

		self.bonus_armor_random=RandomInt( 1, self:GetSpecialValueFor( "bonus_armor_random" ))
		self.bonus_armor = self:GetSpecialValueFor( "bonus_armor" )+self.bonus_armor_random

		self.bonus_speed_random=RandomInt( 1, self:GetSpecialValueFor( "bonus_speed_random" ))
		self.bonus_speed = self:GetSpecialValueFor( "bonus_speed" )+self.bonus_speed_random

		self.bonus_health_random=RandomInt( 1, self:GetSpecialValueFor( "bonus_health_random" ))
		self.bonus_health = self:GetSpecialValueFor( "bonus_health" )+self.bonus_health_random

		self.bonus_magicalarmor_random=RandomInt( 1, self:GetSpecialValueFor( "bonus_magicalarmor_random" ))
		self.bonus_magicalarmor = self:GetSpecialValueFor( "bonus_magicalarmor" )+self.bonus_magicalarmor_random

		self.mana_regen_random=RandomInt( 1, self:GetSpecialValueFor( "mana_regen_random" ))
		self.mana_regen = self:GetSpecialValueFor( "mana_regen" )+self.mana_regen_random

		self.health_regen_random=RandomInt( 1, self:GetSpecialValueFor( "health_regen_random" ))
		self.health_regen = self:GetSpecialValueFor( "health_regen" )+self.health_regen_random
		
		CustomNetTables:SetTableValue( "custom_item_state", string.format( "%d", self:GetEntityIndex() ), { bonus_damage = self.bonus_damage,
		 bonus_strength=self.bonus_strength,
		 bonus_intellect=self.bonus_intellect,
		 bonus_agility=self.bonus_agility,
		 bonus_armor=self.bonus_armor,
		 bonus_speed=self.bonus_speed,
		 bonus_health=self.bonus_health ,
		 bonus_magicalarmor=self.bonus_magicalarmor,
		 mana_regen=self.mana_regen,
		 health_regen=self.health_regen})
	else
		local netTable = CustomNetTables:GetTableValue( "custom_item_state", string.format( "%d", self:GetEntityIndex() ) )
		self.bonus_damage = netTable.bonus_damage
		self.bonus_strength =netTable.bonus_strength
		self.bonus_intellect=netTable.bonus_intellect
		self.bonus_agility=netTable.bonus_agility
		self.bonus_armor=netTable.bonus_armor
		self.bonus_speed=netTable.bonus_speed
		self.bonus_health=netTable.bonus_health
		self.bonus_magicalarmor=netTable.bonus_magicalarmor
		self.mana_regen=netTable.mana_regen
		self.health_regen=netTable.health_regen
	end
end

function item_0007:GetIntrinsicModifierName()
	return "item_base_modifier"
end

