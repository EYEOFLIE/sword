function hsj_cooldown_reset(keys)
	local caster = keys.caster
	local ability=caster:GetAbilityByIndex(1)
	if ability~=nil then
		ability:EndCooldown()
	end
end



function teleport(keys)
	local caster = keys.caster
    local target = keys.target
    print("pointvec:",point)
    caster:SetOrigin(target:GetOrigin()+RandomVector(200) ) 
end


function transfer(keys)
	local point = keys.target_points[1]
	local caster = keys.caster
	local transfert = Entities:FindAllByName("TeleportStone_3") 
	local length = 99999
	local target = nil
	local jidi = Entities:FindByName(nil,"dota_goodguys_fort")
	print(3333)
	table.insert(transfert,jidi)
	for _,unit in pairs(transfert) do
		local distance = (unit:GetOrigin()-point):Length()
		if length >= distance then
			target = unit 
			length  = distance
		end
	end
	if target ~= nil then
		print(3333)
		local new_pos = target:GetOrigin()
		if target:GetName() == "dota_goodguys_fort" then
			caster:SetOrigin(new_pos + Vector(0,-700,0))
			SetTargetToTraversable(caster)

			local info_1 = CreateUnitByName("npc_dummy_unit",Vector(714.841,245.885,633.519), true, nil, target, target:GetTeam() )
			local info_2 = CreateUnitByName("npc_dummy_unit",Vector(-796.011,302.542,645.48), true, nil, target, target:GetTeam() )
			local info_3 = CreateUnitByName("npc_dummy_unit",Vector(-893.797,-1181.53,638.879), true, nil, target, target:GetTeam() )
			local info_4 = CreateUnitByName("npc_dummy_unit",Vector(674.861,-1270.69,643.146), true, nil, target, target:GetTeam() )

			local effectIndex = ParticleManager:CreateParticle("particles/enviroment/main_city/dragon_firebreath.vpcf",PATTACH_CUSTOMORIGIN,info_1)
			ParticleManager:SetParticleControl(effectIndex,0,Vector(714.841,245.885,633.519))
			ParticleManager:SetParticleControlForward(effectIndex,0,Vector(-1,-1,0))
			ParticleManager:SetParticleControlForward(effectIndex,1,Vector(-1,-1,0))
			ParticleManager:SetParticleControlForward(effectIndex,3,Vector(-1,-1,0))

			effectIndex = ParticleManager:CreateParticle("particles/enviroment/main_city/dragon_firebreath.vpcf",PATTACH_CUSTOMORIGIN,info_2)
			ParticleManager:SetParticleControl(effectIndex,0,Vector(-796.011,302.542,645.48))
			ParticleManager:SetParticleControlForward(effectIndex,0,Vector(1,-1,0))
			ParticleManager:SetParticleControlForward(effectIndex,1,Vector(1,-1,0))
			ParticleManager:SetParticleControlForward(effectIndex,3,Vector(1,-1,0))

			effectIndex = ParticleManager:CreateParticle("particles/enviroment/main_city/dragon_firebreath.vpcf",PATTACH_CUSTOMORIGIN,info_3)
			ParticleManager:SetParticleControl(effectIndex,0,Vector(-893.797,-1181.53,638.879))
			ParticleManager:SetParticleControlForward(effectIndex,0,Vector(1,1,0))
			ParticleManager:SetParticleControlForward(effectIndex,1,Vector(1,1,0))
			ParticleManager:SetParticleControlForward(effectIndex,3,Vector(1,1,0))

			effectIndex = ParticleManager:CreateParticle("particles/enviroment/main_city/dragon_firebreath.vpcf",PATTACH_CUSTOMORIGIN,info_4)
			ParticleManager:SetParticleControl(effectIndex,0,Vector(674.861,-1270.69,643.146))
			ParticleManager:SetParticleControlForward(effectIndex,0,Vector(-1,1,0))
			ParticleManager:SetParticleControlForward(effectIndex,1,Vector(-1,1,0))
			ParticleManager:SetParticleControlForward(effectIndex,3,Vector(-1,1,0))

			info_1:SetContextThink("particle_info_1", 
				function()
					info_1:RemoveSelf()
					return nil
				end, 
			3.0)
			info_2:SetContextThink("particle_info_2", 
				function()
					info_2:RemoveSelf()
					return nil
				end, 
			3.0)
			info_3:SetContextThink("particle_info_3", 
				function()
					info_3:RemoveSelf()
					return nil
				end, 
			3.0)
			info_4:SetContextThink("particle_info_4", 
				function()
					info_4:RemoveSelf()
					return nil
				end, 
			3.0)
			PlayerResource:SetCameraTarget(caster:GetPlayerOwnerID(),caster)
			Timers:CreateTimer(0.5,function ()
	            
	                PlayerResource:SetCameraTarget(caster:GetPlayerOwnerID(),nil)
	            end)
		else
			FindClearSpaceForUnit(caster, new_pos, true)
			PlayerResource:SetCameraTarget(caster:GetPlayerOwnerID(),caster)
			Timers:CreateTimer(0.5,function()
	                PlayerResource:SetCameraTarget(caster:GetPlayerOwnerID(),nil)
	            end)
		end
		--SetTargetToTraversable(caster)
	end
	
	local effectIndex = ParticleManager:CreateParticle("particles/econ/events/ti5/teleport_end_ground_flash_ti5.vpcf",PATTACH_CUSTOMORIGIN_FOLLOW,target)
	ParticleManager:SetParticleControl(effectIndex,0,target:GetOrigin())
	ParticleManager:SetParticleControl(effectIndex,2,target:GetOrigin())
