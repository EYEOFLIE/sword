if defend_tu == nil then
    defend_tu = class({})
end


function defend_tu:IsHidden()
    return true
end

function defend_tu:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end


function defend_tu:GetTexture( params )
    return "defend_tu"
end

LinkLuaModifier("defend_tu","lua_modifier/defend_tu.lua",LUA_MODIFIER_MOTION_NONE)