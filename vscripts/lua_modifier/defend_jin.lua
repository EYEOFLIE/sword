if defend_jin == nil then
    defend_jin = class({})
end


function defend_jin:IsHidden()
    return true
end

function defend_jin:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end


function defend_jin:GetTexture( params )
    return "defend_jin"
end

LinkLuaModifier("defend_jin","lua_modifier/defend_jin.lua",LUA_MODIFIER_MOTION_NONE)