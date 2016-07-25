function PrecacheEveryThingFromKV( context )
	local kv_files = {
		"scripts/npc/npc_units_custom.txt",
		--[["scripts/npc/npc_abilities_custom.txt",
		"scripts/npc/npc_heroes_custom.txt",
		"scripts/npc/npc_abilities_override.txt",
		"npc_items_custom.txt"]]--
	}
	for _, kv in pairs(kv_files) do
		local kvs = LoadKeyValues(kv)
		if kvs then
			--PrintTestLog("BEGIN TO PRECACHE RESOURCE FROM: ", kv)
			PrecacheEverythingFromTable( context, kvs)
		end
	end

	local unitKv = LoadKeyValues("scripts/npc/npc_units_custom.txt")
	for k,v in pairs(unitKv) do
		--PrintTestLog("PRECACHE UNIT RESOURCE", k)
		PrecacheUnitByNameSync(k,context)
	end
end
function PrecacheEverythingFromTable( context, kvtable)
	for key, value in pairs(kvtable) do
		if type(value) == "table" then
			PrecacheEverythingFromTable( context, value )
		else
			if string.find(value, "vpcf") then
				PrecacheResource( "particle",  value, context)
				--PrintTestLog("PRECACHE PARTICLE RESOURCE", value)
			end
			if string.find(value, "vmdl") then
				PrecacheResource( "model",  value, context)
				--PrintTestLog("PRECACHE MODEL RESOURCE", value)
			end
			if string.find(value, "vsndevts") then
				PrecacheResource( "soundfile",  value, context)
				--PrintTestLog("PRECACHE SOUND RESOURCE", value)
			end
		end
	end
end
