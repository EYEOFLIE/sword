IS_HUANGSHENZUI_TEST = true
TRUE = 1
FALSE = 0

--判断游戏是否暂停
function IsGamePaused()
    old = GameRules:GetGameTime()
    GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("GamePaused"),function( )
        local new = GameRules:GetGameTime()

        if new == old then
            GameRules.__IsGamePaused = true
        else
            GameRules.__IsGamePaused = false
        end
        old = new

        return 0.1
    end,0)
end

function UnitStunTarget( caster,target,stuntime)
    target:AddNewModifier(caster, nil, "modifier_stunned", {duration=stuntime})
end

function GetDistanceBetweenTwoVec2D(a, b)
    local xx = (a.x-b.x)
    local yy = (a.y-b.y)
    return math.sqrt(xx*xx + yy*yy)
end

function GetDistance(ent1,ent2)
     local pos_1=ent1:GetOrigin()
     local pos_2=ent2:GetOrigin() 
     local x_=(pos_1[1]-pos_2[1])^2
     local y_=(pos_1[2]-pos_2[2])^2
     local dis=(x_+y_)^(0.5)
     return dis
end
function table.nums(table)
    if type(table) ~= "table" then return nil end
    local l = 0
    for k,v in pairs(table) do
        l = l+1
    end
    return l
end
function IsNumberInTable(Table,t)
    if Table == nil then return false end
    if type(Table) ~= "table" then return false end
    for i= 1,#Table do
        if t == Table[i] then
            return true
        end
    end
    return false
end

function IsRadInRect(aVec,rectOrigin,rectWidth,rectLenth,rectRad)
    local aRad = GetRadBetweenTwoVec2D(rectOrigin,aVec)
    local turnRad = aRad + (math.pi/2 - rectRad)
    local aRadius = GetDistanceBetweenTwoVec2D(rectOrigin,aVec)
    local turnX = aRadius*math.cos(turnRad)
    local turnY = aRadius*math.sin(turnRad)
    local maxX = rectWidth/2
    local minX = -rectWidth/2
    local maxY = rectLenth
    local minY = 0
    if(turnX<maxX and turnX>minX and turnY>minY and turnY<maxY)then
        return true
    else
        return false
    end
    return false
end

function  ApplyProjectile(keys,castvec,endvec,File)
--  local benti = Entities:FindByModel(sven_soul,"juggernaut.vmdl")
    --local testtable = FindAllByModel("juggernaut.vmdl")
--  sven_soul:SetAnimation("ACT_DOTA_ATTACK")
    local caster = keys.caster
    local vecCaster = caster:GetOrigin() 
    local point = 1/#endvec*endvec
    local targetPoint = endvec
    local forwardVec = caster:GetForwardVector() 
    local knifeTable = {
    Ability = keys.ability,
    fDistance = keys.DamageRadius,
    fStartRadius = 0,
    fEndRadius = 200,
    Source = caster,
    bHasFrontalCone = false,
    bRepalceExisting = false,
    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES,
    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
    fExpireTime = GameRules:GetGameTime()+10,
    bDeleteOnHit = false,
    vVelocity = point*3000,
    bProvidesVision =true,
    iVisionRadius = 0,
    iVisionTeamNumber = caster: GetTeamNumber(),
    vSpawnOrigin = castvec,
    EffectName = File,
}

ProjectileManager:CreateLinearProjectile(knifeTable)
end
function table.deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
     end
     return _copy(object)
end
--删除table中的table
function TableRemoveTable( table_1 , table_2 )
    for i,v in pairs(table_1) do
        if v == table_2 then
            table.remove(table_1,i)
            return
        end
    end
