
function hsj_GetBreakWeapon( keys )
	local ItemAbility = keys.ability
	local hero=keys.caster
	if hero:IsHero() then
		if ItemAbility:IsItem() then
			local itemKind = GetHeroItemKind(hero)
			ItemAbility:RemoveSelf()
			if itemKind == ITEM_KIND_SWORD then
				local item = CreateItem("item_0230", hero:GetPlayerOwner(), hero:GetPlayerOwner())
				hero:AddItem(item)
			elseif itemKind == ITEM_KIND_KNIFE then
				local item = CreateItem("item_0254", hero:GetPlayerOwner(), hero:GetPlayerOwner())
				hero:AddItem(item)
			elseif itemKind == ITEM_KIND_STICK then
				local item = CreateItem("item_0242", hero:GetPlayerOwner(), hero:GetPlayerOwner())
				hero:AddItem(item)
			elseif itemKind == ITEM_KIND_MAGIC then
				local item = CreateItem("item_0266", hero:GetPlayerOwner(), hero:GetPlayerOwner())
				hero:AddItem(item)
			elseif itemKind == ITEM_KIND_BOW then
				local item = CreateItem("item_0278", hero:GetPlayerOwner(), hero:GetPlayerOwner())
				hero:AddItem(item)
			end
		end
	end
end

function hsj_GetChrismas( keys )
	local ItemAbility = keys.ability
	local hero=keys.caster
	if hero:IsHero() then
		if ItemAbility:IsItem() then
			local randomInt = RandomInt(0, 100)
			ItemAbility:RemoveSelf()

			if randomInt <= 20 then
				hero:SetBaseStrength(hero:GetBaseStrength()+50)
				hero:SetBaseAgility(hero:GetBaseAgility()+50)
				hero:SetBaseIntellect(hero:GetBaseIntellect()+50)
				CPlayerMessage:SendMessage(hero:GetEntityIndex(),"#chrismas_bonus_attribute")
			elseif randomInt <= 40 and randomInt > 20 then
				CPlayerMessage:SendMessage(hero:GetEntityIndex(),"#chrismas_bonus_merits")
				local merits = hero:GetContext("hero_xiuwei")
				hero:SetContextNum("hero_xiuwei", merits + 200, 0)
			elseif randomInt <= 60 and randomInt > 40 then
				hero:ModifyGold(1000,true,DOTA_ModifyGold_Unspecified)
				CPlayerMessage:SendMessage(hero:GetEntityIndex(),"#chrismas_bonus_gold")
			elseif randomInt <= 80 and randomInt > 60 then
				hero:AddExperience(3000,false,true)
				CPlayerMessage:SendMessage(hero:GetEntityIndex(),"#chrismas_bonus_exp")
			elseif randomInt <= 98 and randomInt > 80 then
				local item = CreateItem("item_0062", hero:GetPlayerOwner(), hero:GetPlayerOwner())
				hero:AddItem(item)
				item = CreateItem("item_0063", hero:GetPlayerOwner(), hero:GetPlayerOwner())
				hero:AddItem(item)
				item = CreateItem("item_0064", hero:GetPlayerOwner(), hero:GetPlayerOwner())
				hero:AddItem(item)
				CPlayerMessage:SendMessage(hero:GetEntityIndex(),"#chrismas_bonus_equip")
			elseif randomInt <= 100 and randomInt > 98 then
				ModifyEquipMulti(hero,2,nil)
				CPlayerMessage:SendMessage(hero:GetEntityIndex(),"#chrismas_bonus_equip_state")
			end
		end
	end
end

function RegenHPMP(keys)
	local Target=keys.target
	if keys.regen_health then
		if Target ~= nil and (Target:IsNull() == false) then
			Target:Heal(keys.regen_health,Target)
		end
	end
	if keys.regen_mana then
		Caster:GiveMana(keys.regen_mana)
	end
end

function ReturnDamage(keys)
	local ItemAbility = keys.ability
	local Caster = keys.caster
	local Attacker = keys.attacker
	local DamageTaken = keys.DamageTaken

	if (Attacker:GetTeam()~=Caster:GetTeam()) then
		local damage_to_deal = DamageTaken*keys.returning_damage_pct/100
		if (damage_to_deal>0) then
			local damage_table = {
				ability = ItemAbility,
				victim = Attacker,
				attacker = Caster,
				damage = damage_to_deal,
				damage_type = DAMAGE_TYPE_MAGICAL,
				damage_flags = 1
			}
			ApplyDamage(damage_table)
		end
	end
end

