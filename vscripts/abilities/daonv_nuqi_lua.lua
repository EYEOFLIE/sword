
if daonv_nuqi_lua == nil then
    daonv_nuqi_lua = class({})
end

function daonv_nuqi_lua:DeclareFunctions()
    local funcs = {
         MODIFIER_EVENT_ON_TAKEDAMAGE,
     

    }
    return funcs
end

function daonv_nuqi_lua:OnCreated( kv )
    
    self.lastmana=self:GetCaster():GetMana()
    self.times=1
    self.nuqibianliang=200
    if IsServer() then
        self:GetCaster():SetMana(0)
        self:StartIntervalThink(1)

    end
end


function daonv_nuqi_lua:IsHidden()
    return false
end


function daonv_nuqi_lua:GetTexture( params )
    return "defend_jin"
end

function daonv_nuqi_lua:OnTakeDamage( params )
    
    
    if params.attacker~=self:GetCaster() and params.unit == self:GetCaster() then
        self:GetCaster():SetMana(self:GetCaster():GetMana()+1)
    end
    if params.attacker==self:GetCaster() then
        local mana=(15*params.damage)/(4*self.nuqibianliang)
        self:GetCaster():SetMana(self:GetCaster():GetMana()+mana)
    end
    
    -- body
end

function daonv_nuqi_lua:OnIntervalThink()
    if IsServer() then
        
        if self.times>5 then
            self.times=1
            self:GetCaster():SetMana(0)
        end
        if self.lastmana==self:GetCaster():GetMana() then
            self.times=self.times+1
        else
            self.times=1
            self.lastmana=self:GetCaster():GetMana()
        end
      
    end
end

