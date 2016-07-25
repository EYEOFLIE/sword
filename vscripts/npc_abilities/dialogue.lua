function DialogueThink(event)
	if Events.isTownActive then
		caster = event.caster
		if not caster.hasSpeechBubble then
			local ability = event.ability
			local position = caster:GetAbsOrigin()
			local radius = 300

		    local target_teams = DOTA_UNIT_TARGET_TEAM_FRIENDLY
		    local target_types = DOTA_UNIT_TARGET_HERO
		    local target_flags = DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS
			local units = FindUnitsInRadius(caster:GetTeamNumber(), position, nil, radius, target_teams, target_types, target_flags, FIND_ANY_ORDER, false)

			if #units > 0 then
				if caster.dialogueName then
					if caster.dialogueName == "bearzky" then
						bearzky(caster)
					elseif caster.dialogueName == "merchant" then
						merchant(caster, units)
					elseif caster.dialogueName == "red_fox" then
						red_fox(caster)
					elseif caster.dialogueName == "beaver" then
						beaver(caster)
					elseif caster.dialogueName == "beer_bear" then
						beer_bear(caster)
					elseif caster.dialogueName == "owl" then
						owl(caster)
					elseif caster.dialogueName == "chest_brothers" then
						chest_brothers(caster)
					elseif caster.dialogueName == "rabbit" then
						rabbit(caster)
					elseif caster.dialogueName == "book" then
						book(caster)
					elseif caster.dialogueName == "treant" then
						tree(caster, units)
					elseif caster.dialogueName == "rareShop" then
						rareShop(caster, units)
					elseif caster.dialogueName == "blacksmith" then
						blacksmith(caster, units)
					end
				end
			end
		end
	end
end

function bearzky(caster)
	local time = 5
	local speechSlot = findEmptyDialogSlot()
	if speechSlot < 4 then
		caster:AddSpeechBubble(speechSlot, "#dialogue_bear", time, 0, 0)
		disableSpeech(caster, time, speechSlot)
	end
end

function merchant(caster, units)
	--MERCHANT_OPEN_SOUND_TABLE = {"secretshop_secretshop_welcome_04", "secretshop_secretshop_whatyoubuying_01", "secretshop_secretshop_whatyoubuying_02"}
	local time = 5
	local speechSlot = findEmptyDialogSlot()
	if speechSlot < 4 then
		caster:AddSpeechBubble(speechSlot, "#dialogue_merchant", time, 0, 0)
		disableSpeech(caster, time, speechSlot)
	end
	for _,unit in ipairs(units) do
		local player = unit:GetPlayerOwner()
		local playerId = player:GetPlayerID()	
		CustomGameEventManager:Send_ServerToPlayer(player, "OpenShop", {player=playerId} )
		--EmitSoundOnClient(MERCHANT_OPEN_SOUND_TABLE[RandomInt(1, 3)], player)
	end
end

function blacksmith(caster, units)
	--MERCHANT_OPEN_SOUND_TABLE = {"secretshop_secretshop_welcome_04", "secretshop_secretshop_whatyoubuying_01", "secretshop_secretshop_whatyoubuying_02"}
	print("call how many")
	local time = 5
	local speechSlot = findEmptyDialogSlot()
	if speechSlot < 4 then
		caster:AddSpeechBubble(speechSlot, "#dialogue_blacksmith", time, 0, 0)
		disableSpeech(caster, time, speechSlot)
	end
	for _,unit in ipairs(units) do
		local player = unit:GetPlayerOwner()
		if player then
			local playerId = player:GetPlayerID()	
			CustomGameEventManager:Send_ServerToPlayer(player, "OpenBlacksmith", {player=playerId} )
		end
	end
end

function rareShop(caster, units)
	--MERCHANT_OPEN_SOUND_TABLE = {"secretshop_secretshop_welcome_04", "secretshop_secretshop_whatyoubuying_01", "secretshop_secretshop_whatyoubuying_02"}
	local time = 5
	local speechSlot = findEmptyDialogSlot()
	if speechSlot < 4 then
		caster:AddSpeechBubble(speechSlot, "#dialogue_rare_shop", time, 0, 0)
		disableSpeech(caster, time, speechSlot)
	end
	for _,unit in ipairs(units) do
		local player = unit:GetPlayerOwner()
		local playerId = player:GetPlayerID()
		if not unit.legendHelm then
			CustomGameEventManager:Send_ServerToPlayer(player, "OpenRareShop", {player=playerId} )
		end
		--EmitSoundOnClient(MERCHANT_OPEN_SOUND_TABLE[RandomInt(1, 3)], player)
	end
end

