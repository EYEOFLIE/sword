function Onfb_10_BOSS_01_01Attacked(keys)
	local caster = keys.caster
	caster:SetHealth(caster:GetHealth() + caster:GetMaxHealth() * 0.02)
	local effectIndex = ParticleManager:CreateParticle("particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_buff.vpcf",PATTACH_CUSTOMORIGIN,caster)
	ParticleManager:SetParticleControl(effectIndex,0,caster:GetOrigin())
	ParticleManager:SetParticleControl(effectIndex,1,caster:GetOrigin())
	ParticleManager:SetParticleControl(effectIndex,2,caster:GetOrigin())
end

function Onfb_07_BOSS_01_01Think(keys)
	local caster = keys.caster
	local targets = keys.target_entities
	for _,v in pairs(targets) do
		local damage_table = {
				victim = v,
				attacker = caster,
				damage = keys.Damage/2,
				damage_type = keys.ability:GetAbilityDamageType(), 
			    damage_flags = keys.ability:GetAbilityTargetFlags()
			}
		UnitDamageTarget(damage_table) 
		local effectIndex = ParticleManager:CreateParticle("particles/units/heroes/hero_lich/lich_frost_nova.vpcf",PATTACH_CUSTOMORIGIN,v)
		ParticleManager:SetParticleControl(effectIndex,0,v:GetOrigin())
		ParticleManager:SetParticleControl(effectIndex,1,v:GetOrigin())
		ParticleManager:SetParticleControl(effectIndex,2,v:GetOrigin())
		ParticleManager:SetParticleControl(effectIndex,3,v:GetOrigin())
	end
end

function Onfb_07_BOSS_03_01Think(keys)
	local caster = keys.caster
	local targets = keys.target_entities
	for _,v in pairs(targets) do
		local damage_table = {
				victim = v,
				attacker = caster,
				damage = keys.Damage/5,
				damage_type = keys.ability:GetAbilityDamageType(), 
			    damage_flags = keys.ability:GetAbilityTargetFlags()
			}
		UnitDamageTarget(damage_table) 
		local effectIndex = ParticleManager:CreateParticle("particles/thd2/heroes/kaguya/ability_kaguya02_buddhist_diamond_b.vpcf",PATTACH_CUSTOMORIGIN,v)
		ParticleManager:SetParticleControl(effectIndex,0,v:GetOrigin())
	end
end

function Onfb_07_BOSS_04_01Start(keys)
	local caster = keys.caster
	local effectIndex = ParticleManager:CreateParticle("particles/units/heroes/hero_phantom_lancer/phantomlancer_illusion_destroy.vpcf",PATTACH_CUSTOMORIGIN,v)
	caster:AddNoDraw()
	ParticleManager:SetParticleControl(effectIndex,0,caster:GetOrigin())
	ParticleManager:SetParticleControl(effectIndex,1,caster:GetOrigin())
	caster:SetContextThink("ability_on_fb_07_boss_04_01_start", 
		function ()
			if GetDistance(caster,keys.target) <= 2000 then
				for i=1,keys.IllusionCount do
					local unit= CreateUnitByName("fb_07_BOSS_04_illusion", keys.target:GetOrigin() + RandomVector(200), true, nil, nil, DOTA_TEAM_BADGUYS )
					unit:SetHealth(caster:GetHealth())
					unit:SetContextThink("ability_on_fb_07_boss_04_01_start_remove",
						function ()
							unit:RemoveSelf()
						end, 
					10.0)
				end
				caster:SetOrigin(keys.target:GetOrigin() + RandomVector(200))
				caster:RemoveNoDraw()
				return nil
			end
			caster:RemoveNoDraw()
			return nil
		end, 
	1.0)
end

function Onfb_07_BOSS_06_01Start(keys)
	local caster = keys.caster
	local target = keys.target
	target:AddNoDraw()
	local effectIndex = ParticleManager:CreateParticle("particles/unit/hsjboss/ability_hsj_fb_07_boss_06_g.vpcf",PATTACH_CUSTOMORIGIN,target)
	ParticleManager:SetParticleControl(effectIndex,0,target:GetOrigin())
	ParticleManager:SetParticleControl(effectIndex,1,target:GetOrigin())
	ParticleManager:SetParticleControl(effectIndex,3,target:GetOrigin())
	local count = 0
	target:SetContextThink("ability_on_fb_07_BOSS_06_01_start", 
		function ()
			if count < 30 then
				local damage_table = {
					victim = target,
					attacker = caster,
					damage = keys.Damage/10,
					damage_type = keys.ability:GetAbilityDamageType(), 
				    damage_flags = keys.ability:GetAbilityTargetFlags()
				}
				UnitDamageTarget(damage_table)
				count = count + 1
				return 0.1
			else
				target:RemoveNoDraw()
				return nil
			end
		end, 
	0.1)
end

