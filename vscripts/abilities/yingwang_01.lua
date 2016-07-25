function getchanneltime(event )
	local caster = event.caster
	caster.time=GameRules:GetDOTATime(true,true)
 	
end

function begin_splitshot(event)
	-- Dungeons:Debug()
	-- local cheats = Convars:GetBool("developer")


	local caster = event.caster
	local endtime = GameRules:GetDOTATime(true,true)
	local begintime=endtime-caster.time
	caster.begintime=begintime
	local ability = event.ability
	local abilityLevel = ability:GetLevel()-1
	local location = caster:GetOrigin() + caster:GetForwardVector()*Vector(80,80,0)
	local forwardVector =caster:GetForwardVector()
	local range=ability:GetLevelSpecialValueFor("range", abilityLevel)
	local procs = 0
	local range=event.range


	ability.fv = forwardVector
	ability.damage = event.damage
	EmitSoundOn("Hero_DrowRanger.FrostArrows", caster)
	EndAnimation(caster)
	caster.location=location

	projectileParticle = event.effect_name

    Timers:CreateTimer(0.20,
	  function()
		arrowOrigin = location
		create_shot2(abilityLevel, caster,  forwardVector, ability, arrowOrigin,  range, damage, projectileParticle)
		local manaCost = ability:GetManaCost(abilityLevel)
		caster:ReduceMana(manaCost)
	 end)
  
  Filters:CastSkillArguments(2, caster)
	
end
function begin_channel(event)
	local caster = event.caster
	StartAnimation(caster, {duration=3, activity=ACT_DOTA_ATTACK, rate=0.3})

end

function create_shot2(abilityLevel, caster,  fv, arrowAbility, arrowOrigin,  range, damage, projectileParticle)
		local start_radius = 110
		local end_radius = 110
		local speed = 1000

		local info = 
		{
				Ability = arrowAbility,
		    	EffectName = projectileParticle,
		    	vSpawnOrigin = arrowOrigin,
		    	fDistance = range,
		    	fStartRadius = start_radius,
		    	fEndRadius = end_radius,
		    	Source = caster,
		    	StartPosition = "attach_origin",
		    	bHasFrontalCone = true,
		    	bReplaceExisting = false,
		    	iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		    	iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		    	iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		    	fExpireTime = GameRules:GetGameTime() + 5.0,
			bDeleteOnHit = false,
			vVelocity = fv * speed,
			bProvidesVision = false

		}	
		
		projectile = ProjectileManager:CreateLinearProjectile(info)
		
end

function arrow_strike(event)
	local target = event.target
	local caster = event.caster
	local ability = event.ability
	local damage = event.ability.damage*caster.begintime
	Filters:TakeArgumentsAndApplyDamage(target, caster, damage, DAMAGE_TYPE_MAGICAL, 2)
end


function jianrenfengbao(keys)
	local ability = keys.ability
local caster = keys.caster
local target = keys.target
local targetTeam = ability:GetAbilityTargetTeam() -- DOTA_UNIT_TARGET_TEAM_ENEMY
local targetType = ability:GetAbilityTargetType() -- DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
local targetFlag = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
local damageType = ability:GetAbilityDamageType()
local ability_level = ability:GetLevel() - 1
local abilityDamage = caster:GetAverageTrueAttackDamage() * ability:GetLevelSpecialValueFor("damage", ability_level)
local casterPos = caster:GetAbsOrigin()

	

    Timers:CreateTimer(
    	function ()
    		local times = 0
        	local interval = 1
        	Timers:CreateTimer(
        	function ()
	        		if times < 10 then
					     local units = FindUnitsInRadius( caster:GetTeamNumber(),caster:GetAbsOrigin(), caster, 500,
			            targetTeam, targetType, targetFlag, 0, false )
					     for k,v in pairs ( units ) do
					     	local damageTable = 
					     	{
				     			victim = v,
					            attacker = caster,
					            damage = abilityDamage,
					            damage_type = damageType
					        }
					     ApplyDamage( damageTable )
					     ability:ApplyDataDrivenModifier(caster, v, "modifier_jianrenfengbao", {duration = 1})
					   
					    end
					    times = times + 1
					    return 1
	        		end
	        	end	
        	)

    	end	-- body
    )	
end

function create(keys )
	local caster = keys.caster
	local casterPos = caster:GetAbsOrigin()
	particleID= ParticleManager:CreateParticle(keys.effect_name, PATTACH_CUSTOMORIGIN_FOLLOW,caster)
	ParticleManager:SetParticleControl(particleID,0,casterPos)
	caster.particleID=particleID
	-- body
end

function destroy(keys )
	local caster = keys.caster
	
	if caster.particleID then
		ParticleManager:DestroyParticle(caster.particleID,true)

	end
	
	-- body
end