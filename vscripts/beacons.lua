if Beacons == nil then
  Beacons = class({})
end

function Beacons:MakeBeacon(beaconVector, beaconType, relatedPortal, zIncrease)
  Events.beaconMain = CreateUnitByName("beacon", beaconVector, true, nil, nil, DOTA_TEAM_GOODGUYS)
  Events.beaconMain:SetAbsOrigin(Events.beaconMain:GetAbsOrigin()+Vector(0,0,zIncrease))
  Events.beaconMain:NoHealthBar()
  Events.beaconMain:AddAbility("beacon")
  Events.beaconMain:FindAbilityByName("beacon"):SetLevel(1)	
  Events.beaconMain.type = beaconType
  Events.beaconMain.relatedPortal = relatedPortal
  Beacons:CreateParticle("particles/units/heroes/hero_slark/beacon_glow_ground.vpcf", Events.beaconMain:GetAbsOrigin(), Events.beaconMain, 0)
end

function Beacons:CreatePortal(portalVector, portalTeleportLocation, portalName, particleName, active)
	local portal = CreateUnitByName("beacon", portalVector, true, nil, nil, DOTA_TEAM_GOODGUYS)
	portal.active = active
  	portal:NoHealthBar()
  	portal:AddAbility("town_portal")
  	portal:FindAbilityByName("town_portal"):SetLevel(1)	
  	portal.teleportLocation = portalTeleportLocation
  	portal.name = portalName
  	if particleName then
  		Beacons:CreateParticle(particleName, portal:GetAbsOrigin()+Vector(0,0,10), portal, 0)
  	end
  	Beacons:SetPortal(portal, portalName)
  	if portal.active == true then
  		Beacons:ActivatePortalByName(portalName)
  	end
end

function Beacons:DEBUG()
	Events.WaveNumber = 40
	Beacons:DesertInitiate()
	Beacons:MakeBeacon(Vector(4884,-2944), "wave", "desertDesert")
	Beacons:MinesInitiate()
	Beacons:MakeBeacon(Vector(3136,4480), "wave", "minesMines")
	Dungeons.itemLevel = 0
	RPCItems:RollHandOfMidas(Vector(-14528, 14528), false)
	RPCItems:RollFalconBoots(Vector(-14528, 14528), false)
	RPCItems:RollFalconBoots(Vector(-14528, 14528), false)
	local item = CreateItem("item_debug_blink", nil, nil)
    local drop = CreateItemOnPositionSync( Vector(-14528, 14528), item )
    local position = Vector(-14528, 14528)
    RPCItems:DropItem(item, Vector(-14528, 14528))
    -- for i = 0, 10, 1 do
    -- 	RPCItems:RollItemtype(100, Vector(-5700, 5800), 4, 3)
    -- end
	-- RPCItems:RollSandTombOrb(300, MainHero1:GetAbsOrigin(), "immortal", false, "", nil)
	-- BeaconsTempDebug()


end

function Beacons:BossTest()
  	local bat = CreateUnitByName("lumber_mill_boss", Vector(-5888, -4544), true, nil, nil, DOTA_TEAM_NEUTRALS) 	
  	EmitSoundOn("batrider_bat_respawn_13", bat)
  	EmitSoundOn("batrider_bat_respawn_13", bat)
  	EmitSoundOn("batrider_bat_respawn_13", bat)
end

function Beacons:SetPortal(portal, name)
	if name == "forestTown" then
		Beacons.forestTownPortal = portal
	elseif name == "forestForest" then
		Beacons.forestForestPortal = portal
	elseif name == "desertDesert" then
		Beacons.desertDesertPortal = portal
	elseif name == "desertTown" then
		Beacons.desertTownPortal = portal
	elseif name == "minesTown" then
		Beacons.minesTownPortal = portal
	elseif name == "minesMines" then
		Beacons.minesMinesPortal = portal
	elseif name == "graveyard" then
		Beacons.graveyardPortal = portal
	elseif name == "lumbermill" then
		Beacons.lumbermillPortal = portal
	elseif name == "sandtomb" then
		Beacons.sandtombPortal = portal
	elseif name == "vault" then
		Beacons.vaultPortal = portal
	elseif name == "castle" then
		Beacons.castlePortal = portal
	elseif name == "townsiege" then
		Beacons.townsiegePortal = portal
	end
