stun_nothing = class({})
LinkLuaModifier("stun_nothing","lua_modifier/stun_nothing.lua",LUA_MODIFIER_MOTION_NONE)
--------------------------------------------------------------------------------

function stun_nothing:IsDebuff()
	return true
end

--------------------------------------------------------------------------------

function stun_nothing:IsStunDebuff()
	return true
end


function stun_nothing:CheckState()
	local state = {
	[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
