jinmo_nothing_lua = class({})

--------------------------------------------------------------------------------

function jinmo_nothing_lua:IsDebuff()
	return true
end

--------------------------------------------------------------------------------

function jinmo_nothing_lua:IsStunDebuff()
	return true
end


function jinmo_nothing_lua:CheckState()
	local state = {
	[MODIFIER_STATE_SILENCED] = true,
	[MODIFIER_STATE_INVULNERABLE]= true,
	}

	return state
end

function jinmo_nothing_lua:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
    }
    return funcs
end

function jinmo_nothing_lua:GetDisableAutoAttack(params)
    if IsServer() then
        return 1
    end
    -- body
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
