
function ui_event_init()
	--游戏开始播放动画
	CustomGameEventManager:RegisterListener("UI_gamestart",UIgamestart)

	CustomGameEventManager:RegisterListener("UI_BuyItem",UIBuyItem)
	CustomGameEventManager:RegisterListener("UI_UpgradeItem",UIUpgradeItem)
	CustomGameEventManager:RegisterListener("SendErrorMsg",SendErrorMsg)
	CustomGameEventManager:RegisterListener("CloseHealHeroShipClose",CloseHealHeroShipClose)

	-- 选择难度
	CustomGameEventManager:RegisterListener("ui_event_select_difficulty",UI_GetSelectDifficulty)
	-- 获取英雄颜色
	CustomGameEventManager:RegisterListener("getplayercolor",setplayercolor)
	-- 添加属性点
	CustomGameEventManager:RegisterListener("ui_event_addwuxingdian",addwuxingdian)
	-- 传送阵
	CustomGameEventManager:RegisterListener("ui_event_chuansong",ui_chuansong)
	-- 查找物品
	CustomGameEventManager:RegisterListener("ui_event_hecheng_item_is",ui_hecheng_item_is)
	--对话矿
	CustomGameEventManager:RegisterListener("ui_event_duihuakuang",ui_event_duihuakuang)

	-- 强化
	CustomGameEventManager:RegisterListener("ui_event_hecheng_item",ui_hecheng_item)

	-- 获取强化所需材料
	CustomGameEventManager:RegisterListener("ui_event_strengthen_item_material",On_UI_StrengthenItemMaterial)

	-- 分解
	CustomGameEventManager:RegisterListener("ui_event_decompose_item",On_UI_DecomposeItem)

	-- 分解后的材料
	CustomGameEventManager:RegisterListener("ui_event_decompose_item_material",On_UI_DecomposeItemMaterial)

	-- 合成
	CustomGameEventManager:RegisterListener("ui_event_compose_item",On_UI_ComposeItem)

	-- 物品从背包中丢出
	CustomGameEventManager:RegisterListener("ui_event_backpack_drop_item",UI_BackpackDropItem)

	-- 背包物品对换位置
	CustomGameEventManager:RegisterListener("ui_event_backpack_swap_pos",UI_BackpackSwapPosition)

	-- 捡起物品
	CustomGameEventManager:RegisterListener("ui_event_backpack_right_click_item",On_UI_RightClickItem)

	-- 丢弃物品
	CustomGameEventManager:RegisterListener("ui_event_backpack_menu_drop_item",UI_BackpackMenuDropItem)

	-- 出售物品
	CustomGameEventManager:RegisterListener("ui_event_backpack_menu_sell_item",UI_BackpackMenuSellItem)

	-- 放置到末尾
	CustomGameEventManager:RegisterListener("ui_event_backpack_item_pos_to_end",UI_BackpackItemPosToEnd)

	-- 背包交互
	CustomGameEventManager:RegisterListener("ui_event_backpack_update_backpack",On_UI_BackpackUpdateBackpack)

	-- 存储64位ID
	CustomGameEventManager:RegisterListener("ui_event_steam_id",On_UI_SteamID)

	-- 投票
	CustomGameEventManager:RegisterListener("ui_event_select_mode",On_UI_SelectMode)

	-- 获取选择的模式
	CustomGameEventManager:RegisterListener("dota_player_get_select_mode",On_UI_GetSelectMode)

end


