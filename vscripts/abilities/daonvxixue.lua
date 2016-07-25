--[[
    Author: Noya
    Date: 14.01.2015.
    Applies a Lifesteal modifier if the attacked target is not a building and not a mechanical unit
]]
function VampiricAuraApply( event )
    -- Variables
    local attacker = event.attacker
    local target = event.target
    local ability = event.ability

    if target.GetInvulnCount == nil and not target:IsMechanical() then
       attacker:AddNewModifier(attacker,nil,"xixue",{duration=0.03})
    end
end