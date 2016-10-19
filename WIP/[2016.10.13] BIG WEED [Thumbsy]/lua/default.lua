-- Template taken from Puurokulho's wndrwll: https://www.youtube.com/watch?v=KDWAGbwdA_w

local songName= GAMESTATE:GetCurrentSong():GetSongDir()

local function song_mod_internal(str, pn)
	local ps= GAMESTATE:GetPlayerState(pn)
	local pmods= ps:GetPlayerOptionsString('ModsLevel_Song')
	ps:SetPlayerOptions('ModsLevel_Song', pmods .. ', ' .. str)
end


local function song_mod(str)
	for i=1,2 do
		song_mod_internal(str, 'PlayerNumber_P' .. i)
	end
end



local function song_init()
	fgcurcommand = 0;
	checked = false;
	
	
	
	-- lua course :D	/ timed mod management	
	curmod = 1;
	-- {beat,mod,player}
	mods = {

		{20,'*12 reverse'},
		{20.75,'*12 no reverse,*100 -200 mini'},
		{21.5,'*100 no mini'},
		{28.5,'*12 150 beat'},
		{65,'*10 no beat'},

	}

	-- timed message broadcaster
	curmessage = 1;
	-- {beat,message,ignoreIfAhead}
	messages = {

		{21.5,'ScreenRotateZ10'},
		{22.5,'ScreenRotateZ0'},
		{23,'ScreenShift'},
		{23.875,'ScreenResetShift'},
		{25,'ScreenBob'},
		{28,'ScreenStopEffect'},
		{44,'ScreenBoounce'},
		{60,'CompleteMess'},
		{65,'StopEverything'}

	}
	
end

local function song_update()

	if GAMESTATE:GetSongBeat()>=0.1 and not checked then
	
		if SCREENMAN:GetTopScreen():GetChild('PlayerP1') then
			P1 = SCREENMAN:GetTopScreen():GetChild('PlayerP1')
		end
		
		if P1 then
			P1xpos=P1:GetX();
			P1ypos=P1:GetY();
		end
		
		if SCREENMAN:GetTopScreen():GetChild('PlayerP2') then
			P2 = SCREENMAN:GetTopScreen():GetChild('PlayerP2')
		end
		
		if P2 then
			P2xpos=P2:GetX();
			P2ypos=P2:GetY();
		end
				
		screen = SCREENMAN:GetTopScreen();
		screen:stopeffect();
		screen:x(0);
		
		checked = true;
		
	end
	
	-- Collect all the mods that will be applied in this frame into one string.
	-- Mod tweening doesn't work correctly if the mods are in seperate commands.
	local mods_this_frame= {}
	local function add_mod(mod_str)
		mods_this_frame[#mods_this_frame+1]= mod_str
	end
	local function execute_mods()
		if #mods_this_frame <= 0 then return end
		local total_mod_str= ""
		for i, ms in ipairs(mods_this_frame) do
			if #total_mod_str > 0 then
				total_mod_str= total_mod_str .. ", "
			end
			total_mod_str= total_mod_str .. ms
		end
		song_mod(total_mod_str)
	end
			
	while curmod<= #mods and GAMESTATE:GetSongBeat()>=mods[curmod][1] do
		add_mod(mods[curmod][2])
		curmod = curmod+1
	end

	execute_mods()
	
	while curmessage<= #messages and GAMESTATE:GetSongBeat()>=messages[curmessage][1] do
		if messages[curmessage][3] and GAMESTATE:GetSongBeat()>=messages[curmessage][1]+5 then
			curmessage = curmessage+1;
		else
			MESSAGEMAN:Broadcast(messages[curmessage][2])
			curmessage = curmessage+1;
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
	Def.Quad{
		OnCommand= cmd(diffuse,0,0,0,1;diffusealpha,0;zoomto,6,SCREEN_HEIGHT;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y),
		
		ScreenRotateZ10MessageCommand= function(self)
			screen:rotationz(10);
		end,
		
		ScreenRotateZ0MessageCommand= function(self)
			screen:rotationz(0);
		end,
		
		ScreenShiftMessageCommand= function(self)
			screen:addx(-100);
		end,
		
		ScreenResetShiftMessageCommand= function(self)
			screen:addx(100);
		end,
		
		ScreenBobMessageCommand= function(self)
			screen:bob();
			screen:effectmagnitude(40,0,0);
			screen:effectperiod(1);
			screen:effectclock('beat');
		end,
		
		ScreenBoounceMessageCommand= function(self)
			screen:bounce();
			screen:effectmagnitude(0,-50,0);
			screen:effectperiod(1);
			screen:effectclock('beat');
		end,
		
		CompleteMessMessageCommand= function(self)
			SCREENMAN:SystemMessage('S E N D H E L P');
			screen:vibrate();
			screen:effectmagnitude(20,20,20);
						
			for i=1,2 do
				if ('P' .. i) then
					local pl = screen:GetLifeMeter('PlayerNumber_P' .. i);
					pl:spin();
					pl:effectperiod(1);
					pl:effectclock('beat');
				end
			end
			
		end,
		
		StopEverythingMessageCommand= function(self)
			screen:stopeffect();
			
			for i=1,2 do
				if ('P' .. i) then
					screen:GetLifeMeter('PlayerNumber_P' .. i):stopeffect();
				end
			end
			
		end,
		
		ScreenStopEffectMessageCommand= function(self)
			screen:stopeffect();
		end,
	},
	
}
