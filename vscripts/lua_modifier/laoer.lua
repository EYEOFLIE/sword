
if laoer == nil then
    laoer = class({})
end

function laoer:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
        MODIFIER_EVENT_ON_TAKEDAMAGE,
        MODIFIER_PROPERTY_MIN_HEALTH,

    }
    return funcs
end

function laoer:OnCreated( kv )
    
    self.auto=1
    self.back=1
    self.findone=0
    self.onattack=1
    self.onquery=0
    self.stuned=true
    self.spell=0
    self.MinHealth=1
    if IsServer() then
        
        self:GetCaster().chushengdian=self:GetCaster():GetOrigin()
        self:StartIntervalThink(0.1)
        local eff = ParticleManager:CreateParticle("particles/econ/items/disruptor/disruptor_resistive_pinfold/disruptor_kf_formation_markers.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
        ParticleManager:SetParticleControl(eff, 0,self:GetCaster():GetOrigin())
        ParticleManager:SetParticleControl(eff, 1, Vector(1000,1,1))
        ParticleManager:SetParticleControl(eff, 2, Vector(9999,1,1))
   
    end
end


function laoer:CheckState()
    local state = {
    [MODIFIER_STATE_STUNNED] = self.stuned,
    }

    return state
end

function laoer:GetDisableAutoAttack(params)
    if IsServer() then
        return self.auto
    end
    -- body
end
function laoer:GetMinHealth( params )
    if IsServer() then
        return self.MinHealth
    end
    -- body
end
function laoer:IsHidden()
    return false
end


function laoer:GetTexture( params )
    return "defend_jin"
end

function laoer:OnTakeDamage( params )
    
    
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

function laoer:OnIntervalThink()
    if IsServer() then

        if self.onquery==0 then
            local enemies
            
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


                if(self:GetCaster():GetHealth()==1) then
                    self.onquery=1
                   
                    self:GetCaster():AddNewModifier(self:GetCaster(),self,"wudi_lua",{duration=10})

                    talkall(true,self:GetCaster(),"算你们厉害，你们等着，我还会回来的！！！",false,nil,5,0,0,0)
                    self:GetCaster():Stop()
                    Timers:CreateTimer(5,function ()

                        local ability_01 = self:GetCaster():FindAbilityByName("bounty_hunter_wind_walk")
                        self:GetCaster():CastAbilityNoTarget(ability_01,-1)
                        self:GetCaster():MoveToPosition(Vector(-6338.1,-12610.9))
                        Timers:CreateTimer(5,function ()
                            self:GetCaster():RemoveSelf()
                            Firstsystem:cunzhangquest_four()
                            local cunzhang = Entities:FindByName(nil,"npc_cunzhang")
                            local ability_target=cunzhang:FindAbilityByName("Ability_targeteffect")
                            if(ability_target==nil) then
                                ability_target=cunzhang:AddAbility("Ability_targeteffect")
                                
                            end
                        end)
                    end)
                  
                end
        end
        
    end
end

function laoer:OnAttackLanded( params )
    if IsServer() then
        self.onattack=1
    end
    
    return 0
end
function laoer:OnAttackStart( params )
    if IsServer() then
        self.onattack=0
    end
    
    return 0
end




