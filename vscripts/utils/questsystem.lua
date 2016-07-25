
function DFSTable(tab,key)
	if type(tab)~='table' then return end
	local keys={}
	for k,v in pairs(tab) do
		table.insert(keys,k)
	end
	table.sort(keys)
	for i,k in ipairs(keys) do
		local v=tab[k]
		--print(tostring(k).."\n\t : "..tostring(v))
		if type(v)=='table' then
			local ret=DFSTable(v,key)
			if ret then return ret end
		elseif k==key then
			return v
		end
	end
	return nil
end

function DFSfTable(tab,fun,path,level)
	if type(tab)~='table' or type(fun)~='function' then return end
	path = path or {}
	level = level or 0
	local keys={}
	for k,v in pairs(tab) do
		table.insert(keys,k)
	end
	table.sort(keys)
	for i,k in ipairs(keys) do
		local v=tab[k]
		if type(v)=='table' then
			path[level+1]=k
			local ret=DFSfTable(v,fun,path,level+1)
			if ret then return ret end
		else
			local ret=fun(tab,k,path,level)
			--if ret then return ret end
		end
	end
end
if localize_kv==nil then
    localize_kv=LoadKeyValues("resource/addon_schinese.txt")
end
function LocalizeString(str)
	--print("LocalizeString:"..localize_kv:GetValue(str))
	return DFSTable(localize_kv,str) or str
end


function RemoveItems(hero,item_name,item_num)
	local remove_count=0
	for i=0,5 do
		local curr_item=hero:GetItemInSlot(i)
		if curr_item and curr_item:GetName()==item_name then
			if curr_item:IsStackable() then
				local item_charges=curr_item:GetCurrentCharges()
				if item_charges+remove_count<=item_num then
					hero:RemoveItem(curr_item)
					remove_count=remove_count+item_charges
				else
					local new_charges=item_charges-(item_num-remove_count)
					curr_item:SetCurrentCharges(new_charges)
					remove_count=item_num
				end
			else
				hero:RemoveItem(curr_item)
				remove_count=remove_count+1
			end
		end
		if remove_count>=item_num then break end
	end

	Backpack:Traverse( hero, function(pack,packIndex,itemIndex)
		local curr_item = EntIndexToHScript(itemIndex)
		if curr_item then
			if curr_item and curr_item:GetName()==item_name then
				if curr_item:IsStackable() then
					local item_charges=curr_item:GetCurrentCharges()
					if item_charges+remove_count<=item_num then
						hero:RemoveItem(curr_item)
						remove_count=remove_count+item_charges
					else
						local new_charges=item_charges-(item_num-remove_count)
						curr_item:SetCurrentCharges(new_charges)
						remove_count=item_num
					end
				else
					-- hero:RemoveItem(curr_item)
					Backpack:ConsumeItem(hero,curr_item)
					remove_count=remove_count+1
				end
			end
			if remove_count>=item_num then return true end
		end
	end )

	return remove_count
end

function MoveToQuestTarget(hero,quest_name)
	local quest=QuestSystem:GetQuest(quest_name)
	local ability = hero:FindAbilityByName("Ability_Teleport")
	local subquests = quest["SubQuests"]
	local vPosition
	for k,v in pairs(subquests) do
		if v["Type"] == "FIND_UNIT" then
			local unit = FindCreatureByName(v["FindUnit"])
			if unit then
				vPosition = unit:GetOrigin()
			end
		elseif v["Type"] == "KILL_UNIT" then
			local unit = FindCreatureByName(v["KillUnit"])
			if unit then
				vPosition = unit:GetOrigin()
			end
		elseif v["Type"] == "FIND_ITEM" then
			if itemTable == nil then return end
			for k1,v1 in pairs(itemTable) do
			 	for k2,v2 in pairs(v1[3]) do
			 	 	if v2 == v["FindItem"] then
						local unit = FindCreatureByName(k1)
						if unit then
							vPosition = unit:GetOrigin()
						end
			 	 	end
			 	 end
			end
		end
	end

	if ability ~= nil and vPosition ~= nil then
		hero:CastAbilityOnPosition(vPosition, ability , hero:GetPlayerOwnerID())
		hero:MoveToPosition(vPosition)
	end
end

function FindCreatureByName( name )
	local entities = Entities:FindAllByClassname("npc_dota_creature")
	for k,v in pairs(entities) do
		if v:GetUnitName() == name then
			return v
		end
	end
	return nil
end

-- }
----------------------------------------------------------------------------


