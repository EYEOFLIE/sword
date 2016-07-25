 
function chufa1(trigger)
   -- 使用FindByName来获取要传送的位置
   
   
  print(111)
   print(thisEntity:GetUnitName())
   
    local ent = Entities:FindByName(nil,"chuansong") --西方军团的王前传送点
    if ent == nil then 
        print("zhaobudaoshiti");
        return 
    end
     -- 在这句之前最好判定ent不为nil，否则下一句就会跳红字了。 -- if ent == nil then return end
    local point=ent:GetAbsOrigin()                                  
    -- 获取触发单位的队伍
    local nt=trigger.activator:GetTeam()
    if not(nt==DOTA_TEAM_NEUTRALS) then 
                            --不对刷出来的怪有效
                     --不对英雄生效
            
           -- FindClearSpaceForUnit(trigger.activator, point, false)  --完成传送
           -- trigger.activator:Stop()
            --shualangwang()
        
     end
end