function Reincarnation(keys)
	local ItemAbility = keys.ability
	local Caster = keys.caster
	local CasterHP=Caster:GetHealth()
	-- Change it to your game needs
	local respawnTimeFormula = caster:GetLevel() * 4

	if CasterHP==0 and ItemAbility:IsCooldownReady() then
		local CasterGold = caster:GetGold()
		local RespawnPosition = caster:GetAbsOrigin()

		ItemAbility:StartCooldown()

		-- Kill, counts as death for the player but doesn't count the kill for the killer unit
		Caster:SetHealth(1)
		Caster:Kill(Caster, nil)

		-- Set the gold back
		Caster:SetGold(CasterGold, false)

		-- Set the short respawn time and respawn position
		Caster:SetTimeUntilRespawn(5) 
		Caster:SetRespawnPosition(RespawnPosition) 
	elseif CasterHP==0 then
		-- On Death without reincarnation, set the respawn time to the respawn time formula
		Caster:SetTimeUntilRespawn(respawnTimeFormula)
	end
end

function CreateIllusion(keys)
	local ItemAbility = keys.ability
	local Target = keys.caster

	for i=1,keys.illusion_num do
		--create_illusion(keys, illusion_origin, illusion_incoming_damage, illusion_outgoing_damage, illusion_duration)	
		illusion=create_illusion(keys,Target:GetAbsOrigin(),keys.illusion_damage_percent_incoming,keys.illusion_damage_percent_outgoing,keys.illusion_duration)
		if (illusion ~= nil) then
			local CasterAngles = Target:GetAnglesAsVector()
			illusion:SetAngles(CasterAngles.x,CasterAngles.y,CasterAngles.z)
			
			illusion:SetHealth(illusion:GetMaxHealth()*Target:GetHealthPercent()*0.01)
			illusion:SetMana(illusion:GetMaxMana()*Target:GetManaPercent()*0.01)
		end
	end
end

function create_illusion(keys, illusion_origin, illusion_incoming_damage, illusion_outgoing_damage, illusion_duration)	
	local player_id = keys.caster:GetPlayerID()
	local caster_team = keys.caster:GetTeam()
	
	local illusion = CreateUnitByName(keys.caster:GetUnitName(), illusion_origin, true, keys.caster, nil, caster_team)  --handle_UnitOwner needs to be nil, or else it will crash the game.
	illusion:SetPlayerID(player_id)
	illusion:SetControllableByPlayer(player_id, true)

	--Level up the illusion to the caster's level.
	local caster_level = keys.caster:GetLevel()
	for i = 1, caster_level - 1 do
		illusion:HeroLevelUp(false)
	end

	--Set the illusion's available skill points to 0 and teach it the abilities the caster has.
	illusion:SetAbilityPoints(0)
	for ability_slot = 0, 15 do
		local individual_ability = keys.caster:GetAbilityByIndex(ability_slot)
		if individual_ability ~= nil then 
			local illusion_ability = illusion:FindAbilityByName(individual_ability:GetAbilityName())
			if illusion_ability ~= nil then
				illusion_ability:SetLevel(individual_ability:GetLevel())
			end
		end
	end

	--Recreate the caster's items for the illusion.
	--[[for item_slot = 0, 5 do
		local individual_item = keys.caster:GetItemInSlot(item_slot)
		if individual_item ~= nil then
			local illusion_duplicate_item = CreateItem(individual_item:GetName(), illusion, illusion)
			illusion:AddItem(illusion_duplicate_item)
		end
	end]]--
	
	-- modifier_illusion controls many illusion properties like +Green damage not adding to the unit damage, not being able to cast spells and the team-only blue particle 
	illusion:AddNewModifier(keys.caster, keys.ability, "modifier_illusion", {duration = illusion_duration, outgoing_damage = illusion_outgoing_damage, incoming_damage = illusion_incoming_damage})
	
	illusion:MakeIllusion()  --Without MakeIllusion(), the unit counts as a hero, e.g. if it dies to neutrals it says killed by neutrals, it respawns, etc.  Without it, IsIllusion() returns false and IsRealHero() returns true.

	return illusion
end

function AddDefend(events)
	local caster=events.caster
	local ability=events.ability
	--PrintTable(events)
	local defend_jin=ability:GetSpecialValueFor( "defend_jin")
	if defend_jin then
      caster:SetModifierStackCount("defend_jin", caster, caster:GetModifierStackCount("defend_jin",caster)+defend_jin)
	end

end
function RemoveDefend(events)
	local caster=events.caster
	local ability=events.ability
	if caster then
		local defend_jin=ability:GetSpecialValueFor( "defend_jin")
		if defend_jin then
		 caster:SetModifierStackCount("defend_jin", caster, caster:GetModifierStackCount("defend_jin",caster)-defend_jin)
		end

	end
	



end