function UIgamestart(event,data )
	local player = PlayerResource:GetPlayer(data.PlayerID)
	if player == nil then return end

	local hero = player:GetAssignedHero()
	if hero == nil then return end

	local shifu = Entities:FindByName(nil,"npc_tiejiang")
			Timers:CreateTimer(1,function ()
				local visionTracer = CreateUnitByName("npc_flying_dummy_vision", Vector(-12672.5,-13573.9,2609.8), true, nil, nil, DOTA_TEAM_GOODGUYS)
				visionTracer:AddAbility("dummy_unit"):SetLevel(1)
				
				PlayerResource:SetCameraTarget(data.PlayerID, visionTracer)
				talktoplayer(player,true,shifu,"天玄派是武林中第一大门派，由开山鼻祖天玄子创建，天玄位于群山之颠，山峰淩空，宛若浮云，相传为仙家赐予人间的胜地",false,nil,8,40,40,30)
				Timers:CreateTimer(1,function ()
					visionTracer:MoveToPosition(Vector(-14011.5,-12102.3))
					Timers:CreateTimer(7,function ()
						--recameradistance(2334)
						talktoplayer(player,true,shifu,"天玄一脉历史悠久，创派至今已有两千余年，",false,nil,5,30,50,30)
						Timers:CreateTimer(5,function ()
							visionTracer:MoveToPosition(Vector(-13764,-7856))
							recameradistance(1034)
							local baojian = Entities:FindByName(nil,"baojian")
							ability_01=baojian:AddAbility("Ability_targeteffect")
							ability_01:ApplyDataDrivenModifier(baojian, baojian, "modifier_target_unit", {duration=10})
							talktoplayer(player,true,shifu,"位于”藏剑阁“的“天玄剑”是当年XX祖师在“上古遗迹”中得到古剑“天玄”，仗之横行天下，几无敌手。",false,nil,10,25,50,30)
							Timers:CreateTimer(10,function ()
								recameradistance(2334)
								visionTracer:MoveToPosition(Vector(-15041,-12028.2))
								talktoplayer(player,true,shifu,"天玄派修炼方式注重内功，修仙求积德而不求升仙，积极入世斩妖。同时，也不排斥其他门派的修炼方式，积极搜集和保存各类修仙方法。",false,nil,10,15,50,180)
								Timers:CreateTimer(10,function ()
									visionTracer:MoveToPosition(Vector(-15140,-15680))
									talktoplayer(player,true,shifu,"除魔任务就交给你们了",false,nil,5,5,50,360)
									Timers:CreateTimer(5,function ()
									
									recameradistance(1334)
									PlayerResource:SetCameraTarget(data.PlayerID, nil)
									end)
								end)
							end)
						end)
					end)
				end)
			end)
	-- body
end



function addwuxingdian(event,data )
	local player = PlayerResource:GetPlayer(data.PlayerID)
	if player == nil then return end

	local hero = player:GetAssignedHero()
	if hero == nil then return end
	Setwuxing(hero,data.target)
	-- body
end
function setplayercolor(event,data)

	local player = PlayerResource:GetPlayer(data.PlayerID)
	if player == nil then return end
	for i = 1, #MAIN_HERO_TABLE, 1 do
			local playerID = MAIN_HERO_TABLE[i]:GetPlayerID()
			if playerID then
				if(playerID==data.id) then 
					MAIN_HERO_TABLE[i].color=data.color;
				end
				
			end
	end
