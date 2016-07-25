if defend_shui == nil then
    defend_shui = class({})
end


function defend_shui:IsHidden()
    return true
end

function defend_shui:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end


function defend_shui:GetTexture( params )
    return "defend_shui"
end

LinkLuaModifier("defend_shui","lua_modifier/defend_shui.lua",LUA_MODIFIER_MOTION_NONE)