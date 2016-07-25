
function trigger_quest_npc_0001( data )
	local target = data.activator

	--thisEntity:AddSpeechBubble(1,"#hsj_task_01_recive",5.0,0,0)

	--unit=Entities:FindByName(nil, "npc_task_fb_01_01")

	--print(unit:GetUnitName())
	QuestSystem:OnArriveTrigger(target,thisEntity)
	print("tiejiang")
	event="tiejiang"

	CustomGameEventManager:Send_ServerToPlayer(target:GetPlayerOwner(),event,{open=true}) 
end

function tiejiangout( data )
	local target = data.activator

	--thisEntity:AddSpeechBubble(1,"#hsj_task_01_recive",5.0,0,0)

	--unit=Entities:FindByName(nil, "npc_task_fb_01_01")

	--print(unit:GetUnitName())
	--QuestSystem:OnArriveTrigger(target,thisEntity)
	print("tiejiang2")
	event="tiejiang"
	
	CustomGameEventManager:Send_ServerToPlayer(target:GetPlayerOwner(),event,{open=false}) 

end

function trigger_quest_npc_0002( data )
	local target = data.activator
	local caller = data.caller
	--thisEntity:AddSpeechBubble(1,"#hsj_task_01_recive",5.0,0,0)
	QuestSystem:OnArriveTrigger(target,thisEntity)
end


function trigger_chuansongstart( data )
	local target = data.activator
	local caller = data.caller
	--print(caller:GetOrigin())

	if caller.effectsing==nil then
		local chuansongdummy = CreateUnitByName("npc_chuansong_dummy_vision", caller:GetOrigin(), true, nil, nil, DOTA_TEAM_GOODGUYS)
		effectsing = ParticleManager:CreateParticle("particles/chuansong/teleport_start_winter_major_2016_lvl3.vpcf",PATTACH_ABSORIGIN_FOLLOW,chuansongdummy)
		ParticleManager:SetParticleControl(effectsing,0,chuansongdummy:GetOrigin())
		caller.effectsing=effectsing
		caller.chuansongdummy=chuansongdummy
	
	end
	
	event="chuansong"
	CustomGameEventManager:Send_ServerToPlayer(target:GetPlayerOwner(),event,{open=true})    
	target.chuansongbiaoji=1



end

function trigger_zuge_cangjiange( data )
	local target = data.activator
	local caller = data.caller
	if Firstsystem.zuge_01==1 then
	elseif Firstsystem.zuge_01==2 then
		target:SetOrigin(Vector(-13878.2,-10299.5,1569.88))
		target:Stop()
	end

end

function trigger_chuansongend( data )
	local target = data.activator
	local caller = data.caller
	local enemies = FindUnitsInRadius( DOTA_TEAM_GOODGUYS, caller.chuansongdummy:GetOrigin(), nil, 150, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, 0, 0, false )
	
	if #enemies > 0 then
		
	else
		if caller.effectsing then
		ParticleManager:DestroyParticle(caller.effectsing, false)
		end
	caller.effectsing=nil
	CustomGameEventManager:Send_ServerToPlayer(target:GetPlayerOwner(),event,{open=false})
		
	end
	

end

--新手出生地传送
function trigger_chuansong( data )
	local target = data.activator
	local caller = data.caller
	--print(caller:GetOrigin())
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(target:GetPlayerID()),"diqu",{zhudiqu="location_tianxuanpai",fudiqu=nil})    	

	target:SetOrigin(Vector(-14431.2,-13922.7,2587.36))
	target:Stop()
	Timers:CreateTimer(0.2,function()
						PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),target)
						Timers:CreateTimer(0.5,function()
						PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
						end)
		            end)


end

--新手出生地传送
function trigger_chuansong_second( data )
	local target = data.activator
	local caller = data.caller
	--print(caller:GetOrigin())
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(target:GetPlayerID()),"diqu",{zhudiqu="location_tianxuanpai",fudiqu="location_dizifang"})    	
	target:SetOrigin(Vector(-15160.2,-15354.1,1855.22))
	target:Stop()
	Timers:CreateTimer(0.2,function()
						PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),target)

						Timers:CreateTimer(0.5,function()
						PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
						end)
		            end)


end

function trigger_location( data )
	local target = data.activator
	local caller = data.caller
	print(caller:GetName())
	local Forward=target:GetForwardVector()
	if caller:GetName()=="trigger_chuansong_07" then
		if Forward.x>0 and Forward.y>0 then
		CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(target:GetPlayerID()),"diqu",{zhudiqu="location_tianxuanpai",fudiqu="location_cangjiange"})    	
		else
		CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(target:GetPlayerID()),"diqu",{zhudiqu="location_tianxuanpai",fudiqu=nil})    	
		end

	end
	
	

end