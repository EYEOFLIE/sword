function initplayerstats()
	local timeTxt = string.gsub(string.gsub(GetSystemTime(),':',''),'0','')
	math.randomseed(tonumber(timeTxt))
	PlayerStats={}
	-- body[[playerid=0到9]]
	for i=0,9 do
		PlayerStats[i]={}--每个玩家的包
		PlayerStats[i]['length']=0
	end
	--初始化刷怪
	local temp_leftpoint   = Entities:FindByName(nil, "leftpoint")
	leftpoint_zuobiao=temp_leftpoint:GetAbsOrigin()

	local temp_rightpoint  = Entities:FindByName(nil, "rightpoint")
	rightpoint_zuobiao=temp_rightpoint:GetAbsOrigin()
	
	--初始刷5只羊 3个牛 1个火人
	createunit("yang")
	createunit("yang")
	createunit("yang")
	createunit("yang")
	createunit("yang")

	createunit("niu")
	createunit("niu")
	createunit("niu")

	createunit("huoren")
	createunit("huoren")




end


function createunit( unitname )
	
	local location=Vector(math.random(rightpoint_zuobiao.x-leftpoint_zuobiao.x)+leftpoint_zuobiao.x,math.random(rightpoint_zuobiao.y-leftpoint_zuobiao.y)+leftpoint_zuobiao.y,0)
	local unit=CreateUnitByName(unitname, location, true , nil, nil, DOTA_TEAM_NEUTRALS)
	unit:SetContext("name",unitname,0)
	-- body
end

function createbody(playerid)
	local followed_unit=PlayerStats[playerid]['group'][PlayerStats[playerid]['group_pointer']]
	local chaoxiang=followed_unit:GetForwardVector()
	local position=followed_unit:GetAbsOrigin()
	local newposition=position-chaoxiang*100
	local new_unit=CreateUnitByName("littlebug", newposition, true , nil, nil, followed_unit:GetTeam())
	new_unit:SetContext("name","littlebug",0)
	new_unit:SetForwardVector(chaoxiang)
	GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("1"),
		function ()
			
			if new_unit:IsAlive()==true then
				new_unit:MoveToNPC(followed_unit)
				return 0.2
			end
		end
		,0)
	
	new_unit:MoveToNPC(followed_unit)
	PlayerStats[playerid]['group_pointer']=	PlayerStats[playerid]['group_pointer']+1
	PlayerStats[playerid]['group'][PlayerStats[playerid]['group_pointer']]=new_unit

end
function shualangwang()
	GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("1"),
			function ()
				for i=1,3 do
		        --获取ShuaGuai_1这个实体
		        local ShuaGuai_entity = Entities:FindByName(nil,"shuaguai0")

		        --创建单位
		        local ShuaGuai = CreateUnitByName("langwang",ShuaGuai_entity:GetOrigin(),true,nil,nil,DOTA_TEAM_BADGUYS)
		 
		        --禁止单位寻找最短路径
		        ShuaGuai:SetMustReachEachGoalEntity(true)
		 
		        --让单位沿着设置好的路线开始行动
		        ShuaGuai:SetInitialGoalEntity(ShuaGuai_entity)
		 
		        --添加相位移动的modifier，持续时间0.1秒
		        --当相位移动的modifier消失，系统会自动计算碰撞，这样就避免了卡位
		        ShuaGuai:AddNewModifier(nil, nil, "modifier_phased", {duration=0.1})
		    	end
				
				return 30
				
			end
			,0)

			 
	-- body
end
