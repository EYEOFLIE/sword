
function trigger_boss_01( data )
	local target = data.activator
	local caller = data.caller
	local new_pos = thisEntity:GetOrigin()
	FindClearSpaceForUnit(target, new_pos, true)
--local utt=Entities:FindByName(nil, "npc_tiejiang")
	PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
	Timers:CreateTimer(1, 
		function()
       
        	print(target:GetPlayerOwnerID())
            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
       	 	end
    )
    
end


function trigger_hsj_teleport_xuehai( data )
	local target = data.activator
	local caller = data.caller
	local new_pos = thisEntity:GetOrigin()
	FindClearSpaceForUnit(target, new_pos, true)

	PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
	Timer.Wait 'CameraTarget' (0.5,
        function()
            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
        end
    )
end

function trigger_hsj_teleport_donghai( data )
	local target = data.activator
	local caller = data.caller
	local new_pos = thisEntity:GetOrigin()
	FindClearSpaceForUnit(target, new_pos, true)
	PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
	Timer.Wait 'CameraTarget' (0.5,
        function()
            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
        end
    )
end

function trigger_hsj_teleport_guijie( data )
	local target = data.activator
	local caller = data.caller
	local new_pos = thisEntity:GetOrigin()
	FindClearSpaceForUnit(target, new_pos, true)
	PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
	Timer.Wait 'CameraTarget' (0.5,
        function()
            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
        end
    )
end

function trigger_hsj_teleport_fuxi( data )
	local target = data.activator
	local caller = data.caller
	if GetMapName() == "huangshenzui_easy" then
		CPlayerMessage:SendMessage(target:GetEntityIndex(),"#limit_nandu_info")
	elseif GetMapName() == "huangshenzui_normal" then
		CPlayerMessage:SendMessage(target:GetEntityIndex(),"#limit_nandu_info")
	elseif GetMapName() == "huangshenzui_hard" then
		local new_pos = thisEntity:GetOrigin()
		FindClearSpaceForUnit(target, new_pos, true)
		PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
		Timer.Wait 'CameraTarget' (0.5,
	        function()
	            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
	        end
	    )
	elseif GetMapName() == "huangshenzui_impossible" then
		local new_pos = thisEntity:GetOrigin()
		FindClearSpaceForUnit(target, new_pos, true)
		PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
		Timer.Wait 'CameraTarget' (0.5,
	        function()
	            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
	        end
	    )
	end
end

function trigger_hsj_teleport_xuanyuan( data )
	local target = data.activator
	local caller = data.caller
	if GetMapName() == "huangshenzui_easy" then
		CPlayerMessage:SendMessage(target:GetEntityIndex(),"#limit_nandu_info")
	elseif GetMapName() == "huangshenzui_normal" then
		CPlayerMessage:SendMessage(target:GetEntityIndex(),"#limit_nandu_info")
	elseif GetMapName() == "huangshenzui_hard" then
		local new_pos = thisEntity:GetOrigin()
		FindClearSpaceForUnit(target, new_pos, true)
		PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
		Timer.Wait 'CameraTarget' (0.5,
	        function()
	            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
	        end
	    )
	elseif GetMapName() == "huangshenzui_impossible" then
		local new_pos = thisEntity:GetOrigin()
		FindClearSpaceForUnit(target, new_pos, true)
		PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
		Timer.Wait 'CameraTarget' (0.5,
	        function()
	            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
	        end
	    )
	end
end

function trigger_hsj_teleport_shennong( data )
	local target = data.activator
	local caller = data.caller
	if GetMapName() == "huangshenzui_easy" then
		CPlayerMessage:SendMessage(target:GetEntityIndex(),"#limit_nandu_info")
	elseif GetMapName() == "huangshenzui_normal" then
		CPlayerMessage:SendMessage(target:GetEntityIndex(),"#limit_nandu_info")
	elseif GetMapName() == "huangshenzui_hard" then
		local new_pos = thisEntity:GetOrigin()
		FindClearSpaceForUnit(target, new_pos, true)
		PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
		Timer.Wait 'CameraTarget' (0.5,
	        function()
	            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
	        end
	    )
	elseif GetMapName() == "huangshenzui_impossible" then
		local new_pos = thisEntity:GetOrigin()
		FindClearSpaceForUnit(target, new_pos, true)
		PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
		Timer.Wait 'CameraTarget' (0.5,
	        function()
	            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
	        end
	    )
	end
