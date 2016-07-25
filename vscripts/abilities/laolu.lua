function yujian(event)
	local caster = event.caster
	local ability = event.ability
	local ability_level = ability:GetLevel() - 1
	local location = caster:GetOrigin() + caster:GetForwardVector()*Vector(100,100,200)
	
	local feijian=CreateUnitByName("npc_sword", location, true, nil, caster, caster:GetTeam())
	partic01 = ParticleManager:CreateParticle( "particles/feijian/veno_toxicant_tail.vpcf", PATTACH_ABSORIGIN_FOLLOW, feijian )
	ParticleManager:SetParticleControlEnt(partic01, 0, feijian, PATTACH_POINT_FOLLOW, "attach_tail_fx", feijian:GetAbsOrigin(), true)
	
	
	
	feijian:SetForwardVector(caster:GetForwardVector())
	

	caster.feijian=feijian
	

	
	StartAnimation(feijian, {duration=1.5, activity=ACT_DOTA_ATTACK, rate=1.5})
	
	if(caster:GetClassname()=="npc_dota_hero_dragon_knight") then 

	end
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_feixing_hero", nil)
	Timers:CreateTimer(1.1,
    	function ()
    		
    		ability:ApplyDataDrivenModifier(caster, feijian, "modifier_feixing",nil)
    		
			
			
		end	-- body
    )

    if caster:IsHero() then	
		caster:SwapAbilities("yujianfeixing", "sword_remove", false, true) 
		caster.removed_spells = {}
	   
	    for i = 0, 7 do
	        local ability_slot = caster:GetAbilityByIndex(i)
	       
	        if ability_slot ~= nil and ability_slot:GetAbilityName() ~= "yujianfeixing" and ability_slot:GetAbilityName() ~= "ability_custom_hero_state" and ability_slot:GetAbilityName() ~= "sword_remove" then
	           -- print(ability_slot, ability_slot:GetAbilityName() )
	            caster.removed_spells[i] = { ability_slot:GetAbilityName(), ability_slot:GetLevel() }
	            --print(caster.removed_spells[i][1], caster.removed_spells[i][2])
	            caster:RemoveAbility(ability_slot:GetAbilityName())
	        end
	    end
	end
end
function feixing(event)
	local  caster = event.caster
	local  target = event.target
	target:SetForwardVector(caster:GetForwardVector())
	target:SetOrigin(Vector(caster:GetOrigin().x,caster:GetOrigin().y,caster:GetOrigin().z+100))
	if(caster:GetClassname()=="npc_dota_hero_dragon_knight") then 
		--StartAnimation(caster, {duration=2, activity=ACT_DOTA_IDLE_RARE, rate=1})
	end

end   

function feixingdongzuo(event)
	local  caster = event.caster
	
	if(caster:GetClassname()=="npc_dota_hero_dragon_knight") then 
		--StartAnimation(caster, {duration=2, activity=ACT_DOTA_IDLE_RARE, rate=1})
	end

end   


function swordremove( event)
	-- print(keys.caster.host:GetUnitName())
    local caster = event.caster
    local ability = event.ability
    
    caster:SwapAbilities("yujianfeixing", "sword_remove", true, false) 

    for i = 0, 7 do
        if caster.removed_spells[i] ~= nil then
           -- print(caster.removed_spells[i][1], caster.removed_spells[i][2])
            caster:AddAbility(caster.removed_spells[i][1])
            caster:GetAbilityByIndex(i):SetLevel(caster.removed_spells[i][2])
        end
    end

   	
    local location=caster:GetOrigin()
    caster.feijian:RemoveSelf()
    	
   
    caster:RemoveModifierByName("modifier_feixing_hero")
 	-- body
end

function addeffect(event)
	
	local caster=event.caster
	partic01 = ParticleManager:CreateParticle( event.effectName, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControlEnt(partic01, 0, caster, PATTACH_POINT_FOLLOW, "attach_weapon", caster:GetAbsOrigin(), true)
	--print(event.effectsName_se)
	partic02 = ParticleManager:CreateParticle( event.effectsName_se, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControl(partic02,3,caster:GetAbsOrigin())
	
	-- body
end

function addcastereffect(event)
	
	local caster=event.caster
	local location = caster:GetOrigin() + caster:GetForwardVector()*Vector(100,100,0)
	EmitSoundOn("sword.fei", caster)
	StartAnimation(caster, {duration=1.5, activity=ACT_DOTA_CAST_ABILITY_7, rate=0.3})
	partic02 = ParticleManager:CreateParticle( "particles/addons_gameplay/tower_good_tintable_lamp_end.vpcf", PATTACH_CUSTOMORIGIN, caster )
	ParticleManager:SetParticleControl(partic02, 0, location)
	
	-- body
end