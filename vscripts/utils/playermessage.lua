
if CPlayerMessage==nil then
	CPlayerMessage={}
	CPlayerMessage.players={}
end

function CPlayerMessage:CreateHeroMessageTable( heroIndex )
	self.players[heroIndex]={
		histroy={},
		max_histroy=30,
		message_duration=0,
		message_color_red=200,
		message_color_green=230,
		message_color_blue=200,
		update_time=0,
		hide_histroy=true,
	}
end

function CPlayerMessage:ToggleHistoryInfo( heroIndex )
	local hero = EntIndexToHScript(heroIndex)
	local player_id = hero:GetPlayerOwnerID() + 1

	if self.players[heroIndex] == nil then
		self:CreateHeroMessageTable(heroIndex)
	end

	self:PutHistroy(heroIndex,255)
	--[[if self.players[heroIndex].hide_histroy then
		self.players[heroIndex].hide_histroy = false
		self:PutHistroy(heroIndex,255)
	else
		self.players[heroIndex].hide_histroy = true
		UTIL_ResetMessageText(player_id)
	end]]--
end

function CPlayerMessage:PutHistroy(heroIndex)
	local player_msg=self.players[heroIndex]
	local hero = EntIndexToHScript(heroIndex)
	local player_id = hero:GetPlayerOwnerID() + 1

	if player_msg then
		-- UTIL_ResetMessageText(player_id)
		local alpha=255
		for i,msg in ipairs(player_msg.histroy) do
			-- UTIL_MessageText(
			-- 	player_id,
			-- 	msg,
			-- 	player_msg.message_color_red,
			-- 	player_msg.message_color_green,
			-- 	player_msg.message_color_blue,
			-- 	alpha)
		end
		-- CustomNetTables:SetTableValue("PlayerInfo", "playerQuestHistroy", player_msg.histroy)
	end
end

function CPlayerMessage:SaveHistory(heroIndex,msg)
	if self.players[heroIndex] == nil then
		self:CreateHeroMessageTable(heroIndex)
	end
	local player_msg=self.players[heroIndex]
	if msg and player_msg then
		--player_msg.hide_histroy=false
		player_msg.update_time=GameRules:GetGameTime()
		player_msg.histroy[#player_msg.histroy+1]=msg
		while #player_msg.histroy>player_msg.max_histroy do
			table.remove(player_msg.histroy,1)
		end

		local oldPlayerMessage = CustomNetTables:GetTableValue("PlayerInfo", "playerSystemMessage")	
		oldPlayerMessage[tostring(heroIndex)] = self.players[heroIndex]
		CustomNetTables:SetTableValue("PlayerInfo", "playerSystemMessage", oldPlayerMessage)

		local hero = EntIndexToHScript(heroIndex)
		CustomGameEventManager:Send_ServerToPlayer(hero:GetPlayerOwner(),"hsj_ui_show_quest_message",{});
	end
end

function CPlayerMessage:SendMessage(heroIndex,msg,vars)
	local hero = EntIndexToHScript(heroIndex)
	CustomGameEventManager:Send_ServerToPlayer(hero:GetPlayerOwner(),"avalon_game_ui_add_message",{npc="avalon_game_ui_message_npc_system",text=tostring(msg),vars=vars})
end

function CPlayerMessage:OnTimer()
	local game_time=GameRules:GetGameTime()
	--[[for heroIndex,player_msg in pairs(self.players) do
		if not player_msg.hide_histroy and game_time-player_msg.update_time>player_msg.message_duration then
			self:PutHistroy(heroIndex)
		end
	end]]--
end

function CPlayerMessage:Init()
	CustomNetTables:SetTableValue("PlayerInfo", "playerSystemMessage", {})
	Timer.Loop 'CPlayerMessage:OnTimer' (1, 0,
	    function(i)
	    	CPlayerMessage:OnTimer()
	    end
	)
end