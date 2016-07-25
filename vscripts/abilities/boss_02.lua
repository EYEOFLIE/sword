function ability_BOSS_02_01_start( event )
	local point = event.target_points[1]
	local caster = event.caster
	local ability = event.ability
	local ability_level = ability:GetLevel() - 1
	local barrier_damage = caster:GetIntellect() * ability:GetLevelSpecialValueFor("damage", ability_level) * 0.5
	local intellect = caster:GetIntellect() * 5
	local casterPos = caster:GetAbsOrigin()
	local damageType = event.ability:GetAbilityDamageType()
	if(caster.particletable==nil) then
		caster.particletable={}
		
	end
   	local particle={}

	
    local  ParticleIndex = ParticleManager:CreateParticle( event.effectname, PATTACH_ABSORIGIN, caster )
   	ParticleManager:SetParticleControl( ParticleIndex, 0, Vector(point.x,point.y,point.z))
    particle[1]=ParticleIndex
    particle[2]=point
    particle[3]=GameRules:GetGameTime()+10

	table.insert(caster.particletable,particle)
    ability:ApplyDataDrivenModifier(caster, caster, "modifier_boss_02_01", nil)
end

function ability_BOSS_02_01_damage( event )
	local caster = event.caster
	local ability = event.ability
	local ability_level = ability:GetLevel() - 1
	local targetTeam = ability:GetAbilityTargetTeam() -- DOTA_UNIT_TARGET_TEAM_ENEMY
    local targetType = ability:GetAbilityTargetType() -- DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
    local targetFlag = DOTA_UNIT_TARGET_FLAG_NONE
    local damageType = ability:GetAbilityDamageType()

     
	local i = 1
	for _,v in pairs(caster.particletable) do
		if((v[3]-8)<GameRules:GetGameTime()) then
			local targets = FindUnitsInRadius(
			targetTeam,		--caster team
			v[2],		--find position
			nil,					--find entity
			300,					--find radius
		    DOTA_UNIT_TARGET_TEAM_ENEMY,
			targetType,
			0, 
			FIND_ANY_ORDER,
			false
			)
			if(v[3]<GameRules:GetGameTime()) then
				ParticleManager:DestroyParticle(v[1],true)
				table.remove(caster.particletable,i) 
			end
			for _,o in pairs(targets) do
				local damageTable = 
			     	{
		     			victim = o,
			            attacker = caster,
			            damage = 100,
			            damage_type = damageType,
			            ability = ability
			        }
			     ApplyDamage( damageTable )
			end
			i = i+1	
		end
		
	end
		
	-- body
end