ab_boss_02_ai_lua = class({})
LinkLuaModifier("laoer","lua_modifier/laoer.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("wudi_lua","lua_modifier/wudi_lua.lua",LUA_MODIFIER_MOTION_NONE)
---------------------------------------------------------------------------

function ab_boss_02_ai_lua:GetIntrinsicModifierName()
	return "laoer"
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------