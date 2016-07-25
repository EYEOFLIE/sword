
if Firstsystem == nil then
	Firstsystem = {}
	Firstsystem.cunming={"npc_cunzhang"}
	Firstsystem.cunzhang=0
end

SPAWN_POINT_OPEN_1 = Vector(-4148.37, -11704.2)
SPAWN_POINT_OPEN_2 = Vector(-6508.13, -11154.4)
SPAWN_POINT_OPEN_3 = Vector(-8298.83, -7351.08)
Firstsystem.zuge_01=1
Firstsystem.WaveNumber = 0	
Firstsystem.UniteNumber = 1	
Firstsystem.LastNumber = 0	
function Firstsystem:start(target,unit)
	print("firststart")
	
	if(unit~=nil) then

		for i = 1, #MAIN_HERO_TABLE, 1 do
			local playerID = MAIN_HERO_TABLE[i]:GetPlayerID()
			if playerID then
				MAIN_HERO_TABLE[i]:Stop()
				PlayerResource:SetCameraTarget(playerID, unit)
				
			end
		end


		talkall(true,target,"老婆婆，你在这里做什么",false,nil,3,0,0,0)
		Timers:CreateTimer(3,function ()
			talkall(true,unit,"少年，带老子回家",false,nil,3,0,0,0)
			Timers:CreateTimer(3,function ()
					talkall(true,target,"那你跟着我吧，我送你回家",false,nil,3,0,0,0)
					unit:SetForwardVector(target:GetOrigin()-unit:GetOrigin())
					Timers:CreateTimer(1,function ()
					
					unit:MoveToNPC(target)
					for i = 1, #MAIN_HERO_TABLE, 1 do
						local playerID = MAIN_HERO_TABLE[i]:GetPlayerID()
						if playerID then
						QuestSystem:OnArriveTrigger(MAIN_HERO_TABLE[i],unit)
						PlayerResource:SetCameraTarget(playerID, nil)
						
						end
					end
						-- body
					end)
			end)
		end)
		
	end
end

function Firstsystem:cunkou(target,caller,thisEntity)
	local unit_name=target:GetUnitName()
	local hero=MAIN_HERO_TABLE[1]
	
	if(unit_name=="npc_nvnongfu_unit") then
		caller:RemoveSelf()
		
		local quest_01= CustomNetTables:GetTableValue( "TalkInfo","quest_01_01")
		
		local time=0
		--阿贵和农妇交淡
		for i = 1, 2, 1 do
			time=questtalk(quest_01,thisEntity,target,i,time)
			
			if i==2 then
				time=time+quest_01[tostring(i)]["talktime"]+0.5
			end
		end

		local quest_01_02= CustomNetTables:GetTableValue( "TalkInfo","quest_01_02")
		--阿贵和英雄交淡
		for i = 1, 4, 1 do
			time=questtalk(quest_01_02,thisEntity,hero,i,time)
			
			if i==4 then
				Timers:CreateTimer((time+quest_01_02[tostring(i)]["talktime"]+0.5),function ()
					target:MoveToPosition(Vector(-4697.44,-9019.04,222))
					thisEntity:MoveToPosition(Vector(-4697.44,-9019.04,222))
					for i = 1, #MAIN_HERO_TABLE, 1 do
						local playerID = MAIN_HERO_TABLE[i]:GetPlayerID()
						if playerID then
						QuestSystem:quicklyfinish(MAIN_HERO_TABLE[i],"quest_milufunv")
						Firstsystem.cunzhang=1
						
						end
					end
				end)
			end
			
		end	
	
		
	else
		

		
	end

end
Firstsystem.cunmingnum=0
function Firstsystem:quest_02(target,caller,unit)
	local unit_name=target:GetUnitName()
	
	if(unit_name=="npc_nvnongfu_unit") then
		
		Firstsystem.cunmingnum=Firstsystem.cunmingnum+1
		target:Stop()
	
		--target:RemoveSelf()
		for i = 1, #Firstsystem.cunming, 1 do
			if Firstsystem.cunming[i]== target:GetName() then
				table.remove(Firstsystem.cunming,i) 
			end
		end
		if Firstsystem.cunmingnum==6 then
			caller:RemoveSelf()
		end
	else
		print(unit:GetUnitName())
		
	end



end

