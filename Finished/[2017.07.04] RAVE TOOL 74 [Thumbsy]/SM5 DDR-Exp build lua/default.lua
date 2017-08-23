-- WARNING: SPECIAL HOTFIX FOR DDR-EXP'S SM5 BUILD. SUPPORT FOR MMOD ONLY.
-- Based on template taken from Puurokulho's wndrwll: https://www.youtube.com/watch?v=KDWAGbwdA_w

local function song_mod_internal(str, pn)
	local ps= GAMESTATE:GetPlayerState(pn)
	local pmods= ps:GetPlayerOptionsString('ModsLevel_Song')
	ps:SetPlayerOptions('ModsLevel_Song', pmods .. ', ' .. str)
end


local function song_mod(str, pn)
	song_mod_internal(str, 'PlayerNumber_P' .. pn)
end

local function inject_speed_mods(init_speed, pn, mode)
	-- Set some default values in case we're playing the file in the editor. Make sure to have the speed setting in the editor match this default value.
	if mode == 'editor' then
		init_speed = 450
	end
	
	-- Quick little function I threw together to make the 'breathing' effect, allowing you to easily add a effect where the notes compress/decompress from/to init_speed.
	-- The going back and forth both happen in equal amounts of time (in other words, half the total time it takes for the effect to be applied and undone).
	-- 'beat' is the beat at which the effect starts, 'undo_after' the amount of beats after which the reversing starts, 'base_rate' is the base rate (lol), 'muliplier' is the factor we multiply the speed with.
	local function linear_breathing(beat, undo_after, base_rate, multiplier)
		mods[#mods+1] = {beat, '\' *' .. base_rate*(math.abs(multiplier*init_speed - init_speed)) .. ' ' .. 'm' .. multiplier*init_speed, pn}
		mods[#mods+1] = {beat+undo_after, '\' *' .. base_rate*(math.abs(multiplier*init_speed - init_speed)) .. ' ' .. 'm' .. init_speed, pn}
	end
	
	-- ============================================================================================================
	-- Here we add our player-tailored speed mods to the mod table.
	-- We can't use double-quotation characters, so we escape the apostrophe instead.
	-- What we want to do here is insert tables into mods[], with variable values.
	-- The format of these tables is as seen in the mods[] table.
	
	-- If we want our speed mod tweens to be in time to the beat, we need to calculate what I call the 'base rate'.
	-- We do this by dividing 1 by the amount of time (in seconds) you want the transition to take.
	-- ============================================================================================================
	
	mods[#mods+1] = {99.75, '\' *' .. math.abs(init_speed-0.75*bpm)*1.148 .. ' ' .. 'm' .. 0.75*bpm, pn}
	mods[#mods+1] = {102, '\' *' .. math.abs(init_speed-0.75*bpm)*1.292 .. ' ' .. 'm' .. init_speed, pn}
	
	-- -- Let me see you bounce!
	linear_breathing(104, 0.125, 10.417, 1.5)
	linear_breathing(104.75, 0.125, 10.417, 1.5)
	linear_breathing(105.5, 0.125, 10.417, 1.5)
	linear_breathing(106, 0.125, 10.417, 1.5)
	linear_breathing(106.75, 0.125, 10.417, 1.5)
	linear_breathing(107.5, 0.125, 10.417, 1.5)
	linear_breathing(108, 0.125, 10.417, 1.5)
	linear_breathing(108.75, 0.125, 10.417, 1.5)
	linear_breathing(109.5, 0.125, 10.417, 1.5)
	linear_breathing(110, 0.125, 10.417, 1.5)
	linear_breathing(110.75, 0.125, 10.417, 1.5)
	linear_breathing(111.5, 0.125, 10.417, 1.5)
	linear_breathing(112, 0.125, 10.417, 1.5)
	linear_breathing(112.75, 0.125, 10.417, 1.5)
	linear_breathing(113.5, 0.125, 10.417, 1.5)
	linear_breathing(114, 0.125, 10.417, 1.5)
	linear_breathing(114.75, 0.125, 10.417, 1.5)
	linear_breathing(115.5, 0.125, 10.417, 1.5)
	linear_breathing(116, 0.125, 10.417, 1.5)
	linear_breathing(116.75, 0.125, 10.417, 1.5)
	linear_breathing(117.5, 0.125, 10.417, 1.5)
	
	-- -- Yes sorry that was kind of mean. But it fits the music well, right?
	mods[#mods+1] = {119.5, '\' *' .. 740000 .. ' ' .. 'm' .. init_speed, pn}
	
	-- -- Itchy glitchy~
	mods[#mods+1] = {192.25, '\' *' .. 740000 .. ' ' .. 'm' .. init_speed, pn}
	linear_breathing(196.5, 0.0625, 40, 1.5)
	linear_breathing(196.625, 0.0625, 40, 1.5)
	linear_breathing(196.75, 0.0625, 40, 1.5)
	linear_breathing(196.875, 0.0625, 40, 1.5)
	linear_breathing(198.167, 0.083, 15.385, 2)
	linear_breathing(198.333, 0.083, 15.385, 2)
	linear_breathing(198.5, 0.083, 15.385, 2)
	linear_breathing(198.667, 0.083, 15.385, 2)
	
	-- -- Yes you can have your speed back
	mods[#mods+1] = {209, '\' *' .. 5.181*(init_speed - 0.25*init_speed) .. ' ' .. 'm' .. 0.25*init_speed, pn}
	mods[#mods+1] = {215, '\' *' .. 10.362*(init_speed - 0.5*init_speed) .. ' ' .. 'm' .. 0.75*init_speed, pn}
	mods[#mods+1] = {215.25, '\' *' .. 10.362*(init_speed - 0.25*init_speed) .. ' ' .. 'm' .. 0.5*init_speed, pn}
	mods[#mods+1] = {215.5, '\' *' .. 10.362*(init_speed - 0.75*init_speed) .. ' ' .. 'm' .. 1.25*init_speed, pn}
	mods[#mods+1] = {215.75, '\' *' .. 10.362*(init_speed - 0.25*init_speed) .. ' ' .. 'm' .. init_speed, pn}
	
	mods[#mods+1] = {228, '\' *' .. math.abs(init_speed-0.5*bpm)*0.861 .. ' ' .. 'm' .. 0.5*bpm, pn}
	mods[#mods+1] = {231, '\' *' .. math.abs(init_speed-0.5*bpm)*5.155 .. ' ' .. 'm' .. init_speed, pn}
end

local function song_init()
	max_players = 2
	init_player_speed = {} -- This table stores the value of the XMod that the player chose. Left as nil otherwise. First entry is first player.
	bpm = 155
	checked = false
	
	-- Timed mod management, curmod contains a counter for each player
	curmod = {}
	for pn=1,max_players do
		curmod[pn] = 1
	end
	
	-- {beat,mod,player}
	-- The mods here are independent of the players' options and meant to be applied to everyone
	mods = {

		{119, '*740000 m7400'},
		{192, '*740000 m77.5'},

	}
	
end

local function song_update()

	if GAMESTATE:GetSongBeat()>=0.1 and not checked then
		-- Obtain initial speed settings of the players, then add speed mods to the mod table based on these initial speeds.
		-- Thanks to Jerros for sharing very useful code to make this easier!
		if SCREENMAN:GetTopScreen():GetChild('PlayerP1') or SCREENMAN:GetTopScreen():GetChild('PlayerP2') then
			-- SCREENMAN:SystemMessage('Game mode')
			for pn=1,max_players do
				if SCREENMAN:GetTopScreen():GetChild('PlayerP' .. pn) then
					local s = GAMESTATE:GetPlayerState('PlayerNumber_P' .. pn):GetPlayerOptionsString('ModsLevel_Song')
					local f = string.find(s,'x,')
					local speed = 1
					if f then
						speed = tonumber(string.sub(s,1,f-1))
					elseif string.sub(s,1,1) == 'C' then
						-- Player set CMod. Read out their speed setting and convert it to the right XMod rate.
						local len = string.find(s,',')-1
						speed = tonumber(string.sub(s,2,len))/bpm
						
					elseif string.sub(s,1,1) == 'm' then
						-- Player set mMod. Time for some experimenting
						local len = string.find(s,',')-1
						speed = tonumber(string.sub(s,2,len))
					end
					
					init_player_speed[pn] = speed
					inject_speed_mods(init_player_speed[pn], pn)
				end
			end
		else
			-- If we end up here PlayerP1/2 returns nil, which probably means we're in the editor
			-- SCREENMAN:SystemMessage('SM5 editor mode')
			inject_speed_mods(init_player_speed[pn], pn, 'editor')
		end
		
		-- The mod reading code doesn't work correctly when the table is unsorted, so we sort them based on the beat here.
		local function compare(a,b)
			return a[1] < b[1]
		end
		table.sort(mods, compare)
		
		checked = true
		
	end
	
	local beat = GAMESTATE:GetSongBeat()
	
	-- Collect all the mods that will be applied in this frame into one string.
	-- Mod tweening doesn't work correctly if the mods are in seperate commands.
	-- Edited so that it supports mods assigned to specific players. It loops through the whole mod reading code for each player and then sends the data to the functions seen at the top of the file, for each player separately. Probably a bit messy and unoptimized, but it does the trick.
	for pn=1,max_players do
		
		local mods_this_frame = {}
		-- add_mod() stores all the mods that need to be applied to the player (corresponding to the current iteration of the for loop), it receives the mods from the while loop below
		local function add_mod(mod_str)
			mods_this_frame[#mods_this_frame+1]= mod_str
		end
		-- execute_mods() walks through mods_this_frame[] and concatenates all the different mods to be applied in this frame for the player, into one string. This string is then passed to song_mod()
		local function execute_mods(pn)
			if #mods_this_frame <= 0 then return end
			local total_mod_str= ""
			for i, ms in ipairs(mods_this_frame) do
				if #total_mod_str > 0 then
					total_mod_str= total_mod_str .. ", "
				end
				total_mod_str= total_mod_str .. ms
			end
			song_mod(total_mod_str, pn)
		end
		
		-- Go through the mod table and check what mods need to be applied this frame.
		-- If there is a specific player assigned to the mod and it matches the current iteration, add it to the mod string. Otherwise do nothing (except for increasing the counter).
		-- If there is no player specified, add it to the mod string since the mod is meant for all players.
		while curmod[pn]<= #mods and GAMESTATE:GetSongBeat()>=mods[curmod[pn]][1] do
			if mods[curmod[pn]][3] then
				if pn == mods[curmod[pn]][3] then
					add_mod(mods[curmod[pn]][2])
					curmod[pn] = curmod[pn]+1
				else
					curmod[pn] = curmod[pn]+1
				end
			else
				add_mod(mods[curmod[pn]][2])
				curmod[pn] = curmod[pn]+1
			end			
		end

		execute_mods(pn)
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