----------------------------------------------------------------------------
---------------------------------
-- { Quest type
QUEST_TYPE_QUICK_UNIT="QUICK_UNIT"
QUEST_TYPE_FIND_UNIT="FIND_UNIT"
QUEST_TYPE_KILL_UNIT="KILL_UNIT"
QUEST_TYPE_FIND_ITEM="FIND_ITEM"

local subquest_meta={
	GetKVVar=function(self, key) if self.kv then return self.kv[key] end end,
	CompleteQuest=function(self) self.is_completed=true end,
	IsCompleted=function(self) return self.is_completed end,
	GetTextVars=function(self) return nil end,
	GetDefaultText=function(self) return "nil" end,
	GetText=function(self) 
		local text=self:GetKVVar("Text") or self:GetDefaultText()
		-- local text_vars=self:GetTextVars()
		-- if text and text_vars then
		-- 	text=string.gsub(text, "%$(%w+)", text_vars)
		-- end
		return text
	end,
}
subquest_meta.__index=subquest_meta

QuestTypes={
	[QUEST_TYPE_QUICK_UNIT]={
		OnArriveUnit=function (self, event) --[[ event={hero, unit} ]]
			if event.unit:GetUnitName()==self.kv["FindUnit"] then
				self:CompleteQuest()
			end
		end,
		GetTextVars=function (self)
			return {
				FindUnit=self.kv["FindUnit"] --LocalizeString(self.kv["FindUnit"]),
			}
		end,
		GetDefaultText=function (self)
			return "与 $FindUnit 见面。"
		end,
	},
	[QUEST_TYPE_FIND_UNIT]={
		OnInit=function (self) 
			self.progress=0
		end,
		OnArriveUnit=function (self, event) --[[ event={hero, unit} ]]
			print(event.unit:GetUnitName()==self.kv["FindUnit"])
			print(111)
			print(self.kv["FindUnit"])
			if event.unit:GetUnitName()==self.kv["FindUnit"] then
				self.progress=1
				self:CompleteQuest()
			end
		end,
		GetTextVars=function (self)
			return {
				FindUnit=self.kv["FindUnit"] --LocalizeString(self.kv["FindUnit"]),
			}
		end,
		GetDefaultText=function (self)
			return "与 $FindUnit 见面。"
		end,
	},
	[QUEST_TYPE_KILL_UNIT]={
		OnInit=function (self)
			self.kv["KillNum"]=self.kv["KillNum"] or 0
			self.progress=0
		end,
		OnKillUnit=function (self, event) --[[ event={hero, unit} ]]
			if event.unit:GetUnitName()==self.kv["KillUnit"] then
				self.progress=self.progress+1
				if self.progress>=self.kv["KillNum"] then
					self:CompleteQuest()
				end
				return true
			end
		end,
		GetTextVars=function (self)
			return {
				progress=self.progress,
				KillUnit=self.kv["KillUnit"], --LocalizeString(self.kv["KillUnit"]),
				KillNum=self.kv["KillNum"]
			}
		end,
		GetDefaultText=function (self)
			return "#game_ui_quests_message_kill_unit"
		end,
		quickkill=function (self) --[[ event={hero, unit} ]]
			
			self.progress=self.progress+1
			if self.progress>=self.kv["KillNum"] then
				self:CompleteQuest()
			end
			return true
			
		end,

	},
	[QUEST_TYPE_FIND_ITEM]={
		OnInit=function (self) 
			self.kv["ItemNum"]=self.kv["ItemNum"] or 0
			self.progress=0
		end,
		OnArriveUnit=function (self, event) --[[ event={hero, unit} ]]
			if not self.kv["SubmitUnit"] or event.unit:GetUnitName()==self.kv["SubmitUnit"] then
				local need_item_num=self.kv["ItemNum"]-self.progress
				local submitted_item_num=RemoveItems(event.hero,self.kv["FindItem"],need_item_num)
				self.progress=self.progress+submitted_item_num
				if self.progress>=self.kv["ItemNum"] then
					self:CompleteQuest()
				end
				return true
			end
		end,
		GetTextVars=function (self)
			return {
				progress=self.progress,
				FindItem=self.kv["FindItem"],--LocalizeString(self.kv["FindItem"]),
				ItemNum=self.kv["ItemNum"],
				SubmitUnit=self.kv["SubmitUnit"]--LocalizeString(self.kv["SubmitUnit"])
			}
		end,
		GetDefaultText=function (self)
			if self:GetKVVar("SubmitUnit") then
				return "#game_ui_quests_message_submit_item"
			else
				return "收集 ($progress/$ItemNum) 个 $FindItem。"
			end
		end,
	},
}

function NewSubQuest(kv_subquest)
	local quest_type=kv_subquest["Type"]
	if quest_type and QuestTypes[quest_type] then
		local subquest={
			kv=kv_subquest,
		}
		subquest=setmetatable(subquest,{__index=QuestTypes[quest_type]})
		if subquest.OnInit then subquest:OnInit() end
		return subquest
	end
end
--}
---------------------------------------------------------------------------------------------------

---------------------------------
-- Quest state
QUEST_STATE_ACCEPTED=1
QUEST_STATE_FINISHED=2
QUEST_STATE_SUBMITTED=3
---------------------------------
---------------------------------
-- Quest text type
QUEST_TEXT_TYPE_PRECONDITION=1
QUEST_TEXT_TYPE_ACCEPT=2
QUEST_TEXT_TYPE_ALL_SUBQUESTS=3
QUEST_TEXT_TYPE_UNCOMPLETED_SUBQUESTS=4
QUEST_TEXT_TYPE_FINISHED=5
QUEST_TEXT_TYPE_SUBMITTED=6
---------------------------------
if true or QuestSystem==nil then
	QuestSystem={}
	QuestSystem.global_quests={}
	QuestSystem.npcs_quests={}
	QuestSystem.players_quests={}
end

function QuestSystem:InitQuestSystem()
	print("Load QuestSystem")


	------------------------------------------------------------------
	-- Init quest types
	for _,quest_type in pairs(QuestTypes) do
		setmetatable(quest_type,subquest_meta)
	end
	------------------------------------------------------------------


	------------------------------------------------------------------

	
	local global_talk=LoadKeyValues("scripts/npc/talk.txt")
	for talk_name,talk in pairs(global_talk) do
		if talk then
			CustomNetTables:SetTableValue("TalkInfo", talk_name, talk)
		end
	end
	-- Init global quests
	self.global_quests=LoadKeyValues("scripts/npc/global_quests.txt")

	DFSfTable(self.global_quests,function(tab,key,path,level)
		local number=tonumber(tab[key])
		if number then tab[key]=number end

	end)
	--self.global_quests=self.global_quests["GlobalQuests"]
	------------------------------------------------------------------

	------------------------------------------------------------------
	-- Init NPCs quest table
	local keys={}
	for quest_name,quest in pairs(self.global_quests) do
		if quest then
			CustomNetTables:SetTableValue("TaskInfo", "globalQuests_"..quest_name, quest)
		end
		local npc_name=quest["NPC"]
		if npc_name then
			self.npcs_quests[npc_name] = self.npcs_quests[npc_name] or {}
			self.npcs_quests[npc_name][quest_name]=quest
			--print("NPC("..npc_name..") : quest("..quest_name..")")
			
		end
		table.insert(keys, quest_name)
	end
	ListenToGameEvent("entity_killed",Dynamic_Wrap(QuestSystem, "OnKillUnit"),self)
	------------------------------------------------------------------
end

function QuestSystem:ShowQuestInfo(hero,quest_name,msg,vars)
	self:SaveQuestNetTableInfo(hero)
end

function QuestSystem:sendQuestInfo(hero,quest_name,text_type)
	if text_type==QUEST_TEXT_TYPE_SUBMITTED then
		Timers:CreateTimer(1,function ()
			EmitSoundOn("ui.win",hero)
		end)
	end

	CustomGameEventManager:Send_ServerToPlayer(hero:GetPlayerOwner(),"renwu",{open=true,quest_name=quest_name,quest_type=text_type});

