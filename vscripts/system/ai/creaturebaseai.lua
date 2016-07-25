function Spawn( entityKeyValues )
	Timers:CreateTimer(1, function()
		local cunzhang = Entities:FindByName(nil, "npc_cunzhang")
		local herotable={}
		herotable[1]=cunzhang
		herotable[2]=500
		herotable[3]=cunzhang:GetUnitName()
			
		table.insert(thisEntity.takedamagetable,herotable)
		--thisEntity.takedamagetable[1][2]=1000
	end)
	
end