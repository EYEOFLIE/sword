require( "System.AI.PylAI" )

thinkInterval = 1
local UnitAI = {}
function Spawn( entityKeyValues )
	
	UnitAI=PylAI:Init(thisEntity)
	thisEntity:SetContextThink( "AIThink", AIThink, 1.0 )
end

function AIThink()

	UnitAI:CreateBaseAI(1200,600)

	return thinkInterval
end

