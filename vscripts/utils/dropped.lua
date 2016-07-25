--[[
怪物掉宝
]]--

local itemTable={
		 			{"fb_01_01",0,
						{
							{"item_0074",0.1},
						}
					},   	
					------------狼妖--------------
					{"FB_01_BOSS_01",1,
						{
							{"item_0001",1.0},
							{"item_0012",1.0},
							{"item_0023",1.0},
							{"item_0034",1.0},
							{"item_0045",1.0},

							{"item_0075",1.0},
							{"item_0177",1.0},
						}
					}, 
					------------狼妖--------------
					{"creature_01",1,
						{
							{"item_0001",1.0},
							{"item_0012",1.0},
							{"item_0023",1.0},
							{"item_0034",1.0},
							{"item_0045",1.0},

							{"item_0075",1.0},
							{"item_0177",1.0},
						}
					},    	
					-----------狼妖王-------------
					{"fb_02_01",0,
						{
							{"item_0079",0.1},
							{"item_0178",0.1},
						}
					},   	
					------------鱼妖--------------
					{"fb_02_BOSS_01",1,
						{
							{"item_0076",1.0},
							{"item_0077",1.0},
							{"item_0078",1.0},
							{"item_0080",1.0},
						}
					},		
					-----------鱼妖王-------------
					{"fb_06_BOSS_03",1,
						{
							{"item_0197",1.0},
							{"item_0190",1.0}
						}
					},   					
					------------敖鸳--------------
					{"fb_06_BOSS_01",1,
						{
							{"item_0081",1.0},
							{"item_0082",1.0},
							{"item_0083",1.0},
							{"item_0084",1.0},
						}
					},   					
					----------东海龙王------------
					{"fb_06_BOSS_04",6,
						{
							{"item_0189",1.0},
							{"item_0198",1.0},

							{"item_0223",1.0},
							{"item_0235",1.0},
							{"item_0247",1.0},
							{"item_0259",1.0},
							{"item_0260",1.0}
						}
					},   					
					----------长眉老祖------------
					{"fb_03_01",3,
						{
							{"item_0085",1.0},
							{"item_0086",1.0},
							{"item_0185",1.0},
						}
					},   										
					-----------山妖---------------
					{"fb_03_BOSS_01",1,
						{
							{"item_0002",1.0},
							{"item_0013",1.0},
							{"item_0024",1.0},
							{"item_0035",1.0},
							{"item_0046",1.0},

							{"item_0087",1.0},
							{"item_0211",1.0},
						}
					},   										
					----------山妖王--------------
					{"fb_03_02",0,
						{
							{"item_0091",0.1},
							{"item_0092",0.1}
						}
					},  	
					-----------蜘蛛精-------------
					{"fb_03_BOSS_02",1,
						{
							{"item_0088",1.0},
							{"item_0089",1.0},
							{"item_0090",1.0}
						}
					},  	
					---------千年蜘蛛精-----------
					{"fb_04_BOSS_01",1,
						{
							{"item_0093",1.0},
							{"item_0094",1.0},
							{"item_0095",1.0},
							{"item_0096",1.0},
							{"item_0097",1.0},
							{"item_0213",1.0}
						}
					},	
					-----------雪妖王-------------
					{"fb_04_BOSS_02",1,
						{
							{"item_0283",1.0},
							{"item_0284",1.0},
							{"item_0285",1.0},
							{"item_0286",1.0},
							{"item_0288",1.0},
							{"item_0289",1.0},
							{"item_0290",1.0},
							{"item_0291",1.0}
						}
					},	
					-----------试练魔-------------
					{"fb_05_BOSS_01",1,
						{
							{"item_0098",1.0},
							{"item_0099",1.0}
						}
					},	
					------------朱雀--------------
					{"fb_05_BOSS_02",1,
						{
							{"item_0101",1.0},
							{"item_0100",1.0}
						}
					},	
					------------白虎--------------
					{"fb_05_BOSS_03",1,
						{
							{"item_0102",1.0},
							{"item_0103",1.0}
						}
					},	
					------------青龙--------------
					{"fb_05_BOSS_04",1,
						{
							{"item_0104",1.0},
							{"item_0105",1.0}
						}
					},	
					------------玄武--------------
					{"fb_06_BOSS_02",1,
						{
							{"item_0108",1.0},
							{"item_0109",1.0},
							{"item_0110",1.0},
							{"item_0111",1.0},
							{"item_0112",1.0},
						}
					},	
					------------刑天--------------
					{"fb_10_BOSS_01",1,
						{
							{"item_0115",1.0},
							{"item_0116",1.0},
							{"item_0117",1.0},
							{"item_0118",1.0},
							{"item_0119",1.0},
							{"item_0120",1.0},
							{"item_0121",1.0},
							{"item_0122",1.0},
							{"item_0123",1.0},
							{"item_0124",1.0},
							{"item_0125",1.0},
							{"item_0126",1.0}
						}
					},															
					----------十二祖巫------------
					{"fb_07_BOSS_01",1,
						{
							{"item_0127",1.0},
							{"item_0128",1.0}
						}
					}, 									   						
					------------蛟魔王------------
					{"fb_07_BOSS_02",1,
						{
							{"item_0129",1.0},
							{"item_0130",1.0},
							{"item_0196",1.0}
						}
					}, 									   						
					------------狮驼王------------
					{"fb_07_BOSS_03",1,
						{
							{"item_0133",1.0},
							{"item_0199",1.0}
						}
					}, 									   										
					------------禺狨王------------
					{"fb_07_BOSS_04",1,
						{
							{"item_0131",1.0},
							{"item_0132",1.0},

							{"item_0225",1.0},
							{"item_0237",1.0},
							{"item_0249",1.0},
							{"item_0261",1.0},
							{"item_0273",1.0}
						}
					},	
					------------猕猴王------------
					{"fb_07_02",0,
						{
							{"item_0187",0.1},
							{"item_0203",0.1}
						}
					}, 	
					------------天兵-------------
					{"fb_07_03",0,
						{
							{"item_0187",0.1},
							{"item_0203",0.1}
						}
					}, 	
					------------天将-------------
					{"fb_07_BOSS_05",1,
						{
							{"item_0134",1.0},
							{"item_0135",1.0},
							{"item_0205",1.0}
						}
					}, 									   						
					---------三坛海会大神---------
					{"fb_07_BOSS_06",1,
						{
							{"item_0136",1.0},
							{"item_0137",1.0},
							{"item_0206",1.0}
						}
					}, 									   						
					-----------托塔天王-----------
					{"fb_07_BOSS_07",1,
						{
							{"item_0138",1.0},
							{"item_0139",1.0},

							{"item_0005",1.0},
							{"item_0016",1.0},
							{"item_0027",1.0},
							{"item_0038",1.0},
							{"item_0049",1.0}
						}
					}, 									   						
					-----------二郎真君-----------
					{"fb_08_BOSS_01",1,
						{
							{"item_0140",1.0},
							{"item_0141",1.0},
							{"item_0217",1.0},

							{"item_0227",1.0},
							{"item_0239",1.0},
							{"item_0251",1.0},
							{"item_0263",1.0},
							{"item_0275",1.0}
						}
					}, 									   						
					-----------自在天波旬---------
					{"fb_09_BOSS_01",1,
						{
							{"item_0148",1.0},
							{"item_0149",1.0},
							{"item_0150",1.0},
							{"item_0191",1.0},
						}
					},	
					-----------冥河老祖-----------
					{"fb_09_BOSS_02",1,
						{
							{"item_0151",1.0},
							{"item_0152",1.0},

							{"item_0006",1.0},
							{"item_0017",1.0},
							{"item_0028",1.0},
							{"item_0039",1.0},
							{"item_0050",1.0}
						}
					},	
					-----------地藏王-------------
					{"fb_08_BOSS_02",1,
						{
							{"item_0142",1.0},
							{"item_0143",1.0}
						}
					}, 									   						
					-----------欲色天-------------
					{"fb_08_BOSS_03",1,
						{
							{"item_0144",1.0},
							{"item_0145",1.0}
						}
					}, 									   						
					-----------大梵天-------------
					{"fb_08_BOSS_04",1,
						{
							{"item_0146",1.0},
							{"item_0147",1.0}
						}
					}, 									   						
					------------湿婆--------------
					{"fb_10_BOSS_02",1,
						{
							{"item_0153",1.0},
							{"item_0154",1.0},
						}
					}, 									   						
					----------大日如来------------
					{"fb_09_BOSS_03",1,
						{
							{"item_0303",1.0},
							{"item_0304",1.0},
							{"item_0305",1.0},
							{"item_0306",1.0},
							{"item_0307",1.0}
						}
					},	
					-----------惧留孙-------------
					{"fb_09_BOSS_04",1,
						{
							{"item_0303",1.0},
							{"item_0304",1.0},
							{"item_0305",1.0},
							{"item_0306",1.0},
							{"item_0307",1.0}
						}
					},	
					-----------弥勒佛-------------
					{"fb_10_BOSS_03",1,
						{
							{"item_0155",1.0},
							{"item_0156",1.0},

							{"item_0229",1.0},
							{"item_0241",1.0},
							{"item_0253",1.0},
							{"item_0265",1.0},
							{"item_0277",1.0}
						}
					}, 									   						
					----------燃灯古佛------------
					{"fb_10_BOSS_04",2,
						{
							{"item_0157",1.0},
							{"item_0158",1.0},

							{"item_0008",1.0},
							{"item_0019",1.0},
							{"item_0030",1.0},
							{"item_0041",1.0},
							{"item_0052",1.0}
						}
					},	
					----------如来佛祖------------
					{"fb_10_BOSS_05",2,
						{
							{"item_0200",1.0},
							{"item_0192",1.0},
							{"item_0219",1.0},
							{"item_0220",1.0},
							{"item_0207",1.0},

							{"item_0007",1.0},
							{"item_0018",1.0},
							{"item_0029",1.0},
							{"item_0040",1.0},
							{"item_0051",1.0}
						}
					},	
					------------鲲鹏--------------
					{"fb_11_BOSS_01",1,
						{
							{"item_0159",1.0},
							{"item_0160",1.0},
							{"item_0222",1.0}
						}
					},  														
					----------瑶池金母------------
					{"fb_11_BOSS_02",2,
						{
							{"item_0161",1.0},
							{"item_0162",1.0},
							{"item_0163",1.0},
							{"item_0221",1.0},

							{"item_0009",1.0},
							{"item_0020",1.0},
							{"item_0031",1.0},
							{"item_0042",1.0},
							{"item_0053",1.0}
						}
					},	
					----------昊天上帝------------
					{"fb_12_BOSS_01",2,
						{
							{"item_0164",1.0},
							{"item_0165",1.0},

							{"item_0010",1.0},
							{"item_0021",1.0},
							{"item_0032",1.0},
							{"item_0043",1.0},
							{"item_0054",1.0}
						}
					},	
					------------伏羲--------------
					{"fb_12_BOSS_02",2,
						{
							{"item_0166",1.0},
							{"item_0167",1.0},

							{"item_0010",1.0},
							{"item_0021",1.0},
							{"item_0032",1.0},
							{"item_0043",1.0},
							{"item_0054",1.0}
						}
					},	
					------------神农--------------
					{"fb_12_BOSS_03",2,
						{
							{"item_0168",1.0},
							{"item_0169",1.0},

							{"item_0010",1.0},
							{"item_0021",1.0},
							{"item_0032",1.0},
							{"item_0043",1.0},
							{"item_0054",1.0}
						}
					},	
					------------轩辕--------------
					{"fb_13_BOSS_01",2,
						{
							{"item_0011",1.0},
							{"item_0022",1.0},
							{"item_0033",1.0},
							{"item_0044",1.0},
							{"item_0055",1.0},

							{"item_0170",1.0},
							{"item_0171",1.0}
						}
					},																			
					---------玉清圣人分身--------
					{"fb_13_BOSS_02",2,
						{
							{"item_0011",1.0},
							{"item_0022",1.0},
							{"item_0033",1.0},
							{"item_0044",1.0},
							{"item_0055",1.0},

							{"item_0172",1.0},
							{"item_0173",1.0}
						}
					},															
					---------上清圣人分身--------
					{"fb_13_BOSS_03",2,
						{
							{"item_0011",1.0},
							{"item_0022",1.0},
							{"item_0033",1.0},
							{"item_0044",1.0},
							{"item_0055",1.0},

							{"item_0174",1.0},
							{"item_0175",1.0}
						}
					},															
					---------太清圣人分身--------
					{"fb_13_BOSS_04",2,
						{
							{"item_0011",1.0},
							{"item_0022",1.0},
							{"item_0033",1.0},
							{"item_0044",1.0},
							{"item_0055",1.0},

							{"item_0176",1.0}
						}
					},																			
					---------周清圣人分身--------
				}


