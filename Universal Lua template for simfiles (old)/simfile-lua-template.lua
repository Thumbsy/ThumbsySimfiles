-- Template based on Puurokulho's wndrwll: https://www.youtube.com/watch?v=KDWAGbwdA_w
-- Template last updated on 2017.09.25

local function song_init()
	checked = false;
end

local function song_update()
	local beat = GAMESTATE:GetSongBeat()

	if beat >= 0 and not checked then
		
		
		checked = true
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
