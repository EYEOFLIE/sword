music_table={
	{"backgroundmusic_xuehai","Music_Hsj.BackGroundFutuxuehai",92.0,true},
	{"backgroundmusic_baihu","Music_Hsj.BackGroundBaihu",76.0,true},
	{"backgroundmusic_bingfenggu","Music_Hsj.BackGroundBingfenggu",68.0,true},
	{"backgroundmusic_chiyouzhong","Music_Hsj.BackGroundChiyouzhong",127.0,true},
	{"backgroundmusic_donghai","Music_Hsj.BackGroundDonghai",121.0,true},
	--{"backgroundmusic_fuxi","Music_Hsj.BackGroundFuxi",146.0,true},
	{"backgroundmusic_guijie","Music_Hsj.BackGroundGuijie",199.0,true},
	{"backgroundmusic_huaguoshan","Music_Hsj.BackGroundHuaguoshan",173.0,true},
	{"backgroundmusic_jidijingong","Music_Hsj.BackGroundJidijingong",186.0,true},
	--{"backgroundmusic_jidiwuzhan","Music_Hsj.BackGroundJidiwuzhan",236.0,false},
	{"backgroundmusic_langxue","Music_Hsj.BackGroundLangxue",79.0,true},
	{"backgroundmusic_qinglong","Music_Hsj.BackGroundQinglong",90.0,1},
	{"backgroundmusic_sanshisantianwai","Music_Hsj.BackGroundSanshisantianwai",99.0,true},
	{"backgroundmusic_shazhongfoguo","Music_Hsj.BackGroundShazhongfoguo",187.0,true},
	--{"backgroundmusic_shennong","Music_Hsj.BackGroundShennong",180.0,true},
	{"backgroundmusic_tianting","Music_Hsj.BackGroundTianting",61.0,true},
	--{"backgroundmusic_xuanwu","Music_Hsj.BackGroundXuanwu",85.0,true},
	{"backgroundmusic_xuanyuan","Music_Hsj.BackGroundXuanyuan",121.0,true},
	{"backgroundmusic_zhizhudong","Music_Hsj.BackGroundZhizhudong",73.0,true},
	{"backgroundmusic_zhuque","Music_Hsj.BackGroundZhuque",127.0,true},
	--{"backgroundmusic_zuwu","Music_Hsj.BackGroundZuwu",134.0,true},
}

function InitBackGroundMusic()
	for k,v in ipairs(music_table) do
		local ent = Entities:FindByName(nil, v[1])
		if ent ~= nil then
			ent:SetContextThink(v[1],
				function ()
					EmitSoundOn(v[2],ent)
					if v[4] then
						return v[3]
					else
						return nil
					end
				end, 
			0.1)
		end
	end
end

function EmitSoundBackGroundMusic(strMusic)
	for k,v in ipairs(music_table) do
		if v[1] == strMusic then
			local ent = Entities:FindByName(nil, v[1])
			if ent ~= nil then
				ent:SetContextThink(v[1],
					function ()
						EmitSoundOn(v[2],ent)
						v[4] = true
						return v[3]
					end, 
				0.1)
			end
		end
	end
end

function StopSoundBackGroundMusic(strMusic)
	for k,v in ipairs(music_table) do
		if v[1] == strMusic then
			local ent = Entities:FindByName(nil, v[1])
			if ent ~= nil then
				ent:SetContextThink(v[1],
					function ()
						StopSoundOn(v[2],ent)
						v[4] = false
						return nil
					end, 
				0.1)
			end
		end
	end
end