function red_fox(caster)
	local time = 5
	local speechSlot = findEmptyDialogSlot()
	if speechSlot < 4 then
		caster:AddSpeechBubble(speechSlot, "#dialogue_fox", time, 0, 0)
		disableSpeech(caster, time, speechSlot)
	end
end

function beaver(caster)
	local time = 5
	local speechSlot = findEmptyDialogSlot()
	if speechSlot < 4 then
		local dialogue = ""
		if not Dungeons.cleared.townsiege then
			dialogue = "#dialogue_beaver"
		else
			dialogue = "#dialogue_beaver_two"
		end
		caster:AddSpeechBubble(speechSlot, dialogue, time, 0, 0)
		disableSpeech(caster, time, speechSlot)
	end
end

function beer_bear(caster)
	local time = 5
	local speechSlot = findEmptyDialogSlot()
	if speechSlot < 4 then
		caster:AddSpeechBubble(speechSlot, "#dialogue_beer_bear", time, 0, 0)
		disableSpeech(caster, time, speechSlot)
	end
end

function owl(caster)
	local time = 5
	local speechSlot = findEmptyDialogSlot()
	if speechSlot < 4 then
		caster:AddSpeechBubble(speechSlot, "#dialogue_owl", time, 0, 0)
		disableSpeech(caster, time, speechSlot)
	end
end

function chest_brothers(caster)
	local time = 5
	local speechSlot = findEmptyDialogSlot()
	if speechSlot < 4 then
		caster:AddSpeechBubble(speechSlot, "#dialogue_chest_brothers", time, 0, 0)
		disableSpeech(caster, time, speechSlot)
	end
end

function rabbit(caster)
	local time = 7
	local speechSlot = findEmptyDialogSlot()
	if speechSlot < 4 then
		caster:AddSpeechBubble(speechSlot, "#dialogue_rabbit", time, 0, 0)
		disableSpeech(caster, time, speechSlot)
	end
end

function book(caster)
	local time = 8
	local speechSlot = findEmptyDialogSlot()
	if speechSlot < 4 then
		if caster.state == 0 then
			caster:AddSpeechBubble(speechSlot, "#dialogue_book", time, 0, 0)
			disableSpeech(caster, time, speechSlot)
		elseif caster.state == 1 then
			caster:AddSpeechBubble(speechSlot, "#dialogue_book_two", time, 0, 0)
			disableSpeech(caster, time, speechSlot)
		elseif caster.state == 2 then
			caster:AddSpeechBubble(speechSlot, "#dialogue_book_three", time, 0, 0)
			disableSpeech(caster, time, speechSlot)
		end
	end
end

function tree(caster, units)
	if not Dungeons.entryPoint then
		local time = 7
		local speechSlot = findEmptyDialogSlot()
		if speechSlot < 4 then
			caster:AddSpeechBubble(speechSlot, "#logging_camp_tree_dialogue_three", time, 0, 0)
			disableSpeech(caster, time, speechSlot)
			for _,hero in pairs(units) do
				if not hero.steelbark and hero:HasAnyAvailableInventorySpace() then
					RPCItems:RollSteelbarkPlate(hero)
					hero.steelbark = true
				end
			end			
			
		end
	else
		local time = 7
		local speechSlot = findEmptyDialogSlot()
		if speechSlot < 4 then
			caster:AddSpeechBubble(speechSlot, "#logging_camp_tree_dialogue_two", time, 0, 0)
			EmitSoundOn("treant_treant_attack_01", caster) 
			disableSpeech(caster, time, speechSlot)
		end
	end
end

function disableSpeech(caster, time, speechSlot)
	caster.hasSpeechBubble = true
	Timers:CreateTimer(time+1,
	    function()
	      	caster.hasSpeechBubble = false
	      	clearDialogSlot(speechSlot)
	    end)
end

function deltaFacingVector(caster, triggeringUnit)
	local facing = (caster:GetAbsOrigin() - triggeringUnit:GetAbsOrigin()):Normalized() 
	local rotationVector = facing - caster.baseFVector
	local deltaFacingVector = rotationVector/20
	return deltaFacingVector
end

function findEmptyDialogSlot()
	if not Events.Dialog1 then
		Events.Dialog1 = true
		return 1
	elseif not Events.Dialog2 then
		Events.Dialog2 = true
		return 2
	elseif not Events.Dialog3 then
		Events.Dialog3 = true
		return 3
	end
	return 4
end

function clearDialogSlot(slot)
	if slot == 1 then
		Events.Dialog1 = false
	elseif slot == 2 then
		Events.Dialog2 = false
	elseif slot == 3 then
		Events.Dialog3 = false
	end
end