end

function hsj_courier_item_blink(keys)
	local point = keys.target_points
	local caster =keys.caster
	caster:SetOrigin(point[1])
end
function hsj_courier_item_sell(keys)
	local target = keys.target
	local caster = keys.caster
	local plyID = caster:GetPlayerOwnerID()
	if target:IsItem() then
		local cost = target:GetCost()/2
		local curgold = PlayerResource:GetGold(plyID)
		PlayerResource:SetGold(plyID,curgold+cost,true)
		target:RemoveSelf()
	else
		GameRules:SendCustomMessage("Can`t Sell this Item!",caster:GetTeamNumber(),1)
	end
end

function hsj_OnHeroAttackLanded(keys)
	local target = keys.target
	local caster = keys.caster
	local deal_damage = GetHsjDealDamage( 
			caster, 
			caster:GetPrimaryAttribute(), 
			0.2, 
			20, 
			GetHeroItemKind(caster), 
			1000
	)
	local damage_table = {
		victim = target,
		attacker = caster,
		damage = deal_damage/5,
		damage_type = DAMAGE_TYPE_MAGICAL, 
		damage_flags = DOTA_UNIT_TARGET_FLAG_NONE
	}
	UnitDamageTarget(damage_table)
end

function hsj_OnGodAttacked(keys)
	local target = keys.attacker
	local caster = keys.caster
	local deal_damage = GetHsjDealDamage( 
			caster, 
			caster:GetPrimaryAttribute(), 
			0.2, 
			20, 
			GetHeroItemKind(caster), 
			1000
	)
	local damage_table = {
		victim = target,
		attacker = caster,
		damage = deal_damage/5,
		damage_type = DAMAGE_TYPE_MAGICAL, 
		damage_flags = DOTA_UNIT_TARGET_FLAG_NONE
	}
	UnitDamageTarget(damage_table)
	local effectIndex = ParticleManager:CreateParticle("particles/units/heroes/hero_omniknight/omniknight_purification.vpcf",PATTACH_CUSTOMORIGIN_FOLLOW,target)
	ParticleManager:SetParticleControl(effectIndex,0,target:GetOrigin())
	ParticleManager:SetParticleControl(effectIndex,1,Vector(1,1,1))
	ParticleManager:SetParticleControl(effectIndex,2,target:GetOrigin())
end

function hsj_OnDemonAttackLanded(keys)
	local target = keys.target
	local caster = keys.caster

	local deal_damage = GetHsjDealDamage( 
			caster, 
			caster:GetPrimaryAttribute(), 
			0.2, 
			20, 
			GetHeroItemKind(caster), 
			1000
	)
	local damage_table = {
		victim = target,
		attacker = caster,
		damage = deal_damage/3,
		damage_type = DAMAGE_TYPE_MAGICAL, 
		damage_flags = DOTA_UNIT_TARGET_FLAG_NONE
	}
	UnitDamageTarget(damage_table)
	local effectIndex = ParticleManager:CreateParticle("particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_transform.vpcf",PATTACH_CUSTOMORIGIN_FOLLOW,target)
	ParticleManager:SetParticleControl(effectIndex,0,target:GetOrigin())
end


function zhiliao( keys )
	if 1==1 then
	return end
	local caster = keys.caster
	PrintTable(keys)
	print(caster:GetHealth())
	print(caster:GetUnitName())
	print(222)
	print(keys.unit:GetUnitName())
	
	-- body
end

function adddamagetable( keys)

	local attacker=keys.attacker
	local caster = keys.caster

	local isadd=0
	
	if caster.takedamagetable == nil then
	return end
	for _,v in pairs(caster.takedamagetable) do
		
		if v[1]==attacker then
			v[2]=v[2]+keys.DamageTaken
			isadd=1
			v[4]=GameRules:GetGameTime()
			v[5]=1
		end
	end
	if isadd==0 then
		local herotable={}
		herotable[1]=attacker
		herotable[2]=keys.DamageTaken
		herotable[3]=keys.attacker:GetUnitName()
		herotable[4]=GameRules:GetGameTime()
		herotable[5]=1
		table.insert(caster.takedamagetable,herotable)
		local enemies = FindUnitsInRadius( caster:GetTeam(), caster:GetOrigin(), nil, 800, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, 0, 0, false )
		for _,v in pairs(enemies) do
			
			--v:MoveToTargetToAttack(attacker)
		end
	end
	
	

	table.sort(caster.takedamagetable, sortFunc)
	

	--PrintTable(caster.takedamagetable)

	-- body
