function begin_cast(event)
	local caster = event.caster
	local ability = event.ability
	StartAnimation(caster, {duration=0.4, activity=ACT_DOTA_CAST_ABILITY_1, rate=0.8})
end

function addscale(event)
	
	local caster = event.caster
	local ability = event.ability
	local target = event.target

	local abilityLevel = ability:GetLevel()
	target:SetModelScale(target:GetModelScale()+0.25);
	local manaCost = ability:GetManaCost(abilityLevel-1)

	caster:ReduceMana(manaCost)
	
   
end
function delscale(event)
	local caster = event.caster
	local ability = event.ability
	local target = event.target
	
	target:SetModelScale(target:GetModelScale()-0.25);
	
end