end
function ui_chuansong(event,data)
		local player = PlayerResource:GetPlayer(data.PlayerID)
		if player == nil then return end

		local hero = player:GetAssignedHero()
		if hero == nil then return end
		local chuansong_01
		--print(data.chuansong)
		if data.chuansong==1 then
			chuansong_01=Entities:FindByName(nil, "trigger_chuansong_01")	
		end
		if data.chuansong==2 then
			chuansong_01=Entities:FindByName(nil, "trigger_chuansong_02")	
		end
		if data.chuansong==3 then
			
			chuansong_01=Entities:FindByName(nil, "trigger_chuansong_03")	
		end
		if data.chuansong==4 then
			
			chuansong_01=Entities:FindByName(nil, "trigger_chuansong_04")	
		end
			
			if chuansong_01.chuansongdummy==nil then
				local chuansongdummy = CreateUnitByName("npc_chuansong_dummy_vision", chuansong_01:GetOrigin(), true, nil, nil, DOTA_TEAM_GOODGUYS)

				chuansong_01.chuansongdummy=chuansongdummy
			
			end
			effectsing = ParticleManager:CreateParticle("particles/econ/events/ti6/teleport_end_ti6_lvl3.vpcf",PATTACH_ABSORIGIN_FOLLOW,hero)
			ParticleManager:SetParticleControl(effectsing,0,hero:GetOrigin())
			ParticleManager:SetParticleControl(effectsing,1,chuansong_01.chuansongdummy:GetOrigin())
			MinimapEvent(hero:GetTeamNumber(), chuansong_01.chuansongdummy, chuansong_01.chuansongdummy:GetOrigin().x, chuansong_01.chuansongdummy:GetOrigin().y, DOTA_MINIMAP_EVENT_TEAMMATE_TELEPORTING, 3)

			EmitSoundOn("chuansong.doing", hero)
			EmitSoundOn("chuansong.doing", chuansong_01)
			Timers:CreateTimer(1,function ()
				StopSoundOn("chuansong.doing",hero)
				EmitSoundOn("chuansong.out", hero)
			end)
			Timers:CreateTimer(1.5,function ()
				StopSoundOn("chuansong.doing",chuansong_01)
				EmitSoundOn("chuansong.in", chuansong_01.chuansongdummy)
				ParticleManager:DestroyParticle(effectsing,false)
				
			end)
			
			Timers:CreateTimer(1.5,function ()
				ParticleManager:DestroyParticle(effectsing,false)
				hero:SetOrigin(Vector(chuansong_01:GetOrigin().x+200,chuansong_01:GetOrigin().y+200,chuansong_01:GetOrigin().z))
				FindClearSpaceForUnit(hero, Vector(chuansong_01:GetOrigin().x+200,chuansong_01:GetOrigin().y+200,chuansong_01:GetOrigin().z), true)
			
				PlayerResource:SetCameraTarget(hero:GetPlayerOwnerID(),hero)
				Timers:CreateTimer(0.5,function()
						local enemies = FindUnitsInRadius( DOTA_TEAM_GOODGUYS, chuansong_01.chuansongdummy:GetOrigin(), nil, 150, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, 0, 0, false )
	
						if #enemies > 0 then
								
						else

							if chuansong_01.effectsing then
								--ParticleManager:DestroyParticle(chuansong_01.effectsing, false)
								chuansong_01.effectsing=nil
							end
					
						
						end
		               PlayerResource:SetCameraTarget(hero:GetPlayerOwnerID(),nil)
		            end)
			end)
			
			
			
		
end


function ui_event_duihuakuang(event,data)
		local player = PlayerResource:GetPlayer(data.PlayerID)
		if player == nil then return end

		local hero = player:GetAssignedHero()
		if hero == nil then return end

		if data.funcname==1 then
			event="talk"
			CustomGameEventManager:Send_ServerToPlayer(hero:GetPlayerOwner(),event,{open=true,unitename="npc_nvnongfu_unit",talk="带<span><font color=\"#FEA12F\">".."老</font></span>子回家",next=true,missname=2,nexttext="接受"}) 

		
		end
end
--查找物品
function ui_item_is(player,itemname)
	
	if player == nil then return end

	local hero = player:GetAssignedHero()
	if hero == nil then return end
	local isitem=-1
	print(222)
	Backpack:Traverse( hero, function(pack,packIndex,itemIndex)
			local packItem = EntIndexToHScript(itemIndex)
			if packItem then

				if packItem:GetAbilityName() == itemname then

					isitem=0
					return true					
				end
			end
		end )
	if(isitem==-1) then
		for item_slot = 0,5 do
			
			item = hero:GetItemInSlot(item_slot)
			if item ~= nil then
				
				local isChecked = false
				
				if item:GetAbilityName() == itemname then
					isitem=0
					break;
				end
			end
		end

	end

	return isitem
	-- body
end
-- 扣钱
function SubGold( PlayerID,gold )
	if PlayerResource:GetGold(PlayerID) >= gold then
		local unreliable_gold = PlayerResource:GetUnreliableGold(PlayerID)
		local sub = unreliable_gold - gold

		if sub < 0 then
			PlayerResource:SetGold(PlayerID, 0, false)

			local reliable_gold = PlayerResource:GetReliableGold(PlayerID)
			PlayerResource:SetGold(PlayerID, reliable_gold + sub, true)
		else
			PlayerResource:SetGold(PlayerID, sub, false)
		end

		return true
	end
	return false
