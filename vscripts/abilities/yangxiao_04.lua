function OnLuodu03AttackLanded(keys)

	local caster = EntIndexToHScript(keys.caster_entindex)
	local target = keys.target

	EmitSoundOn("Hero_Juggernaut.BladeDance", caster)
	StartAnimation(caster, {duration=0.2, activity=ACT_DOTA_ATTACK_EVENT, rate=0.8})
	
	
end