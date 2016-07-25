function quest_01(event)

	local caster = event.caster
	local enemies = FindUnitsInRadius( DOTA_TEAM_GOODGUYS, caster:GetOrigin(), nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY,DOTA_UNIT_TARGET_HERO, 0, 0, false )
	local ability=event.ability
	if #enemies > 0 then
		caster:RemoveModifierByName("quest_01")
		caster:RemoveAbility("Ability_quest_01")
		local index = RandomInt( 1, #enemies )
		local visionTracer = CreateUnitByName("npc_flying_dummy_vision", Vector(-15784,-12056,2700), true, nil, nil, DOTA_TEAM_GOODGUYS)
		visionTracer:AddAbility("dummy_unit"):SetLevel(1)
		for i = 1, #MAIN_HERO_TABLE, 1 do
			local playerID = MAIN_HERO_TABLE[i]:GetPlayerID()
			if playerID then
				MAIN_HERO_TABLE[i]:Stop()
				PlayerResource:SetCameraTarget(playerID, visionTracer)
				
			end
		end
		recameradistance(1000)
		talkall(true,enemies[1],"师傅不好了，今天来了一个人领着几个奇怪的动物把剑偷走了",false,nil,5,30,60,90)
		Timers:CreateTimer(5,function ()
			talkall(true,caster,"为师早已卦到最近几日我派将会发生重大变故，想必就是今天的事",false,nil,5,0,0,0,nil,1)
			Timers:CreateTimer(5,function ()
			talkall(true,enemies[1],"师傅，今天来了一个人穿着奇特，好像并不是中原的人",false,nil,5,0,0,0)	
				Timers:CreateTimer(5,function ()
				talkall(true,caster,"火炎剑丢失，如盗剑之人心性狂躁，必定会给江湖带来一场浩劫，我想派弟子出去寻找",false,nil,5,0,0,0,nil,1)	
					Timers:CreateTimer(5,function ()
						talkall(true,enemies[1],"师傅，徒弟学艺不精，没能阻止盗剑之人，希望师傅能给个戴罪立功的机会",false,nil,5,0,0,0)	
						Timers:CreateTimer(5,function ()
							talkall(true,caster,"好吧，你们先去你们各自的师父那里拿些出门的法宝，限你们在一月之内寻回火炎剑",false,nil,5,0,0,0,nil,1)	
							for i = 1, #MAIN_HERO_TABLE, 1 do
							local playerID = MAIN_HERO_TABLE[i]:GetPlayerID()
							if playerID then
								QuestSystem:OnArriveTrigger(MAIN_HERO_TABLE[i],MAIN_NPC[1])
								MAIN_HERO_TABLE[i]:Stop()
								recameradistance(1334)
								PlayerResource:SetCameraTarget(playerID, nil)
							end
						end
						end)
					end)
				end)	
			end)	
		end)
		
		
	end

end


function quest_02(event)

	local caster = event.caster
	local enemies = FindUnitsInRadius( DOTA_TEAM_GOODGUYS, caster:GetOrigin(), nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, 0, 0, false )
	if #enemies > 0 then
		caster:RemoveModifierByName("quest_01")
		caster:RemoveAbility("Ability_quest_01")
		local index = RandomInt( 1, #enemies )
		text="同学，你赶紧回寨子吧，妖怪要来了"
		
		
		enemies[index]:Stop()
		enemies[index]:DestroyAllSpeechBubbles()
		enemies[index]:AddSpeechBubble(1,text,3.0,-20,100)
		caster:MoveToPosition(Vector(-4897.76,-7627.99,268.883))
		caster:RemoveModifierByName("quest_02")
	end

end


function quest_03(event)

	local caster = event.caster
	local index = RandomInt( 1, #Firstsystem.cunming)
	local cun = Entities:FindByName(nil, Firstsystem.cunming[index])
	if IsValidEntity(cun) == false then return nil end
	local newOrder = {
		UnitIndex = caster:entindex(), 
		OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
		TargetIndex = nil, --Optional.  Only used when targeting units
		AbilityIndex = 0, --Optional.  Only used when casting abilities
		Position = cun:GetOrigin() , --Optional.  Only used when targeting the ground
		Queue = 0 --Optional.  Used for queueing up abilities
 	}
	ExecuteOrderFromTable(newOrder)

end

function quest_xiaogui(event)

	local caster = event.caster
	StartAnimation(caster, {duration=1, activity=ACT_DOTA_RELAX_END, rate=1})
	caster:AddNewModifier( caster, nil, 'modifier_invisible', nil )
end

function quest_xiaogui_xx(event)

	local caster = event.caster


end
