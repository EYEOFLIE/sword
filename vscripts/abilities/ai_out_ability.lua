function lanaya_enemy_think(event)
	local targets = event.target_entities
	local caster = event.caster
	local ability = event.ability
	--local ability_01 = caster:FindAbilityByName("nyx_assassin_mana_burn")
	--local ability_02 = caster:FindAbilityByName("templar_assassin_refraction")
	--local ability_03 = caster:FindAbilityByName("Ability_Dropped")
	--local ability_04 = caster:FindAbilityByName("naga_siren_song_of_the_siren")
	
	caster:RemoveModifierByName("modifier_ai_chufa")

	

	
	
    --local numberIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_nyx_assassin/nyx_assassin_mana_burn_msg.vpcf", PATTACH_OVERHEAD_FOLLOW, caster )
   -- ParticleManager:SetParticleControl( numberIndex, 1, Vector( 0, 20, 0 ) )
   -- ParticleManager:SetParticleControl( numberIndex, 2, Vector( 1, 3, 0 ) )
	--print(caster:GetHealthPercent())

	if(caster:GetHealthPercent()<50) then
		QuestSystem:quicklyfinish(MAIN_HERO_TABLE[1],"quest_zhuxian_01_01")
		caster:RemoveModifierByName("modifier_ai_out_ability")
		StartAnimation(caster, {duration=0.6, activity=ACT_DOTA_ATTACK2, rate=0.8})
		EmitSoundOn("Hero_NagaSiren.SongOfTheSiren",caster)
		caster.song = ParticleManager:CreateParticle("particles/units/heroes/hero_siren/naga_siren_siren_song_cast.vpcf",PATTACH_ABSORIGIN_FOLLOW,caster)
		ParticleManager:SetParticleControl(caster.song,0,caster:GetOrigin())
		Timers:CreateTimer(1,function ()
			--effectsing2 = ParticleManager:CreateParticle("particles/units/heroes/hero_siren/naga_siren_song_aura.vpcf",PATTACH_ABSORIGIN_FOLLOW,caster)
			--ParticleManager:SetParticleControl(effectsing2,0,caster:GetOrigin())
		end)
		local enemies = FindUnitsInRadius( DOTA_TEAM_GOODGUYS, caster:GetOrigin(), nil, 1500, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, 0, 0, false )
		for _,v in pairs(enemies) do
			
			ability:ApplyDataDrivenModifier(v, v, "modifier_jinmo", nil)
		end
		caster.enemy=enemies
		ability:ApplyDataDrivenModifier(caster, caster, "modifier_jinmo", nil)
		for i = 1, #MAIN_HERO_TABLE, 1 do
			local playerID = MAIN_HERO_TABLE[i]:GetPlayerID()

			if playerID then
			local player = PlayerResource:GetPlayer(playerID)
			local hero = player:GetAssignedHero()
			
			talktoplayer(player,true,hero,"啊，这是什么法术，我的头好晕。。。。。",false,nil,5,0,50,0)
				
			end
		end
		
			Timers:CreateTimer(5,function ()
				for _,v in pairs(enemies) do
			
					v:Stop()
					StartAnimation(v, {duration=1, activity=ACT_DOTA_DIE, rate=1.3})
					Timers:CreateTimer(0.9,function ()
					ability:ApplyDataDrivenModifier(v, v, "modifier_cant_move", nil)
				   	effectsleep = ParticleManager:CreateParticle("particles/generic_gameplay/generic_sleep.vpcf",PATTACH_OVERHEAD_FOLLOW,v)
					ParticleManager:SetParticleControl(effectsleep,0,v:GetOrigin())
					v.effectsleep=effectsleep
					end)
			
				end
				--caster:DestroyParticle(caster.song,false)
				Firstsystem:juqing_02(caster)
			end)

		
				
		
		

	end
	

end
function jianling_enemy_think(event)
	local caster = event.caster
	local ability = event.ability
	caster:RemoveModifierByName("jianling_ai_chufa")
	if(caster:GetHealthPercent()<50) then
		
		Firstsystem.zhujiao_01:SetControllableByPlayer(-1,true)
		caster:RemoveModifierByName("jianling_ai_out_ability")
		ability:ApplyDataDrivenModifier(caster,caster, "jianling_cant_move_02", {})
		ability:ApplyDataDrivenModifier(Firstsystem.zhujiao_01,Firstsystem.zhujiao_01, "jianling_cant_move_02", {})
		effectshouwang = ParticleManager:CreateParticle("particles/units/heroes/hero_beastmaster/beastmaster_primal_roar.vpcf",PATTACH_ABSORIGIN_FOLLOW,caster)
		ParticleManager:SetParticleControl(effectshouwang,0,caster:GetOrigin())
		ParticleManager:SetParticleControl(effectshouwang,1,Firstsystem.zhujiao_01:GetOrigin())
				
			StartAnimation(Firstsystem.zhujiao_01, {duration=2, activity=ACT_DOTA_DIE, rate=2.0})
			Timers:CreateTimer(1.5,function ()
				ability:ApplyDataDrivenModifier(Firstsystem.zhujiao_01,Firstsystem.zhujiao_01, "jianling_cant_move", {duration=6})
				Timers:CreateTimer(3,function ()
					talkall(true,caster,"汝的血。。。。莫非。。。。",false,nil,3,0,0,0,"",1)
					local baojian = Entities:FindByName(nil,"baojian")
					baojian:RemoveSelf()
					
					Timers:CreateTimer(3,function ()
						local baojian_02=CreateUnitByName("npc_sword", Vector(-13787.7,-8182.75,2598.38), true, nil, nil, DOTA_TEAM_GOODGUYS)
						partic01 = ParticleManager:CreateParticle( "particles/feijian/veno_toxicant_tail.vpcf", PATTACH_ABSORIGIN_FOLLOW, baojian_02 )
						ParticleManager:SetParticleControlEnt(partic01, 0, baojian_02, PATTACH_POINT_FOLLOW, "attach_tail_fx", baojian_02:GetAbsOrigin(), true)
						StartAnimation(baojian_02, {duration=1.5, activity=ACT_DOTA_ATTACK, rate=1.5})
						talkall(true,Firstsystem.zhujiao_01,"别跑，我不信我打不过你",false,nil,5,0,0,0)
						caster:MoveToNPC(baojian_02)
						Timers:CreateTimer(5,function ()
							caster:RemoveSelf()
							Timers:CreateTimer(2,function ()
								Firstsystem.zhujiao_01:MoveToPosition(Vector(-13622.8,-8244.81))
								Timers:CreateTimer(5,function ()
								Firstsystem.zhujiao_01:SetForwardVector(Firstsystem.zhujiao_01:GetOrigin()-baojian_02:GetOrigin())
								talkall(true,Firstsystem.zhujiao_01,"这剑。。。莫非刚才的怪物是这剑的剑灵？",false,nil,5,0,0,0)
									Timers:CreateTimer(5,function ()
										talkall(true,Firstsystem.zhujiao_01,"不管了，这剑倒是把好剑，先拿走了，乘他们还没醒，我先溜走了",false,nil,5,0,0,0)
										Timers:CreateTimer(5,function ()
											EmitSoundOn("ui.ding",Firstsystem.zhujiao_01)
											baojian_02:RemoveSelf()
											Firstsystem:juqing_03(Firstsystem.zhujiao_01)
										end)

									end)
								end)
							end)
						end)
					end)
				end)
			end)
	

		
		
		
		
		--Firstsystem:juqing_03()

	end
	-- body
end

function ddd( )


	-- body
end
