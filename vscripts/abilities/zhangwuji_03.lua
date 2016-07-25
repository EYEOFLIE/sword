function AbilityCreateEffect( keys )
        local caster = keys.caster
               
        --创建特效
      
        if caster.particleID==nil then
       		createeffect(keys)
       	else
 			SpellRemove(keys)
 			createeffect(keys)
     	end
   	
end
function createeffect(keys)
		local caster = keys.caster
		local particleID={}
        local r=170
		local num=keys.num
 		for i = 0,num-1 do
        	particleID[i]={}
	 		particleID[i]['id']= ParticleManager:CreateParticle(keys.effect_name, PATTACH_ABSORIGIN_FOLLOW,caster)
	 		particleID[i]['cp0']= Vector(caster:GetOrigin().x + math.cos(i*2*math.pi/num) * r,caster:GetOrigin().y + math.sin(i*2*math.pi/num) *r,caster:GetOrigin().z + 170)
	 		particleID[i]['2d']=GetRadBetweenTwoVec2D(caster:GetOrigin(),particleID[i]['cp0']) --转换2D坐标
        	ParticleManager:SetParticleControl(particleID[i]['id'],0,particleID[i]['cp0'])
        	local fv=caster:GetForwardVector()
			if 	fv.x>0	then
			particleID[i]['2d'] = particleID[i]['2d'] + math.pi/60
			else 

			particleID[i]['2d'] = particleID[i]['2d'] - math.pi/60
			end
 			local CP1=Vector(caster:GetOrigin().x + math.cos(particleID[i]['2d']) * r,caster:GetOrigin().y + math.sin(particleID[i]['2d'] ) * r,caster:GetOrigin().z + 170)
			ParticleManager:SetParticleControl(particleID[i]['id'],1,CP1)
       	end
     	caster.particleID=particleID

end
function SpellThink(keys)
		local caster=EntIndexToHScript(keys.caster_entindex)
		--旋转
		local r=170
	
		if caster.particleID then 
			for k,v in pairs(caster.particleID) do

				local turnVec = Vector(caster:GetOrigin().x + math.cos(v['2d']) * r,caster:GetOrigin().y + math.sin(v['2d'] ) * r,caster:GetOrigin().z + 170)
				
	        	ParticleManager:SetParticleControl(v['id'],0,turnVec)
				local fv=caster:GetForwardVector()
				if 	fv.x>0	then
				v['2d'] = v['2d'] + math.pi/60
				else 

				v['2d'] = v['2d'] - math.pi/60
				end
				turnVec = Vector(caster:GetOrigin().x + math.cos(v['2d']) * r,caster:GetOrigin().y + math.sin(v['2d'] ) * r,caster:GetOrigin().z + 170)
				
	        	ParticleManager:SetParticleControl(v['id'],1,turnVec)
	        end
	    end
        


end
function SpellRemove(keys)
	
	local caster = EntIndexToHScript(keys.caster_entindex)
	if caster.particleID then
	for k,v in pairs(caster.particleID) do

			ParticleManager:SetParticleControl(v['id'],1,caster:GetOrigin()-Vector(0,0,300))
			ParticleManager:DestroyParticle(v['id'],true)
			
        end
	end
	caster.particleID = nil
	
	
	
end

function SdddRemove(keys)
	
print(211111)
	
	
end

