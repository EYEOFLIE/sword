
if xixue == nil then
    xixue = class({})
end


function xixue:IsHidden()
    return false
end

function xixue:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,

	}

	return funcs
end


function xixue:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end
function xixue:OnTakeDamage(params)
	
	params.attacker:Heal(params.damage*10/100,nil)
	local eff = ParticleManager:CreateParticle("particles/units/heroes/hero_skeletonking/wraith_king_vampiric_aura_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.attacker)
 
	PopupNumbers(params.attacker, "heal", Vector(130,203,76), 1.0, math.ceil(params.damage*50/100), 0, nil)
	-- body
end


function xixue:GetTexture( params )
    return "skeleton_king_vampiric_aura"
end

LinkLuaModifier("xixue","lua_modifier/xixue.lua",LUA_MODIFIER_MOTION_NONE)
