-- Based on template taken from Puurokulho's wndrwll: https://www.youtube.com/watch?v=KDWAGbwdA_w

local function song_init()
	fgcurcommand = {
		'bounce_vertically',
		'skew_plrs1',
		'skew_plrs2',
		'bob_horizontally',
		'STOP1',
		'angery_thomas',
		'angery_thomas_intensifies',
		'STOP2',
	}
	fg_cnt = 1
	checked = false
	max_players = 2
	
	plr = {}
	plrxpos = {}
end

local function song_update()
	local beat = GAMESTATE:GetSongBeat()

	if beat >= 0.1 and not checked then
		for pn=1,max_players do
			if SCREENMAN:GetTopScreen():GetChild('PlayerP' .. pn) then
				table.insert(plr,SCREENMAN:GetTopScreen():GetChild('PlayerP' .. pn))
				table.insert(plrxpos, plr[#plr]:GetX())
			end
		end
		
		checked = true
	end
	
	-- ==================
	-- == SILLY THINGS ==
	-- ==================
	if beat > 4 and fgcurcommand[fg_cnt] == 'bounce_vertically' then
		for i,v in pairs(plr) do
			if v then
				v:bounce()
				v:effectmagnitude(0,100,0)
				v:effectperiod(1)
				v:effectclock('beat')
			end
		end
		fg_cnt = fg_cnt + 1
	end

	if beat > 20 and fgcurcommand[fg_cnt] == 'skew_plrs1' then
		for i,v in pairs(plr) do
			if v then
				v:linear(0.111)
				v:rotationx(65)
				v:rotationy(20)
				v:rotationz(-20)
				v:sleep(0.993)
				v:linear(0.114)
				v:rotationy(0)
				v:rotationx(0)
				v:rotationz(0)
			end
		end
		fg_cnt = fg_cnt + 1
	end

	if beat > 23.75 and fgcurcommand[fg_cnt] == 'skew_plrs2' then
		for i,v in pairs(plr) do
			if v then
				v:linear(0.110)
				v:rotationx(65)
				v:rotationy(20)
				v:rotationz(-20)
				v:sleep(0.993)
				v:linear(0.114)
				v:rotationy(0)
				v:rotationx(0)
				v:rotationz(0)
			end
		end
		fg_cnt = fg_cnt + 1
	end

	if beat > 36 and fgcurcommand[fg_cnt] == 'bob_horizontally' then
		for i,v in pairs(plr) do
			if v then
				v:x(plrxpos[i] + 50*math.sin(beat*math.pi + i*math.pi))
			end
		end
		
		if beat > 64 then
			fg_cnt = fg_cnt + 1
		end
	end

	if beat > 64 and fgcurcommand[fg_cnt] == 'STOP1' then
		for i,v in pairs(plr) do
			if v then
				v:x(plrxpos[i])
				v:stopeffect()
			end
		end
		fg_cnt = fg_cnt + 1
	end

	if beat > 68 and fgcurcommand[fg_cnt] == 'angery_thomas' then
		for i,v in pairs(plr) do
			if v then
				v:vibrate()
				v:effectmagnitude(30,30,0)
			end
		end
		fg_cnt = fg_cnt + 1
	end

	if beat > 68 and beat < 98 then
		for i,v in pairs(plr) do
			if v then
				v:zoom(1 + 0.25*math.sin(beat*math.pi + i*math.pi))
			end
		end
	end

	if beat > 98 and fgcurcommand[fg_cnt] == 'angery_thomas_intensifies' then
		for i,v in pairs(plr) do
			if v then
				v:linear(1)
				v:vibrate()
				v:effectmagnitude(50,50,0)
				v:zoom(2)
			end
		end
		fg_cnt = fg_cnt + 1
	end

	if beat > 100 and fgcurcommand[fg_cnt] == 'STOP2' then

		for i,v in pairs(plr) do
			if v then
				v:stopeffect()
				v:stoptweening()
				v:zoom(1)
			end
		end
	end
end

return Def.ActorFrame{
	OnCommand= function(self)
		song_init()
		self:SetUpdateFunction(song_update)
	end,
	
	Def.Quad{
		Name= "I may be sleeping, but I preserve the world.",
		InitCommand= cmd(visible,false),
		OnCommand= cmd(sleep,1000),
	},
}