end
 GameRules.AbilityBehavior = {             
    DOTA_ABILITY_BEHAVIOR_ATTACK,            
    DOTA_ABILITY_BEHAVIOR_AURA,     
    DOTA_ABILITY_BEHAVIOR_AUTOCAST,    
    DOTA_ABILITY_BEHAVIOR_CHANNELLED,   
    DOTA_ABILITY_BEHAVIOR_DIRECTIONAL,    
    DOTA_ABILITY_BEHAVIOR_DONT_ALERT_TARGET,    
    DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT, 
    DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK,   
    DOTA_ABILITY_BEHAVIOR_DONT_RESUME_MOVEMENT,             
    DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING,    
    DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL,      
    DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE,   
    DOTA_ABILITY_BEHAVIOR_IGNORE_TURN ,        
    DOTA_ABILITY_BEHAVIOR_IMMEDIATE,         
    DOTA_ABILITY_BEHAVIOR_ITEM,              
    DOTA_ABILITY_BEHAVIOR_NOASSIST,            
    DOTA_ABILITY_BEHAVIOR_NONE,             
    DOTA_ABILITY_BEHAVIOR_NORMAL_WHEN_STOLEN, 
    DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE,       
    DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES,      
    DOTA_ABILITY_BEHAVIOR_RUNE_TARGET,         
    DOTA_ABILITY_BEHAVIOR_UNRESTRICTED ,  
}

--判断单体技能
function CDOTABaseAbility:IsUnitTarget( )
    local b = self:GetBehavior()

    if self:IsHidden() then b = b - 1 end
    for k,v in pairs(GameRules.AbilityBehavior) do
        repeat
            if v == 0 then break end
            b = b % v
        until true
    end

    if (b - DOTA_ABILITY_BEHAVIOR_AOE) == DOTA_ABILITY_BEHAVIOR_UNIT_TARGET then
        b = b - DOTA_ABILITY_BEHAVIOR_AOE
    end

    if b == DOTA_ABILITY_BEHAVIOR_UNIT_TARGET then
        return true
    end
    return false
end

--判断点目标技能
function CDOTABaseAbility:IsPoint( )
    local b = self:GetBehavior()

    if self:IsHidden() then b = b - 1 end
    for k,v in pairs(GameRules.AbilityBehavior) do
        repeat
            if v == 0 then break end
            b = b % v
        until true
    end

    if (b - DOTA_ABILITY_BEHAVIOR_AOE) == DOTA_ABILITY_BEHAVIOR_POINT then
        b = b - DOTA_ABILITY_BEHAVIOR_AOE
    end

    if b == DOTA_ABILITY_BEHAVIOR_POINT then
        return true
    end
    return false
end

--判断无目标技能
function CDOTABaseAbility:IsNoTarget( )
    local b = self:GetBehavior()
    
    if self:IsHidden() then b = b - 1 end
    for k,v in pairs(GameRules.AbilityBehavior) do
        repeat
            if v == 0 then break end
            b = b % v
        until true
    end

    if (b - DOTA_ABILITY_BEHAVIOR_AOE) == DOTA_ABILITY_BEHAVIOR_NO_TARGET then
        b = b % DOTA_ABILITY_BEHAVIOR_AOE
    end

    if b == DOTA_ABILITY_BEHAVIOR_NO_TARGET then
        return true
    end
    return false
end

--弹射函数 
--用于检测是否被此次弹射命中过
function CatapultFindImpact( unit,str )
    for i,v in pairs(unit.CatapultImpact) do
        if v == str then
            return true
        end
    end
    return false
end
 
