if defend_mu == nil then
    defend_mu = class({})
end


function defend_mu:IsHidden()
    return true
end

function defend_mu:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end


function defend_mu:GetTexture( params )
    return "defend_mu"
end

LinkLuaModifier("defend_mu","lua_modifier/defend_mu.lua",LUA_MODIFIER_MOTION_NONE)