end

function Beacons:DeactivatePortalByName(name)
	if name == "forestTown" then
		Beacons:DeactivatePortal(Beacons.forestTownPortal)
	elseif name == "forestForest" then
		Beacons:DeactivatePortal(Beacons.forestForestPortal)
	elseif name == "desertDesert" then
		Beacons:DeactivatePortal(Beacons.desertDesertPortal)
	elseif name == "desertTown" then
		Beacons:DeactivatePortal(Beacons.desertTownPortal)
	elseif name == "minesMines" then
		Beacons:DeactivatePortal(Beacons.minesMinesPortal)
	elseif name == "minesTown" then
		Beacons:DeactivatePortal(Beacons.minesTownPortal)
	end
end

function Beacons:ActivatePortalByName(portalName)
	local portal = ""
	local particle = ""
	local colorVector = ""
	if portalName == "forestTown" then
		portal = Beacons.forestTownPortal
		particle = "particles/portals/green_portal.vpcf"
		colorVector = Vector(0,0.8,0.3)
	elseif portalName == "forestForest" then
		portal = Beacons.forestForestPortal
		particle = "particles/portals/green_portal.vpcf"
		colorVector = Vector(0,0.8,0.3)
	elseif portalName == "desertDesert" then
		portal = Beacons.desertDesertPortal
		particle = "particles/portals/green_portal.vpcf"
		colorVector = Vector(1,1,0)
	elseif portalName == "desertTown" then
		portal = Beacons.desertTownPortal
		particle = "particles/portals/green_portal.vpcf"
		colorVector = Vector(1,1,0)
	elseif portalName == "minesMines" then
		portal = Beacons.minesMinesPortal
		particle = "particles/portals/green_portal.vpcf"
		colorVector = Vector(1,0,0)
	elseif portalName == "minesTown" then
		portal = Beacons.minesTownPortal
		particle = "particles/portals/green_portal.vpcf"
		colorVector = Vector(1,0,0)
	elseif portalName == "graveyard" then
		portal = Beacons.graveyardPortal
		particle = "particles/portals/green_portal.vpcf"
		colorVector = Vector(0.5,0.5,0.5)
	elseif portalName == "lumbermill" then
		portal = Beacons.lumbermillPortal
		particle = "particles/portals/green_portal.vpcf"
		colorVector = Vector(0.5,0.5,0.5)	
	elseif portalName == "sandtomb" then
		portal = Beacons.sandtombPortal
		particle = "particles/portals/green_portal.vpcf"
		colorVector = Vector(0.5,0.5,0.5)	
	elseif portalName == "vault" then
		portal = Beacons.vaultPortal
		particle = "particles/portals/green_portal.vpcf"
		colorVector = Vector(0.5,0.5,0.5)		
	elseif portalName == "castle" then
		portal = Beacons.castlePortal
		particle = "particles/portals/green_portal.vpcf"
		colorVector = Vector(0.5,0.5,0.5)		
	elseif portalName == "townsiege" then
		portal = Beacons.townsiegePortal
		particle = "particles/portals/green_portal.vpcf"
		colorVector = Vector(0.5,0.5,0.5)			
	end
	Beacons:ActivatePortal(portal, particle, colorVector)
end

function Beacons:ActivatePortal(portal, particle, colorVector)
	Beacons:CreateActiveParticle(particle, portal:GetAbsOrigin(), portal, 0, colorVector)
	portal.active = true
end

function Beacons:DeactivatePortal(portal)
	portal.active = false
	ParticleManager:DestroyParticle( portal.activeParticle, false )
end

function Beacons:IsHeroInCorrectLocation(hero, beaconPortal)
	local currentLocation = ""
	if hero.lastPortalUsed then
		if hero.lastPortalUsed == "forestTown" then
			currentLocation = "forestForest"
		elseif hero.lastPortalUsed == "desertTown" then
			currentLocation = "desertDesert"
		elseif hero.lastPortalUsed == "minesTown" then
			currentLocation = "minesMines"
		elseif hero.lastPortalUsed == "mainTown" then
			return true
		end
	end
	print(beaconPortal)
	print(currentLocation)
	if beaconPortal == currentLocation then
		return true
	else
		return false
	end
