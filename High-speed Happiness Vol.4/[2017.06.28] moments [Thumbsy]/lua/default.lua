-- Template based on Puurokulho's wndrwll: https://www.youtube.com/watch?v=KDWAGbwdA_w
-- Template last updated on 2017.09.25

local function song_mod_internal(str, pn)
	local ps= GAMESTATE:GetPlayerState(pn)
	local pmods= ps:GetPlayerOptionsString('ModsLevel_Song')
	ps:SetPlayerOptions('ModsLevel_Song', pmods .. ', ' .. str)
end


local function song_mod(str, pn)
	song_mod_internal(str, 'PlayerNumber_P' .. pn)
end

local function moments_inject_speed_mods()
	local prev_player_speed = {} -- We need to remember the 'old' speed when we want to calculate the stuff for the new speed, so we save the 'old' speed for each player in this array.
	
	-- This function is used to retrieve the index of a specific player in the moments_enabled_players_no array. We need this for speed mods that target specific players.
	local function get_pn_index(pn)
		for index, value in ipairs(moments_enabled_players_no) do
			if value == pn then
				return index
			end
		end

		return false
	end
			
	-- In the beginning, the 'old' speed is of course the speed that the player starts with.
	for i=1,moments_amount_enabled_players do
		prev_player_speed[i] = moments_player_init_speeds[i][3]
	end
	
	
	
	-- ============================================================================================================
	-- The following functions are used to add tables in the mod table that will apply the speed mods to players.
	-- We can't use double-quotation characters, so we escape the apostrophe instead.
	
	-- Tween timing of speed mods works as follows. Starting with XMod as an example, a transition rate of *1 means that the tween is applied with a speed of -/+1x in one second.
	-- So if for example we would like the notes to go from 1x to 2x in half a second, you would only have to put '*2 2x'. If you want it to go from 1x to 3x in half a second, you'd put '*4 2x'. Etcetera.
	-- For CMod it's a bit confusing. Timing-wise, you need to treat it as if it were XMod. So you'll have to convert your CMod values to the XMod equivalent first to get your timing right.
	-- Let's say we have a song with a tempo of 200 BPM, and the player has set their speed to C300. We want the notes to tween from C300 to C500 in half a second. This would be the equivalent of tweening from 1.5x to 2.5x
	-- (a difference of 1x). Thus, what we would put is '*2 C500'.
	-- Finally MMod. Tween timing with MMod is completely different. With MMod, a transition rate of *1 means that the MMod value will de-/increment with -/+1 in one second.
	-- Thus, if the player has set m300 and you want it to go to m500 in half a second, you'd put '*400 m500'. Just like with XMod, you won't need to take the song's tempo into account (yay).
	
	-- If we want our speed mod tweens to be in time to the beat, we need to calculate what I call the 'base rate', since the transition rates are based on time and not beats.
	-- We do this by dividing 1 by the amount of time (in seconds) you want the transition to take.
	-- But that's only half of the required calculations, as the above examples have already shown. The amount of change that needs to be made from the current value to the next value will also determine the final transition rate.
	-- ============================================================================================================
	
	
	
	-- Apply a speed mod with a specific value to the player(s). tween_time in seconds. scroll_speed is expressed in BPM at 1x. A specific player can be targeted with pn (optional).
	local function add_speed_mod_absolute(beat, tween_time, scroll_speed, pn)
		local base_rate = 1 / tween_time
		local xrate = scroll_speed / moments_bpm
		local xrate_diff
		local scroll_diff
		local index
		
		if pn then
			if SCREENMAN:GetTopScreen():GetChild('PlayerP' .. pn) then
				index = get_pn_index(pn)
				
				if moments_player_init_speeds[index][2] == 'x' then
					xrate_diff = math.abs(xrate - prev_player_speed[index])
					moments_mods[#moments_mods+1] = {beat, '\' *' .. base_rate * xrate_diff .. ' ' .. xrate .. 'x', pn}
					prev_player_speed[index] = xrate
				elseif moments_player_init_speeds[index][2] == 'C' then
					scroll_diff = math.abs(scroll_speed - prev_player_speed[index])
					moments_mods[#moments_mods+1] = {beat, '\' *' .. (base_rate * scroll_diff) / moments_bpm .. ' ' .. 'C' .. scroll_speed, pn}
					prev_player_speed[index] = scroll_speed
				elseif moments_player_init_speeds[index][2] == 'm' then
					scroll_diff = math.abs(scroll_speed - prev_player_speed[index])
					moments_mods[#moments_mods+1] = {beat, '\' *' .. base_rate * scroll_diff .. ' ' .. 'm' .. scroll_speed, pn}
					prev_player_speed[index] = scroll_speed
				else
					-- We shouldn't be ending up here, if we do, something went wrong.
					SCREENMAN:SystemMessage('[ERROR] No valid speed type detected for Player ' .. pn)
				end
			end
		else
			for i,v in pairs(moments_player_init_speeds) do
				if v[2] == 'x' then
					xrate_diff = math.abs(xrate - prev_player_speed[i])
					moments_mods[#moments_mods+1] = {beat, '\' *' .. base_rate * xrate_diff .. ' ' .. xrate .. 'x', v[1]}
					prev_player_speed[i] = xrate
				elseif v[2] == 'C' then
					scroll_diff = math.abs(scroll_speed - prev_player_speed[i])
					moments_mods[#moments_mods+1] = {beat, '\' *' .. (base_rate * scroll_diff) / moments_bpm .. ' ' .. 'C' .. scroll_speed, v[1]}
					prev_player_speed[i] = scroll_speed
				elseif v[2] == 'm' then
					scroll_diff = math.abs(scroll_speed - prev_player_speed[i])
					moments_mods[#moments_mods+1] = {beat, '\' *' .. base_rate * scroll_diff .. ' ' .. 'm' .. scroll_speed, v[1]}
					prev_player_speed[i] = scroll_speed
				else
					-- We shouldn't be ending up here, if we do, something went wrong.
					SCREENMAN:SystemMessage('[ERROR] No valid speed type detected for Player ' .. v[1])
				end
			end
		end
	end
	
	-- Apply speed mod to the player(s) that is a multiple of their own chosen speed. tween_time in seconds. A specific player can be targeted with pn (optional).
	local function add_speed_mod_relative(beat, tween_time, multiplier, pn)
		local base_rate = 1 / tween_time
		local speed
		local speed_diff
		local index
		
		if pn then
			if SCREENMAN:GetTopScreen():GetChild('PlayerP' .. pn) then
				index = get_pn_index(pn)
				speed = multiplier * moments_player_init_speeds[index][3]
				speed_diff = math.abs(speed - prev_player_speed[index])
				
				if moments_player_init_speeds[index][2] == 'x' then
					moments_mods[#moments_mods+1] = {beat, '\' *' .. base_rate * speed_diff .. ' ' .. speed .. 'x', pn}
					prev_player_speed[index] = speed
				elseif moments_player_init_speeds[index][2] == 'C' then
					moments_mods[#moments_mods+1] = {beat, '\' *' .. (base_rate * speed_diff) / moments_bpm .. ' ' .. 'C' .. speed, pn}
					prev_player_speed[index] = speed
				elseif moments_player_init_speeds[index][2] == 'm' then
					moments_mods[#moments_mods+1] = {beat, '\' *' .. base_rate * speed_diff .. ' ' .. 'm' .. speed, pn}
					prev_player_speed[index] = speed
				else
					-- We shouldn't be ending up here, if we do, something went wrong.
					SCREENMAN:SystemMessage('[ERROR] No valid speed type detected for Player ' .. pn)
				end
			end
		else
			for i,v in pairs(moments_player_init_speeds) do
				speed = multiplier * v[3]
				speed_diff = math.abs(speed - prev_player_speed[i])
				
				if v[2] == 'x' then
					moments_mods[#moments_mods+1] = {beat, '\' *' .. base_rate * speed_diff .. ' ' .. speed .. 'x', v[1]}
					prev_player_speed[i] = speed
				elseif v[2] == 'C' then
					moments_mods[#moments_mods+1] = {beat, '\' *' .. (base_rate * speed_diff) / moments_bpm .. ' ' .. 'C' .. speed, v[1]}
					prev_player_speed[i] = speed
				elseif v[2] == 'm' then
					moments_mods[#moments_mods+1] = {beat, '\' *' .. base_rate * speed_diff .. ' ' .. 'm' .. speed, v[1]}
					prev_player_speed[i] = speed
				else
					-- We shouldn't be ending up here, if we do, something went wrong.
					SCREENMAN:SystemMessage('[ERROR] No valid speed type detected for Player ' .. v[1])
				end
			end
		end
	end
	
	-- Derived function for the 'breathing' effect, allowing you to easily add a effect where the notes compress/decompress from/to the previous speed before the function was called.
	-- The going back and forth happens symmetrically in time (in other words, it takes as long for the new speed to be applied as it takes for it to be undone).
	local function linear_breathing(beat, undo_after, tween_time, multiplier, pn)
		local base_rate = 1 / tween_time
		local speed
		local speed_diff
		local index
		
		if pn then
			if SCREENMAN:GetTopScreen():GetChild('PlayerP' .. pn) then
				index = get_pn_index(pn)
				speed = multiplier * prev_player_speed[index]
				speed_diff = math.abs(speed - prev_player_speed[index])
				
				if moments_player_init_speeds[index][2] == 'x' then
					moments_mods[#moments_mods+1] = {beat, '\' *' .. base_rate * speed_diff .. ' ' .. speed .. 'x', pn}
					moments_mods[#moments_mods+1] = {beat+undo_after, '\' *' .. base_rate * speed_diff .. ' ' .. prev_player_speed[index] .. 'x', pn}
				elseif moments_player_init_speeds[index][2] == 'C' then
					moments_mods[#moments_mods+1] = {beat, '\' *' .. (base_rate * speed_diff) / moments_bpm .. ' ' .. 'C' .. speed, pn}
					moments_mods[#moments_mods+1] = {beat+undo_after, '\' *' .. (base_rate * speed_diff) / moments_bpm .. ' ' .. 'C' .. prev_player_speed[index], pn}
				elseif moments_player_init_speeds[index][2] == 'm' then
					moments_mods[#moments_mods+1] = {beat, '\' *' .. base_rate * speed_diff .. ' ' .. 'm' .. speed, pn}
					moments_mods[#moments_mods+1] = {beat+undo_after, '\' *' .. base_rate * speed_diff .. ' ' .. 'm' .. prev_player_speed[index], pn}
				else
					-- We shouldn't be ending up here, if we do, something went wrong.
					SCREENMAN:SystemMessage('[ERROR] No valid speed type detected for Player ' .. pn)
				end
			end
		else
			for i,v in pairs(moments_player_init_speeds) do
				speed = multiplier * prev_player_speed[i]
				speed_diff = math.abs(speed - prev_player_speed[i])
				
				if v[2] == 'x' then
					moments_mods[#moments_mods+1] = {beat, '\' *' .. base_rate * speed_diff .. ' ' .. speed .. 'x', v[1]}
					moments_mods[#moments_mods+1] = {beat+undo_after, '\' *' .. base_rate * speed_diff .. ' ' .. prev_player_speed[i] .. 'x', v[1]}
				elseif v[2] == 'C' then
					moments_mods[#moments_mods+1] = {beat, '\' *' .. (base_rate * speed_diff) / moments_bpm .. ' ' .. 'C' .. speed, v[1]}
					moments_mods[#moments_mods+1] = {beat+undo_after, '\' *' .. (base_rate * speed_diff) / moments_bpm .. ' ' .. 'C' .. prev_player_speed[i], v[1]}
				elseif v[2] == 'm' then
					moments_mods[#moments_mods+1] = {beat, '\' *' .. base_rate * speed_diff .. ' ' .. 'm' .. speed, v[1]}
					moments_mods[#moments_mods+1] = {beat+undo_after, '\' *' .. base_rate * speed_diff .. ' ' .. 'm' .. prev_player_speed[i], v[1]}
				else
					-- We shouldn't be ending up here, if we do, something went wrong.
					SCREENMAN:SystemMessage('[ERROR] No valid speed type detected for Player ' .. v[1])
				end
			end
		end
	end
	
	----------------------------------
	-- Insert your speed mods below --
	----------------------------------
	add_speed_mod_relative(204, 0.257, 4.5)
	add_speed_mod_relative(204.75, 0.086, 1)
	add_speed_mod_relative(212, 0.257, 4.5)
	add_speed_mod_relative(212.75, 0.086, 1)
	add_speed_mod_relative(220, 0.257, 4.5)
	add_speed_mod_relative(220.75, 0.086, 1)
	
end

local function song_init()
	moments_max_players = 32	-- The maximum amount of players that could practically be expected
	moments_enabled_players = {}	-- This table will contain the currently enabled players (the actual children)
	moments_enabled_players_no = {}	-- This table will contain the currently enabled players (just the player numbers, stored as integers)
	moments_amount_enabled_players = 0
	moments_player_init_speeds = {} -- moments_player_init_speeds is a table containing tables of the following format: {player_no, speed_type, init_value}
	moments_bpm = 175
	
	-- Timed mod management, curmod contains a counter for each player
	curmod = {}

	-- {beat, mod, player (optional)}
	moments_mods = {
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

	checked = false;
end

local function song_update()
	local beat = GAMESTATE:GetSongBeat()

	if beat >= 0 and not checked then
	
		local en_plrs_index = 1
		for i=1,moments_max_players do
			if SCREENMAN:GetTopScreen():GetChild('PlayerP' .. i) then
				moments_enabled_players[en_plrs_index] = SCREENMAN:GetTopScreen():GetChild('PlayerP' .. i)
				moments_enabled_players_no[en_plrs_index] = i
				en_plrs_index = en_plrs_index + 1
			end
		end
		
		if #moments_enabled_players < 1 then
			moments_amount_enabled_players = 1
		else
			moments_amount_enabled_players = #moments_enabled_players
		end
		
		for plr=1,moments_amount_enabled_players do
			curmod[plr] = 1
		end
		
		-- Obtain initial speed settings of the players, then add speed mods to the mod table based on these initial speeds. During normal game mode, either P1 or P2 are assumed to be present.
		-- Thanks to Jerros for sharing very useful code to make this easier!
		if SCREENMAN:GetTopScreen():GetChild('PlayerP1') or SCREENMAN:GetTopScreen():GetChild('PlayerP2') then
			-- SCREENMAN:SystemMessage('Game mode')
			for pn=1,moments_amount_enabled_players do
				local s = GAMESTATE:GetPlayerState('PlayerNumber_P' .. moments_enabled_players_no[pn]):GetPlayerOptionsString('ModsLevel_Song')
				local f = string.find(s,'x,')
				moments_player_init_speeds[pn] = {moments_enabled_players_no[pn], nil, 1}
				if f then
					-- Player set XMod.
					moments_player_init_speeds[pn][3] = tonumber(string.sub(s,1,f-1))
					moments_player_init_speeds[pn][2] = 'x'
				elseif string.sub(s,1,1) == 'C' then
					-- Player set CMod.
					local len = string.find(s,',')-1
					moments_player_init_speeds[pn][3] = tonumber(string.sub(s,2,len))
					moments_player_init_speeds[pn][2] = 'C'
				elseif string.sub(s,1,1) == 'm' then
					-- Player set mMod.
					local len = string.find(s,',')-1
					moments_player_init_speeds[pn][3] = tonumber(string.sub(s,2,len))
					moments_player_init_speeds[pn][2] = 'm'
				end
			end
			
			moments_inject_speed_mods()
		else
			-- If we end up here, the PlayerP1/2 children don't exist, which probably means we're in the editor
			-- SCREENMAN:SystemMessage('SM5 editor mode')
			moments_enabled_players_no = {1}
			moments_player_init_speeds[1] = {1, 'x', 2.5}
			moments_inject_speed_mods()
		end
		
		-- The mod reading code doesn't work correctly when the table is unsorted, so we sort them based on the beat here.
		local function compare(a,b)
			return a[1] < b[1]
		end
		table.sort(moments_mods, compare)
		
		checked = true
	end
	
	-- Collect all the mods that will be applied in this frame into one string.
	-- Mod tweening doesn't work correctly if the mods are in seperate commands.
	-- Edited so that it supports mods assigned to specific players. It loops through the whole mod reading code for each player and then sends the data to the functions seen at the top of the file, for each player separately. Probably a bit messy and unoptimized, but it does the trick.
	for plr=1,moments_amount_enabled_players do
		
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
		while curmod[plr]<= #moments_mods and beat>=moments_mods[curmod[plr]][1] do
			if moments_mods[curmod[plr]][3] then
				if moments_enabled_players_no[plr] == moments_mods[curmod[plr]][3] then
					add_mod(moments_mods[curmod[plr]][2])
					curmod[plr] = curmod[plr]+1
				else
					curmod[plr] = curmod[plr]+1
				end
			else
				add_mod(moments_mods[curmod[plr]][2])
				curmod[plr] = curmod[plr]+1
			end			
		end

		execute_mods(moments_enabled_players_no[plr])
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
