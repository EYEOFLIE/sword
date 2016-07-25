function AbilityCreateEffect( keys )
        local caster = keys.caster
       	local u=6
        local r=200
       
        local tt= {}
        for i = 0,u-1 do
        	tt[i]={}
        	local point=Vector(caster:GetOrigin().x + math.cos(i*2*math.pi/u) * r,caster:GetOrigin().y + math.sin(i*2*math.pi/u) *r,caster:GetOrigin().z+200)
			tt[i]['id']=CreateUnitByName("npc_flying_dummy_vision", point, true, nil, nil, DOTA_TEAM_GOODGUYS)
			tt[i]['id']:AddAbility("dummy_unit"):SetLevel(1)
			tt[i]['id']:AddNewModifier( tt[i]['id'], nil, 'modifier_movespeed_cap', nil )
        	tt[i]['2d']=GetRadBetweenTwoVec2D(caster:GetOrigin(),tt[i]['id']:GetOrigin()) --转换2D坐标
	
	 		
			--UTIL_Remove(visionTracer)
        	
 			
       	end
       	caster.tt=tt

  
   	
end
function SpellThink(keys)
		local caster=EntIndexToHScript(keys.caster_entindex)
		--旋转
		local r=200
		local u=6
		
		
		
			
		for k,v in pairs(caster.tt) do
			
	 		
			local turnVec = Vector(caster:GetOrigin().x + math.cos(v['2d']) * r,caster:GetOrigin().y + math.sin(v['2d']) * r,caster:GetOrigin().z + 300)
			v['id']:SetOrigin(turnVec)

			particleID= ParticleManager:CreateParticle(keys.effect_name,PATTACH_OVERHEAD_FOLLOW,v['id'])
	 		ParticleManager:SetParticleControl(particleID,0,v['id']:GetOrigin())
        	turnVec = Vector(v['id']:GetOrigin().x,v['id']:GetOrigin().y,v['id']:GetOrigin().z-300)
			ParticleManager:SetParticleControl(particleID,1,turnVec)
			particleID= ParticleManager:CreateParticle("particles/econ/items/zeus/lightning_weapon_fx/zuus_lb_cfx_il.vpcf",PATTACH_ABSORIGIN_FOLLOW,v['id'])
			v['2d']= v['2d']+ math.pi/60
		end


end

function givedamage(keys)
	local ability = keys.ability
		local caster=EntIndexToHScript(keys.caster_entindex)
		--旋转
		local damageType = ability:GetAbilityDamageType()


		local targetTeam = ability:GetAbilityTargetTeam() -- DOTA_UNIT_TARGET_TEAM_ENEMY
		local targetType = ability:GetAbilityTargetType() -- DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
		local targetFlag = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES

		
	 		Timers:CreateTimer(
		    	function ()
		    		local times = 0
		        	local interval = 1
		        	Timers:CreateTimer(
		        	function ()
			        		if times < 10 then
			        			for k,v in pairs(caster.tt) do
			
							     local units = FindUnitsInRadius(caster:GetTeamNumber(),v['id']:GetAbsOrigin()-Vector(0,0,300), caster, 50,
					            targetTeam, targetType, targetFlag, 0, false )
							   
							     
								    for o,t in pairs ( units ) do
								    	
								     	local damageTable = 
								     	{
							     			victim = t,
								            attacker = caster,
								            damage = 10000,
								            damage_type = damageType
								        }
								     ApplyDamage( damageTable )
								    
								   
								    end
							    end
							    times = times + 1
							    return 1
			        		end
			        	end	
		        	)

		    	end	-- body
    		)
		
			
			
		


end
function SpellRemove(keys)
	
	local caster = EntIndexToHScript(keys.caster_entindex)
	for k,v in pairs(caster.tt) do
		UTIL_Remove(v['id'])
	end
	caster.tt = nil
	
	
	
end