end

function Beacons:ResetPortalsUsed()
  for i = 1, #MAIN_HERO_TABLE, 1 do
    MAIN_HERO_TABLE[i].lastPortalUsed = ""
  end
end

function Beacons:WaveClear(waveNumber)
	print("Beacons:WaveClear -- "..waveNumber)
	Events.isTownActive = true
	Beacons:WorldBeacons()
	if waveNumber == 4 or waveNumber == 5 then
		Beacons:ActivatePortalByName("forestForest")
		Beacons:MakeBeacon(Vector(-6443,-5282), "wave", "forestForest", 0)
	elseif waveNumber == 8 or waveNumber == 9 then
		Beacons:ActivatePortalByName("forestForest")
		Beacons:MakeBeacon(Vector(-6443,-5282), "wave", "forestForest", 0)
	elseif waveNumber == 12 or waveNumber == 13 then
		Beacons:ActivatePortalByName("forestForest")
		Beacons:MakeBeacon(Vector(-6443,-5282), "wave", "forestForest", 0)
	elseif waveNumber == 16 or waveNumber == 17 then
		Beacons:ActivatePortalByName("forestForest")
		Beacons:MakeBeacon(Vector(-6443,-5282), "wave", "forestForest", 0)
	elseif waveNumber == 20 then
		Beacons:ActivatePortalByName("forestForest")
		Beacons:MakeBeacon(Vector(-6443,-5282), "wave", "forestForest", 0)
	elseif waveNumber == 22 then
		-- NEVERLORD --
		Beacons:ActivatePortalByName("forestForest")
		Beacons:MakeBeacon(Vector(4884,-2944), "wave", "desertDesert", 10)
		Beacons:ResetPortalsUsed()
	elseif waveNumber == 26 then
		Beacons:ActivatePortalByName("desertDesert")
		Beacons:MakeBeacon(Vector(4884,-2944), "wave", "desertDesert", 10)
	elseif waveNumber == 30 then
		Beacons:ActivatePortalByName("desertDesert")
		Beacons:MakeBeacon(Vector(4884,-2944), "wave", "desertDesert", 10)
	elseif waveNumber == 34 then
		Beacons:ActivatePortalByName("desertDesert")
		Beacons:MakeBeacon(Vector(4884,-2944), "wave", "desertDesert", 10)
	elseif waveNumber == 38 then
		Beacons:ActivatePortalByName("desertDesert")
		Beacons:MakeBeacon(Vector(4884,-2944), "wave", "desertDesert", 10)
	elseif waveNumber == 40 then
		-- JONUOUS --
		Beacons:ActivatePortalByName("desertDesert")
		Beacons:MakeBeacon(Vector(3136,4480), "wave", "minesMines", 0)
		Beacons:ResetPortalsUsed()
	elseif waveNumber == 44 then
		Beacons:ActivatePortalByName("minesMines")
		Beacons:MakeBeacon(Vector(3136,4480), "wave", "minesMines", 0)
	elseif waveNumber == 48 then
		Beacons:ActivatePortalByName("minesMines")
		Beacons:MakeBeacon(Vector(3136,4480), "wave", "minesMines", 0)
	elseif waveNumber == 52 then
		Beacons:ActivatePortalByName("minesMines")
		Beacons:MakeBeacon(Vector(3136,4480), "wave", "minesMines", 0)
	elseif waveNumber == 56 then
		Beacons:ActivatePortalByName("minesMines")
		Beacons:MakeBeacon(Vector(3136,4480), "wave", "minesMines", 0)
	end
end



function Beacons:CreateParticle(particleName, particleVector, caster, destroyTime)

		local pfx = ParticleManager:CreateParticle( particleName, PATTACH_CUSTOMORIGIN, caster )
		caster.particle = pfx
		ParticleManager:SetParticleControl( pfx, 0, particleVector )
		ParticleManager:SetParticleControl( pfx, 1, particleVector )
		ParticleManager:SetParticleControl( pfx, 2, particleVector )
		ParticleManager:SetParticleControl( pfx, 3, particleVector )
		if destroyTime > 0 then
			Timers:CreateTimer(destroyTime, function() 
			  ParticleManager:DestroyParticle( pfx, false )
			end)  
		end