end

function QuestSystem:SaveQuestNetTableInfo(hero)
	local questNameList = self:GetHeroQuestsNameList(hero)
	local questList = self:GetHeroQuests(hero)

	CustomNetTables:SetTableValue("PlayerInfo", "playerQuests_"..tostring(hero:GetEntityIndex()), questNameList)

	for k,v in pairs(questList) do
		CustomNetTables:SetTableValue("PlayerInfo", "playerQuests_"..tostring(hero:GetEntityIndex()).."_"..k, v)
	end

	CustomGameEventManager:Send_ServerToPlayer(hero:GetPlayerOwner(),"ui_quest_update",{});
 end

function QuestSystem:ShowQuestText(hero,quest_name,text_type)

	if not hero or not quest_name then return end
	local quest=self:GetQuest(quest_name)
	local player_quests=self:GetHeroQuests(hero)
	local text=nil

	if player_quests then
		local player_quest=player_quests[quest_name]

		if text_type==QUEST_TEXT_TYPE_PRECONDITION then --前提条件

		elseif text_type==QUEST_TEXT_TYPE_SUBMITTED then
			local task_unit = Entities:FindByName(nil,quest["NPC"])
			if task_unit.quest then
				for _,sub in pairs(task_unit.quest) do
					if sub["hero"]==hero then 
						ParticleManager:DestroyParticle(sub["partic"],true)
						if quest["Infinity"]==1 then
						particleID= ParticleManager:CreateParticleForPlayer("particles/juqing/gantanhao_pt_aizi.vpcf",PATTACH_OVERHEAD_FOLLOW,task_unit,hero:GetOwner())
		 				ParticleManager:SetParticleControl(particleID,0,task_unit:GetOrigin())
		 				sub["partic"]=particleID
		 				end
					end
				end
			end
		elseif text_type==QUEST_TEXT_TYPE_ACCEPT then
			text="#taskchat_"..quest_name.."_AcceptText"
			local task_unit = Entities:FindByName(nil,quest["NPC"])

			task_unit:DestroyAllSpeechBubbles()
			task_unit:AddSpeechBubble(1,text,5.0,0,0)	
			local effectIndex = ParticleManager:CreateParticle("particles/huangshenzui/task/task_accepted.vpcf",PATTACH_CUSTOMORIGIN,hero)
			ParticleManager:SetParticleControlEnt(effectIndex , 0, hero, 5, "follow_origin", Vector(0,0,0), true)
			ParticleManager:SetParticleControlEnt(effectIndex , 1, hero, 5, "follow_origin", Vector(0,0,0), true)
			ParticleManager:SetParticleControlEnt(effectIndex , 2, hero, 5, "follow_origin", Vector(0,0,0), true)
			ParticleManager:SetParticleControlEnt(effectIndex , 3, hero, 5, "follow_origin", Vector(0,0,0), true)

		
			if task_unit.quest then
				for _,sub in pairs(task_unit.quest) do
					if sub["hero"]==hero then 
						ParticleManager:DestroyParticle(sub["partic"],true)
						particleID= ParticleManager:CreateParticleForPlayer("particles/juqing/wenhao_pt_aizi.vpcf",PATTACH_OVERHEAD_FOLLOW,task_unit,hero:GetOwner())
		 				ParticleManager:SetParticleControl(particleID,0,task_unit:GetOrigin())
		 				sub["partic"]=particleID
					end
				end
			end
			

		elseif text_type==QUEST_TEXT_TYPE_ALL_SUBQUESTS then
			
			if player_quest and player_quest["SubQuests"] then
				for _,subquest in pairs(player_quest["SubQuests"]) do
					local subquest_text=subquest:GetText()
					if subquest_text then
						text=text or ""
						text=text.. "\n" .. subquest_text
					end
				end
			end
		elseif text_type==QUEST_TEXT_TYPE_UNCOMPLETED_SUBQUESTS then
			
			if player_quest and player_quest["SubQuests"] then
				for _,subquest in pairs(player_quest["SubQuests"]) do
					if not subquest:IsCompleted() then
						local subquest_text=subquest:GetText()
						if subquest_text then
							text=text or ""
							text=text.. "\n" .. subquest_text
						end
					end
				end
			end
		elseif text_type==QUEST_TEXT_TYPE_FINISHED then --任务已完成
			text="#taskchat_"..quest_name.."_FinishedText"
			hero:DestroyAllSpeechBubbles()
			hero:AddSpeechBubble(1,text,5.0,-20,100)
			local task_unit = Entities:FindByName(nil,quest["NPC"])
			if task_unit.quest then
				for _,sub in pairs(task_unit.quest) do
					if sub["hero"]==hero then 
						ParticleManager:DestroyParticle(sub["partic"],true)
						particleID= ParticleManager:CreateParticleForPlayer("particles/juqing/wenhao_wancheng_aizi.vpcf",PATTACH_OVERHEAD_FOLLOW,task_unit,hero:GetOwner())
		 				ParticleManager:SetParticleControl(particleID,0,task_unit:GetOrigin())
		 				sub["partic"]=particleID
					end
				end
			end
			--local effectIndex = ParticleManager:CreateParticle("particles/quest/hero_levelup.vpcf",PATTACH_CUSTOMORIGIN,hero)
			--ParticleManager:SetParticleControlEnt(effectIndex , 0, hero, 5, "follow_origin", Vector(0,0,0), true)
			
		elseif text_type==QUEST_TEXT_TYPE_SUBMITTED then --任务已提交
			text="#taskchat_"..quest_name.."_SubmitedText"
			local task_unit = Entities:FindByName(nil,quest["NPC"])
			--task_unit:DestroyAllSpeechBubbles()
			task_unit:AddSpeechBubble(1,text,5.0,0,0)
			local effectIndex = ParticleManager:CreateParticle("particles/quest/hero_levelup.vpcf",PATTACH_CUSTOMORIGIN,task_unit)
			ParticleManager:SetParticleControlEnt(effectIndex , 0, task_unit, 5, "follow_origin", Vector(0,0,0), true)
			--ParticleManager:DestroyParticleSystemTime(effectIndex,2.0)
		end
	end
	--if text then self:ShowQuestInfo(hero, quest_name, text) end
	if text_type==QUEST_TEXT_TYPE_SUBMITTED  or text_type==QUEST_TEXT_TYPE_ACCEPT  then self:sendQuestInfo(hero, quest_name, text_type) end
	if text then self:SaveQuestNetTableInfo(hero) end