--caster是施法者或者主要来源
--target是第一个目标
--ability是技能来源
--effectName是弹射的投射物
--move_speed是投射物的速率
--doge是表示能否被躲掉
--radius是每次弹射的范围
--count是弹射次数
--teams,types,flags获取单位的三剑客
--find_tpye是单位组按远近或者随机排列
--      FIND_CLOSEST
--      FIND_FARTHEST
--      FIND_UNITS_EVERYWHERE
function Catapult( caster,target,ability,effectName,move_speed,radius,count,teams,types,flags,find_tpye )
    print("Run Catapult")
 
    local old_target = caster
 
    --生成独立的字符串
    local str = DoUniqueString(ability:GetAbilityName())
    print("Catapult:"..str)
 
    --假设一个马甲
    local unit = {}
 
    --绑定信息
    --是否发射下一个投射物
    unit.CatapultNext = false
    unit.count_num = 0
    --本次弹射标识的字符串
    unit.CatapultThisProjectile = str
    unit.old_target = old_target
    --本次弹射的目标
    unit.CatapultThisTarget     = target
 
    --CatapultUnit用来存储unit
    if caster.CatapultUnit == nil then
        caster.CatapultUnit = {}
    end
 
    --把unit插入CatapultUnit
    table.insert(caster.CatapultUnit,unit)
 
    --用于决定是否发射投射物
    local fire = true
 
    --弹射最大次数
    local count_num = 0
     
    GameRules:GetGameModeEntity():SetContextThink(str,
        function( )
 
            --满足达到最大弹射次数删除计时器
            if count_num>=count then
                print("Catapult impact :"..count_num)
                print("Catapult:"..str.." is over")
                return nil
            end
 
 
            if unit.CatapultNext then
 
                --获取单位组
                local group = FindUnitsInRadius(caster:GetTeamNumber(),target:GetOrigin(),nil,radius,teams,types,flags,FIND_CLOSEST,true)
                 
                --用于计算循环次数
                local num = 0
                for i=1,#group do
                    if group[i].CatapultImpact == nil then
                        group[i].CatapultImpact = {}
                    end
 
                    --判断是否命中
                    local impact = CatapultFindImpact(group[i],str)
 
                    if  impact == false then
 
                        --替换old_target
                        old_target = target
 
                        --新target
                        target = group[i]
 
                        --可以发射新投射物
                        fire = true
                        unit.count_num = count_num
                        --等待下一个目标
                        unit.old_target = old_target
                        unit.CatapultNext =false
 
                        --锁定当前目标
                        unit.CatapultThisTarget = target
                        break
                    end
                    num = num + 1
                end
 
                --如果大于等于单位组的数量那么就删除计时器
                if num >= #group then
                    --从CatapultUnit中删除unit
                    TableRemoveTable(caster.CatapultUnit,unit)
 
                    print("Catapult impact :"..count_num)
                    print("Catapult:"..str.." is over")
                    return nil
                end
            end
 
            --发射投射物
            if fire then
                fire = false
                count_num = count_num + 1
                local info = 
                {
                    Target = target,
                    Source = old_target,
                    Ability = ability,  
                    EffectName = effectName,
                    bDodgeable = false,
                    iMoveSpeed = move_speed,
                    bProvidesVision = true,
                    iVisionRadius = 300,
                    iVisionTeamNumber = caster:GetTeamNumber(),
                    iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
                }
                projectile = ProjectileManager:CreateTrackingProjectile(info)               
            end
 
            return 0.05
        end,0)
end
 
--此函数在KV里面用OnProjectileHitUnit调用
function CatapultImpact( keys )
    local caster = keys.caster
    local target = keys.target
 
    --防止意外
    if caster.CatapultUnit == nil then
        caster.CatapultUnit = {}
    end
    if target.CatapultImpact == nil then
        target.CatapultImpact = {}
    end
 
    --挨个检测是否是弹射的目标
    for i,v in pairs(caster.CatapultUnit) do
         
        if v.CatapultThisProjectile ~= nil and v.CatapultThisTarget ~= nil then
 
            if v.CatapultThisTarget == target then
 
                --标记target被CatapultThisProjectile命中
                table.insert(target.CatapultImpact,v.CatapultThisProjectile)
 
                --允许发射下一次投射物
                v.CatapultNext = true
                return
            end
 
        end
    end
end

function PrintTable(t, indent, done)
    --print ( string.format ('PrintTable type %s', type(keys)) )
    if type(t) ~= "table" then return end

    done = done or {}
    done[t] = true
    indent = indent or 0

    local l = {}
    for k, v in pairs(t) do
        table.insert(l, k)
    end

    table.sort(l)
    for k, v in ipairs(l) do
        -- Ignore FDesc
        if v ~= 'FDesc' then
            local value = t[v]

            if type(value) == "table" and not done[value] then
                done [value] = true
                print(string.rep ("\t", indent)..tostring(v)..":")
                PrintTable (value, indent + 2, done)
            elseif type(value) == "userdata" and not done[value] then
                done [value] = true
                print(string.rep ("\t", indent)..tostring(v)..": "..tostring(value))
                PrintTable ((getmetatable(value) and getmetatable(value).__index) or getmetatable(value), indent + 2, done)
            else
                if t.FDesc and t.FDesc[v] then
                    print(string.rep ("\t", indent)..tostring(t.FDesc[v]))
                else
                    print(string.rep ("\t", indent)..tostring(v)..": "..tostring(value))
                end
            end
        end
    end
end