end

function Beacons:DesertInitiate()
	Beacons:CreatePortal(Vector(1792,-2624), Vector(-13945,12400), "desertDesert", "particles/customgames/capturepoints/cp_desert_allied_metal.vpcf", true)
	Beacons:CreatePortal(Vector(-13945,12400), Vector(1792,-2624), "desertTown", "particles/customgames/capturepoints/cp_desert_allied_metal.vpcf", true)
	AddFOWViewer(DOTA_TEAM_GOODGUYS, Vector(1792,-2624), 200, 99999, false)
end

function Beacons:MinesInitiate()
	Beacons:CreatePortal(Vector(3821,1404), Vector(-14452,12400), "minesMines", "particles/customgames/capturepoints/cp_earth_captured.vpcf", true)
	Beacons:CreatePortal(Vector(-14452,12400), Vector(3821,1404), "minesTown", "particles/customgames/capturepoints/cp_earth_captured.vpcf", true)
	AddFOWViewer(DOTA_TEAM_GOODGUYS, Vector(3821,1404), 200, 99999, false)
end

function Beacons:CreateDungeonBeacon(position, beaconType, dungeonName, imagePath, recommendedLevel, entryPoint, itemLevel, zIncrease)
  beacon = CreateUnitByName("beacon", position, true, nil, nil, DOTA_TEAM_GOODGUYS)
  beacon:SetAbsOrigin(beacon:GetAbsOrigin()+Vector(0,0,zIncrease))
  beacon:NoHealthBar()
  beacon:AddAbility("beacon")
  beacon:FindAbilityByName("beacon"):SetLevel(1)	
  beacon.type = beaconType
  beacon.recommendedLevel = recommendedLevel
  beacon.dungeon = dungeonName
  beacon.dungeonImagePath = imagePath
  beacon.entryPoint = entryPoint
  beacon.itemLevel = itemLevel
  Beacons:CreateParticle("particles/units/heroes/hero_slark/beacon_glow_red_ground.vpcf", beacon:GetAbsOrigin(), beacon, 0)
  return beacon
end

function Beacons:WorldBeacons()
	Dungeons.itemLevel = 0
	Beacons.DungeonBeaconTable = {}
	if not Dungeons.cleared.townsiege then
		dungeonBeacon = Beacons:CreateDungeonBeacon(Vector(-14074, 13888), "dungeon", "town_siege", "file://{images}/custom_game/dungeons/town_siege.jpg", "1", Vector(-2688,2240), 4, 0)
		table.insert(Beacons.DungeonBeaconTable, dungeonBeacon)
	end
	if not Dungeons.cleared.graveyard then
		--TODO: move graveyard to Vector(-5248, -7360) when dungeons are more widespread, also: set zIncrease to 0
		local dungeonBeacon = Beacons:CreateDungeonBeacon(Vector(-4780, -6300), "dungeon", "graveyard", "file://{images}/custom_game/dungeons/graveyard.jpg", "5-12", Vector(-4224,-11328), 8, 7)
		table.insert(Beacons.DungeonBeaconTable, dungeonBeacon)
	end
	if not Dungeons.cleared.lumbermill then
		dungeonBeacon = Beacons:CreateDungeonBeacon(Vector(-7104, -6464), "dungeon", "logging_camp", "file://{images}/custom_game/dungeons/logging_camp.jpg", "12-18", Vector(-16064,-15168), 17, 0)
		table.insert(Beacons.DungeonBeaconTable, dungeonBeacon)
	end
	if not Dungeons.cleared.sandtomb and Events.WaveNumber > 18 then
		dungeonBeacon = Beacons:CreateDungeonBeacon(Vector(6336, -2983), "dungeon", "sand_tomb", "file://{images}/custom_game/dungeons/sand_tomb.jpg", "20-26", Vector(9344,-2944), 36, 0)
		table.insert(Beacons.DungeonBeaconTable, dungeonBeacon)
	end
	if not Dungeons.cleared.vault and Events.WaveNumber > 18 then
		dungeonBeacon = Beacons:CreateDungeonBeacon(Vector(6912, -2048), "dungeon", "vault", "file://{images}/custom_game/dungeons/vault.jpg", "26-30", Vector(15282,-2493), 50, 0)
		table.insert(Beacons.DungeonBeaconTable, dungeonBeacon)
	end
	if not Dungeons.cleared.castle and Events.WaveNumber > 24 then
		dungeonBeacon = Beacons:CreateDungeonBeacon(Vector(827,2796), "dungeon", "castle", "file://{images}/custom_game/dungeons/castle.jpg", "40-50", Vector(-4928,5537), 68, 0)
		table.insert(Beacons.DungeonBeaconTable, dungeonBeacon)
	end
