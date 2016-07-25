wudi_lua = class({})

--------------------------------------------------------------------------------

function wudi_lua:IsDebuff()
	return true
end

--------------------------------------------------------------------------------

function wudi_lua:IsStunDebuff()
	return true
end


function wudi_lua:CheckState()
	local state = {
	[MODIFIER_STATE_INVULNERABLE]= true,
	}

	return state
end

function wudi_lua:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
    }
    return funcs
end

function wudi_lua:GetDisableAutoAttack(params)
    if IsServer() then
        return 1
    end
    -- body
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
