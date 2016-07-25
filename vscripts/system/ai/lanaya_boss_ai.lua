
if lanaya_boss_ai == nil then
    lanaya_boss_ai = class({})
end

function lanaya_boss_ai:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
        MODIFIER_EVENT_ON_TAKEDAMAGE,

    }
    return funcs
end

function lanaya_boss_ai:OnCreated( kv )
    
    self.auto=1
    self.back=1
    self.findone=0
    self.onattack=1
    self.onquery=0
    self.stuned=true
    self.spell=0
    if IsServer() then
        
        self:GetCaster().chushengdian=self:GetCaster():GetOrigin()
        self:StartIntervalThink(0.1)
        local eff = ParticleManager:CreateParticle("particles/econ/items/disruptor/disruptor_resistive_pinfold/disruptor_kf_formation_markers.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
        ParticleManager:SetParticleControl(eff, 0,self:GetCaster():GetOrigin())
        ParticleManager:SetParticleControl(eff, 1, Vector(1000,1,1))
        ParticleManager:SetParticleControl(eff, 2, Vector(9999,1,1))
   
    end
end


function lanaya_boss_ai:CheckState()
    local state = {
    [MODIFIER_STATE_STUNNED] = self.stuned,
    }

    return state
end

function lanaya_boss_ai:GetDisableAutoAttack(params)
    if IsServer() then
        return self.auto
    end
    -- body
end

function lanaya_boss_ai:IsHidden()
    return false
end


function lanaya_boss_ai:GetTexture( params )
    return "defend_jin"
end

function lanaya_boss_ai:OnTakeDamage( params )
    
    
    if params.attacker~=self:GetCaster() and params.unit == self:GetCaster() then
        --self:GetCaster():RemoveModifierByName("stun_nothing")
        self.stuned=false
        local isadd=0
    
        if params.unit.takedamagetable == nil then
           params.unit.takedamagetable={}
            local herotable={}
            herotable[1]=params.attacker
            herotable[2]=params.damage
            herotable[3]=params.attacker:GetUnitName()
            herotable[4]=GameRules:GetGameTime()
            herotable[5]=1
            table.insert(params.unit.takedamagetable,herotable)
        else
            for _,v in pairs(params.unit.takedamagetable) do
            
                if  v[1]==params.attacker then
                    v[2]=v[2]+params.damage
                    v[4]=GameRules:GetGameTime()
                    v[5]=1
                    isadd=1
                end
            end

            if isadd==0 then
            local herotable={}
            herotable[1]=params.attacker
            herotable[2]=params.damage
            herotable[3]=params.attacker:GetUnitName()
            herotable[4]=GameRules:GetGameTime()
            herotable[5]=1
            table.insert(params.unit.takedamagetable,herotable)
           
            end

        end
  
        table.sort(params.unit.takedamagetable, sortFunc)

    end
    
    -- body
end

function lanaya_boss_ai:OnIntervalThink()
    if IsServer() then

        if self.onquery==0 then
        local enemies
        local ability_01 = self:GetCaster():FindAbilityByName("nyx_assassin_mana_burn")
        local ability_02 = self:GetCaster():FindAbilityByName("templar_assassin_refraction")
        
        if((self:GetCaster():GetOrigin()-self:GetCaster().chushengdian):Length2D()>1000)then
            self:GetCaster():Stop()
            self:GetCaster():MoveToPosition(self:GetCaster().chushengdian)
            self:GetCaster():Heal(self:GetCaster():GetHealthDeficit(),nil)
            self.back=2
            self:GetCaster().takedamagetable=nil
            self.findone=0
        end
        if((self:GetCaster():GetOrigin()-self:GetCaster().chushengdian):Length2D()<100)then
            self.back=1
        end

        if self.back==2 then return end
        if self:GetCaster().takedamagetable then
           
            if not self:GetCaster().takedamagetable[1][1]:IsAlive() then 
                table.remove(self:GetCaster().takedamagetable,1)
                table.sort(self:GetCaster().takedamagetable, sortFunc)

            end
            if next(self:GetCaster().takedamagetable) == nil then
                self:GetCaster().takedamagetable=nil
                return
            end
            

            if self.onattack==1  then
                
                if  ability_01:IsFullyCastable() then
                    local range = ability_01:GetCastRange()
                    target = AICore:RandomEnemyHeroInRange( self:GetCaster(), range )
                    if target then
                    local order =
                        {
                            OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
                            UnitIndex = self:GetCaster():entindex(),
                            TargetIndex = target:entindex(),
                            AbilityIndex = ability_01:entindex()
                        }
                        ExecuteOrderFromTable(order)
                        self.spell=1
                    end
                elseif  ability_02:IsFullyCastable() then
                        
                    local order =
                    {
                        UnitIndex = self:GetCaster():entindex(),
                        OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
                        AbilityIndex = ability_02:entindex(),
                    }
                    ExecuteOrderFromTable(order)
                    self.spell=1
                else
                     self.spell=0
                end

                if(self.spell==0) then 
                    self:GetCaster():MoveToTargetToAttack(self:GetCaster().takedamagetable[1][1])
                end

                

                
                
            end
                     

        else

            if self.findone==0 then
            enemies = FindUnitsInRadius( DOTA_TEAM_GOODGUYS, self:GetCaster():GetOrigin(), nil, self:GetCaster():GetAcquisitionRange(), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, 0, FIND_CLOSEST, false )
            else
            enemies = FindUnitsInRadius( DOTA_TEAM_GOODGUYS, self:GetCaster():GetOrigin(), nil, self:GetCaster():GetCurrentVisionRange(), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, 0, FIND_CLOSEST, false )
            end
           
            if #enemies > 0 then
              
                if self.onattack==1 then
               
                    self:GetCaster():MoveToTargetToAttack(enemies[1])
                end
                self.findone=1
            else
                self:GetCaster():Stop()
                self:GetCaster():MoveToPosition(self:GetCaster().chushengdian)
                self:GetCaster():Heal(self:GetCaster():GetHealthDeficit(),nil)
                self.back=2
                self.findone=0
                self:GetCaster().takedamagetable=nil
            end
        end


        if(self:GetCaster():GetHealthPercent()<50) then
            self.onquery=1
            --self:GetCaster():RemoveAbility("ab_boss_01_ai_lua")
            QuestSystem:quicklyfinish(MAIN_HERO_TABLE[1],"quest_zhuxian_01_01")
            StartAnimation(self:GetCaster(), {duration=0.6, activity=ACT_DOTA_ATTACK2, rate=0.8})
            EmitSoundOn("Hero_NagaSiren.SongOfTheSiren",self:GetCaster())
            self:GetCaster().song = ParticleManager:CreateParticle("particles/units/heroes/hero_siren/naga_siren_siren_song_cast.vpcf",PATTACH_ABSORIGIN_FOLLOW,caster)
            ParticleManager:SetParticleControl(self:GetCaster().song,0,self:GetCaster():GetOrigin())
            Timers:CreateTimer(1,function ()
                --effectsing2 = ParticleManager:CreateParticle("particles/units/heroes/hero_siren/naga_siren_song_aura.vpcf",PATTACH_ABSORIGIN_FOLLOW,caster)
                --ParticleManager:SetParticleControl(effectsing2,0,caster:GetOrigin())
            end)
            local enemies = FindUnitsInRadius( DOTA_TEAM_GOODGUYS, self:GetCaster():GetOrigin(), nil, 1500, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, 0, 0, false )
            for _,v in pairs(enemies) do
                v:AddNewModifier(v,self,"jinmo_nothing_lua",{duration=7})
            end
            self:GetCaster().enemy=enemies
            self:GetCaster():AddNewModifier(self:GetCaster(),self,"jinmo_nothing_lua",{duration=7})
            for i = 1, #MAIN_HERO_TABLE, 1 do
                local playerID = MAIN_HERO_TABLE[i]:GetPlayerID()

                if playerID then
                local player = PlayerResource:GetPlayer(playerID)
                local hero = player:GetAssignedHero()
                
                talktoplayer(player,true,hero,"啊，这是什么法术，我的头好晕。。。。。",false,nil,5,0,50,0)
                    
                end
            end
            
                Timers:CreateTimer(5,function ()
                    for _,v in pairs(enemies) do
                
                        v:Stop()
                        StartAnimation(v, {duration=1, activity=ACT_DOTA_DIE, rate=1.3})
                        Timers:CreateTimer(0.9,function ()
                        v:AddNewModifier(v,self,"cant_move_lua",{})
                       
                        effectsleep = ParticleManager:CreateParticle("particles/generic_gameplay/generic_sleep.vpcf",PATTACH_OVERHEAD_FOLLOW,v)
                        ParticleManager:SetParticleControl(effectsleep,0,v:GetOrigin())
                        v.effectsleep=effectsleep
                        end)
                
                    end
                    --caster:DestroyParticle(caster.song,false)
                    Firstsystem:juqing_02(self:GetCaster())
                end)

            
                    
            
            

        end
        end
        
    end
end

function lanaya_boss_ai:OnAttackLanded( params )
    if IsServer() then
        self.onattack=1
    end
    
    return 0
end
function lanaya_boss_ai:OnAttackStart( params )
    if IsServer() then
        self.onattack=0
    end
    
    return 0
end