--=====================================================================================================================================================================
function DropItems(keys)
	
	local  target=EntIndexToHScript( keys.caster_entindex )
	local creatureClass = target:GetUnitName()

	if keys.attacker:IsHero() then
		keys.attacker:SetHealth(keys.attacker:GetHealth() + keys.attacker:GetMaxHealth()*0.1)
	else
		if keys.attacker.hero~=nil then
			keys.attacker.hero:SetHealth(keys.attacker.hero:GetHealth() + keys.attacker.hero:GetMaxHealth()*0.1)
		end
	end 
	
	for k,v in pairs(itemTable) do
	    if v[1]==creatureClass then
	    	local dropItemCount = #itemTable[k][3]
	    	local dropCount = itemTable[k][2]
	    	local a = 1

	    	if dropCount == 0 then
	    		local i = RandomInt( 1, dropItemCount)
	    		local itemName=itemTable[k][3][i][1]
	    		local itemDropRate=itemTable[k][3][i][2]
	    		if RandomFloat(0.0, 1.0)<=itemDropRate then
		    		local newItem = CreateItem(itemName, nil, nil )
		    		local drop = CreateItemOnPositionSync( target:GetOrigin()+RandomVector(150), newItem )
		    		local Delete = false
		    		drop:SetContextThink(DoUniqueString("CheckingItem") , 
		    		function()
		    			if GameRules.__IsGamePaused then  return 1 end
		    			if Delete == false then Delete = true
		    			else
		    				if (drop:GetContainedItem()).Owner == nil then
		    					PrintTestLog("RemoveItem!!!!")
		    					hsj_ReleaseItem(drop:GetContainedItem())
		    					drop:RemoveSelf() 
		    				else
		    					return nil
		    				end
		    			end
		    			return 60
		    		end,0)
		    	end
	    	end

	    	while (a<=dropCount) do
			   local i = RandomInt( 1, dropItemCount)

	    		local itemName=itemTable[k][3][i][1]
	    		local itemDropRate=itemTable[k][3][i][2]

	    		if RandomFloat(0.0, 1.0)<=itemDropRate then

	    			GameRules:GetGameModeEntity().sword:SpawnitemEntity( itemName,target:GetOrigin())
		    		
		    		a = a + 1
		    	end
			end
			GameRules:GetGameModeEntity().sword:SpawnitemEntity( "item_bag_of_gold",target:GetOrigin())
	    end
	end
end

function hsj_ReleaseItem(item)
	local quality = GetItemQuality(item)
	local modifyGold = 0
	if quality ~= nil then
		if quality >= 0 and quality <= 3 then
			modifyGold = 100
		elseif quality > 3 and quality <= 4 then
			modifyGold = 300
		elseif quality > 4 then
			modifyGold = 900
		end
		for i=0,PlayerResource:GetTeamPlayerCount() do
			PlayerResource:ModifyGold( i, modifyGold/PlayerResource:GetTeamPlayerCount() , false, DOTA_ModifyGold_SellItem)
		end
	end
end

