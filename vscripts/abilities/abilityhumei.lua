function OnHumei01SpellStart(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local target = keys.target
	local targets = FindUnitsInRadius(
			caster:GetTeam(),		--caster team
			target:GetOrigin(),		--find position
			nil,					--find entity
			keys.Radius,					--find radius
		    DOTA_UNIT_TARGET_TEAM_ENEMY,
			keys.ability:GetAbilityTargetType(),
			0, 
			FIND_ANY_ORDER,
			false
	)
	local deal_damage = GetHsjDealDamage( 
			caster, 
			keys.AttributeType, 
			keys.AttributeDamageIncrease, 
			keys.AttributeBaseDamage, 
			ITEM_KIND_MAGIC, 
			keys.BaseDamage
	)
	for _,v in pairs(targets) do
		local damage_table = {
			victim = v,
			attacker = caster,
			damage = deal_damage,
			damage_type = keys.ability:GetAbilityDamageType(), 
			damage_flags = keys.ability:GetAbilityTargetFlags()
		}
		UnitDamageTarget(damage_table)
	end
end

function OnHumei01FireEffect(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local target = keys.target
	local effectIndex = ParticleManager:CreateParticle("particles/heroes/sanae/ability_sanea_02_effect.vpcf", PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleControl(effectIndex, 0, target:GetOrigin())
	ParticleManager:SetParticleControl(effectIndex, 1, target:GetOrigin())
	ParticleManager:SetParticleControl(effectIndex, 2, target:GetOrigin())
	ParticleManager:SetParticleControl(effectIndex, 3, target:GetOrigin())
	ParticleManager:SetParticleControl(effectIndex, 5, target:GetOrigin())
	ParticleManager:SetParticleControl(effectIndex, 6, target:GetOrigin())
end

function OnHumei02FireDamage(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local vecCaster = caster:GetOrigin()
	local target = keys.target
	local deal_damage = GetHsjDealDamage( 
			caster, 
			keys.AttributeType, 
			keys.AttributeDamageIncrease, 
			keys.AttributeBaseDamage, 
			ITEM_KIND_MAGIC, 
			keys.BaseDamage
	)
	local damage_table = {
		victim = target,
		attacker = caster,
		damage = deal_damage/5,
		damage_type = keys.ability:GetAbilityDamageType(), 
		damage_flags = keys.ability:GetAbilityTargetFlags()
	}
	UnitDamageTarget(damage_table)
end

function OnHumei03SpellStart(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local MagicMultiState = GetEquipMulti(caster,ITEM_KIND_MAGIC)
	
	caster:SetContextNum("EquipMultiAbility", MagicMultiState, 0)
    
	caster:SetContextThink("ability_humei03_modifier_timer", 
			function()
				caster:SetContextNum("EquipMultiAbility", 0, 0)
				return nil
			end, 
		keys.Duration
	)
end

function OnHumei03CreateTracking(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local target = keys.target

	if target == nil then
		return
	end

	for i=1,4 do
		local swordTable = {
			Target = target,
			Source = caster,
			Ability = keys.ability,	
			EffectName = "particles/neutral_fx/black_dragon_attack.vpcf",
			iMoveSpeed = 1500,
			vSourceLoc= caster:GetAbsOrigin(),
			bDrawsOnMinimap = false, 
	        bDodgeable = true,
	        bIsAttack = false, 
	        bVisibleToEnemies = true,
	        bReplaceExisting = false,
	        flExpireTime = GameRules:GetGameTime() + 10,
			bProvidesVision = true,
			iVisionRadius = 100,
			iVisionTeamNumber = caster:GetTeamNumber(),
			iSourceAttachment = i
		} 
		ProjectileManager:CreateTrackingProjectile(swordTable)
	end
end

function OnHumei03ProjectileHit(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local target = keys.target
	local deal_damage = GetHsjDealDamage( 
			caster, 
			keys.AttributeType, 
			keys.AttributeDamageIncrease, 
			keys.AttributeBaseDamage, 
			ITEM_KIND_MAGIC, 
			keys.BaseDamage
	)
	local damage_table = {
		victim = target,
		attacker = caster,
		damage = deal_damage/4,
		damage_type = keys.ability:GetAbilityDamageType(), 
		damage_flags = keys.ability:GetAbilityTargetFlags()
	}
	UnitDamageTarget(damage_table)
end

function OnHumei04Think(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local vecCaster = caster:GetOrigin()
	local targetPoint =  vecCaster + caster:GetForwardVector() --keys.target_points[1]
	local sparkRad = GetRadBetweenTwoVec2D(vecCaster,targetPoint)
	local findVec = Vector(vecCaster.x + math.cos(sparkRad) * keys.DamageLenth/2,vecCaster.y + math.sin(sparkRad) * keys.DamageLenth/2,vecCaster.z)
	local findRadius = math.sqrt(((keys.DamageLenth/2)*(keys.DamageLenth/2) + (keys.DamageWidth/2)*(keys.DamageWidth/2)))
	local DamageTargets = FindUnitsInRadius(
		   caster:GetTeam(),		--caster team
		   findVec,		            --find position
		   nil,					    --find entity
		   findRadius,		            --find radius
		   DOTA_UNIT_TARGET_TEAM_ENEMY,
		   keys.ability:GetAbilityTargetType(),
		   0, FIND_CLOSEST,
		   false
	    )
	local deal_damage = GetHsjDealDamage( 
			caster, 
			keys.AttributeType, 
			keys.AttributeDamageIncrease, 
			keys.AttributeBaseDamage, 
			ITEM_KIND_MAGIC, 
			keys.BaseDamage
	)
	for _,v in pairs(DamageTargets) do
		local vecV = v:GetOrigin()
		if(IsRadInRect(vecV,vecCaster,keys.DamageWidth,keys.DamageLenth,sparkRad))then
			local damage_table = {
				victim = v,
				attacker = caster,
				damage = deal_damage/5,
				damage_type = keys.ability:GetAbilityDamageType(), 
				damage_flags = 0
			}
			UnitDamageTarget(damage_table)
			UnitStunTarget(caster,v,0.2)
		end
	end
	HumeiSparkParticleControl(caster,targetPoint,keys.ability)
end

function OnHumei04SpellStart(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local targetPoint = keys.target_points[1]
	--[[local forwardVector = caster:GetOrigin()+caster:GetForwardVector()*1000
	local effectIndex = ParticleManager:CreateParticle("particles/thd2/chen_cast_4.vpcf", PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleControl(effectIndex, 0, caster:GetOrigin()+Vector(0,0,64))
	ParticleManager:SetParticleControl(effectIndex, 1, forwardVector)]]--

	local unit = CreateUnitByName(
		"npc_dota2x_unit_marisa04_spark"
		,caster:GetOrigin()
		,false
		,caster
		,caster
		,caster:GetTeam()
	)
	caster.effectcircle = ParticleManager:CreateParticle("particles/heroes/marisa/marisa_04_spark_circle.vpcf", PATTACH_CUSTOMORIGIN, unit)
	ParticleManager:DestroyParticleSystem(caster.effectcircle,false)
	caster.effectIndex = ParticleManager:CreateParticle("particles/thd2/heroes/marisa/marisa_04_spark.vpcf", PATTACH_CUSTOMORIGIN, unit)
	ParticleManager:DestroyParticleSystem(caster.effectIndex,false)
	caster.effectIndex_b = ParticleManager:CreateParticle("particles/thd2/heroes/marisa/marisa_04_spark_wind_b.vpcf", PATTACH_CUSTOMORIGIN, unit)
	ParticleManager:DestroyParticleSystem(caster.effectIndex_b,false)
	keys.ability:SetContextNum("ability_marisa_04_spark_unit",unit:GetEntityIndex(),0)

	HumeiSparkParticleControl(caster,targetPoint,keys.ability)
	keys.ability:SetContextNum("ability_marisa_04_spark_lock",FALSE,0)
end

function HumeiSparkParticleControl(caster,targetPoint,ability)
	local unitIndex = ability:GetContext("ability_marisa_04_spark_unit")
	local unit = EntIndexToHScript(unitIndex)

	if(caster.targetPoint == targetPoint)then
		return
	else
		caster.targetPoint = targetPoint
	end

	if(caster.effectIndex_b ~= -1)then
		ParticleManager:DestroyParticleSystem(caster.effectIndex_b,true)
	end

	if(unit == nil or caster.effectIndex == -1 or caster.effectcircle == -1)then
		print(unit)
		print(caster.effectIndex)
		print(caster.effectcircle)
		return
	end

	caster.effectIndex_b = ParticleManager:CreateParticle("particles/thd2/heroes/marisa/marisa_04_spark_wind_b.vpcf", PATTACH_CUSTOMORIGIN, unit)

	forwardRad = GetRadBetweenTwoVec2D(targetPoint,caster:GetOrigin()) 
	vecForward = Vector(math.cos(math.pi/2 + forwardRad),math.sin(math.pi/2 + forwardRad),0)
	unit:SetForwardVector(vecForward)
	vecUnit = caster:GetOrigin() + Vector(caster:GetForwardVector().x * 100,caster:GetForwardVector().y * 100,160)
	vecColor = Vector(255,255,255)
	unit:SetOrigin(vecUnit)

	ParticleManager:SetParticleControl(caster.effectcircle, 0, caster:GetOrigin())
	
	local effect2ForwardRad = GetRadBetweenTwoVec2D(caster:GetOrigin(),targetPoint) 
	local effect2VecForward = Vector(math.cos(effect2ForwardRad)*850,math.sin(effect2ForwardRad)*850,0) + caster:GetOrigin() + Vector(caster:GetForwardVector().x * 100,caster:GetForwardVector().y * 100,108)
	
	ParticleManager:SetParticleControl(caster.effectIndex, 0, caster:GetOrigin() + Vector(caster:GetForwardVector().x * 92,caster:GetForwardVector().y * 92,150))
	ParticleManager:SetParticleControl(caster.effectIndex, 1, effect2VecForward)
	ParticleManager:SetParticleControl(caster.effectIndex, 2, vecColor)
	local forwardRadwind = forwardRad + math.pi
	ParticleManager:SetParticleControl(caster.effectIndex, 8, Vector(math.cos(forwardRadwind),math.sin(forwardRadwind),0))
	ParticleManager:SetParticleControl(caster.effectIndex, 9, caster:GetOrigin() + Vector(caster:GetForwardVector().x * 100,caster:GetForwardVector().y * 100,108))

	ParticleManager:SetParticleControl(caster.effectIndex_b, 0, caster:GetOrigin() + Vector(caster:GetForwardVector().x * 92,caster:GetForwardVector().y * 92,150))
	ParticleManager:SetParticleControl(caster.effectIndex_b, 8, Vector(math.cos(forwardRadwind),math.sin(forwardRadwind),0))
	ParticleManager:DestroyParticleSystem(caster.effectIndex_b,false)
end


function OnHumei04SpellThink(keys)
	if(keys.ability:GetContext("ability_marisa_04_spark_lock")==FALSE)then
		OnHumei04Think(keys)
	end
end

function OnHumei04SpellRemove(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local unitIndex = keys.ability:GetContext("ability_marisa_04_spark_unit")

	local unit = EntIndexToHScript(unitIndex)
	if(unit~=nil)then
		unit:RemoveSelf()
		caster.effectcircle = -1
		caster.effectIndex = -1
	end
	keys.ability:SetContextNum("ability_marisa_04_spark_lock",TRUE,0)
end