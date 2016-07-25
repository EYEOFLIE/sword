function ChestPatrolThink1(event)
	caster = event.caster
	point = Vector(-6800, 4000)
	caster:MoveToPosition( point )
end

function ChestPatrolThink2(event)
	caster = event.caster
	ability = event.ability
	point = Vector(-5800, 4600)

	caster:MoveToPosition( point )
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_chest_patrol_point_two", {})
end

function ChestPatrolThink3(event)
	caster = event.caster
	ability = event.ability
	point = Vector(-5800, 5400)

	caster:MoveToPosition( point )
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_chest_patrol_point_three", {})
end

function ChestPatrolThink4(event)
	caster = event.caster
	ability = event.ability
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_chest_patrol_point_one", {})
end

function OwlPatrolThink1(event)
	caster = event.caster
	point = Vector(-14462, 14314)
	caster:MoveToPosition( point )
end

function OwlPatrolThink2(event)
	ability = event.ability
	caster = event.caster
	point = Vector(-13504, 14528)
	caster:MoveToPosition( point )
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_owl_patrol_point_two", {})
end

function OwlPatrolThink3(event)
	caster = event.caster
	ability = event.ability
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_owl_patrol_point_one", {})
end
