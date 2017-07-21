-- Template taken from Puurokulho's wndrwll: https://www.youtube.com/watch?v=KDWAGbwdA_w

local function song_mod_internal(str, pn)
	local ps= GAMESTATE:GetPlayerState(pn)
	local pmods= ps:GetPlayerOptionsString('ModsLevel_Song')
	ps:SetPlayerOptions('ModsLevel_Song', pmods .. ', ' .. str)
end


local function song_mod(str, pn)
	song_mod_internal(str, 'PlayerNumber_P' .. pn)
end

local function inject_speed_mods(init_speed, pn, mode)
	-- Set some default values in case we're playing the file in the editor
	if mode == 'editor' then
		init_speed = 2;
		pn = 1;
	end
	
	-- Here we add our player-tailored speed mods to the mod table.
	-- We can't use double-quotation characters, so we escape the apostrophe instead: \'
	-- What we want to do here is insert tables into mods[], with variable values.
	-- The first table below would for example be {204, ' *25 9x', 1}
	-- if player 1 has set their xmod to 2x
	mods[#mods+1] = {204, '\' *25 ' .. 4.5*init_speed .. 'x', pn}
	mods[#mods+1] = {204.875, '\' *64 ' .. init_speed .. 'x', pn}
	mods[#mods+1] = {212, '\' *25 ' .. 4.5*init_speed .. 'x', pn}
	mods[#mods+1] = {212.875, '\' *64 ' .. init_speed .. 'x', pn}
	mods[#mods+1] = {220, '\' *25 ' .. 4.5*init_speed .. 'x', pn}
	mods[#mods+1] = {220.875, '\' *64 ' .. init_speed .. 'x', pn}
end

local function song_init()
	max_players = 2;
	player_speed_type = {} -- This table stores the speed mod type the player chose. In this case, we only store it when someone chose XMod. Otherwise a dummy value is filled in. First entry is first player.
	init_player_speed = {} -- This table stores the value of the XMod that the player chose. Left as nil otherwise. First entry is first player.
	checked = false;
	
	-- timed mod management, curmod contains a counter for each player
	curmod = {}
	for pn=1,max_players do
		curmod[pn] = 1
	end
	
	-- {beat,mod,player}
	mods = {

		{19, '*1000 50% Stealth'},
		{19.125, '*1000 No Stealth'},
		{19.25, '*1000 50% Stealth'},
		{19.375, '*1000 No Stealth'},
		{19.5, '*1000 50% Stealth'},
		{19.625, '*1000 No Stealth'},
		{19.75, '*1000 50% Stealth'},
		{19.875, '*1000 No Stealth'},
		{64, '*1000 Stealth'},
		{64.5, '*0.9728 50% Stealth'},
		{66, '*2.9155 No Stealth'},
		{267, '*1000 50% Stealth'},
		{267.125, '*1000 No Stealth'},
		{267.25, '*1000 50% Stealth'},
		{267.375, '*1000 No Stealth'},
		{267.5, '*1000 50% Stealth'},
		{267.625, '*1000 No Stealth'},
		{267.75, '*1000 50% Stealth'},
		{267.875, '*1000 No Stealth'},

	}
	
end

local function song_update()

	if GAMESTATE:GetSongBeat()>=0.1 and not checked then
		-- Obtain initial speed settings of the players, then add speed mods to the mod table based on these initial speeds.
		-- Thanks to Jerros for sharing very useful code to make this easier!
		if SCREENMAN:GetTopScreen():GetChild('PlayerP1') or SCREENMAN:GetTopScreen():GetChild('PlayerP2') then
			-- SCREENMAN:SystemMessage('Game mode');
			for pn=1,max_players do
				if SCREENMAN:GetTopScreen():GetChild('PlayerP' .. pn) then
					local s = GAMESTATE:GetPlayerState(pn-1):GetPlayerOptionsString('ModsLevel_Song');
					local f = string.find(s,'x,');
					local speed = 1;
					if f then
						speed = tonumber(string.sub(s,1,f-1));
						player_speed_type[pn] = 'XMod';
					elseif string.sub(s,1,1) ~= 'C' and string.sub(s,1,1) ~= 'm' then
						-- If we got here, it means the player set 1x (which doesn't get explicitly mentioned in the PlayerOptions)
						-- Since the variable speed is set as 1 by default, we only need to fill in player_speed_type[] here.
						player_speed_type[pn] = 'XMod';
					end
					init_player_speed[pn] = speed;
													
					if player_speed_type[pn] == 'XMod' then
						inject_speed_mods(init_player_speed[pn], pn);
					end
				end
			end
		else
			-- If we end up here PlayerP1/2 returns nil, which probably means we're in the editor
			-- SCREENMAN:SystemMessage('SM5 editor mode');
			inject_speed_mods(init_player_speed[pn], pn, 'editor');
		end
		
		-- The mod reading code doesn't work correctly when the table is unsorted, so we sort them based on the beat here.
		local function compare(a,b)
			return a[1] < b[1]
		end
		table.sort(mods, compare);
		
		checked = true;
		
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
