function defendwuxing(events)
	local caster=EntIndexToHScript(events.caster_entindex)
	local wuxing=CustomNetTables:GetTableValue("unite_state", caster:GetUnitName())
	for o,v in pairs(wuxing) do
		if not caster:HasModifier("defend_"..o) then
            caster:AddNewModifier(caster,nil,"defend_"..o,{})
        end
       
        caster:SetModifierStackCount("defend_"..o, caster, v*1)

	end

	
end