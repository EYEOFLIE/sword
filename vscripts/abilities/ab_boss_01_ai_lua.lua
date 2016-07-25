ab_boss_01_ai_lua = class({})
LinkLuaModifier("lanaya_boss_ai","system/ai/lanaya_boss_ai.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("jinmo_nothing_lua","lua_modifier/jinmo_nothing_lua.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("cant_move_lua","lua_modifier/cant_move_lua.lua",LUA_MODIFIER_MOTION_NONE)
---------------------------------------------------------------------------

function ab_boss_01_ai_lua:GetIntrinsicModifierName()
	return "lanaya_boss_ai"
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------