end

-- 判断物品栏已满
function UIIsItemFull( unit )

	if not unit:HasInventory() then
		return nil
	end

	local num = 0
	for i=0,5 do
		if unit:GetItemInSlot(i) ~= nil then
			num = num + 1
		end
	end
	if num < 6 then
		return true
	else
		return false
	end
end

-- 删除物品
function UIRemoveItemByName( unit,itemname )
	for i=0,5 do
		local item = unit:GetItemInSlot(i)
		if item then
			if item:GetAbilityName() == itemname then
				return item
			end
		end
	end
end

-- 判断物品栏是否有物品
function UIHasItem( unit, item )
	for i=0,5 do
		local itemSlot = unit:GetItemInSlot(i)
		if itemSlot == item then
			return true
		end
	end
	return false
end

-- 购买物品
function UIBuyItem( event,data )
	if data.entindex and data.entindex ~= -1 and data.info then
		local unit = EntIndexToHScript(data.entindex)
		local player = PlayerResource:GetPlayer(data.PlayerID)
		if player ~=nil and unit ~= nil then

			-- 判断购买者
			-- if not Shops:HasInHome(unit) and not Shops:HasInSide(unit) then
			-- 	return
			-- end

			-- 判断物品栏
			local buy = not Backpack:IsFull( unit )
			if buy == nil then
				data.text="#not_inventory"
				SendErrorMsg(event,data)
				return
			elseif buy == false then
				data.text="#dota_hud_error_cant_purchase_inventory_full"
				SendErrorMsg(event,data)
				return
			end 

			-- 判断是否需要子物品
			local itemChild = nil
			if data.info.NeedItem then
				for k,v in pairs(data.info.NeedItem) do
					
					if unit:HasItemInInventory(v) then
						itemChild = v
					end
					
					break
				end
			else
				itemChild = true;
			end

			-- 删除子物品
			if not itemChild then
				data.text="#upgrade_item_fail"
				SendErrorMsg(event,data)
				return
			elseif itemChild ~= true then
				local hOldItem = UIRemoveItemByName(unit,itemChild)
				unit:RemoveItem(hOldItem)

				-- 返回金钱
				local gold = GetItemCost(itemChild)
				local unreliable_gold = PlayerResource:GetUnreliableGold(data.PlayerID)
				PlayerResource:SetGold(data.PlayerID, unreliable_gold + gold, false)
			end

			local gold = GetItemCost( data.info.name )

			if SubGold( data.PlayerID, gold ) then
				Backpack:CreateItem( unit, data.info.name )
			else
				data.text="#dota_hud_error_not_enough_gold"
				SendErrorMsg(event,data)
			end
		end
	else
		data.text="#dota_hud_error_cant_sell_shop_not_in_range"
		SendErrorMsg(event,data)
	end
end

-- 升级物品
function UIUpgradeItem( event,data )
	if data.entindex then
		local unit = EntIndexToHScript(data.entindex)
		local player = PlayerResource:GetPlayer(data.PlayerID)
		if player ~=nil and unit ~= nil then

			-- 判断物品栏
			local buy = UIIsItemFull(unit)
			if buy == nil then
				data.text="#not_inventory"
				SendErrorMsg(event,data)
				return
			end

			-- 判断是否有物品
			if not unit:HasItemInInventory(data.itemChildName) then
				data.text="#upgrade_item_fail"
				SendErrorMsg(event,data)
				return
			end

			local gold = GetItemCost( data.itemName )

			if SubGold( data.PlayerID, gold ) then
				local hOldItem = UIRemoveItemByName(unit,data.itemChildName)
				local cost = hOldItem.m_ChildrenCost or 0
				unit:RemoveItem(hOldItem)

				local item = CreateItem(data.itemName, nil, nil)
				item.m_ChildrenCost = cost + GetItemCost( data.itemChildName )
				print(item.m_ChildrenCost)
			else
				data.text="#dota_hud_error_not_enough_gold"
				SendErrorMsg(event,data)
			end
		end
	end
