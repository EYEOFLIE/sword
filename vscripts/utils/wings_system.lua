
if WingsSystem == nil then
	WingsSystem = {}
	setmetatable(WingsSystem,WingsSystem)
end

WingsSystem.UnitData = {}
WingsSystem.WingsType = {}
WingsSystem.WingsType["God"] = {}
WingsSystem.WingsType["Demon"] = {}

-- 成仙翅膀
WingsSystem.WingsType["God"][1] = { EffectName = "particles/wings/god_level_1/god_wings_level_1.vpcf", ControlPointEnts={[0]="follow_wings"} }
WingsSystem.WingsType["God"][2] = { EffectName = "particles/wings/god_level_2/god_wings_level_2.vpcf", ControlPointEnts={[0]="follow_wings"} }
WingsSystem.WingsType["God"][3] = { EffectName = "particles/wings/god_level_3/god_wings_level_3.vpcf", ControlPointEnts={[0]="follow_wings",[10]="follow_origin"} }
WingsSystem.WingsType["God"][4] = { EffectName = "particles/wings/god_level_4/god_wings_level_4.vpcf", ControlPointEnts={[0]="follow_wings",[10]="follow_origin"} }
WingsSystem.WingsType["God"][5] = { EffectName = "particles/hero_pp/skywrath_dpits3_backwing_p.vpcf", ControlPointEnts={[0]="follow_wings",[10]="follow_origin"} }


-- 成魔翅膀
WingsSystem.WingsType["Demon"][1] = { EffectName = "particles/wings/demon_level_1/demon_wings_level_1.vpcf", ControlPointEnts={[0]="follow_wings"} }
WingsSystem.WingsType["Demon"][2] = { EffectName = "particles/wings/demon_level_2/demon_wings_level_2.vpcf", ControlPointEnts={[0]="follow_wings"} }
WingsSystem.WingsType["Demon"][3] = { EffectName = "particles/wings/demon_level_3/demon_wings_level_3.vpcf", ControlPointEnts={[0]="follow_wings",[10]="follow_origin"} }
WingsSystem.WingsType["Demon"][4] = { EffectName = "particles/wings/demon_level_4/demon_wings_level_4.vpcf", ControlPointEnts={[0]="follow_wings",[10]="follow_origin"} }
WingsSystem.WingsType["Demon"][5] = { EffectName = "particles/wings/demon_level_5/demon_wings_level_5.vpcf", ControlPointEnts={[0]="follow_wings",[10]="follow_origin"} }

-- 单位数据
local unitDataTemplate = {
	wingsType = "",
	wingsLevel = 0,
	ParticleID = nil,
}

-- 设置特效控制点
-- @unit  [单位]
-- @particleID  [特效ID]
-- @controlPoints  [Vector控制点]
-- @controlPointEnts  [绑定到attach点]
-- 
function WingsSystem:SetControlPoints( unit, particleID, controlPoints, controlPointEnts )

	for k,v in pairs(controlPoints or {}) do
		if v == 0 then
			
			ParticleManager:SetParticleControl(particleID,k,unit:GetOrigin())
		else
			
			ParticleManager:SetParticleControl(particleID,k,v)
		end
	end


		
		ParticleManager:SetParticleControlEnt(particleID, 0, unit, 5, "follow_origin", unit:GetOrigin(), true)


end

-- 清除翅膀
function WingsSystem:ClearWings( unit )
	if type(unit) ~= "table" then return end
	if unit:IsNull() then return end

	local unitIndex = unit:GetEntityIndex()

	if self.UnitData[unitIndex] == nil then return end

	local data = self.UnitData[unitIndex]

	-- 删除之前的特效
	if data.ParticleID then
		ParticleManager:DestroyParticle(data.ParticleID,true)
		data.ParticleID = nil
	end

	data.wingsType = ""
	data.wingsLevel = 0
end

-- 创建翅膀
-- @unit  [单位]
-- @wingsType  [翅膀类型，如"God","Demon"]
-- @wingsLevel  [翅膀等级]
-- 
function WingsSystem:CreateWings( unit, wingsType, wingsLevel )
	if type(unit) ~= "table" then return end
	if unit:IsNull() then return end
	if not unit:IsAlive() then return end

	if self.WingsType[wingsType] == nil then return end
	if self.WingsType[wingsType][wingsLevel] == nil then return end

	local unitIndex = unit:GetEntityIndex()

	if self.UnitData[unitIndex] == nil then self(unit) end

	local data = self.UnitData[unitIndex]
	local wings = self.WingsType[wingsType][wingsLevel];

	-- 删除之前的特效
	if data.ParticleID then
		ParticleManager:DestroyParticle(data.ParticleID,true)
	end

	-- 创建特效
	
	local e = ParticleManager:CreateParticle(wings.EffectName or "", PATTACH_CUSTOMORIGIN_FOLLOW, unit)
	self:SetControlPoints(unit,e,wings.ControlPoints,wings.ControlPointEnts)

	data.wingsType = wingsType
	data.wingsLevel = wingsLevel
	data.ParticleID = e

end

-- 创建翅膀
-- @hero [英雄]
-- 
function WingsSystem:CreateWingsForHero( hero )
	if type(hero) ~= "table" then return end
	if hero:IsNull() then return end
	if hero.IsHero and not hero:IsHero() then return end

	
   
end

-- 初始化单位数据
-- @unit [单位]
-- 
function WingsSystem:__call( unit )
	
	if type(unit) == "table" and not unit:IsNull() then

		local unitIndex = unit:GetEntityIndex()
		local data = vlua.clone(unitDataTemplate)

		self.UnitData[unitIndex] = data
	end

end