Firstsystem.zhujiao_01=nil
function Firstsystem:kaizhang(unit)

	--talkall(true,unit,"藏剑格有打斗的声音",false,nil,10,10,60,90)
	--if 1==1 then return end
	local unit_05=CreateUnitByName("npc_cike3_BOSS", Vector(-13968,-7363.72,2597.88), true, nil, nil, DOTA_TEAM_BADGUYS )
	unit_05:AddAbility("ab_boss_01_ai_lua"):SetLevel(1)
	unit_05:SetForwardVector(Vector(0,-1,0))
	local Item_01 = CreateItem("item_0001", nil, nil )
	unit_05:AddItem(Item_01)
	Firstsystem.zhujiao_01=unit_05
	
	--if 1==1 then return end
	talkall(true,unit,"藏剑格有打斗的声音",false,nil,10,10,60,90)
	
	EmitSoundOn("talk.talk_101",unit)
										

	local unit_01=CreateUnitByName("npc_cike_unit", Vector(-14654.9,-8382.84,2597.88), true, nil, nil, DOTA_TEAM_BADGUYS )
	local unit_02=CreateUnitByName("npc_cike_unit", Vector(-14654.9,-7876,2597.88), true, nil, nil, DOTA_TEAM_BADGUYS )
	local unit_03=CreateUnitByName("npc_cike_unit", Vector(-13232,-7876,2597.88), true, nil, nil, DOTA_TEAM_BADGUYS )
	local unit_04=CreateUnitByName("npc_cike_unit", Vector(-13232,-8396,2597.88), true, nil, nil, DOTA_TEAM_BADGUYS )

	
	
	local visionTracer = CreateUnitByName("npc_flying_dummy_vision", unit:GetOrigin(), true, nil, nil, DOTA_TEAM_GOODGUYS)
	visionTracer:AddAbility("dummy_unit"):SetLevel(1)
	
	local shifu = Entities:FindByName(nil,"shifu")
	local shouwei_01 = Entities:FindByName(nil,"shouwei_01")
	local shouwei_02 = Entities:FindByName(nil,"shouwei_02")
	local shouwei_03 = Entities:FindByName(nil,"shouwei_03")
	local shouwei_04 = Entities:FindByName(nil,"shouwei_04")

	

	shouwei_01:FindAbilityByName("Ability_shouwei"):ApplyDataDrivenModifier(shouwei_01, shouwei_01, "modifiers_langan", nil)

	
	for i = 1, #MAIN_HERO_TABLE, 1 do
			local playerID = MAIN_HERO_TABLE[i]:GetPlayerID()
			if playerID then
				MAIN_HERO_TABLE[i]:Stop()
				PlayerResource:SetCameraTarget(playerID, visionTracer)
				
			end
	end
	
		Timers:CreateTimer(3,function ()
			unit:MoveToPosition(Vector(-13431.2,-8484))
			visionTracer:MoveToPosition(Vector(-13431.2,-8484))
			recameradistance(2000)
			Timers:CreateTimer(7,function ()
			Firstsystem.zuge_01=2
			recameradistance(700)
			talkall(true,unit,"都住手！你们是谁？敢擅闯剑神殿？",false,nil,5,5,55,180)
			local ability_target=unit:FindAbilityByName("Ability_targeteffect")
			ability_target:ApplyDataDrivenModifier(unit, unit, "cant_move", nil)
			EmitSoundOn("talk.talk_102",unit)
			
			unit_01:MoveToPosition(Vector(-14253.3,-7296,2583.98))
			unit_01:AddAbility("dummy_unit_unautoaddtack"):SetLevel(1)
			--unit_01.chuforward=Vector(0,-1,0)
			

			unit_02:MoveToPosition(Vector(-14056.1,-7296,2583.98))
			unit_02:AddAbility("dummy_unit_unautoaddtack"):SetLevel(1)
			--unit_02.chuforward=Vector(0,-1,0)
			--ability_01:ApplyDataDrivenModifier(unit_02, unit_02, "modifier_back_position", nil)

			unit_03:MoveToPosition(Vector(-13892.9,-7296,2583.98))
			unit_03:AddAbility("dummy_unit_unautoaddtack"):SetLevel(1)
			--unit_03.chuforward=Vector(0,-1,0)
			--ability_01:ApplyDataDrivenModifier(unit_03, unit_03, "modifier_back_position", nil)

			unit_04:MoveToPosition(Vector(-13661.9,-7296,2583.98))
			unit_04:AddAbility("dummy_unit_unautoaddtack"):SetLevel(1)
			--unit_04.chuforward=Vector(0,-1,0)
			--ability_01:ApplyDataDrivenModifier(unit_04, unit_04, "modifier_back_position", nil)

			shouwei_01:MoveToPosition(Vector(-13656,-8728,2583.98))
			--shouwei_01.chuforward=Vector(0,1,0)
			--ability_01:ApplyDataDrivenModifier(shouwei_01, shouwei_01, "modifier_back_position", nil)
			shouwei_01:AddAbility("dummy_unit_unautoaddtack"):SetLevel(1)
			shouwei_02:MoveToPosition(Vector(-13530.8,-8728,2583.98))
			--shouwei_02.chuforward=Vector(0,1,0)
			--ability_01:ApplyDataDrivenModifier(shouwei_02, shouwei_02, "modifier_back_position", nil)
			shouwei_02:AddAbility("dummy_unit_unautoaddtack"):SetLevel(1)
			shouwei_03:MoveToPosition(Vector(-13362.6,-8728,2583.98))
			--shouwei_03.chuforward=Vector(0,1,0)
			--ability_01:ApplyDataDrivenModifier(shouwei_03, shouwei_03, "modifier_back_position", nil)
			
			shouwei_03:AddAbility("dummy_unit_unautoaddtack"):SetLevel(1)

			shouwei_04:MoveToPosition(Vector(-13202.4,-8728,2583.98))
			--shouwei_04.chuforward=Vector(0,1,0)
			--ability_01:ApplyDataDrivenModifier(shouwei_04, shouwei_04, "modifier_back_position", nil)
			shouwei_04:AddAbility("dummy_unit_unautoaddtack"):SetLevel(1)
			
			
			
				Timers:CreateTimer(5,function ()
				recameradistance(800)
				visionTracer:MoveToPosition(Vector(-13968,-7363.72))
					Timers:CreateTimer(2,function ()
					
					talkall(true,unit_05,"我是谁你需要知道",false,nil,5,0,55,0,"",1)
					
					EmitSoundOn("talk.talk_103",unit)
						
						Timers:CreateTimer(5,function ()
						recameradistance(1334)
						talkall(true,unit_05,"击败他",true,"接受",7,5,35,0)

						unit:RemoveModifierByName("cant_move")
						--shouwei_01:MoveToTargetToAttack(unit_01)
						--shouwei_02:MoveToTargetToAttack(unit_03)
						--shouwei_03:MoveToTargetToAttack(unit_02)
						--shouwei_04:MoveToTargetToAttack(unit_04)
						visionTracer:RemoveSelf()
						for i = 1, #MAIN_HERO_TABLE, 1 do
							local playerID = MAIN_HERO_TABLE[i]:GetPlayerID()
							local shouwei_04 = Entities:FindByName(nil,"shouwei_04")

							QuestSystem:OnArriveTrigger(MAIN_HERO_TABLE[i],MAIN_NPC[1])
							if playerID then
								
								PlayerResource:SetCameraTarget(playerID, nil)
								
							end
						end
						end)
					end)
				end)
			end)
		end)
	
