
function trigger_tiejiang_npc_putin( data )
	local target = data.activator
	--EmitSoundOn("Shop.Available", target)
	
	event="tiejiang"
	CustomGameEventManager:Send_ServerToPlayer(target:GetPlayerOwner(),event,{open=true}) 
end

function trigger_tiejiang_npc_putout( data )
	local target = data.activator

	
	event="tiejiang"
	CustomGameEventManager:Send_ServerToPlayer(target:GetPlayerOwner(),event,{open=false}) 
end

function trigger_diyizhang( data )
	local target = data.activator
	local caller = data.caller
	if Firstsystem.cunzhang==0 then
	Firstsystem:start(target,thisEntity)
	caller:RemoveSelf()
	end
end

function trigger_xiaogui( data )
	local target = data.activator
	local caller = data.caller
	if Firstsystem.cunzhang==4 then
		caller:RemoveSelf()
		Firstsystem:killmonster(target)
	end

end

function trigger_shuaguairenwu( data )
	local target = data.activator
	local caller = data.caller
	if target:IsHero() then
		if Firstsystem.cunzhang==1 then
			Firstsystem:cunzhangshuaguai(target,thisEntity)
		end
		if Firstsystem.cunzhang==2 then
			--Firstsystem:cunzhangquest_five()
			Firstsystem:cunzhangquest_sec(target,thisEntity)
		end
		if Firstsystem.cunzhang==3 then
			Firstsystem:cunzhangquest_six(target,thisEntity)
			
		end
		

		QuestSystem:OnArriveTrigger(target,thisEntity)
	end
	--caller:RemoveSelf()
end

function trigger_task( data )
	local target = data.activator
	local caller = data.caller
	
	QuestSystem:OnArriveTrigger(target,thisEntity)
	--caller:RemoveSelf()
end


function trigger_shuabing( data )
	local target = data.activator
	local caller = data.caller
	
	Firstsystem:cunkou(target,caller,thisEntity)
	
end

function trigger_quest_02( data )
	local target = data.activator
	local caller = data.caller
	
	Firstsystem:quest_02(target,caller,thisEntity)
	
end

function trigger_renwu( data )
	local target = data.activator
	--print(target:FindAbilityByName("daonv_god"):GetLevelSpecialValueFor("gods_strength_damage", 2))
end


function trigger_juqing( data )
	local target = data.activator
	local caller = data.caller
	if(target:IsHero()) then
		Firstsystem:kaizhang(target)
		--caller:RemoveSelf()
	end
	
	
end