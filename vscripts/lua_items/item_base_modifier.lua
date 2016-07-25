if item_base_modifier == nil then
	item_base_modifier = class({})
end

function item_base_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,

	}
	return funcs
end

function item_base_modifier:OnCreated( kv )	
	self.BaseClass.OnCreated( self, kv )
	local hAbility = self:GetAbility()
	self.damageBonus = 0
	self.strengthBonus = 0
	self.intellectBonus = 0
	self.agilityBonus = 0
	self.speedBonus = 0
	self.armorBonus = 0
	self.healthBonus = 0
	self.magicalarmorBonus = 0
	self.manaregen = 0
	self.healthregen =0
	if hAbility ~= nil then
		self.damageBonus = hAbility.bonus_damage
		self.strengthBonus = hAbility.bonus_strength
		self.intellectBonus = hAbility.bonus_intellect
		self.agilityBonus = hAbility.bonus_agility
		self.speedBonus = hAbility.bonus_speed
		self.armorBonus = hAbility.bonus_armor
		self.healthBonus = hAbility.bonus_health
		self.magicalarmorBonus= hAbility.bonus_magicalarmor
		self.manaregen = hAbility.mana_regen
		self.healthregen = hAbility.health_regen
		
	end
end

function item_base_modifier:IsHidden()
	return true
end

function item_base_modifier:GetModifierPreAttack_BonusDamage( params )	--攻击力

	return self.damageBonus
end
function item_base_modifier:GetModifierBonusStats_Intellect( params )	--智力
	return self.intellectBonus
end

function item_base_modifier:GetModifierBonusStats_Strength( params )	--力量
	return self.strengthBonus
end

function item_base_modifier:GetModifierBonusStats_Agility( params )	--敏捷
	return self.agilityBonus
end

function item_base_modifier:GetModifierMoveSpeedBonus_Special_Boots( params ) --移速
	return self.speedBonus
end

function item_base_modifier:GetModifierPhysicalArmorBonus( params ) --护甲
	return self.armorBonus
end
function item_base_modifier:GetModifierHealthBonus( params ) --血量
	return self.healthBonus
end
function item_base_modifier:GetModifierMagicalResistanceBonus( params ) --魔抗
	return self.magicalarmorBonus
end
function item_base_modifier:GetModifierPercentageManaRegen( params ) --回魔
	return self.manaregen
end

function item_base_modifier:GetModifierConstantHealthRegen( params ) --回魔
	return self.healthregen
end

function item_base_modifier:GetAttributes()
  return MODIFIER_ATTRIBUTE_MULTIPLE
end

