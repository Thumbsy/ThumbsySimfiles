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
	fgcurcommand = 0
	checked = false
	
	
	
	-- timed mod management	
	curmod = 1
	-- {beat,mod,player}
	mods = {
		{234, '*20 -200% Mini'},
	}	
end

local function song_update()

	if GAMESTATE:GetSongBeat()>=0.1 and not checked then
					
		screen = SCREENMAN:GetTopScreen()
		
		checked = true
	end
	
	local beat = GAMESTATE:GetSongBeat()

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
	
	if beat >= 234.000 then
		MESSAGEMAN:Broadcast('Pwoap')
	end
	
	if beat >= 234.667 then
		MESSAGEMAN:Broadcast('BlackOut')
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
	
	Def.Sprite{
		Name="Shocked dj TAKA",
		Texture="mfw.png",
		OnCommand=function(self)
			self:diffusealpha(0)
				:Center()
				:zoom(1)
		end,
		PwoapMessageCommand=function(self)
			self:diffusealpha(1)
		end,
	},
	
	Def.Quad{
		Name="Blackout",
		OnCommand=function(self)
			self:FullScreen()
				:diffuse(Color.Black)
				:diffusealpha(0)
		end,
		BlackOutMessageCommand=function(self)
			self:diffusealpha(1)
		end,
	},
}