end

function QuestSystem:GetQuest(quest_name)
	if self.global_quests[quest_name] then
		return self.global_quests[quest_name]
	end
end

function QuestSystem:GetNPCQuests(npc_name)
	if npc_name and self.npcs_quests[npc_name] then
		return self.npcs_quests[npc_name]
	end
end


function QuestSystem:GetPlayerQuests(player)
	if player then
		local hero=player:GetAssignedHero()
		return self:GetHeroQuests(hero)
	end
end

function QuestSystem:GetHeroQuests(hero)
	if hero then
		self.players_quests[tostring(hero:GetEntityIndex())]=self.players_quests[tostring(hero:GetEntityIndex())] or {}
		return self.players_quests[tostring(hero:GetEntityIndex())]
	end
end

function QuestSystem:GetHeroQuestsNameList(hero)
	if hero then
		local questNameList = {}
		local questsList = self:GetHeroQuests(hero)
		for k,v in pairs(questsList) do
			--if not self:IsQuestFinished(hero, k) then
			if not (v["state"] == QUEST_STATE_SUBMITTED) then
		 		table.insert(questNameList,#questNameList+1,k)
		 	end
		 	--end
		end 
		return questNameList
	end
end

function QuestSystem:GetHeroQuest(hero,quest_name)
	local player_quests=self:GetHeroQuests(hero)
	if player_quests then return player_quests[quest_name] end
end

function QuestSystem:GetEnvVars(hero,quest_name)
	local player_quests=self:GetHeroQuests(hero)
	local vars={
		level=hero:GetLevel(),
		gold=PlayerResource:GetGold(hero:GetPlayerOwnerID()),
		timeofday=GameRules:GetTimeOfDay(),
		xiuwei=hero:GetContext("hero_xiuwei") or 0,
		multistate=0,
		FinCnt=0,
	}
	if player_quests and player_quests[quest_name] then
		local player_quest=player_quests[quest_name]
		vars["FinCnt"]=player_quest["fin_cnt"] or 0
	end
	return vars
end

function QuestSystem:IsQuestAcceptable(hero,quest_name)
	local player_quests=self:GetHeroQuests(hero)
	local quest=self:GetQuest(quest_name)
	if player_quests and quest then
		local player_quest=player_quests[quest_name]
		local quest_state=self:GetPlayerQuestState(hero,quest_name)
		if not player_quest or (player_quest["Infinity"]==1 and quest_state==QUEST_STATE_SUBMITTED) or player_quest["IsQuestGroup"]==1 then
			if quest["IsQuestGroup"]==1 then
				if player_quest then
					if quest_state==QUEST_STATE_ACCEPTED then 
						if player_quest["CurrentQuest"] then
							local curr_quest=self:GetHeroQuest(hero, player_quest["CurrentQuest"])
							if curr_quest and curr_quest["state"]~=QUEST_STATE_SUBMITTED then
								return false
							end
						end
					elseif quest_state==QUEST_STATE_SUBMITTED then
						if player_quest["Infinity"]~=1 then
							return false
						end
					else
						return false
					end
				end
			end
			if quest["Precondition"] and quest["Precondition"]["PreQuests"] then
				local pre_quests=quest["Precondition"]["PreQuests"]
				for name,fin_num in pairs(pre_quests) do
					local fin_cnt=0
					if player_quests[name] and player_quests[name]["fin_cnt"] then 
						fin_cnt=player_quests[name]["fin_cnt"] 
					end
					--print(string.format("%s:pre_quest=%s, fin_cnt=%d, fin_num=%d",quest_name,name,fin_cnt,fin_num))
					if fin_cnt<fin_num then
						return false
					end
				end
			end
			if quest["Precondition"] and quest["Precondition"]["NoQuests"] then
				local pre_quests=quest["Precondition"]["NoQuests"]
				for name,fin_num in pairs(pre_quests) do
					local state = self:GetPlayerQuestState(hero,name)
					if state ~= nil then
						return false
					end
				end
			end
			if quest["Precondition"] and quest["Precondition"]["WeaponTypeNeeded"] then
				local weaponType =quest["Precondition"]["WeaponTypeNeeded"]
				if GetHeroItemKind(hero) ~= weaponType then
					return false
				end
			end

			if quest["Precondition"] and quest["Precondition"]["IsZuobi"] then
				local IsZuobi =quest["Precondition"]["IsZuobi"]
				if IsZuobi~=nil then
					if hero.iszuobi == IsZuobi then
						return true
					end
				end
			end
			if quest["Precondition"] and type(quest["Precondition"]["LogicalFormula"])=='string' then
				local vars=self:GetEnvVars(hero,quest_name) or {}
				local cmd=string.gsub(quest["Precondition"]["LogicalFormula"],"%$(%w+)",vars)
				local result=load("return "..cmd)()
				--print("cmd:"..cmd.."  return:"..tostring(result))
				return result
			end
			--print("acceptable="..tostring(acceptable))
			return true
		end
	end
end

function QuestSystem:GetAcceptableQuests(hero,npc_name)
	--print("npc_name="..tostring(npc_name))
	local player_quests=self:GetHeroQuests(hero)
	local npc_quests=self:GetNPCQuests(npc_name)
	local acceptable_quests={}
	if player_quests and npc_quests then
		for quest_name,quest in pairs(npc_quests) do
			if self:IsQuestAcceptable(hero,quest_name) then
				table.insert(acceptable_quests,quest_name)
			elseif not player_quests[quest_name] or (player_quests[quest_name]["Infinity"] and self:GetPlayerQuestState(hero, quest_name)==QUEST_STATE_SUBMITTED) then
				--print(quest_name.." unacceptable!")
				self:ShowQuestText(hero, quest_name, QUEST_TEXT_TYPE_PRECONDITION)
			end
		end
	end
	return acceptable_quests
end

function QuestSystem:AcceptQuest(hero,quest_name)
	local player_quests=self:GetHeroQuests(hero)
	local quest=self:GetQuest(quest_name)
	
	if hero and player_quests and quest then
		if self.OnQuestAccept==nil or self:OnQuestAccept(hero,quest_name) then
			if quest["IsQuestGroup"]==1 then
				local quests=quest["Quests"]
				if type(quests)=='table' then

					local quest_num=0
					local total_chance=0
					for _,q in pairs(quests) do
						if type(q)=='table' then
							q["AcceptChance"]=q["AcceptChance"] or 100
							total_chance=total_chance+q["AcceptChance"]
						end
					end

					local accept_quest_name=nil
					local rd=RandomFloat(0, total_chance-0.01)
					for n,q in pairs(quests) do
						if type(q)=='table' then
							if rd<q["AcceptChance"] then
								accept_quest_name=n
								break
							end
							rd=rd-q["AcceptChance"]
						end
					end

					if accept_quest_name then
						local mem_quest_name=quest_name .. "_" .. tostring(accept_quest_name)
						local mem_quest=self.global_quests[mem_quest_name]
						if not mem_quest then
							mem_quest=setmetatable(quests[accept_quest_name],{__index=quest})
							mem_quest["IsQuestGroup"]=0
							self.global_quests[mem_quest_name]=mem_quest
						end
						local mem_player_quest=self:AcceptQuest(hero, mem_quest_name)
						if mem_player_quest then
							mem_player_quest["QuestInGroup"]=quest_name
							mem_player_quest["QuestInGroupIndex"]=accept_quest_name

							local player_quest=player_quests[quest_name] or setmetatable({},{__index=quest})
							player_quest["CurrentQuest"]=mem_quest_name
							player_quest["state"]=QUEST_STATE_ACCEPTED
							player_quests[quest_name]=player_quest

							self:ShowQuestText(hero, mem_quest_name, QUEST_TEXT_TYPE_ACCEPT)
							return player_quest
						end
					end
				end
			elseif quest["SubQuests"] then
				----------------------------------------------------------
				-- Init subquest
				
				
				local player_subquests={}
				for _,kv_subquest in pairs(quest["SubQuests"]) do
					local subquest=NewSubQuest(kv_subquest)
					if subquest then
						table.insert(player_subquests, subquest)
					end
				end
				----------------------------------------------------------
				local player_quest=player_quests[quest_name] or setmetatable({},{__index=quest})
				player_quest["state"]=QUEST_STATE_ACCEPTED
				player_quest["SubQuests"]=player_subquests
				player_quests[quest_name]=player_quest
				
				--print(string.format("player_%d accepted quest_%d",hero:GetPlayerOwnerID(),quest_name))
				
				self:ShowQuestText(hero, quest_name, QUEST_TEXT_TYPE_ALL_SUBQUESTS)
				
				
				return player_quest
			end
		end
	end
end

function QuestSystem:GetPlayerQuestState(hero,quest_name)
	local player_quest=self:GetHeroQuest(hero, quest_name)
	if player_quest then
		return player_quest["state"]
	end
	return nil
end

function QuestSystem:GetPlayerQuestSubquests(hero, quest_name)
	local player_quest=self:GetHeroQuest(hero, quest_name)
	if player_quest then
		return player_quest["SubQuests"]
	end
	return nil
end

function QuestSystem:IsQuestFinished(hero,quest_name)
	local player_quests=self:GetHeroQuests(hero)
	if hero and player_quests and player_quests[quest_name] then
		local player_quest=player_quests[quest_name]
		if self:GetPlayerQuestState(hero,quest_name)~=QUEST_STATE_FINISHED then
			if player_quest["IsQuestGroup"]==1 then
				return player_quest["Quests"] and player_quest["Quests"]["RequestMissionCount"] and (player_quest["MissionCount"] or 0)>=player_quest["Quests"]["RequestMissionCount"]
			else
				local subquests=self:GetPlayerQuestSubquests(hero, quest_name)
				if subquests then
					for _,subquest in pairs(subquests) do
						if not subquest:IsCompleted() then return false end
					end
				end
			end
		end
		return true
	end
end

function QuestSystem:CheckQuestFinish(hero, quest_name)
	if self:IsQuestFinished(hero, quest_name) then
		self:FinishQuest(hero, quest_name)
	end
end

function QuestSystem:FinishQuest(hero,quest_name)
	local player_quests=self:GetHeroQuests(hero)
	if hero and player_quests and player_quests[quest_name] then
		local player_quest=player_quests[quest_name]
		if self.OnQuestFinish==nil or self:OnQuestFinish(hero,quest_name)==true then
			player_quest["state"]=QUEST_STATE_FINISHED

			--print(string.format("player_%d finished quest_%d",hero:GetPlayerOwnerID(),quest_name))
			if player_quest["AutoSubmit"]==1 then
				self:SubmitQuest(hero,quest_name)
			else
				--self:ShowQuestInfo(hero,quest_name,"达成任务目标。")
				self:ShowQuestText(hero, quest_name, QUEST_TEXT_TYPE_FINISHED)
			end
		end
	end
end

function QuestSystem:SubmitQuest(hero,quest_name)
	local player_quests=self:GetHeroQuests(hero)
	if hero and player_quests and player_quests[quest_name] then
		local player_quest=player_quests[quest_name]
		if self.OnQuestSubmit==nil or self:OnQuestSubmit(hero,quest_name) then
			player_quest["state"]=QUEST_STATE_SUBMITTED

			player_quest["fin_cnt"]=(player_quest["fin_cnt"] or 0) +1
			--print(string.format("player_%d submitted quest_%d",hero:GetPlayerOwnerID(),quest_name))
			--self:ShowQuestInfo(hero,quest_name,"完成任务。")
			self:ShowQuestText(hero, quest_name, QUEST_TEXT_TYPE_SUBMITTED)
			self:QuestReward(hero,quest_name)

			if player_quest["QuestInGroup"] then
				local group_quest=self:GetHeroQuest(hero, player_quest["QuestInGroup"])
				if group_quest then
					group_quest["MissionCount"]=(group_quest["MissionCount"] or 0) +1
					self:CheckQuestFinish(hero, player_quest["QuestInGroup"])
					group_quest["CurrentQuest"]=nil
				end
				player_quest["QuestInGroup"]=nil
			elseif player_quest["IsQuestGroup"]==1 then
				player_quest["MissionCount"]=0
			end
		end
	end
end


function QuestSystem:QuestReward(hero,quest_name)

	local player_quests=self:GetHeroQuests(hero)
	if hero and player_quests and player_quests[quest_name] then
		player_quest=player_quests[quest_name]
		local total_reward={}
		local rewards=player_quest["Rewards"]
		if not rewards then return end
		if rewards["Fixed"] then
			self:IterateReward(total_reward,rewards["Fixed"])
		end
		if rewards["Random"] then
			local rdindex=RandomInt(1,#rewards["Random"])
			--print("random reward index:"..tostring(rdindex))
			self:IterateReward(total_reward,rewards["Random"][rdindex])
		end
		if rewards["Chance"] then
			local limit=rewards["Chance"]["Limit"] or 0xfffff
			local keys={}
			for key,reward in pairs(rewards["Chance"]) do
				if type(reward)=='table' then
					table.insert(keys,key)
				end
			end
			limit=math.min(limit,#keys)
			for i=1,#keys do
				local rdidx=RandomInt(1,#keys)
				local reward=rewards["Chance"][keys[rdidx]]
				if type(reward)=='table' and reward["Chance"] then
					if RandomFloat(0,99.99)<reward["Chance"] then
						self:IterateReward(total_reward,reward)
						limit=limit-1
					end
				end
				table.remove(keys,rdidx)

				if limit<=0 then break end
			end
			--[[local randomNumber = RandomFloat(0,99.99)
			for i=1,limit do
				for k,v in pairs(keys) do
					local min = 
					local max = 
				end
			end]]--
		end
		if rewards["Extra"] then
			for _,reward in pairs(rewards["Extra"]) do
				if type(reward["LogicalFormula"])=='string' then
					local vars=self:GetEnvVars(hero,quest_name) or {}
					local cmd=string.gsub(reward["LogicalFormula"],"%$(%w+)",vars)
					local result=load("return "..cmd)()
					if result then
						self:IterateReward(total_reward,reward)
					end
				end
			end
		end
		
		local reward_desc=self:GetRewardDescription(total_reward)
		if reward_desc then
			local msg="#game_ui_quests_message_reward"
			self:ShowQuestInfo(hero,quest_name,msg,reward_desc)
			self:GiveRewards(hero,total_reward)
		end
	end
end

function QuestSystem:IterateReward(dst_reward,src_reward)
	if dst_reward and src_reward then
		for key,value in pairs(src_reward) do
			if type(value)=='number' and key~="Chance" then
				dst_reward[key]=(dst_reward[key] or 0) +src_reward[key]
			end
		end
		return dst_reward
	end
end

function QuestSystem:GiveRewards(hero,quest_reward)
	if hero and quest_reward then
		local reward=quest_reward
		if reward["EXP"] then 
			hero:AddExperience(reward["EXP"],false,true)
		end
		if reward["Gold"] then
			hero:ModifyGold(reward["Gold"],true,DOTA_ModifyGold_Unspecified)
		end
		if reward["STR"] then
			hero:SetBaseStrength(hero:GetBaseStrength()+reward["STR"])
		end
		if reward["AGI"] then
			hero:SetBaseAgility(hero:GetBaseAgility()+reward["AGI"])
		end
		if reward["INT"] then
			hero:SetBaseIntellect(hero:GetBaseIntellect()+reward["INT"])
		end
		if reward["PrimaryAttribute"] then
			if Hero:GetPrimaryAttribute()==DOTA_ATTRIBUTE_STRENGTH then
				hero:SetBaseStrength(hero:GetBaseStrength()+reward["PrimaryAttribute"])
			elseif Hero:GetPrimaryAttribute()==DOTA_ATTRIBUTE_AGILITY then
				hero:SetBaseAgility(hero:GetBaseAgility()+reward["PrimaryAttribute"])
			elseif Hero:GetPrimaryAttribute()==DOTA_ATTRIBUTE_INTELLECT then
				hero:SetBaseIntellect(hero:GetBaseIntellect()+reward["PrimaryAttribute"])
			end
		end
		if reward["MAX_HP"] then
			hero:SetMaxHealth(hero:GetMaxHealth()+reward["MAX_HP"])
		end
		if reward["Level"] then
			for lvl=1,reward["Level"] do
				hero:HeroLevelUp(true)
			end
		end
		if reward["xiuwei"] then
			local xiuwei = hero:GetContext("hero_xiuwei")
			hero:SetContextNum("hero_xiuwei", xiuwei + reward["xiuwei"], 0)
		end
		if reward["EquipMulti"] then
			--ModifyEquipMulti(hero,reward["EquipMulti"],nil)
			
		end
		if reward["HeroStateMulti"] then
			ModifyHeroMultiState(hero,reward["HeroStateMulti"],nil)
			WingsSystem:CreateWingsForHero( hero )

		end
		if reward["Ablity03"] then
			local ability=hero:GetAbilityByIndex(2)
			ability:SetLevel(1)
		end
		if reward["Ablity04"] then
			local ability=hero:GetAbilityByIndex(3)
			ability:SetLevel(1)
		end
		if reward["Demon"] then
			hero:AddAbility("ability_demon")
			local ability = hero:FindAbilityByName("ability_demon")
			ability:SetLevel(1)
			WingsSystem:CreateWingsForHero( hero )
		end
		if reward["God"] then
			hero:AddAbility("ability_god")
			local ability = hero:FindAbilityByName("ability_god")
			ability:SetLevel(1)
			WingsSystem:CreateWingsForHero( hero )
		end
		-------------------------------------------------------------
		-- reward items --
		local reward_items={}
		for k,v in pairs(reward) do
			if k:sub(1,5)=="item_" then
				reward_items[k]=v
			end
		end
		local item_total=0
		for item_name,item_num in pairs(reward_items) do
			item_total=item_total+1
		end
		if item_total>0 then
			local item_count=0
			for item_name,item_num in pairs(reward_items) do
				item_count=item_count+1
				
				local new_item=CreateItem(item_name,hero,hero)
				Backpack:AddItemImmediate( hero, new_item )
				--local new_item_origin=hero:GetOrigin()
				--local new_item_radian=(math.pi*2)*(item_count/item_total)-math.pi/2
				--new_item_origin.x=new_item_origin.x+math.cos(new_item_radian)*100
				--new_item_origin.y=new_item_origin.y+math.sin(new_item_radian)*100
				--CreateItemOnPositionForLaunch(new_item_origin,new_item)
				--hero:PickupDroppedItem(new_item)
				if new_item then
					if new_item:IsStackable() then
						new_item:SetCurrentCharges(item_num)
					elseif item_num>1 then
						for i=1,item_num-1 do
							local new_item_2=CreateItem(item_name,hero,hero)
							Backpack:AddItemImmediate( hero, new_item )
							--CreateItemOnPositionForLaunch(new_item_origin,new_item_2)
							--hero:PickupDroppedItem(new_item_2)
						end
					end
				end
			end
		end
		-------------------------------------------------------------
	end
end

----------------------------------------------------------------------------------------------
--[[function QuestSystem:GetAllRewardsDescription(rewards)
	if type(rewards)=='type' then
		local desc=""
		local reward_desc

		reward_desc=QuestSystem:GetRewardDescription(rewards["fixed"])
		if reward_desc and #reward_desc>0 then
			desc=desc .. string.format("固定奖励：%s",reward_desc)
		end

		reward_desc=QuestSystem:GetRewardDescription(rewards["random"])
		if reward_desc and #reward_desc>0 then
			desc=desc .. string.format("随机奖励：%s",reward_desc)
		end

		reward_desc=QuestSystem:GetRewardDescription(rewards["chance"])
		if reward_desc and #reward_desc>0 then
			desc=desc .. string.format("几率奖励：%s",reward_desc)
		end
		return desc
	end
end]]

function QuestSystem:GetRewardDescription(reward)
	if type(reward)=='table' then
		local desc={}
		if reward["EXP"] then
			desc["list_EXP"] = reward["EXP"]
		end
		if reward["Gold"] then
			desc["list_Gold"] = reward["Gold"]

		end
		if reward["STR"] then
			desc["list_STR"] = reward["STR"]

		end
		if reward["AGI"] then
			desc["list_AGI"] = reward["AGI"]

		end
		if reward["INT"] then
			desc["list_INT"] = reward["INT"]

		end
		if reward["PrimaryAttribute"] then
			desc["list_PrimaryAttribute"] = reward["PrimaryAttribute"]

		end
		if reward["MAX_HP"] then
			desc["list_MAX_HP"] = reward["MAX_HP"]
			
		end
		if reward["Level"] then
			desc["list_Level"] = reward["Level"]

		end
		if reward["xiuwei"] then
			desc["list_xiuwei"] = reward["xiuwei"]

		end
		if reward["EquipMulti"] then
			desc["list_EquipMulti"] = reward["EquipMulti"]

		end
		if reward["HeroStateMulti"] then
			desc["list_HeroStateMulti"] = reward["HeroStateMulti"]

		end
		if reward["Ablity03"] then
			desc["list_Ablity03"] = ""

		end
		if reward["Ablity04"] then
			desc["list_Ablity04"] = ""

		end
		if reward["God"] then
			desc["list_God"] = ""

		end
		if reward["Demon"] then
			desc["list_Demon"] = ""

		end
		local reward_items={}
		for k,v in pairs(reward) do
			if k:sub(1,5)=="item_" then
				reward_items[k]=v
			end
		end
		for item_name,item_num in pairs(reward_items) do
			desc[item_name] = item_num
			-- desc=desc .. string.format("%d个%s ",item_num,item_name)
		end
		
		-- if #desc==0 then desc=nil end
		for k,v in pairs(desc) do
			return desc
		end
	end
end
--------------------------------------------------------------------------------

function QuestSystem:OnArriveTrigger(hero,unit)
	local player_quests=self:GetHeroQuests(hero)
	local event={hero=hero,unit=unit}
	local unit_name=unit:GetUnitName()
	if player_quests then
		for quest_name,player_quest in pairs(player_quests) do
			local quest_state=self:GetPlayerQuestState(hero,quest_name)
			 if quest_state==QUEST_STATE_ACCEPTED and player_quest["IsQuestGroup"]~=1 then
			 	local have_subquest_completed=false
			 	local player_subquests=self:GetPlayerQuestSubquests(hero, quest_name)
			 	for _,subquest in pairs(player_subquests) do
			 		if not subquest:IsCompleted() and subquest.OnArriveUnit then
			 			if subquest:OnArriveUnit(event) then
			 				self:ShowQuestInfo(hero, quest_name, subquest:GetText(), subquest:GetTextVars())
			 			end
			 			if subquest:IsCompleted() then
			 				local info=subquest:GetText().."_complete"
			 				self:ShowQuestInfo(hero, quest_name, info, subquest:GetTextVars())
			 				have_subquest_completed=true
			 			end
			 		end
			 	end
			 	if have_subquest_completed then
			 		self:CheckQuestFinish(hero, quest_name)
			 	end
			 --------------------------------------------------------
			 -- Submit quest
			 elseif quest_state==QUEST_STATE_FINISHED and player_quest["NPC"]==unit_name then
				self:SubmitQuest(hero,quest_name)
			 end
		end

		 --------------------------------------------------------
		 -- Accept quest

		local acceptable_quests_id=self:GetAcceptableQuests(hero,unit_name)
		for i,quest_name in pairs(acceptable_quests_id) do
			if self:GetPlayerQuestState(hero, quest_name)~=QUEST_STATE_ACCEPTED then
				self:ShowQuestText(hero, quest_name, QUEST_TEXT_TYPE_ACCEPT)
			end
		
			self:AcceptQuest(hero,quest_name)
		end
	end
end

function QuestSystem:OnKillUnit(event)
	local attackerEntity=EntIndexToHScript(event.entindex_attacker)
	local killedEntity = EntIndexToHScript(event.entindex_killed)
	local player=attackerEntity:GetPlayerOwner()
	if attackerEntity==nil or killedEntity==nil or player==nil then return end
	--------------------------------------------------------------
	
	
	if killedEntity.takedamagetable then
		local unit=killedEntity
		for _,v in pairs(killedEntity.takedamagetable) do
			local hero=v[1]
			local event={hero=v[1], unit=unit}
			
			player_quests=self:GetHeroQuests(hero)
			if player_quests then
				
				for quest_name,player_quest in pairs(player_quests) do

					local quest_state=self:GetPlayerQuestState(hero,quest_name)

					if quest_state==QUEST_STATE_ACCEPTED and player_quest["IsQuestGroup"]~=1 then
						local have_subquest_completed=false
					 	local player_subquests=self:GetPlayerQuestSubquests(hero, quest_name)
					 	for _,subquest in pairs(player_subquests) do
					 		if not subquest:IsCompleted() and subquest.OnKillUnit then
					 			
					 			if subquest:OnKillUnit(event) then
					 				self:ShowQuestInfo(hero, quest_name, subquest:GetText(), subquest:GetTextVars())
					 			end
					 			if subquest:IsCompleted() then 
					 				local info= subquest:GetText().."_complete"
					 				self:ShowQuestInfo(hero, quest_name, info, subquest:GetTextVars())
					 				have_subquest_completed=true 
					 			end
					 		end
					 	end
					 	if have_subquest_completed then
					 		self:CheckQuestFinish(hero, quest_name)
					 	end
					end
				end
			end
		
			
		end
	else
		local hero=player:GetAssignedHero()
		local unit=killedEntity
		local event={hero=hero, unit=unit}
		player_quests=self:GetHeroQuests(hero)
		if player_quests then
			for quest_name,player_quest in pairs(player_quests) do
				local quest_state=self:GetPlayerQuestState(hero,quest_name)
				if quest_state==QUEST_STATE_ACCEPTED and player_quest["IsQuestGroup"]~=1 then 
					local have_subquest_completed=false
				 	local player_subquests=self:GetPlayerQuestSubquests(hero, quest_name)
				 	for _,subquest in pairs(player_subquests) do
				 		if not subquest:IsCompleted() and subquest.OnKillUnit then
				 			if subquest:OnKillUnit(event) then
				 				self:ShowQuestInfo(hero, quest_name, subquest:GetText(), subquest:GetTextVars())
				 			end
				 			if subquest:IsCompleted() then 
				 				local info= subquest:GetText().."_complete"
				 				self:ShowQuestInfo(hero, quest_name, info, subquest:GetTextVars())
				 				have_subquest_completed=true 
				 			end
				 		end
				 	end
				 	if have_subquest_completed then
				 		self:CheckQuestFinish(hero, quest_name)
				 	end
				end
			end
		end
	end

	--判断杀死的单位是不是剧情中最后一个
	if killedEntity:GetUnitName()=="creature_01" then
		Firstsystem.LastNumber = Firstsystem.LastNumber+1
	end

end
QuestSystem.x=1
function QuestSystem:quicklyfinish(hero,quest_name)
	
	local player_subquests=self:GetPlayerQuestSubquests(hero, quest_name)
		
	player_quests=self:GetHeroQuests(hero)
	if player_quests then
		
		for quest_name,player_quest in pairs(player_quests) do

			local quest_state=self:GetPlayerQuestState(hero,quest_name)

			if quest_state==QUEST_STATE_ACCEPTED and player_quest["IsQuestGroup"]~=1 then
				local have_subquest_completed=false
			 	local player_subquests=self:GetPlayerQuestSubquests(hero, quest_name)
			 	for _,subquest in pairs(player_subquests) do
			 		if not subquest:IsCompleted() and subquest.quickkill then
			 			
			 			if subquest:quickkill() then
			 				self:ShowQuestInfo(hero, quest_name, subquest:GetText(), subquest:GetTextVars())
			 			end
			 			if subquest:IsCompleted() then 
			 				local info= subquest:GetText().."_complete"
			 				self:ShowQuestInfo(hero, quest_name, info, subquest:GetTextVars())
			 				have_subquest_completed=true 
			 			end
			 		end
			 	end
			 	if have_subquest_completed then
			 		self:CheckQuestFinish(hero, quest_name)
			 	end
			end
		end
	end
	Timers:CreateTimer(3,function ()
		self:SubmitQuest(hero,quest_name)
	end)
	
		
end

function QuestSystem:initquestforplayer(hero)

	for quest_name,quest in pairs(self.global_quests) do
		if quest then
			local onequest = self:GetQuest(quest_name)
			if string.sub(quest_name,0,string.len(quest_name)-6)=="quest_zhuxian" then --是否为主线任务
				
			else 
				if onequest.Infinity==1 then --是否为无限任务.
				
					local npc = Entities:FindByName(nil, onequest["NPC"])
					if npc then 
						local quest_table={}
						particleID= ParticleManager:CreateParticleForPlayer("particles/juqing/gantanhao_pt_aizi.vpcf",PATTACH_OVERHEAD_FOLLOW,npc,hero:GetOwner())
		 				ParticleManager:SetParticleControl(particleID,0,npc:GetOrigin())
		 				quest_table["hero"]=hero
		 				quest_table["partic"]=particleID
		 				if npc.quest then
		 					table.insert(npc.quest, quest_table)
		 				else
		 					npc.quest={}
		 					table.insert(npc.quest, quest_table)
		 				end
						

					end
			
					
				else
					--print(onequest["NPC"])
					--print(onequest["Precondition"]["PreQuests"])
					if	next(onequest["Precondition"]["PreQuests"]) ==nil then --有无前致任务
						local npc = Entities:FindByName(nil, onequest["NPC"])
						if npc then 
							local quest_table={}
							particleID= ParticleManager:CreateParticleForPlayer("particles/juqing/gantanhao_pt_aizi.vpcf",PATTACH_OVERHEAD_FOLLOW,npc,hero:GetOwner())
			 				ParticleManager:SetParticleControl(particleID,0,npc:GetOrigin())
			 				quest_table["hero"]=hero
			 				quest_table["partic"]=particleID
			 				if npc.quest then
			 					table.insert(npc.quest, quest_table)
			 				else
			 					npc.quest={}
			 					table.insert(npc.quest, quest_table)
			 				end
							

						end
					else

					end
					

				end

			end
			
			
		end
		
	end


		
end


