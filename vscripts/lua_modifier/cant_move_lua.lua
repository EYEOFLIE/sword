cant_move_lua = class({})

--------------------------------------------------------------------------------

function cant_move_lua:IsDebuff()
	return true
end

--------------------------------------------------------------------------------

function cant_move_lua:IsStunDebuff()
	return true
end


function cant_move_lua:CheckState()
	local state = {
	[MODIFIER_STATE_STUNNED] = true,
	[MODIFIER_STATE_FROZEN]= true,
	[MODIFIER_STATE_INVULNERABLE]= true,
	
	}

	return state
end

function cant_move_lua:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
    }
    return funcs
end


function cant_move_lua:GetDisableAutoAttack(params)
    if IsServer() then
        return 1
    end
    -- body
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