end

function trigger_hsj_teleport_zuwu( data )
	local target = data.activator
	local caller = data.caller
	if GetMapName() == "huangshenzui_easy" then
		CPlayerMessage:SendMessage(target:GetEntityIndex(),"#limit_nandu_info")
	elseif GetMapName() == "huangshenzui_normal" then
		local new_pos = thisEntity:GetOrigin()
		FindClearSpaceForUnit(target, new_pos, true)
		PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
		Timer.Wait 'CameraTarget' (0.5,
	        function()
	            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
	        end
	    )
	elseif GetMapName() == "huangshenzui_hard" then
		local new_pos = thisEntity:GetOrigin()
		FindClearSpaceForUnit(target, new_pos, true)
		PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
		Timer.Wait 'CameraTarget' (0.5,
	        function()
	            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
	        end
	    )
	elseif GetMapName() == "huangshenzui_impossible" then
		local new_pos = thisEntity:GetOrigin()
		FindClearSpaceForUnit(target, new_pos, true)
		PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
		Timer.Wait 'CameraTarget' (0.5,
	        function()
	            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
	        end
	    )
	end
end

function trigger_hsj_teleport_shengren( data )
	local target = data.activator
	local caller = data.caller
	if GetMapName() == "huangshenzui_easy" then
		CPlayerMessage:SendMessage(target:GetEntityIndex(),"#limit_nandu_info")
	elseif GetMapName() == "huangshenzui_normal" then
		CPlayerMessage:SendMessage(target:GetEntityIndex(),"#limit_nandu_info")
	elseif GetMapName() == "huangshenzui_hard" then
		if PlayerResource:GetPlayerCount() == 1 then 
			local new_pos = thisEntity:GetOrigin()
			FindClearSpaceForUnit(target, new_pos, true)
			PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
			Timer.Wait 'CameraTarget' (0.5,
		        function()
		            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
		        end
		    )
		    return
		end
		CPlayerMessage:SendMessage(target:GetEntityIndex(),"#limit_nandu_info")
	elseif GetMapName() == "huangshenzui_impossible" then
		local new_pos = thisEntity:GetOrigin()
		FindClearSpaceForUnit(target, new_pos, true)
		PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
		Timer.Wait 'CameraTarget' (0.5,
	        function()
	            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
	        end
	    )
	end
end

function trigger_hsj_teleport_shangqing( data )
	local target = data.activator
	local caller = data.caller
	if GetMapName() == "huangshenzui_easy" then
		CPlayerMessage:SendMessage(target:GetEntityIndex(),"#limit_nandu_info")
	elseif GetMapName() == "huangshenzui_normal" then
		CPlayerMessage:SendMessage(target:GetEntityIndex(),"#limit_nandu_info")
	elseif GetMapName() == "huangshenzui_hard" then
		local new_pos = thisEntity:GetOrigin()
		FindClearSpaceForUnit(target, new_pos, true)
		PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
		Timer.Wait 'CameraTarget' (0.5,
	        function()
	            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
	        end
	    )
	elseif GetMapName() == "huangshenzui_impossible" then
		local new_pos = thisEntity:GetOrigin()
		FindClearSpaceForUnit(target, new_pos, true)
		PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
		Timer.Wait 'CameraTarget' (0.5,
	        function()
	            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
	        end
	    )
	end
end

