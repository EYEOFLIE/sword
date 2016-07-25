
if normal_unite_ai == nil then
    normal_unite_ai = class({})
end

function normal_unite_ai:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
        MODIFIER_EVENT_ON_TAKEDAMAGE,

    }
    return funcs
end

function normal_unite_ai:OnCreated( kv )
    
    self.auto=1
    self.back=1
    self.findone=0
    self.onattack=1
    self.onspell=1
    if IsServer() then
        self:GetCaster().chushengdian=self:GetCaster():GetOrigin()
        self:StartIntervalThink(0.1)
    end
end

function normal_unite_ai:GetDisableAutoAttack(params)
    if IsServer() then
        return self.auto
    end
    -- body
end

function normal_unite_ai:IsHidden()
    return false
end


function normal_unite_ai:GetTexture( params )
    return "ability_hsj_humei03"
end

function normal_unite_ai:OnTakeDamage( params )
    if params.attacker~=self:GetCaster() then

        local isadd=0
    
        if self:GetCaster().takedamagetable == nil then
           self:GetCaster().takedamagetable={}
            local herotable={}
            herotable[1]=params.attacker
            herotable[2]=params.damage
            herotable[3]=params.attacker:GetUnitName()
            herotable[4]=GameRules:GetGameTime()
            herotable[5]=1
            table.insert(self:GetCaster().takedamagetable,herotable)
        else
            for _,v in pairs(self:GetCaster().takedamagetable) do
            
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
            table.insert(self:GetCaster().takedamagetable,herotable)
           
            end

        end
  
        table.sort(self:GetCaster().takedamagetable, sortFunc)

    end
    
    -- body
end

function normal_unite_ai:OnIntervalThink()
    if IsServer() then
        local enemies
        
        if self:GetCaster():GetAggroTarget() then
            --print(self:GetCaster():GetAggroTarget():GetUnitName())
        end
        
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

                
            if self.onattack==1 and self.onspell==1 then

               
                  self:GetCaster():MoveToTargetToAttack(self:GetCaster().takedamagetable[1][1])

                
                
            end
                     

        else
            if self.findone==0 then
            enemies = FindUnitsInRadius( DOTA_TEAM_GOODGUYS, self:GetCaster():GetOrigin(), nil, self:GetCaster():GetAcquisitionRange(), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, 0, FIND_CLOSEST, false )
            else
            enemies = FindUnitsInRadius( DOTA_TEAM_GOODGUYS, self:GetCaster():GetOrigin(), nil, self:GetCaster():GetCurrentVisionRange(), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, 0, FIND_CLOSEST, false )
            end
            if #enemies > 0 then
              
                if self.onattack==1 and self.onspell==1 then
               
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
        
    end
end

function normal_unite_ai:OnAttackLanded( params )
    if IsServer() then
        self.onattack=1
    end
    
    return 0
end
function normal_unite_ai:OnAttackStart( params )
    if IsServer() then
        self.onattack=0
    end
    
    return 0
end

LinkLuaModifier("normal_unite_ai","lua_modifier/normal_unite_ai.lua",LUA_MODIFIER_MOTION_NONE)