end
function creep_enemy_think(keys)
	local targets = keys.target_entities
	local caster = keys.caster
	local ability = keys.ability

	if targets~= nil then
		caster.IsAIstart = true
	else
		caster.IsAIstart = false
	end
	if(caster.chuposition==nil)then
	caster.chuposition=caster:GetOrigin()
	caster.chuforward=caster:GetForwardVector()
	caster.churange=caster:GetAcquisitionRange()
	caster.takedamagetable={}
		for i = 1, #MAIN_HERO_TABLE, 1 do
		local herotable={}
		herotable[1]=MAIN_HERO_TABLE[i]
		herotable[2]=0
		herotable[3]=MAIN_HERO_TABLE[i]:GetUnitName()
		herotable[4]=0
		herotable[5]=1
		table.insert(caster.takedamagetable,herotable)
		end	

	end
	--if caster.takedamagetable[1][1]::GetAssignedHero() then
	--	caster:SetAttacking(caster.takedamagetable[1][1])
	--end
	
	if next(caster.takedamagetable) ~= nil then 
		--caster:MoveToTargetToAttack(caster.takedamagetable[1][1])
		if caster.takedamagetable[1][1] then
		  
		  table.remove(caster.takedamagetable,1) 
		end
		table.sort(caster.takedamagetable, sortFunc)
		if next(caster.takedamagetable) ~= nil then 
		--caster:MoveToTargetToAttack(caster.takedamagetable[1][1])
		
			for _,v in pairs(caster.takedamagetable) do
				if v[2]<50 then
					v[2]=0
				else
					v[2]=v[2]-20
				end
				
			end
			if caster.takedamagetable[1][2]>0 then
				
				
			end
			
			if caster.takedamagetable[1][4]+5<GameRules:GetGameTime() and caster.takedamagetable[1][5]==1 then
				--print(333)
				--caster:SetAggroTarget(nil)
				--caster.takedamagetable[1][5]=2
			end
			
		end
	end

	local damageState = CustomNetTables:GetTableValue("HeroInfo", "aggrtable")	
	local unitIndex = caster:GetEntityIndex()
	--print(tostring(unitIndex))
	damageState[tostring(unitIndex)] = caster.takedamagetable
	if caster:GetUnitName()=="npc_cike3_BOSS" then
		--print(222)
				if caster:GetAggroTarget() then 
					--print(444444444)
					--print(caster:GetAggroTarget():GetUnitName())
				end
		--CustomNetTables:SetTableValue("HeroInfo", "aggrtable", damageState)
	end

	
	--PrintTable(oldheroState)
end

function cancelattackhero(keys)
	local caster = keys.caster
	local ability = keys.ability
	if caster:GetUnitName()=="npc_cike3_BOSS" then
		
		if caster:GetAggroTarget() then 
			if((caster:GetOrigin()-caster:GetAggroTarget():GetOrigin()):Length2D()>1000)then 
				caster:SetAggroTarget(nil)
				caster:Stop()
			end
	
		end
		--CustomNetTables:SetTableValue("HeroInfo", "aggrtable", damageState)
	end
	if caster.chuposition then
		if ((caster:GetOrigin()-caster.chuposition):Length2D()>1500) then
			ability:ApplyDataDrivenModifier(caster, caster, "modifier_back_position", nil)
		end
	end
	
end


function back_position(keys)
	
	local caster = keys.caster
	local ability = keys.ability

	if(caster.chuposition~=nil)then
		
		caster:MoveToPosition(caster.chuposition)
		--print((caster:GetOrigin()-caster.chuposition):Length2D())
		if((caster:GetOrigin()-caster.chuposition):Length2D()<100)then 
			caster:Stop()
			--caster:SetOrigin(caster.chuposition)
			caster:SetForwardVector(caster.chuforward)
			
			caster:RemoveModifierByName("modifier_back_position")
			
			if(caster:GetUnitName()=="npc_cike3_BOSS") then
			caster:RemoveModifierByName("modifier_ai_out_ability")
			local ability_01 = caster:FindAbilityByName("Ability_BOSS_lanaya")
			ability_01:ApplyDataDrivenModifier(caster, caster, "modifier_ai_chufa", nil)
			--caster:GiveMana(1010000)
			end
		end
						
		        		

	end
	
end