function trigger_hsj_teleport_zhouqing( data )
	local target = data.activator
	local caller = data.caller
	if GetMapName() == "huangshenzui_easy" then
		CPlayerMessage:SendMessage(target:GetEntityIndex(),"#limit_nandu_info")
	elseif GetMapName() == "huangshenzui_normal" then
		CPlayerMessage:SendMessage(target:GetEntityIndex(),"#limit_nandu_info")
	elseif GetMapName() == "huangshenzui_hard" then
		local new_pos = thisEntity:GetOrigin()
		FindClearSpaceForUnit(target, new_pos, true)
		PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
		Timer.Wait 'CameraTarget' (0.5,
	        function()
	            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
	        end
	    )
	elseif GetMapName() == "huangshenzui_impossible" then
		local new_pos = thisEntity:GetOrigin()
		FindClearSpaceForUnit(target, new_pos, true)
		PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
		Timer.Wait 'CameraTarget' (0.5,
	        function()
	            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
	        end
	    )
	end
end

function trigger_hsj_teleport_taiqing( data )
	local target = data.activator
	local caller = data.caller
	if GetMapName() == "huangshenzui_easy" then
		CPlayerMessage:SendMessage(target:GetEntityIndex(),"#limit_nandu_info")
	elseif GetMapName() == "huangshenzui_normal" then
		CPlayerMessage:SendMessage(target:GetEntityIndex(),"#limit_nandu_info")
	elseif GetMapName() == "huangshenzui_hard" then
		local new_pos = thisEntity:GetOrigin()
		FindClearSpaceForUnit(target, new_pos, true)
		PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
		Timer.Wait 'CameraTarget' (0.5,
	        function()
	            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
	        end
	    )
	elseif GetMapName() == "huangshenzui_impossible" then
		local new_pos = thisEntity:GetOrigin()
		FindClearSpaceForUnit(target, new_pos, true)
		PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
		Timer.Wait 'CameraTarget' (0.5,
	        function()
	            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
	        end
	    )
	end
end

function trigger_hsj_teleport_yuqing( data )
	local target = data.activator
	local caller = data.caller
	if GetMapName() == "huangshenzui_easy" then
		CPlayerMessage:SendMessage(target:GetEntityIndex(),"#limit_nandu_info")
	elseif GetMapName() == "huangshenzui_normal" then
		CPlayerMessage:SendMessage(target:GetEntityIndex(),"#limit_nandu_info")
	elseif GetMapName() == "huangshenzui_hard" then
		local new_pos = thisEntity:GetOrigin()
		FindClearSpaceForUnit(target, new_pos, true)
		PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
		Timer.Wait 'CameraTarget' (0.5,
	        function()
	            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
	        end
	    )
	elseif GetMapName() == "huangshenzui_impossible" then
		local new_pos = thisEntity:GetOrigin()
		FindClearSpaceForUnit(target, new_pos, true)
		PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
		Timer.Wait 'CameraTarget' (0.5,
	        function()
	            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
	        end
	    )
	end
end

function trigger_hsj_teleport_kunpeng( data )
	local target = data.activator
	local caller = data.caller
	if GetMapName() == "huangshenzui_easy" then
		CPlayerMessage:SendMessage(target:GetEntityIndex(),"#limit_nandu_info")
	elseif GetMapName() == "huangshenzui_normal" then
		CPlayerMessage:SendMessage(target:GetEntityIndex(),"#limit_nandu_info")
	elseif GetMapName() == "huangshenzui_hard" then
		local new_pos = thisEntity:GetOrigin()
		FindClearSpaceForUnit(target, new_pos, true)
		PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
		Timer.Wait 'CameraTarget' (0.5,
	        function()
	            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
	        end
	    )
	elseif GetMapName() == "huangshenzui_impossible" then
		local new_pos = thisEntity:GetOrigin()
		FindClearSpaceForUnit(target, new_pos, true)
		PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),thisEntity)
		Timer.Wait 'CameraTarget' (0.5,
	        function()
	            PlayerResource:SetCameraTarget(target:GetPlayerOwnerID(),nil)
	        end
	    )
	end
end