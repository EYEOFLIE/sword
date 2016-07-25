
if suit_lua == nil then
    suit_lua = class({})
end

function suit_lua:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,

    }
    return funcs
end

function suit_lua:OnCreated( kv )

        self.BaseClass.OnCreated( self, kv )
        self.damageBonus = 0
        self.strengthBonus =0
        self.intellectBonus = 0
        self.agilityBonus = 0
        self.speedBonus = 0
        self.armorBonus = 0
        self.healthBonus = 0
        self.magicalarmorBonus = 0
        self.manaregen = 0
        self.healthregen =0

        local netTable = CustomNetTables:GetTableValue( "custom_suit_state", string.format( "%d", self:GetCaster():GetEntityIndex() ) )
        self.damageBonus = netTable.bonus_damage
        self.strengthBonus =netTable.bonus_strength
        self.intellectBonus=netTable.bonus_intellect
        self.agilityBonus=netTable.bonus_agility
        self.speedBonus=netTable.bonus_speed
      
end

function suit_lua:GetModifierPreAttack_BonusDamage( params )  --攻击力
   
    return self.damageBonus
end
function suit_lua:GetModifierBonusStats_Intellect( params )   --智力
    
    return self.intellectBonus
end

function suit_lua:GetModifierBonusStats_Strength( params )    --力量
    return self.strengthBonus
end

function suit_lua:GetModifierBonusStats_Agility( params ) --敏捷
    return self.agilityBonus
end

function suit_lua:GetModifierMoveSpeedBonus_Constant( params ) --移速
    --print(self.speedBonus)
    return self.speedBonus
end

function suit_lua:GetModifierPhysicalArmorBonus( params ) --护甲
    return self.armorBonus
end
function suit_lua:GetModifierHealthBonus( params ) --血量
    return self.healthBonus
end
function suit_lua:GetModifierMagicalResistanceBonus( params ) --魔抗
    return self.magicalarmorBonus
end
function suit_lua:GetModifierPercentageManaRegen( params ) --回魔
    return self.manaregen
end

function suit_lua:GetModifierConstantHealthRegen( params ) --回魔
    return self.healthregen
end


function suit_lua:IsHidden()
    return false
end

function suit_lua:GetAttributes()
    return  MODIFIER_ATTRIBUTE_MULTIPLE
end

function suit_lua:GetTexture( params )
    return "ability_hsj_humei01"
end

LinkLuaModifier("suit_lua","lua_modifier/suit_lua.lua",LUA_MODIFIER_MOTION_NONE)