function string.split(str, delimiter)
    if str==nil or str=='' or delimiter==nil then
        return nil
    end
    
    local result = {}
    for match in (str..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

function PrintTestLog(string)
    if(IS_HUANGSHENZUI_TEST == true)then
        print(string)
    end
end

function GetHeroItemKind(hero)
    if hero:GetClassname() == "npc_dota_hero_legion_commander" then
        return ITEM_KIND_SWORD
    end
    if hero:GetClassname() == "npc_dota_hero_dragon_knight" then
        return ITEM_KIND_KNIFE
    end
    if hero:GetClassname() == "npc_dota_hero_lina" then
        return ITEM_KIND_MAGIC
    end
    if hero:GetClassname() == "npc_dota_hero_tidehunter" then
        return ITEM_KIND_STICK
    end
    return ITEM_KIND_SWORD
end

function hsj_GetSpellDamage(hero,index)
    local AttributeType = 0
    local AttributeDamageIncrease = 0
    local AttributeBaseDamage = 0
    local itemKind = GetHeroItemKind(hero)
    local BaseDamage = 0

    if hero:GetClassname() == "npc_dota_hero_juggernaut" then
        if index == 1 then
            AttributeType = 1
            AttributeDamageIncrease = 0.2
            AttributeBaseDamage = 20
            BaseDamage = 1000
            return GetHsjDealDamage( hero, AttributeType, AttributeDamageIncrease, AttributeBaseDamage, itemKind, BaseDamage)
        elseif index == 2 then
            AttributeType = 1
            AttributeDamageIncrease = 0.2
            AttributeBaseDamage = 20
            BaseDamage = 1000
            return GetHsjDealDamage( hero, AttributeType, AttributeDamageIncrease, AttributeBaseDamage, itemKind, BaseDamage)
        elseif index == 3 then
            AttributeType = 1
            AttributeDamageIncrease = 0.2
            AttributeBaseDamage = 20
            BaseDamage = 1000
            return GetHsjDealDamage( hero, AttributeType, AttributeDamageIncrease, AttributeBaseDamage, itemKind, BaseDamage) * 2
        elseif index == 4 then
            AttributeType = 1
            AttributeDamageIncrease = 0.2
            AttributeBaseDamage = 20
            BaseDamage = 1000
            return GetHsjDealDamage( hero, AttributeType, AttributeDamageIncrease, AttributeBaseDamage, itemKind, BaseDamage) * 6
        end
    end
    if hero:GetClassname() == "npc_dota_hero_centaur" then
        if index == 1 then
            AttributeType = 1
            AttributeDamageIncrease = 0.2
            AttributeBaseDamage = 20
            BaseDamage = 1000
            return GetHsjDealDamage( hero, AttributeType, AttributeDamageIncrease, AttributeBaseDamage, itemKind, BaseDamage)
        elseif index == 2 then
            AttributeType = 1
            AttributeDamageIncrease = 0.2
            AttributeBaseDamage = 20
            BaseDamage = 1000
            return GetHsjDealDamage( hero, AttributeType, AttributeDamageIncrease, AttributeBaseDamage, itemKind, BaseDamage)
        elseif index == 3 then
            AttributeType = 1
            AttributeDamageIncrease = 0.8
            AttributeBaseDamage = 20
            BaseDamage = 1000
            return GetHsjDealDamage( hero, AttributeType, AttributeDamageIncrease, AttributeBaseDamage, itemKind, BaseDamage)
        elseif index == 4 then
            AttributeType = 0
            AttributeDamageIncrease = 0
            AttributeBaseDamage = 0
            BaseDamage = 0
            return 0
        end
    end
    if hero:GetClassname() == "npc_dota_hero_crystal_maiden" then
        if index == 1 then
            AttributeType = 1
            AttributeDamageIncrease = 0.2
            AttributeBaseDamage = 20
            BaseDamage = 1000
            return GetHsjDealDamage( hero, AttributeType, AttributeDamageIncrease, AttributeBaseDamage, itemKind, BaseDamage)
        elseif index == 2 then
            AttributeType = 1
            AttributeDamageIncrease = 0.2
            AttributeBaseDamage = 20
            BaseDamage = 1000
            return GetHsjDealDamage( hero, AttributeType, AttributeDamageIncrease, AttributeBaseDamage, itemKind, BaseDamage) * 2
        elseif index == 3 then
            AttributeType = 1
            AttributeDamageIncrease = 0.2
            AttributeBaseDamage = 20
            BaseDamage = 1000
            return GetHsjDealDamage( hero, AttributeType, AttributeDamageIncrease, AttributeBaseDamage, itemKind, BaseDamage)
        elseif index == 4 then
            AttributeType = 1
            AttributeDamageIncrease = 0.2
            AttributeBaseDamage = 20
            BaseDamage = 1000
            return GetHsjDealDamage( hero, AttributeType, AttributeDamageIncrease, AttributeBaseDamage, itemKind, BaseDamage) * 6
        end
    end
    if hero:GetClassname() == "npc_dota_hero_tidehunter" then
        if index == 1 then
            AttributeType = 1
            AttributeDamageIncrease = 0.2
            AttributeBaseDamage = 20
            BaseDamage = 1000
            return GetHsjDealDamage( hero, AttributeType, AttributeDamageIncrease, AttributeBaseDamage, itemKind, BaseDamage)
        elseif index == 2 then
            AttributeType = 1
            AttributeDamageIncrease = 0.2
            AttributeBaseDamage = 20
            BaseDamage = 1000
            return GetHsjDealDamage( hero, AttributeType, AttributeDamageIncrease, AttributeBaseDamage, itemKind, BaseDamage) * 3
        elseif index == 3 then
            AttributeType = 1
            AttributeDamageIncrease = 0.8
            AttributeBaseDamage = 20
            BaseDamage = 1000
            return GetHsjDealDamage( hero, AttributeType, AttributeDamageIncrease, AttributeBaseDamage, itemKind, BaseDamage) * 6
        elseif index == 4 then
            AttributeType = 1
            AttributeDamageIncrease = 0.2
            AttributeBaseDamage = 20
            BaseDamage = 1000
            return GetHsjDealDamage( hero, AttributeType, AttributeDamageIncrease, AttributeBaseDamage, itemKind, BaseDamage) * 20
        end
    end
    return 0
end
function Getherocolor(caster)
    if caster.color==1 then
        return "#58E4A7"
    end  
    if caster.color==2 then
        return "#094D0F"
    end
    if caster.color==3 then
        return "#EA7BB2"
    end 
    if caster.color==4 then
        return "#A800A8"
    end 
    if caster.color==5 then
        return "#2B65DE"
    end 
end

function GetEquipMulti(caster,equipKind)
    
    local EquipMulti = 0
    for i=0,5 do
        local itemEnt=caster:GetItemInSlot(i)
        if itemEnt~=nil then 
            local multi = GetItemMult(itemEnt,equipKind)
			if multi then EquipMulti=EquipMulti+multi end
        end
    end
    --print(EquipMulti)
    EquipMulti = EquipMulti + (caster:GetModifierStackCount("passive_hsj_item_extra_equip_state",caster) or 0)
    EquipMulti = EquipMulti + (caster:GetContext("hsj_hero_task_equipmulti") or 0)
    EquipMulti = EquipMulti + (caster:GetContext("EquipMultiAbility") or 0)
    EquipMulti = EquipMulti + (caster:GetModifierStackCount("passive_hsj_suit_equip_state",caster) or 0)

    local itemKind = GetHeroItemKind(caster)
    if itemKind == ITEM_KIND_SWORD then
        EquipMulti = EquipMulti + (caster:GetModifierStackCount("passive_hsj_item_extra_sword_equip_state",caster) or 0)
    elseif itemKind == ITEM_KIND_KNIFE then
        EquipMulti = EquipMulti + (caster:GetModifierStackCount("passive_hsj_item_extra_blade_equip_state",caster) or 0)
    elseif itemKind == ITEM_KIND_STICK then
        EquipMulti = EquipMulti + (caster:GetModifierStackCount("passive_hsj_item_extra_stick_equip_state",caster) or 0)
    elseif itemKind == ITEM_KIND_MAGIC then
        EquipMulti = EquipMulti + (caster:GetModifierStackCount("passive_hsj_item_extra_magic_equip_state",caster) or 0)
    elseif itemKind == ITEM_KIND_BOW then
        EquipMulti = EquipMulti + (caster:GetModifierStackCount("passive_hsj_item_extra_bow_equip_state",caster) or 0)
    end

    return EquipMulti
end

function SetEquipMulti(caster,task_multi,ability_multi)
    if caster then
        if task_multi then
            caster:SetContextNum("hsj_hero_task_equipmulti",task_multi,0)
        end
        if ability_multi then
            caster:SetContextNum("EquipMultiAbility",ability_multi,0)
        end
    end
end

function ModifyEquipMulti(caster,modify_task_multi,modify_ability_multi)
    if caster then
        if modify_task_multi then
            caster:SetContextNum("hsj_hero_task_equipmulti",caster:GetContext("hsj_hero_task_equipmulti")+modify_task_multi,0)
        end
        if modify_ability_multi then
            caster:SetContextNum("EquipMultiAbility",caster:GetContext("EquipMultiAbility")+modify_ability_multi,0)
        end
    end
end

function GetHeroxiuwei(caster)
    local xiuwei = 0
    xiuwei = xiuwei + (caster:GetContext("hero_xiuwei") or 0)
    return xiuwei
end

function Getwuxing(caster,name)
    
    return caster:GetContext("hero_"..name)
end

function Setwuxing(caster,name)

    if(caster:GetContext("hero_wuxing")>0) then
    caster:SetContextNum("hero_"..name,caster:GetContext("hero_"..name)+1,0)
    caster:SetContextNum("hero_wuxing",caster:GetContext("hero_wuxing")-1,0)
    caster:SetModifierStackCount("defend_"..name, caster, caster:GetContext("hero_"..name)*1+caster:GetModifierStackCount("defend_"..name,caster))
    
        
    end 
    

end

function GetHeroArmorState(caster)

   return caster:GetPhysicalArmorValue()
end


function GetHeroAttackspeedState(caster)

   return string.format("%.2f", 1/caster:GetAttacksPerSecond()) 

end
--功德
function SetHeroMultiState(caster,task_multi,ability_multi)
    if caster then
        if task_multi then
            caster:SetContextNum("hsj_hero_task_statemulti",task_multi,0)
        end
        if ability_multi then
            caster:SetContextNum("HeroMultiStateAbility",ability_multi,0)
        end
    end
end

function ModifyHeroMultiState(caster,modify_task_multi,modify_ability_multi)
    if caster then
        if modify_task_multi then
            caster:SetContextNum("hsj_hero_task_statemulti",caster:GetContext("hsj_hero_task_statemulti")+modify_task_multi,0)
        end
        if modify_ability_multi then
            caster:SetContextNum("HeroMultiStateAbility",caster:GetContext("HeroMultiStateAbility")+modify_ability_multi,0)
        end
    end
end

function UnitDamageTarget(DamageTable)
    ApplyDamage(DamageTable)
end

function GetAttributeByAttributeType(caster,AttributeType)
    if AttributeType == 0 then
        return caster:GetStrength()
    elseif AttributeType == 1 then
        return caster:GetAgility()
    elseif AttributeType == 2 then
        return caster:GetIntellect()
    end
end

function SetTargetToTraversable(target)
    UnitNoCollision(target,target,0.1)
end

function UnitNoCollision( caster,target,duration)
    target:AddNewModifier(caster, nil, "modifier_phased", {duration=duration})
end

function GetRadBetweenTwoVec2D(a,b)
    local y = b.y - a.y
    local x = b.x - a.x
    return math.atan2(y,x)
end

function GetRadBetweenTwoVecZ3D(a,b)
    local y = b.y - a.y
    local x = b.x - a.x
    local z = b.z - a.z
    local s = math.sqrt(x*x + y*y)
    return math.atan2(z,s)
end



function GetHsjDealDamage( caster, AttributeType, AttributeDamageIncrease, AttributeBaseDamage, ITEM_KIND, BaseDamage)
    local deal_damage = 
    (
        (     GetAttributeByAttributeType(caster,AttributeType)
            * AttributeDamageIncrease
            + AttributeBaseDamage
        )
            * GetEquipMulti(caster,ITEM_KIND)
            * 10 
            + 100
            * (caster:GetLevel()/10+1)
    )* math.pow(2,GetHeroMultiState(caster)) + BaseDamage
    return deal_damage
end

function UnitPauseTarget( caster,target,pausetime)
        local dummy = CreateUnitByName("npc_dummy_unit", 
                            target:GetAbsOrigin(), 
                            false, 
                            caster, 
                            caster, 
                            caster:GetTeamNumber()
                        )
        dummy:SetOwner(caster)
        dummy:AddAbility("ability_stunsystem_pause") 
        local ability = dummy:FindAbilityByName("ability_stunsystem_pause")
            
        ability:ApplyDataDrivenModifier( caster, target, "modifier_stunsystem_pause", {Duration=pausetime} )
        dummy:SetContextThink(DoUniqueString('ability_stunsystem_pause_timer'),
            function ()
                    target:RemoveModifierByName("modifier_stunsystem_pause")
                    dummy:RemoveSelf()
                    return nil
        end,pausetime)
end

function CourierPickupItem( courier, container )
    if type(courier) ~= "table" and type(container) ~= "table" then return false end
    if courier:IsNull() or container:IsNull() then return false end

    courier:SetContextThink(DoUniqueString("CourierPickupItem"), function()
        if courier:IsNull() or container:IsNull() then return nil end
        
        if courier.m_ExecuteOrderFilter_OrderType == DOTA_UNIT_ORDER_PICKUP_ITEM then
            if (courier:GetOrigin() - container:GetOrigin()):Length2D() <= 150 then
                OnHSJ_UI_RightClickItem(1, {unitIndex=courier:GetEntityIndex(),targetIndex=container:GetEntityIndex(),PlayerID=courier:GetPlayerOwnerID()})
                courier:Stop()
                return nil
            end
        else
            return nil
        end

        return 0.2
    end, 0)
end

function questtalk(questname,npc_one,npc_two,i,time) 
    Timers:CreateTimer((time+questname[tostring(i-1)]["talktime"]+0.5),function ()

            if questname[tostring(i)]["queue"]==1 then
                if npc_one~=npc_two then 
                npc_one:Stop()
                npc_one:SetForwardVector(npc_two:GetOrigin()-npc_one:GetOrigin())
                end
                talkall(true,npc_one,questname[tostring(i)]["text"],false,nil,questname[tostring(i)]["talktime"],questname[tostring(i)]["jiaodutime"],0,0)
            end
            if questname[tostring(i)]["queue"]==2 then
                if npc_one~=npc_two then 
                npc_two:Stop()
                npc_two:SetForwardVector(npc_one:GetOrigin()-npc_two:GetOrigin())
                end
                talkall(true,npc_two,questname[tostring(i)]["text"],false,nil,questname[tostring(i)]["talktime"],questname[tostring(i)]["jiaodutime"],0,0)
            end
        
    end)
    local times=time+questname[tostring(i-1)]["talktime"]+0.5
    return times

end
function talkall(open,unit,talk,next,nexttext,talktime,shijiaotime,juli,jiaodu,missname,type)
    local event="talk"
    local ability_01=unit:FindAbilityByName("Ability_targeteffect")
    if(ability_01==nil) then
        ability_01=unit:AddAbility("Ability_targeteffect")
    end
    missname=missname or ""
    type=type or 0
    ability_01:ApplyDataDrivenModifier(unit, unit, "modifier_target_unit", {duration=talktime})
    local team=unit:GetTeamNumber()
    print(team)
    text="#"..unit:GetUnitName()
    GameRules:SendCustomMessage(text,DOTA_TEAM_GOODGUYS,1)
    CustomGameEventManager:Send_ServerToAllClients(event,{open=open,unitename=unit:GetUnitName(),talk=talk,next=next,nexttext=nexttext,talktime=talktime,juli=juli,jiaodu=jiaodu,shijiaotime=shijiaotime,talktime=talktime,missname=missname,type=type})    
    
end
function talktoplayer(player,open,unit,talk,next,nexttext,talktime,shijiaotime,juli,jiaodu,missname,type)
    local event="talk"
    local ability_01=unit:FindAbilityByName("Ability_targeteffect")
    if(ability_01==nil) then
        ability_01=unit:AddAbility("Ability_targeteffect")
    end
    missname=missname or ""
    type=type or 0
    ability_01:ApplyDataDrivenModifier(unit, unit, "modifier_target_unit", {duration=talktime})
    CustomGameEventManager:Send_ServerToPlayer(player,event,{open=open,unitename=unit:GetUnitName(),talk=talk,next=next,nexttext=nexttext,talktime=talktime,juli=juli,jiaodu=jiaodu,shijiaotime=shijiaotime,talktime=talktime,missname=missname,type=type})    
    
end

function PopupNumbers(target, pfx, color, lifetime, number, presymbol, postsymbol)
    local pfxPath = string.format("particles/msg_fx/msg_%s.vpcf", pfx)
    
    local pidx = ParticleManager:CreateParticle(pfxPath, PATTACH_OVERHEAD_FOLLOW, target) -- target:GetOwner()
 
    local digits = 0
    if number ~= nil then
        digits = #tostring(number)
    end
    if presymbol ~= nil then
        digits = digits + 1
    end
    if postsymbol ~= nil then
        digits = digits + 1
    end

    ParticleManager:SetParticleControl(pidx, 1, Vector(tonumber(presymbol), tonumber(number), tonumber(postsymbol)))
    ParticleManager:SetParticleControl(pidx, 2, Vector(lifetime, digits, 0))
    ParticleManager:SetParticleControl(pidx, 3, color)
end

function PopupNumbers_damage(target, pfx, color, lifetime, number, presymbol, postsymbol)
    local pfxPath = "particles/damage/msg_damage.vpcf"
    local pidx = ParticleManager:CreateParticle(pfxPath, PATTACH_OVERHEAD_FOLLOW, target) -- target:GetOwner()
 
    local digits = 0
    if number ~= nil then
        digits = #tostring(number)
    end
    if presymbol ~= nil then
        digits = digits + 1
    end
    if postsymbol ~= nil then
        digits = digits + 1
    end
    if number==0 then
        number=1
    end
   
    ParticleManager:SetParticleControl(pidx, 0, Vector(target:GetOrigin().x, target:GetOrigin().y, target:GetOrigin().z-200))
    ParticleManager:SetParticleControl(pidx, 1, Vector(tonumber(presymbol), tonumber(number), tonumber(postsymbol)))
    ParticleManager:SetParticleControl(pidx, 2, Vector(lifetime, digits, 0))
    ParticleManager:SetParticleControl(pidx, 3, color)
end

function  defaultcamera()
        GameRules:GetGameModeEntity():SetCameraDistanceOverride(1334.0)--设置镜头距离，默认1134
end

NOW_DISTANCE = 1334

function  recameradistance(distance)
    local now=GameRules:GetGameModeEntity():GetCameraDistanceOverride()
    if now>distance then
         Timers:CreateTimer(
            function ()
            local defaultdistace=now
            Timers:CreateTimer(
            function ()
                    if defaultdistace > distance then
                        
                        defaultdistace = defaultdistace - 10
                        GameRules:GetGameModeEntity():SetCameraDistanceOverride(defaultdistace)
                        return 0.01
                    end
                    
                end 
            )

        end)
    elseif now==distance then

    elseif now < distance then
         Timers:CreateTimer(
            function ()
            local defaultdistace=now
            Timers:CreateTimer(
            function ()
                    if defaultdistace < distance then
                        
                        defaultdistace = defaultdistace + 10
                        
                        GameRules:GetGameModeEntity():SetCameraDistanceOverride(defaultdistace)
                        return 0.01
                    end
                    
                end 
            )

        end)
    end
   
       
end
--爆过的东西就不再爆了
function PickRandomShuffle( reference_list, bucket )
    if ( #reference_list == 0 ) then
        return nil
    end
    
    if ( #bucket == 0 ) then
        -- ran out of options, refill the bucket from the reference
        for k, v in pairs(reference_list) do
            bucket[k] = v
        end
    end

    -- pick a value from the bucket and remove it
    local pick_index = RandomInt( 1, #bucket )
    local result = bucket[ pick_index ]
    table.remove( bucket, pick_index )
    return result
end

function  sortFunc(a, b)
    
      return a[2] > b[2]
        
end

function lua_string_split(str, split_char)
    local sub_str_tab = {};
    while (true) do
        local pos = string.find(str, split_char);
        if (not pos) then
            sub_str_tab[#sub_str_tab + 1] = str;
            break;
        end
        local sub_str = string.sub(str, 1, pos - 1);
        sub_str_tab[#sub_str_tab + 1] = sub_str;
        str = string.sub(str, pos + 1, #str);
    end

    return sub_str_tab;
end