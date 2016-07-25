
if defend_huo == nil then
    defend_huo = class({})
end


function defend_huo:IsHidden()
    return true
end

function defend_huo:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end


function defend_huo:GetTexture( params )
    return "defend_huo"
end

LinkLuaModifier("defend_huo","lua_modifier/defend_huo.lua",LUA_MODIFIER_MOTION_NONE)
