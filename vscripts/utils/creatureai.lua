

require( "StateMachine_AI" )


local FSM={}

local thinkInterval=1.0

local state_01={STATE=STATE_NORMAL}
local state_02={STATE=STATE_ANGRY}
local StateVectory={state_01,state_02}
function Spawn( entityKeyValues )

	FSM=FSMManager:CreateFSM(thisEntity,state_01,StateVectory)
	thisEntity:SetContextThink( "AIThink", AIThink, 0.25 )


end

function AIThink()

	FSM:OnThink()

	return thinkInterval
end


function state_01:think()
	PrintTestLog("AI----->state_normal_think")
	PrintTestLog(FSM._entity)
	if FSMManager:RandomEnemyHeroInRange(FSM._entity,500) ~=nil then 
		PrintTestLog("boss wanna change state-->STATE_ANGRY")

		FSM:ChangeState(STATE_ANGRY)
		

	end


	

end

function state_02:think()
	PrintTestLog("AI----->state_angry_think")
end