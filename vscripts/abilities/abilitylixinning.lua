function Onlixinning01CreateTracking(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local targets = FindUnitsInRadius(
			caster:GetTeam(),		--caster team
			caster:GetOrigin(),		--find position
			nil,					--find entity
			500,					--find radius
		    DOTA_UNIT_TARGET_TEAM_ENEMY,
			keys.ability:GetAbilityTargetType(),
			0, 
			FIND_ANY_ORDER,
			false
	)

	if targets[1] == nil then
		return
	end

	local swordTable = {
		Target = targets[1],
		Source = caster,
		Ability = keys.ability,	
		EffectName = "particles/heroes/lixinning/ability_lixinning01_swords_base_attack.vpcf",
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
		iVisionTeamNumber = caster:GetTeamNumber()
	} 
	ProjectileManager:CreateTrackingProjectile(swordTable)

	--caster:EmitSound("Voice_Hsj_lixinning.Abilitylixinning012")
end

function Onlixinning01DealDamage(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)

	local damage_table = {
		victim = keys.target,
		attacker = caster,
		damage = caster.ability_lixinning01_dealdamage,
		damage_type = keys.ability:GetAbilityDamageType(), 
	    damage_flags = keys.ability:GetAbilityTargetFlags()
	}
	UnitDamageTarget(damage_table) 
end

function Onlixinning01SpellStart(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local swordCount = 3 + GetHeroMultiState(caster)
	caster.swordCount = swordCount
	local deal_damage = GetHsjDealDamage( 
			caster, 
			keys.AttributeType, 
			keys.AttributeDamageIncrease, 
			keys.AttributeBaseDamage, 
			ITEM_KIND_SWORD, 
			keys.BaseDamage
	)

	caster.lixinning01Swords = {}

	-- ´´½¨ÐÇÐÇ
	for i = 0,swordCount-1 do
		local vec = Vector(caster:GetOrigin().x + math.cos(i*2*math.pi/swordCount) * 100,caster:GetOrigin().y + math.sin(i*2*math.pi/swordCount) * 100,caster:GetOrigin().z + 100)
		local unit = CreateUnitByName(
		"npc_hsj_unit_lixinning01_sword"
		,vec
		,false
		,caster
		,caster
		,caster:GetTeam()
		)
		unit:SetContextNum("ability_lixinning01_unit_rad",GetRadBetweenTwoVec2D(caster:GetOrigin(),vec),0)
		unit.hero = caster
		unitAbility = unit:FindAbilityByName("ability_hsj_lixinning01_dealdamage")
		unitAbility:SetLevel(1)
		unit.ability_lixinning01_dealdamage = deal_damage/3
		unit.upVector = unit:GetUpVector()
		unit:SetForwardVector(unit.upVector)
		unit.hero = caster
		
		--[[local effectIndex
		effectIndex = ParticleManager:CreateParticle("particles/heroes/liningxin/ability_liningxin_sword.vpcf", PATTACH_CUSTOMORIGIN, unit)
		ParticleManager:SetParticleControlEnt(effectIndex , 0, unit, 5, "follow_origin", Vector(0,0,0), true)]]--

		Timer.Wait 'ability_lixinning01_sword_release' (keys.AbilityDuration,
			function()
				if not unit:IsNull() and unit ~= nil then
					unit:ForceKill(true)
				end
			end
	    )
		table.insert(caster.lixinning01Swords,unit)
	end
end

function Onlixinning01SpellThink(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local vCaster = caster:GetOrigin()
	local swords = caster.lixinning01Swords
	for _,v in pairs(swords) do
		local vVec = v:GetOrigin() 
		local turnRad = v:GetContext("ability_lixinning01_unit_rad") + math.pi/120
		v:SetContextNum("ability_lixinning01_unit_rad",turnRad,0)
		local turnVec = Vector(vCaster.x + math.cos(turnRad) * 100,vCaster.y + math.sin(turnRad) * 100,vCaster.z + 100)
		v:SetOrigin(turnVec)
		v:SetForwardVector(v.upVector)
	end
end

function Onlixinning01SpellRemove(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	for _,v in pairs(caster.lixinning01Swords) do
		v:SetOrigin(v:GetOrigin() - Vector(0,0,300))
		v:ForceKill(true)
	end
	caster.lixinning01Swords = {}
end

function OnLixinning02SpellStart(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local EquipMultiAbility = caster:GetContext("EquipMultiAbility")

	EquipMultiAbility = EquipMultiAbility + keys.EquipMulti
	caster:SetContextNum("EquipMultiAbility", EquipMultiAbility, 0)
	caster:SetContextThink("ability_lixinning02_modifier_timer", 
			function()
				EquipMultiAbility = EquipMultiAbility - keys.EquipMulti
				caster:SetContextNum("EquipMultiAbility", EquipMultiAbility, 0)
				return nil
			end, 
		keys.Duration
	)
end
function OnLixinning2DealDamage(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local targets = keys.target_entities

	local deal_damage = GetHsjDealDamage( 
			caster, 
			keys.AttributeType, 
			keys.AttributeDamageIncrease, 
			keys.AttributeBaseDamage, 
			ITEM_KIND_SWORD, 
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
		local effectIndex = ParticleManager:CreateParticle("particles/heroes/wenjian/wenjian_01_effect_explosion.vpcf",PATTACH_CUSTOMORIGIN_FOLLOW,v)
		ParticleManager:SetParticleControl(effectIndex,0,v:GetOrigin())
		ParticleManager:SetParticleControl(effectIndex,2,v:GetOrigin())
		ParticleManager:SetParticleControl(effectIndex,3,v:GetOrigin())
	end
end
function Onlixinning03CreateTracking(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)

	for i=0,2 do

		local unit = CreateUnitByName(
			"npc_hsj_unit_lixinning01_sword"
			,keys.attacker:GetOrigin() + RandomVector(400)
			,false
			,caster
			,caster
			,caster:GetTeam()
		)
		unit:SetOrigin(unit:GetOrigin() + Vector(0,0,300)) 

		local rad = GetRadBetweenTwoVec2D(unit:GetOrigin(),keys.attacker:GetOrigin())
		unit:SetForwardVector(Vector(math.cos(rad),math.sin(rad),-1))

		local swordTable = {
			Target = keys.attacker,
			Source = unit,
			Ability = keys.ability,	
			EffectName = "particles/heroes/lixinning/ability_lixinning01_swords_base_attack.vpcf",
			iMoveSpeed = 1500,
			vSourceLoc=  unit:GetAbsOrigin(),
			bDrawsOnMinimap = false, 
	        bDodgeable = true,
	        bIsAttack = false, 
	        bVisibleToEnemies = true,
	        bReplaceExisting = false,
	        flExpireTime = GameRules:GetGameTime() + 10,
			bProvidesVision = true,
			iVisionRadius = 100,
			iVisionTeamNumber = caster:GetTeamNumber()
		} 

		Timer.Wait 'ability_lixinning03_sword_release' (0.7,
			function()
				local effectIndex = ParticleManager:CreateParticle("particles/heroes/lixining/ability_lixinning03_explosion.vpcf",PATTACH_CUSTOMORIGIN_FOLLOW,caster)
				ParticleManager:SetParticleControl(effectIndex,0,unit:GetOrigin())
				ParticleManager:SetParticleControl(effectIndex,3,unit:GetOrigin())
				unit:ForceKill(true)
				unit:SetOrigin(unit:GetOrigin() - Vector(0,0,300))
			end
	    )

		ProjectileManager:CreateTrackingProjectile(swordTable)
	end
end

function Onlixinning03DealDamage(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local deal_damage = GetHsjDealDamage( 
			caster, 
			keys.AttributeType, 
			keys.AttributeDamageIncrease, 
			keys.AttributeBaseDamage, 
			ITEM_KIND_SWORD, 
			keys.BaseDamage
	)

	local damage_table = {
		victim = keys.target,
		attacker = caster,
		damage = deal_damage/2,
		damage_type = keys.ability:GetAbilityDamageType(), 
	    damage_flags = keys.ability:GetAbilityTargetFlags()
	}
	UnitDamageTarget(damage_table) 
end

function OnLixinning04SpellStart(keys)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local target = keys.target
	local vecTarget = target:GetOrigin()

	UnitPauseTarget( caster, target, keys.PauseDuration)
	local entity = CreateUnitByName(
		"npc_dummy_unit"
		,vecTarget
		,false
		,caster
		,caster
		,caster:GetTeam()
	)
	local effectIndex = ParticleManager:CreateParticle("particles/heroes/lixining/ability_lixinning04_bagua.vpcf",PATTACH_CUSTOMORIGIN,entity)
	ParticleManager:SetParticleControl(effectIndex,0,target:GetOrigin())
	ParticleManager:SetParticleControl(effectIndex,3,target:GetOrigin())
	ParticleManager:SetParticleControl(effectIndex,4,target:GetOrigin())
	ParticleManager:SetParticleControl(effectIndex,6,target:GetOrigin())
	ParticleManager:DestroyParticleSystemTime(effectIndex,8)

	entity:SetContextThink("ability_lixinning04_swords_release", 
		function()
			entity:RemoveSelf()
			return nil
		end, 
	3.1)

	Timer.Loop 'ability_lixinning04_swords_timer' (0.03, 90,
		function(i)
			local vecRandom = Vector(math.cos(RandomFloat(-math.pi,math.pi))*500,math.cos(RandomFloat(-math.pi,math.pi))*500,RandomInt(0, 300))
			entity:SetOrigin(vecTarget + vecRandom)

			local rad = GetRadBetweenTwoVec2D(entity:GetOrigin(),vecTarget)
			local forwardVec = Vector( math.cos(rad) * 2000 , math.sin(rad) * 2000 , RandomInt(0, 500))

			local swordTable = {
				Ability				= keys.ability,
				EffectName			= "particles/heroes/lixinning/ability_lixinning04_projectile.vpcf",
				vSpawnOrigin		= entity:GetOrigin(),
				fDistance			= 1000,
				fStartRadius		= 120,
				fEndRadius			= 120,
				Source				= entity,
				bHasFrontalCone		= false,
				bReplaceExisting	= false,
				iUnitTargetTeam		= DOTA_UNIT_TARGET_TEAM_ENEMY,
				iUnitTargetFlags	= DOTA_UNIT_TARGET_FLAG_NONE,
				iUnitTargetType		= DOTA_UNIT_TARGET_FLAG_NONE,
				fExpireTime			= GameRules:GetGameTime() + 10.0,
				bDeleteOnHit		= false,
				vVelocity			= forwardVec,
				bProvidesVision		= true,
				iVisionRadius		= 400,
				iVisionTeamNumber	= caster:GetTeamNumber(),
			} 

			ProjectileManager:CreateLinearProjectile(swordTable)
			local deal_damage = GetHsjDealDamage( 
				caster, 
				keys.AttributeType, 
				keys.AttributeDamageIncrease, 
				keys.AttributeBaseDamage, 
				ITEM_KIND_SWORD, 
				keys.BaseDamage
			)

			local damage_table = {
				victim = keys.target,
				attacker = caster,
				damage = deal_damage/5,
				damage_type = keys.ability:GetAbilityDamageType(), 
			    damage_flags = keys.ability:GetAbilityTargetFlags()
			}
			UnitDamageTarget(damage_table) 
		end
	)
end