function Onfb_07_BOSS_07_01Start(keys)
	local caster = keys.caster
	local target = keys.target
	local effectIndex = ParticleManager:CreateParticle("particles/units/heroes/hero_tinker/tinker_laser.vpcf",PATTACH_CUSTOMORIGIN,caster)
	ParticleManager:SetParticleControl(effectIndex, 0, target:GetOrigin()+Vector(0,0,128))
	ParticleManager:SetParticleControl(effectIndex, 1, caster:GetOrigin()+Vector(0,0,400))
	ParticleManager:SetParticleControl(effectIndex, 9, target:GetOrigin()+Vector(0,0,128))
end

function Onfb_08_BOSS_01Created(keys)
	local caster = keys.caster
	caster:SetContextThink("Onfb_08_BOSS_01Created", 
		function ()
			if( (caster:GetHealth()) ~= (caster:GetMaxHealth()) )then
				local effectIndex = ParticleManager:CreateParticle("particles/unit/boss/ability_fb_boss_08_01.vpcf",PATTACH_CUSTOMORIGIN,caster)
				ParticleManager:SetParticleControl(effectIndex, 0, caster:GetOrigin())
				ParticleManager:SetParticleControl(effectIndex, 1, caster:GetOrigin())
				local decreaseHealth = caster:GetHealth()/caster:GetMaxHealth()
				caster:SetBaseAttackTime(0.5*decreaseHealth)
				caster:SetBaseDamageMax(60000*(2-decreaseHealth))
				caster:SetBaseDamageMin(60000*(2-decreaseHealth))
			end
			return 0.2
		end, 
	0.2)
end

function Onfb_fb_09_BOSS_01Think(keys)
	local caster = keys.caster
	local targets = keys.target_entities
	local effectIndex1 = ParticleManager:CreateParticle("particles/units/heroes/hero_life_stealer/life_stealer_loadout.vpcf",PATTACH_CUSTOMORIGIN,caster)
	ParticleManager:SetParticleControl(effectIndex1,0,caster:GetOrigin())
	ParticleManager:SetParticleControl(effectIndex1,1,caster:GetOrigin())
	for _,v in pairs(targets) do
		local damage_table = {
				victim = v,
				attacker = caster,
				damage = keys.Damage/5,
				damage_type = keys.ability:GetAbilityDamageType(), 
			    damage_flags = keys.ability:GetAbilityTargetFlags()
			}
		UnitDamageTarget(damage_table) 
		caster:SetHealth(caster:GetHealth() + keys.Damage)
		local effectIndex = ParticleManager:CreateParticle("particles/econ/events/newbloom_2015/shivas_guard_flash_nian2015.vpcf",PATTACH_CUSTOMORIGIN,v)
		ParticleManager:SetParticleControl(effectIndex,0,v:GetOrigin())
		ParticleManager:SetParticleControl(effectIndex,1,v:GetOrigin())
	end
end

function Onfb_11_BOSS_01_01Start(keys)
	local caster = keys.caster
	local effectIndex = ParticleManager:CreateParticle("particles/units/heroes/hero_phantom_lancer/phantomlancer_illusion_destroy.vpcf",PATTACH_CUSTOMORIGIN,v)
	caster:AddNoDraw()
	ParticleManager:SetParticleControl(effectIndex,0,caster:GetOrigin())
	ParticleManager:SetParticleControl(effectIndex,1,caster:GetOrigin())
	caster:SetContextThink("ability_on_fb_11_BOSS_01_01_start", 
		function ()
			if GetDistance(caster,keys.target) <= 2000 then
				for i=1,keys.IllusionCount do
					local unit= CreateUnitByName("fb_11_BOSS_01_illusion", keys.target:GetOrigin() + RandomVector(200), true, nil, nil, DOTA_TEAM_BADGUYS )
					unit:SetHealth(caster:GetHealth())
					unit:SetContextThink("ability_on_fb_11_BOSS_01_01_start_remove",
						function ()
							unit:RemoveSelf()
						end, 
					10.0)
				end
				if GetDistance(caster,keys.target) <= 2000 then
					caster:SetOrigin(keys.target:GetOrigin() + RandomVector(200))
				end
				caster:RemoveNoDraw()
				return nil
			end
			caster:RemoveNoDraw()
			return nil
		end, 
	1.0)
end

function Onfb_11_BOSS_02_01AttackLanded(keys)
	local caster = keys.caster
	local target = keys.target
	local effectIndex = ParticleManager:CreateParticle("particles/units/heroes/hero_omniknight/omniknight_purification.vpcf",PATTACH_CUSTOMORIGIN,target)
	ParticleManager:SetParticleControl(effectIndex,0,target:GetOrigin())
	ParticleManager:SetParticleControl(effectIndex,1,Vector(100,100,100))
	ParticleManager:SetParticleControl(effectIndex,2,target:GetOrigin())

	local dealdamage = keys.damage
	local merits = caster:GetContext("hero_xiuwei")

	if caster:GetContext("hero_xiuwei")~=nil then
		dealdamage = keys.damage + merits
	end
	
	local damage_table = {
			victim = target,
			attacker = caster,
			damage = dealdamage,
			damage_type = keys.ability:GetAbilityDamageType(), 
			damage_flags = keys.ability:GetAbilityTargetFlags()
	}
	UnitDamageTarget(damage_table)
end