end

-- 发送错误消息
function SendErrorMsg( event,data )
	CustomGameEventManager:Send_ServerToPlayer(
		PlayerResource:GetPlayer(data.PlayerID),
		"avalon_game_ui_show_bottom_message",
		{text=data.text,r=255,g=0,b=0})
end

function SendErrorMsgBox( event,data )
	CustomGameEventManager:Send_ServerToPlayer(
		PlayerResource:GetPlayer(data.PlayerID),
		"avalon_game_ui_add_message",
		{text=data.text,vars=data.vars,npc="#avalon_game_ui_message_npc_system"})
	
end

function SendErrorMsgBoxForAllPlayer( text, vars )
	CustomGameEventManager:Send_ServerToAllClients(
		"avalon_game_ui_add_message",
		{text=text,vars=vars,npc="#avalon_game_ui_message_npc_system"})
end

function SendErrorMsgBoxForHero( hero, text, vars )
	local data = {}

	data.PlayerID = hero:GetPlayerID()

	data.text = text

	data.vars = vars

	SendErrorMsgBox(1,data)
end

-- 取消修理
function CloseHealHeroShipClose( event,data )
	if data.entindex then
		local unit = EntIndexToHScript(data.entindex)
		if unit then
			unit._No_HealHeroShip = true
			unit:RemoveModifierByName("modifier_BaseHealHeroShip_heal_effect")
		end
	end
end

-- 返回合成配方
function ui_hecheng_item( event,data )
	if GameRules:IsGamePaused() then return end
	
	if type(data.itemIndex) == "number" then
		local item = EntIndexToHScript(data.itemIndex)
		if item == nil then return end

		local player = PlayerResource:GetPlayer(data.PlayerID)
		if player == nil then return end

		local hero = player:GetAssignedHero()
		if hero == nil then return end
		
		local item_data=GameRules.m_ItemData_Items[item:GetAbilityName()]
		local hecheng_item={}
		local ItemRequirements
		print(item_data.ItemResult)
		hecheng_item['ItemResult']={}
		hecheng_item['ItemResult'][item_data.ItemResult]=ui_item_is(player,item_data.ItemResult)
		for _,special in pairs(item_data.ItemRequirements) do
		
			ItemRequirements=string.split(special,";")
			
		end
		hecheng_item['ItemRequirements']={}
		for k,v in pairs(ItemRequirements) do
			hecheng_item['ItemRequirements'][v]=ui_item_is(player,v)
		end
	
		
		CustomGameEventManager:Send_ServerToPlayer(player,"ui_event_hecheng_item_return",{itemname=hecheng_item}) 
	end
end

-- 强化的材料
_G["StrengthenSlotItem"] = {}
function On_UI_StrengthenItemMaterial( event,data )
	if GameRules:IsGamePaused() then return end
	if type(data.itemIndex) == "number" then
		local item = EntIndexToHScript(data.itemIndex)
		if item == nil then return end

		local player = PlayerResource:GetPlayer(data.PlayerID)
		if player == nil then return end

		local hero = player:GetAssignedHero()
		if hero == nil then return end

		StrengthenSlotItem[hero:GetEntityIndex()] = data.itemIndex

		local materialItemName = GetItemMaterialName(item)

		CustomGameEventManager:Send_ServerToPlayer(player,"ui_event_strengthen_item_material_return",{itemname=materialItemName}) 

	end
end

-- 分解
function On_UI_DecomposeItem( event,data )
	if GameRules:IsGamePaused() then return end
	if type(data.itemIndex) == "number" then
		local item = EntIndexToHScript(data.itemIndex)
		if item == nil then return end

		local player = PlayerResource:GetPlayer(data.PlayerID)
		if player == nil then return end

		local hero = player:GetAssignedHero()
		if hero == nil then return end

		if UIHasItem(hero,item) then
			OnCourierDecomposeSpellStart({caster=hero,item=item})
		else
			local hasItem,packIndex = Backpack:HasItem(hero,item:GetEntityIndex())

			if hasItem then
				OnCourierDecomposeSpellStart({caster=hero,item=item})
			end
		end

	end
