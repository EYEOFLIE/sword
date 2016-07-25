function daonv_qunchaofeng( event )
    local caster = event.caster
    local ability = event.ability
    local ability_level = ability:GetLevel() - 1
    caster:SetMana(caster:GetMana()+20)
    local pfx = ParticleManager:CreateParticle( event.effectname, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControl(pfx,0,caster:GetOrigin())
	ParticleManager:SetParticleControl(pfx,1,caster:GetForwardVector())
	ParticleManager:SetParticleControl(pfx,2,Vector(500,0,0))
	ParticleManager:SetParticleControl(pfx,3,caster:GetOrigin())

	local pfx2 = ParticleManager:CreateParticle( "particles/rain_fx/econ_snow.vpcf", PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl(pfx2,0,caster:GetOrigin())
	PrintTable(SceneEntity:FindCamera())
end


function daonv_danchaofeng( event )
    local caster = event.caster
    local ability = event.ability
    local ability_level = ability:GetLevel() - 1
    caster:SetMana(caster:GetMana()+20)
    local pfx = ParticleManager:CreateParticle( event.effectname, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControl(pfx,0,caster:GetOrigin())
	ParticleManager:SetParticleControl(pfx,1,caster:GetForwardVector())
	ParticleManager:SetParticleControl(pfx,2,Vector(500,0,0))
	ParticleManager:SetParticleControl(pfx,3,caster:GetOrigin())
end


function addtarget(event)
	local caster = event.caster
    local ability = event.ability
    local target = event.target
    local ability_level = ability:GetLevel() - 1
    local isadd=0
    
        if target.takedamagetable == nil then
           target.takedamagetable={}
            local herotable={}
            herotable[1]=caster
            herotable[2]=100000
            herotable[3]=caster:GetUnitName()
            herotable[4]=GameRules:GetGameTime()
            herotable[5]=1
            table.insert(target.takedamagetable,herotable)
        else
            for _,v in pairs(target.takedamagetable) do
            
                if  v[1]==caster then
                    v[2]=v[2]+100000
                    v[4]=GameRules:GetGameTime()
                    v[5]=1
                    isadd=1
                end
            end

            if isadd==0 then
            local herotable={}
            herotable[1]=caster
            herotable[2]=100000
            herotable[3]=caster:GetUnitName()
            herotable[4]=GameRules:GetGameTime()
            herotable[5]=1
            table.insert(target.takedamagetable,herotable)
           
            end

        end
  
        table.sort(target.takedamagetable, sortFunc)
        --PrintTable(target.takedamagetable)
	-- body
end

function deltarget(event)
	local caster = event.caster
    local ability = event.ability
    local target = event.target
    local ability_level = ability:GetLevel() - 1

    if target.takedamagetable ~= nil then
          
       
        for _,v in pairs(target.takedamagetable) do
        
            if  v[1]==caster then
                v[2]=v[2]-100000
                v[4]=GameRules:GetGameTime()
                v[5]=1
                isadd=1
            end
        end
      table.sort(target.takedamagetable, sortFunc)
  	end
    --PrintTable(target.takedamagetable)
	-- body
end
