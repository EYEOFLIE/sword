function OnGolemDied(keys)
	caster = keys.caster
	location = caster:GetAbsOrigin()
	if string.find(caster:GetUnitName(), "big_mud") then
		CreateUnitByName("med_mud", location, true, nil, nil, DOTA_TEAM_NEUTRALS)
		CreateUnitByName("med_mud", location, true, nil, nil, DOTA_TEAM_NEUTRALS)
	elseif string.find(caster:GetUnitName(), "med_mud") then
		CreateUnitByName("little_mud", location, true, nil, nil, DOTA_TEAM_NEUTRALS)
		CreateUnitByName("little_mud", location, true, nil, nil, DOTA_TEAM_NEUTRALS)
	end
end