end

function Firstsystem:juqing_02(unit)

	local visionTracer = CreateUnitByName("npc_flying_dummy_vision", unit:GetOrigin(), true, nil, nil, DOTA_TEAM_GOODGUYS)
	visionTracer:AddAbility("dummy_unit"):SetLevel(1)
	
	local shouwei_01 = Entities:FindByName(nil,"shouwei_01")
	local ability_01=unit:FindAbilityByName("Ability_targeteffect")
	ability_01:ApplyDataDrivenModifier(unit, unit, "drop_target_unit", {duration=5})

	for i = 1, #MAIN_HERO_TABLE, 1 do
			local playerID = MAIN_HERO_TABLE[i]:GetPlayerID()
			if playerID then
				MAIN_HERO_TABLE[i]:Stop()
				PlayerResource:SetCameraTarget(playerID, visionTracer)
				
			end
	end

	Timers:CreateTimer(1,function ()
		visionTracer:MoveToPosition(Vector(-13454.8,-7881.85))
		unit:MoveToPosition(Vector(-13454.8,-7881.85))
	
		Timers:CreateTimer(3,function ()

			unit:Stop()
			unit:SetForwardVector(Vector(-1,0,0))
			talkall(true,unit,"有结界？试试前辈交我的破界咒语吧。",false,nil,3,0,60,90)
			--if 1==1 then return end
			Timers:CreateTimer(2,function ()
				talkall(true,unit,"* * * * * * * * *",false,nil,3,0,60,90)
				StartAnimation(unit, {duration=0.6, activity=ACT_DOTA_ATTACK2, rate=0.8})
				ParticleManager:DestroyParticle(shouwei_01.partic, false)
				shouwei_01:RemoveModifierByName("langanshengying")
				Timers:CreateTimer(3,function ()

					local jianlin = CreateUnitByName("npc_jianling_unit", Vector(-13764,-7856,2604), true, nil, nil, DOTA_TEAM_BADGUYS)
					--jianlin:AddAbility("dummy_unit"):SetLevel(1)
					for i = 1, #MAIN_HERO_TABLE, 1 do
						local playerID = MAIN_HERO_TABLE[i]:GetPlayerID()
						if playerID then
						local player = PlayerResource:GetPlayer(playerID)
						local hero = player:GetAssignedHero()
						local partic02 = ParticleManager:CreateParticle( "particles/dao/shake.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero )
						ParticleManager:SetParticleControl(partic02, 0,hero:GetOrigin())
							
						end
					end

					Timers:CreateTimer(1,function ()
						visionTracer:MoveToPosition(Vector(-13764,-7856))
						recameradistance(900)
						talkall(true,jianlin,"是谁打饶吾沉睡了！！",false,nil,5,5,60,90,"",1)
						--unit:AddNewModifier( unit, nil, "modifier_knockback", modifierKnockback )
						
						Timers:CreateTimer(5,function ()
							recameradistance(1334)
							for i = 1, #MAIN_HERO_TABLE, 1 do
								local playerID = MAIN_HERO_TABLE[i]:GetPlayerID()
								QuestSystem:OnArriveTrigger(MAIN_HERO_TABLE[i],MAIN_NPC[1])
								if playerID then
									MAIN_HERO_TABLE[i]:Stop()
									PlayerResource:SetCameraTarget(playerID, nil)
									
								end
							
							end
							
							unit:SetTeam(DOTA_TEAM_GOODGUYS)
							unit:SetControllableByPlayer(0,true)
							
							--talkall(true,unit,"击杀剑灵",false,nil,5,0,0,0)	
							Timers:CreateTimer(5,function ()
								jianlin:RemoveModifierByName("dummy_unit")
							end)
							
							
						end)
					end)
				end)
			end)
		end)
	end)
end

function Firstsystem:juqing_03(unit)

	Timers:CreateTimer(1,function ()
		recameradistance(1334)
		--unit:RemoveModifierByName("modifier_jinmo")
		yujian=unit:FindAbilityByName("yujianfeixing")
		local order =
		{
			UnitIndex = unit:entindex(),
			OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
			AbilityIndex = yujian:entindex(),
		}
		ExecuteOrderFromTable(order)
		
	end)

	Timers:CreateTimer(5,function ()
		unit:MoveToPosition(Vector(0,0,0))
		Timers:CreateTimer(5,function ()
			unit.feijian:RemoveSelf()
			
			for _,v in pairs(unit.enemy) do
				ParticleManager:DestroyParticle(v.effectsleep,false)
				v:RemoveModifierByName("cant_move_lua")
			end
			unit:RemoveSelf()	
			Firstsystem.zuge_01=1		
			for i = 1, #MAIN_HERO_TABLE, 1 do
				QuestSystem:quicklyfinish(MAIN_HERO_TABLE[i],"quest_zhuxian_01_02")
				local playerID = MAIN_HERO_TABLE[i]:GetPlayerID()
										
				if playerID then
					local player = PlayerResource:GetPlayer(playerID)
					talktoplayer(player,true,MAIN_HERO_TABLE[i],"刚才的人呢。。。我要赶紧去告诉师尊",false,nil,5,0,0,0)
					MAIN_HERO_TABLE[i]:Stop()
					PlayerResource:SetCameraTarget(playerID, nil)
					
				end
				local shifu = Entities:FindByName(nil,"npc_tiejiang")
				local ability_target=shifu:FindAbilityByName("Ability_targeteffect")
			    if(ability_target==nil) then
			        ability_target=shifu:AddAbility("Ability_targeteffect")
			        
			    end

			    shifu:AddAbility("Ability_quest_01"):SetLevel(1)
			    ability_target:ApplyDataDrivenModifier(shifu, shifu, "modifier_target_unit", {nil})
			end
			
			local shouwei_01 = Entities:FindByName(nil,"shouwei_01")
			local shouwei_02 = Entities:FindByName(nil,"shouwei_02")
			local shouwei_03 = Entities:FindByName(nil,"shouwei_03")
			local shouwei_04 = Entities:FindByName(nil,"shouwei_04")
			local ability_01=shouwei_02:FindAbilityByName("Ability_Dropped")
			--ability_01:ApplyDataDrivenModifier(shouwei_01, shouwei_01, "modifier_back_position", nil)

			--ability_01:ApplyDataDrivenModifier(shouwei_02, shouwei_02, "modifier_back_position", nil)

			--ability_01:ApplyDataDrivenModifier(shouwei_03, shouwei_03, "modifier_back_position", nil)

			--ability_01:ApplyDataDrivenModifier(shouwei_04, shouwei_04, "modifier_back_position", nil)

			
			
		end)		
	end)
end
function view(a,pid)
  pvalue=-math.deg(math.atan(a.y/a.x)-math.atan(a.y/a.x))
 
 if a.x<0  then
   pvalue=pvalue+180
 end
 
  SendToConsole("dota_camera_yaw "..tostring(pvalue))  
end

function Firstsystem:killmonster(target)
	Firstsystem.cunzhang=0 
	local xiaogui = Entities:FindByName(nil,"npc_xiaogui_unit")
	local xiaohai = Entities:FindByName(nil,"npc_xiaobao_unit")
	
	--xiaogui:SetTeam(DOTA_TEAM_BADGUYS)
	local ab=xiaogui:FindAbilityByName("Ability_BOSS_xiaogui")
	ab:SetLevel(1) 
	local quest_01_05= CustomNetTables:GetTableValue( "TalkInfo","quest_01_05")
	
	--ab:ApplyDataDrivenModifier(xiaogui, xiaogui, "xiaogui_ai_chufa", {})
	--xiaogui:RemoveModifierByName("xiaogui_ai_chufa")
	local time=0
	--英雄和村长交淡
	for i = 1, 2, 1 do
		time=questtalk(quest_01_05,target,target,i,time)
		
		if i==2 then
			time=time+quest_01_05[tostring(i)]["talktime"]+0.5
			Timers:CreateTimer((time+0.5),function ()
				xiaogui:RemoveModifierByName("xiaogui_yinsheng")
				xiaogui:SetTeam(DOTA_TEAM_GOODGUYS)
				Timers:CreateTimer((2+0.5),function ()
					target:MoveToNPC(xiaogui)
					Timers:CreateTimer(1,function ()
						target:Stop()
						StartAnimation(target, {duration=1.5, activity=ACT_DOTA_ATTACK, rate=1})
						xiaogui:RemoveModifierByName("xiaogui_tiaowu")
						xiaogui:RemoveModifierByName("modifier_invisible")
						Timers:CreateTimer(0.5,function ()
							StartAnimation(xiaogui, {duration=1.5, activity=ACT_DOTA_DIE, rate=1})
							particle= ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_bloodritual_ring_b_lv.vpcf", PATTACH_CUSTOMORIGIN,xiaogui)
							ParticleManager:SetParticleControl(particle,0,xiaogui:GetOrigin())
							Timers:CreateTimer(1.2,function ()
								ab:ApplyDataDrivenModifier(xiaogui, xiaogui, "xiaogui_siwang", {})
								Timers:CreateTimer(1.5,function ()
									talkall(true,xiaohai,"呜呜呜呜。。。。。你把小宝的好朋友弄没了。。我要去告诉阿娘",false,nil,4,0,0,0)
									Timers:CreateTimer(4.5,function ()
										xiaohai:MoveToPosition(Vector(-4710.32,-7508.78))
										talkall(true,target,"。。。。这村里怎么会有妖怪，要赶紧告诉老村长,让他们小心些",false,nil,3,0,0,0)
										Firstsystem.cunzhang=2
										local cunzhang = Entities:FindByName(nil,"npc_cunzhang")
										local ability_target=cunzhang:FindAbilityByName("Ability_targeteffect")
										if(ability_target==nil) then
									        ability_target=cunzhang:AddAbility("Ability_targeteffect")
									    end
									    ability_target:ApplyDataDrivenModifier(shifu, shifu, "modifier_target_unit", {nil})
									end)	
								end)
							end)
						end)
					end)
				end)

			end)
		end
	end

end

function Firstsystem:cunzhangquest_sec(target,thisEntity)



	Firstsystem.cunzhang=0

	local quest_01_06= CustomNetTables:GetTableValue( "TalkInfo","quest_01_06")
	local time=0
	--英雄和村长交淡
	for i = 1, 2, 1 do
		time=questtalk(quest_01_06,target,thisEntity,i,time)
		
		if i==2 then
			time=time+quest_01_06[tostring(i)]["talktime"]+0.5
			Timers:CreateTimer((time+0.5),function ()
				self:cunzhangquest_thd(target,thisEntity)
			end)
		end
	end


end

function Firstsystem:cunzhangquest_thd(target,thisEntity)
	
	local boss_01=CreateUnitByName("boss_laoer", Vector(-6237.85,-8312.54,214.884), true, nil, nil, DOTA_TEAM_BADGUYS )
	boss_01:AddAbility("ab_boss_02_ai_lua"):SetLevel(1)
	
	local npc_songxiansheng_unit = Entities:FindByName(nil,"npc_songxiansheng_unit")
	local npc_xiaonvhai_unit = Entities:FindByName(nil,"npc_xiaonvhai_unit")
	local npc_nvnongming_unit = Entities:FindByName(nil,"npc_nvnongming_unit")
	local npc_nannongfu_unit = Entities:FindByName(nil,"npc_nannongfu_unit")
	local npc_nongming_unit = Entities:FindByName(nil,"npc_nongming_unit")
	local npc_xiaoer_unit=Entities:FindByName(nil,"npc_xiaoer_unit")
	local npc_nvnongfu_unit=Entities:FindByName(nil,"npc_nvnongfu_unit")
	npc_songxiansheng_unit:MoveToPosition(Vector(-4847.82,-7646.12,262.126))
	npc_xiaonvhai_unit:MoveToPosition(Vector(-4847.82,-7646.12,262.126))
	npc_nvnongming_unit:MoveToPosition(Vector(-4847.82,-7646.12,262.126))
	npc_nannongfu_unit:MoveToPosition(Vector(-4847.82,-7646.12,262.126))
	npc_nongming_unit:MoveToPosition(Vector(-4847.82,-7646.12,262.126))
	npc_xiaoer_unit:MoveToPosition(Vector(-4847.82,-7646.12,262.126))
	npc_nvnongfu_unit:MoveToPosition(Vector(-4847.82,-7646.12,262.126))
	local quest_01_07= CustomNetTables:GetTableValue( "TalkInfo","quest_01_07")
	local time=0
	--英雄和村长交淡
	for i = 1, 2, 1 do
		time=questtalk(quest_01_07,boss_01,target,i,time)
		
		if i==2 then
			time=time+quest_01_07[tostring(i)]["talktime"]+0.5
			
		end
	end

	local quest_01_08= CustomNetTables:GetTableValue( "TalkInfo","quest_01_08")
	for i = 1, 1, 1 do
		time=questtalk(quest_01_08,target,target,i,time)
		
		if i==1 then
			time=time+quest_01_08[tostring(i)]["talktime"]+0.5
			
		end
	end

end
function Firstsystem:cunzhangquest_four()	
	local cunzhang = Entities:FindByName(nil,"npc_cunzhang")
	local quest_01_09= CustomNetTables:GetTableValue( "TalkInfo","quest_01_09")
	local time=0
	--英雄和村长交淡
	for i = 1, 2, 1 do
		time=questtalk(quest_01_09,cunzhang,cunzhang,i,time)
		
		if i==2 then
			time=time+quest_01_09[tostring(i)]["talktime"]+0.5
			
		end
	end
	local quest_01_10= CustomNetTables:GetTableValue( "TalkInfo","quest_01_10")

	--英雄和村长交淡
	for i = 1, 2, 1 do
		time=questtalk(quest_01_10,MAIN_HERO_TABLE[1],MAIN_HERO_TABLE[1],i,time)
		if i==2 then
			time=time+quest_01_10[tostring(i)]["talktime"]+0.5
			Timers:CreateTimer((time+0.5),function ()
				local forward_01=Vector(-5654.86,-7795.22,222)-Vector(-5577.41,-7666.12,222)
				local  jiejie_01 = ParticleManager:CreateParticle( "particles/units/heroes/hero_dark_seer/dark_seer_wall_of_replica.vpcf", PATTACH_ABSORIGIN, cunzhang )
   				ParticleManager:SetParticleControl( jiejie_01, 0, Vector(-6261.5,-6903.75,222))
   				ParticleManager:SetParticleControl( jiejie_01, 1, Vector(-5291,-7496,222))
   				ParticleManager:SetParticleControl( jiejie_01, 2, forward_01)
   				local forward_02=Vector(-5509.2,-7683.85,222)-Vector(-5647.21,-7717.86222)
   				local  jiejie_02 = ParticleManager:CreateParticle( "particles/units/heroes/hero_dark_seer/dark_seer_wall_of_replica.vpcf", PATTACH_ABSORIGIN, cunzhang )
   				ParticleManager:SetParticleControl( jiejie_02, 0, Vector(-5291,-7496,222))
   				ParticleManager:SetParticleControl( jiejie_02, 1, Vector(-4980.33,-8659.88,222))
   				ParticleManager:SetParticleControl( jiejie_01, 2, forward_02)
				self:cunzhangquest_five()
			end)
			
		end
	end

	

end
function Firstsystem:cunzhangquest_five()
	Firstsystem.cunzhang=0
	--local boss_01=CreateUnitByName("npc_dota_hero_target_dummy", Vector(-6237.85,-8312.54,214.884), true, nil, nil, DOTA_TEAM_BADGUYS )
	--if 1==1 then return end
	Firstsystem.UniteNumber = 4*#MAIN_HERO_TABLE
	event="shuaguai_01"
	local wave=1 
	CustomGameEventManager:Send_ServerToAllClients(event,{open=true,time=30,wave=1,total=wave})
	
	Timers:CreateTimer(
    	function ()
    		local times = 0
        	Timers:CreateTimer(
        	function ()
	        		if times < wave then
					    Firstsystem:wave_redirect()
					    times = times + 1
					    return 30
	        		end
	        end)

    end)
	local cunzhang = Entities:FindByName(nil,"npc_cunzhang")
    cunzhang:SetContextThink("quest_01", 
	function ()
			if Firstsystem.LastNumber==Firstsystem.UniteNumber*3 then 
				local ability_target=cunzhang:FindAbilityByName("Ability_targeteffect")
				if(ability_target==nil) then
					ability_target=cunzhang:AddAbility("Ability_targeteffect")
				end
				ability_target:ApplyDataDrivenModifier(cunzhang, cunzhang, "modifier_target_unit", {nil})
				Firstsystem.cunzhang=3
				return nil
			end
		return 1.0
	end,1)

end
function Firstsystem:cunzhangquest_six( target,unit )
	Firstsystem.cunzhang=0
	local quest_01_11= CustomNetTables:GetTableValue( "TalkInfo","quest_01_11")
		
	local time=0
	--英雄和村长交淡
	for i = 1, 7, 1 do
		time=questtalk(quest_01_11,target,unit,i,time)
		
		if i==7 then
			time=time+quest_01_11[tostring(i)]["talktime"]+0.5
		end
	end

end
function Firstsystem:cunzhangshuaguai( target,unit )
	Firstsystem.cunzhang=0
	local quest_01_03= CustomNetTables:GetTableValue( "TalkInfo","quest_01_03")
		
	local time=0
	--英雄和村长交淡
	for i = 1, 11, 1 do
		time=questtalk(quest_01_03,target,unit,i,time)
		
		if i==11 then
			time=time+quest_01_03[tostring(i)]["talktime"]+0.5
		end
	end

	local quest_01_04= CustomNetTables:GetTableValue( "TalkInfo","quest_01_04")
	--阿贵和英雄交淡
	for i = 1, 1, 1 do
		time=questtalk(quest_01_04,target,target,i,time)
		
		if i==1 then
			Timers:CreateTimer((time+quest_01_04[tostring(i)]["talktime"]+0.5),function ()
				Firstsystem.cunzhang=4 --激活小鬼任务
			end)
		end
		
	end	

	-- body
end


function Firstsystem:spawnUnit(unitName, spawnPoint, quantity)
  local difficulty=GameRules:GetCustomGameDifficulty()
  local num=#MAIN_HERO_TABLE
  local damage_canshu=difficulty*0.1*num/(1+0.1*num*difficulty)

  local delay = 2.7
  if Firstsystem.WaveNumber > 42 then
    delay = 6
  end
  for i = 0, quantity-1, 1 do
    Timers:CreateTimer(i*delay, 
    function()
      local unit = CreateUnitByName(unitName, spawnPoint, true, nil, nil, DOTA_TEAM_BADGUYS)
	  local health = unit:GetBaseMaxHealth()+unit:GetBaseMaxHealth()*(difficulty*0.6*num/(1+0.6*num*difficulty))
	    print(unit:GetBaseDamageMin())
      print(unit:GetBaseDamageMax())
      unit:SetBaseDamageMax(unit:GetBaseDamageMax()+unit:GetBaseDamageMax()*damage_canshu)

	  unit:SetBaseDamageMin(unit:GetBaseDamageMin()+unit:GetBaseDamageMin()*damage_canshu)
	  unit:SetBaseMaxHealth(health)
	  unit:SetMaxHealth(health)
	  unit:SetHealth(unit:GetMaxHealth())
     -- if not unit.worldPanel then
   
    -- entityHeight could be loaded from the npc_heroes.txt "HealthBarOffset"
    --unit.worldPanel = WorldPanels:CreateWorldPanelForAll(
     -- {layout = "file://{resources}/layout/custom_game/worldpanels/healthbar.xml",
      --  entity = unit:GetEntityIndex(),
       -- entityHeight = 210,
      --})
  		--end
      --Firstsystem:AdjustDeathXP(unit)
    end)
  end
end

function Firstsystem:wave_redirect()
  print("WAVENUMBER: "..Firstsystem.WaveNumber)
  if Firstsystem.WaveNumber == 0 then
    Firstsystem:wave1()
  end
  if Firstsystem.WaveNumber == 1 then
    Firstsystem:wave2()
  end

  if Firstsystem.WaveNumber == 2 then
    Firstsystem:wave3()
  end

  if Firstsystem.WaveNumber == 3 then
    Firstsystem:wave4()
  end

  if Firstsystem.WaveNumber == 4 then
    Firstsystem:wave5()
  end
  if Firstsystem.WaveNumber == 5 then
    Firstsystem:wave6()
  end
  if Firstsystem.WaveNumber == 6 then
    Firstsystem:wave7()
  end
  if Firstsystem.WaveNumber == 7 then
    Firstsystem:wave8()
  end
 if Firstsystem.WaveNumber == 8 then
    Firstsystem:wave9()
  end
   if Firstsystem.WaveNumber == 9 then
    Firstsystem:wave10()
  end
   if Firstsystem.WaveNumber == 10 then
    Firstsystem:wave11()
  end
   if Firstsystem.WaveNumber == 11 then
    Firstsystem:wave12()
  end
  

  Firstsystem.WaveNumber = Firstsystem.WaveNumber + 1
end

function Firstsystem:wave1()
	
      Firstsystem:spawnUnit("creature_01", SPAWN_POINT_OPEN_1, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_01", SPAWN_POINT_OPEN_2, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_01", SPAWN_POINT_OPEN_3, Firstsystem.UniteNumber)

    print("wave1 spawned")
end

function Firstsystem:wave2()

      Firstsystem:spawnUnit("creature_04", SPAWN_POINT_OPEN_1, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_05", SPAWN_POINT_OPEN_2, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_06", SPAWN_POINT_OPEN_3, Firstsystem.UniteNumber)

    print("wave2 spawned")
end

function Firstsystem:wave3()

     
      Firstsystem:spawnUnit("creature_01", SPAWN_POINT_OPEN_1, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_02", SPAWN_POINT_OPEN_2, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_03", SPAWN_POINT_OPEN_3, Firstsystem.UniteNumber)

    print("wave1 spawned")
end

function Firstsystem:wave4()

      Firstsystem:spawnUnit("creature_04", SPAWN_POINT_OPEN_1, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_05", SPAWN_POINT_OPEN_2, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_06", SPAWN_POINT_OPEN_3, Firstsystem.UniteNumber)

    print("wave2 spawned")
end

function Firstsystem:wave5()

     
      Firstsystem:spawnUnit("creature_01", SPAWN_POINT_OPEN_1, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_02", SPAWN_POINT_OPEN_2, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_03", SPAWN_POINT_OPEN_3, Firstsystem.UniteNumber)

    print("wave1 spawned")
end

function Firstsystem:wave6()

      Firstsystem:spawnUnit("creature_04", SPAWN_POINT_OPEN_1, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_05", SPAWN_POINT_OPEN_2, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_06", SPAWN_POINT_OPEN_3, Firstsystem.UniteNumber)

    print("wave2 spawned")
end

function Firstsystem:wave7()

      Firstsystem:spawnUnit("creature_04", SPAWN_POINT_OPEN_1, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_05", SPAWN_POINT_OPEN_2, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_06", SPAWN_POINT_OPEN_3, Firstsystem.UniteNumber)

    print("wave2 spawned")
end
function Firstsystem:wave8()

      Firstsystem:spawnUnit("creature_04", SPAWN_POINT_OPEN_1, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_05", SPAWN_POINT_OPEN_2, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_06", SPAWN_POINT_OPEN_3, Firstsystem.UniteNumber)

      Firstsystem:spawnUnit("creature_07", SPAWN_POINT_OPEN_1, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_08", SPAWN_POINT_OPEN_2, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_09", SPAWN_POINT_OPEN_3, Firstsystem.UniteNumber)

    print("wave2 spawned")
end

function Firstsystem:wave9()

      Firstsystem:spawnUnit("creature_04", SPAWN_POINT_OPEN_1, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_05", SPAWN_POINT_OPEN_2, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_06", SPAWN_POINT_OPEN_3, Firstsystem.UniteNumber)

      Firstsystem:spawnUnit("creature_07", SPAWN_POINT_OPEN_1, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_08", SPAWN_POINT_OPEN_2, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_09", SPAWN_POINT_OPEN_3, Firstsystem.UniteNumber)

    print("wave2 spawned")
end
function Firstsystem:wave10()

      Firstsystem:spawnUnit("creature_10", SPAWN_POINT_OPEN_1, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_05", SPAWN_POINT_OPEN_2, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_06", SPAWN_POINT_OPEN_3, Firstsystem.UniteNumber)

      Firstsystem:spawnUnit("creature_07", SPAWN_POINT_OPEN_1, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_08", SPAWN_POINT_OPEN_2, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_09", SPAWN_POINT_OPEN_3, Firstsystem.UniteNumber)

    print("wave2 spawned")
end

function Firstsystem:wave11()

      Firstsystem:spawnUnit("creature_10", SPAWN_POINT_OPEN_1, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_05", SPAWN_POINT_OPEN_2, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_06", SPAWN_POINT_OPEN_3, Firstsystem.UniteNumber)

      Firstsystem:spawnUnit("creature_07", SPAWN_POINT_OPEN_1, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_08", SPAWN_POINT_OPEN_2, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_09", SPAWN_POINT_OPEN_3, Firstsystem.UniteNumber)

    print("wave2 spawned")
end


function Firstsystem:wave12()

      Firstsystem:spawnUnit("creature_10", SPAWN_POINT_OPEN_1, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_05", SPAWN_POINT_OPEN_2, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_06", SPAWN_POINT_OPEN_3, Firstsystem.UniteNumber)

      Firstsystem:spawnUnit("creature_07", SPAWN_POINT_OPEN_1, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_08", SPAWN_POINT_OPEN_2, Firstsystem.UniteNumber)
      Firstsystem:spawnUnit("creature_09", SPAWN_POINT_OPEN_3, Firstsystem.UniteNumber)

    print("wave2 spawned")
end