end

-- 分解后的材料
_G["DecomposeSlotItem"] = {}
function On_UI_DecomposeItemMaterial( event,data )
	if GameRules:IsGamePaused() then return end
	if type(data.itemIndex) == "number" then
		local item = EntIndexToHScript(data.itemIndex)
		if item == nil then return end

		local player = PlayerResource:GetPlayer(data.PlayerID)
		if player == nil then return end

		local hero = player:GetAssignedHero()
		if hero == nil then return end

		DecomposeSlotItem[hero:GetEntityIndex()] = data.itemIndex

		local materialItemName = GetItemMaterialName(item)

		CustomGameEventManager:Send_ServerToPlayer(player,"ui_event_decompose_item_material_return",{itemname=materialItemName}) 

	end
end

-- 合成
function On_UI_ComposeItem( event,data )
	if GameRules:IsGamePaused() then return end
	if type(data.itemIndex) == "number" then
		local player = PlayerResource:GetPlayer(data.PlayerID)
		if player == nil then return end

		local hero = player:GetAssignedHero()
		if hero == nil then return end
		local composeInfo={}
		local item = EntIndexToHScript(data.peifang)
		local item_data=GameRules.m_ItemData_Items[item:GetAbilityName()]
		local hecheng_item={}
		hecheng_item['ItemResult']=item_data.ItemResult
		for _,special in pairs(item_data.ItemRequirements) do
		
			composeInfo["requestItem"]=string.split(special,";")
			
		end
		 composeInfo["composeItem"]=item_data.ItemResult

		-- 无效配方
		if composeInfo == nil then
			data.text = "#ui_event_compose_item_invaild";
			SendErrorMsgBox(event,data)
			return 
		end

		local isComposed = false
		local composeItem = {}
		local item
		
		
		
		for k1,v1 in pairs(composeInfo["requestItem"]) do

			Backpack:Traverse( hero, function(pack,packIndex,itemIndex)
				local packItem = EntIndexToHScript(itemIndex)
				if packItem then
					local isChecked = false
					for k3,v3 in pairs(composeItem) do
						if packItem == v3 then
							isChecked = true
						end
					end
					if packItem:GetAbilityName() == v1 and (not isChecked) then
						
						table.insert(composeItem,packItem)
						return true
					end
				end
			end )
			
			for item_slot = 0,5 do
				
				item = hero:GetItemInSlot(item_slot)
				if item ~= nil then
					
					local isChecked = false
					
					for k3,v3 in pairs(composeItem) do
					
						if item:GetAbilityName() == v3:GetAbilityName() then
							isChecked = true
						end
					end
					if item:GetAbilityName() == v1 and (not isChecked) then
						
						table.insert(composeItem,item)
						break;
					end
				end
			end
		end
		
		local ent = Entities:FindByName(nil, "npc_tiejiang")

		particleID=ParticleManager:CreateParticle("particles/tiejiang/tiejiang.vpcf", PATTACH_ABSORIGIN_FOLLOW,ent)
		ParticleManager:SetParticleControl(particleID,0,ent:GetOrigin())
		StartAnimation(ent, {duration=2, activity=ACT_DOTA_ATTACK, rate=1.25})
		if (#composeItem) == (#composeInfo["requestItem"]) then
					
			for k2,v2 in pairs(composeItem) do
				if UIHasItem(hero,v2) then
					hero:RemoveItem(v2)
				else
					Backpack:ConsumeItem(hero,v2)
				end
			end
			Timers:CreateTimer(3,
		  		function()
					EmitSoundOn("ui.ding", hero)
					Backpack:CreateItem( hero, composeInfo["composeItem"] )
					isComposed = true
			end)
			
		else
			data.text = "#ui_event_compose_item_not_enough";
			SendErrorMsgBox(event,data)
		end

		if data.isGem == 0 and isComposed then
			local gold = PlayerResource:GetGold(data.PlayerID)
			if gold >= 2000 then
				SubGold(data.PlayerID,0)
			else
				return
			end
		end
	end
end

-- 物品从背包中丢出
function UI_BackpackDropItem( event,data )
	if GameRules:IsGamePaused() then return end
	if type(data.itemIndex) == "number" and type(data.unitIndex) == "number" and type(data.pos_x) == "number" and type(data.pos_y) == "number" and type(data.pos_z) == "number" then
		local unit = EntIndexToHScript(data.unitIndex)
		if unit == nil then return end

		local player = PlayerResource:GetPlayer(data.PlayerID)
		if player == nil then return end

		local hero = player:GetAssignedHero()
		if hero == nil then return end
		if hero:IsNull() and not hero:IsAlive() then return end
		
		local item = EntIndexToHScript(data.itemIndex)

		Backpack:DropItemToOtherUnitPosition(hero, unit, item, Vector(data.pos_x,data.pos_y,data.pos_z))
		
		
	end
end

-- 背包物品对换位置
function UI_BackpackSwapPosition( event,data )
	if GameRules:IsGamePaused() then return end
	if type(data.packIndex1) == "number" and type(data.packIndex2) == "number" then
		local player = PlayerResource:GetPlayer(data.PlayerID)
		if player == nil then return end

		local hero = player:GetAssignedHero()
		if hero == nil then return end
		if hero:IsNull() and not hero:IsAlive() then return end
		
		Backpack:SwapItem( hero, data.packIndex1, data.packIndex2 )
	end
end

-- 捡起物品
function On_UI_RightClickItem( event,data )
	
	if type(data.unitIndex) == "number" and type(data.targetIndex) == "number" then
		local player = PlayerResource:GetPlayer(data.PlayerID)
		if player == nil then return end
		
		local unit = EntIndexToHScript(data.unitIndex)
		local target = EntIndexToHScript(data.targetIndex)

		if unit == nil or target == nil then return end
		if target:GetClassname() ~= "dota_item_drop" then return end

		local hero = player:GetAssignedHero()
		if hero == nil then return end

		if hero ~= unit and unit:GetUnitName() == "unit_courier" then
			if (unit:GetOrigin() - target:GetOrigin()):Length2D() <= 150 then
				local item = target:GetContainedItem()
				Backpack:AddItem( hero, item )
			end
		else
			if hero:GetNumItemsInInventory() >= 6 and (hero:GetOrigin() - target:GetOrigin()):Length2D() <= 150 then
				local item = target:GetContainedItem()
				Backpack:AddItem( hero, item )
			end
		end
	
			
	end
end

-- 丢弃物品
function UI_BackpackMenuDropItem( event,data )
	if type(data.itemIndex) == "number" and type(data.unitIndex) == "number" then
		local unit = EntIndexToHScript(data.unitIndex)
		if unit == nil then return end

		local item = EntIndexToHScript(data.itemIndex)
		if item == nil then return end

		local player = PlayerResource:GetPlayer(data.PlayerID)
		if player == nil then return end

		local hero = player:GetAssignedHero()
		if hero == nil then return end
		
		Backpack:DropItemToOtherUnit( hero, unit, item )
	end
end

function UI_BackpackMenuSellItem( event,data )
	if GameRules:IsGamePaused() then return end
	if type(data.itemIndex) == "number" then
		local item = EntIndexToHScript(data.itemIndex)
		if item == nil then return end

		local player = PlayerResource:GetPlayer(data.PlayerID)
		if player == nil then return end

		local hero = player:GetAssignedHero()
		if hero == nil then return end
		
		Backpack:SellItem( hero, item )
	end
end

function UI_BackpackItemPosToEnd( event,data )
	if type(data.packIndex) == "number" then
		local player = PlayerResource:GetPlayer(data.PlayerID)
		if player == nil then return end

		local hero = player:GetAssignedHero()
		if hero == nil then return end
		
		Backpack:ItemPosToEnd( hero, data.packIndex )
	end
end


function On_UI_DotaDropItem( event,data )
	local player = PlayerResource:GetPlayer(data.PlayerID)
	if player == nil then return end

	local hero = player:GetAssignedHero()
	if hero == nil then return end

	Backpack:ComposeItemsRefresh(hero)
end

function On_UI_BackpackUpdateBackpack( event,data )
	
	local player = PlayerResource:GetPlayer(data.PlayerID)
	if player == nil then return end

	local hero = player:GetAssignedHero()
	if hero == nil then return end

	for i=1,BackpackConfig.MaxItem do
		Backpack:UpdateItem( hero, i )
	end
end

function On_UI_SteamID( event,data )
	if type(data.steamid) == "string" then

		local player = PlayerResource:GetPlayer(data.PlayerID)
		if player == nil then return end

		local hero = player:GetAssignedHero()
		if hero == nil then return end

		SteamAccountID[hero:GetEntityIndex()] = data.steamid
		print("Save SteamAccountID "..hero:GetEntityIndex().."="..data.steamid)

	end
end





OpenFogOfWarNum = {}
PlayersSelectMode = {}
PlayersSelectMode["RandomSuit"] = {}
PlayersSelectMode["FixSuit"] = {}
function On_UI_SelectMode( event,data )
	if type(data.mode) == "string" then
		local player = PlayerResource:GetPlayer(data.PlayerID)
		if player == nil then return end

		local id = data.PlayerID + 1

		if data.mode == "RandomSuit" then
			PlayersSelectMode["RandomSuit"][id] = true
			PlayersSelectMode["FixSuit"][id] = nil

		elseif data.mode == "FixSuit" then
			PlayersSelectMode["FixSuit"][id] = true
			PlayersSelectMode["RandomSuit"][id] = nil

		elseif data.mode == "FogOfWar" then
			OpenFogOfWarNum[id] = true
		end

		CustomGameEventManager:Send_ServerToAllClients("ui_event_select_mode_return",
			{RandomSuit=#PlayersSelectMode["RandomSuit"],FixSuit=#PlayersSelectMode["FixSuit"],FogOfWar=#OpenFogOfWarNum})
	end
end

function On_UI_GetSelectMode( event,data )
	local player = PlayerResource:GetPlayer(data.PlayerID)
	if player == nil then return end

	if #PlayersSelectMode["RandomSuit"] > #PlayersSelectMode["FixSuit"] then
		CustomGameEventManager:Send_ServerToPlayer(player,"dota_player_get_select_mode_return",{mode="RandomSuit"})
	else
		CustomGameEventManager:Send_ServerToPlayer(player,"dota_player_get_select_mode_return",{mode="FixSuit"})
	end
	
end

PlayersSelectDifficulty = {}
PlayersSelectDifficulty["easy"] = 0
PlayersSelectDifficulty["normal"] = 0
PlayersSelectDifficulty["hard"] = 0
PlayersSelectDifficulty["veryhard"] = 0
PlayersSelectDifficulty["devil"] = 0

function UI_GetSelectDifficulty( event,data )

	if type(data.difficulty) == "string" then
		local player = PlayerResource:GetPlayer(data.PlayerID)
		if player == nil then return end

		local id = data.PlayerID

		for i = 1, #Playerlist, 1 do
			if Playerlist[i]['id']==data.PlayerID and Playerlist[i]['check']==0 then 
				PlayersSelectDifficulty[data.difficulty] = PlayersSelectDifficulty[data.difficulty] + 1
				Playerlist[i]['check']=1
			end
		end
		
		CustomGameEventManager:Send_ServerToAllClients("ui_event_select_difficulty_return",
			{easy=PlayersSelectDifficulty["easy"], hard=PlayersSelectDifficulty["hard"],
			 normal=PlayersSelectDifficulty["normal"], veryhard=PlayersSelectDifficulty["veryhard"],
			 devil=PlayersSelectDifficulty["devil"]})
	end
end
ui_event_init()