end

function Beacons:RemoveDungeonBeacons()
	for i = 1, #Beacons.DungeonBeaconTable, 1 do
		if not Beacons.DungeonBeaconTable[i]:IsNull() then
			UTIL_Remove(Beacons.DungeonBeaconTable[i])
		end
	end
end

function Beacons:CreateActiveParticle(particleName, particleVector, caster, destroyTime, colorVector)
		local pfx = ParticleManager:CreateParticle( particleName, PATTACH_CUSTOMORIGIN, caster )
		caster.activeParticle = pfx
		ParticleManager:SetParticleControl( pfx, 0, particleVector )
		ParticleManager:SetParticleControl( pfx, 1, colorVector )
		ParticleManager:SetParticleControl( pfx, 2, colorVector )
		ParticleManager:SetParticleControl( pfx, 3, colorVector )
		if destroyTime > 0 then
			Timers:CreateTimer(destroyTime, function() 
			  ParticleManager:DestroyParticle( pfx, false )
			end)  
		end
end

function Beacons:CreateParticleEnt(particleName, particleVector, caster, destroyTime)
	local pfx = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN, caster )
	 ParticleManager:SetParticleControlEnt( pfx, 0, caster, PATTACH_POINT_FOLLOW, "attach_origin", particleVector, true )
	 ParticleManager:SetParticleControlEnt( pfx, 0, caster, PATTACH_POINT_FOLLOW, "attach_origin", particleVector, true )
	 ParticleManager:SetParticleControlEnt( pfx, 0, caster, PATTACH_POINT_FOLLOW, "attach_origin", particleVector, true )
		if destroyTime > 0 then
			Timers:CreateTimer(destroyTime, function() 
			  ParticleManager:DestroyParticle( pfx, false )
			end)  
		end
end

function BeaconsTempDebug()
	Timers:CreateTimer(30, function()
		local relic = CreateUnitByName("prop_unit", Vector(-6780, 4700)+Vector(140,0,0), false, nil, nil, DOTA_TEAM_GOODGUYS)
		relic:SetOriginalModel("models/items/chen/squareskystaff_weapon/squareskystaff_weapon.vmdl")
		relic:SetModel("models/items/chen/squareskystaff_weapon/squareskystaff_weapon.vmdl")
		relic:SetForwardVector(Vector(0,-1))
		ability = relic:AddAbility("ability_sand_relic_passive")
		ability:SetLevel(1)
		local relicPos = relic:GetAbsOrigin() +Vector(0,0,100)
		relic:SetAbsOrigin(relicPos)
		relic:SetForwardVector(Vector(0,1))
    	relic:AddAbility("replica")
    	relic:FindAbilityByName("replica"):SetLevel(1)
    	relic:SetModelScale(2.2)
		ability.relic = relic
		ability.relicPosition = relicPos
		ability.liftPos = 0
		ability.totalLift = 0
		ability.liftVelocity = 0
		ability.lifting = true

		local relicDummy = CreateUnitByName("dummy_unit_vulnerable", Vector(11136,-1792), false, nil, nil, DOTA_TEAM_GOODGUYS)
		ability:ApplyDataDrivenModifier(relic, relicDummy, "modifier_relic_dummy_effect", {duration = 99999})
		ability.dummy = relicDummy
	end)
end