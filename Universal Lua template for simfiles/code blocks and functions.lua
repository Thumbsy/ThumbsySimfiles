-- This is basically a giant dump where I leave code snippets and bits that can be used in the templates.
-- Last updated on 2017.09.27



-- ===============================================================
-- ===============================================================
-- === DETECTION AND MANIPULATION OF CURRENTLY ENABLED PLAYERS ===
-- ===============================================================
-- ===============================================================
-- With this you can use easily get and manipulate players in a fairly efficient way. Depending on what you want to achieve with your script, you might not need the bits related to prefix_enabled_players or prefix_enabled_players_no.

-- Add this to OnCommand / song_init():
	prefix_max_players = 32	-- The maximum amount of players that could practically be expected
	prefix_enabled_players = {}	-- This table will contain the currently enabled players (the actual children)
	prefix_enabled_players_no = {}	-- This table will contain the currently enabled players (just the player numbers, stored as integers)
	prefix_amount_enabled_players = 0

-- Add this to the initialization if-statement inside UpdateCommand / song_update()
	-- Save all currently enabled players in the table prefix_enabled_players
	local en_plrs_index = 1
	for i=1,prefix_max_players do
		if SCREENMAN:GetTopScreen():GetChild('PlayerP' .. i) then
			prefix_enabled_players[en_plrs_index] = SCREENMAN:GetTopScreen():GetChild('PlayerP' .. i)
			prefix_enabled_players_no[en_plrs_index] = i
			en_plrs_index = en_plrs_index + 1
		end
	end
	
	if #prefix_enabled_players < 1 then
		prefix_amount_enabled_players = 1
	else
		prefix_amount_enabled_players = #prefix_enabled_players
	end
	
	for plr=1,prefix_amount_enabled_players do
		curmod[plr] = 1
	end

-- You can then use something like this to apply effects to all players (vibrate as an example)
	for i,v in pairs(prefix_enabled_players) do
		if v then
			v:vibrate()
			v:effectmagnitude(30,30,0)
		end
	end

-- If instead you just need the player numbers of the currently present players, you can use this (example to spin the life bars)
	for i,v in pairs(prefix_enabled_players_no) do
		if SCREENMAN:GetTopScreen():GetChild('PlayerP' .. v) then
			local pl = screen:GetLifeMeter('PlayerNumber_P' .. v)
			pl:spin()
			pl:effectperiod(1)
			pl:effectclock('beat')
		end
	end



-- =====================================
-- =====================================
-- === Timed mod attacks for players ===
-- =====================================
-- =====================================
-- With a couple of functions, a table and a loop, you'll be able to apply mods to the players (globally as well as individually). Timing is beat-based. This requires the player-detection script.

-- In case of .lua, add this at the top of the file
	local function song_mod_internal(str, pn)
		local ps= GAMESTATE:GetPlayerState(pn)
		local pmods= ps:GetPlayerOptionsString('ModsLevel_Song')
		ps:SetPlayerOptions('ModsLevel_Song', pmods .. ', ' .. str)
	end


	local function song_mod(str, pn)
		song_mod_internal(str, 'PlayerNumber_P' .. pn)
	end

-- In case of .lua, add this to song_init()
	-- Timed mod management, curmod contains a counter for each player
	curmod = {}

	-- {beat, mod, player (optional)}
	prefix_mods = {
		-- Put your mods here
	}

-- In case of .xml, add this to OnCommand
	-- {beat, mod, player (optional)}
	prefix_mods = {
		-- Put your mods here
	}

-- In case of .lua, add this to song_update()
	-- Collect all the mods that will be applied in this frame into one string.
	-- Mod tweening doesn't work correctly if the mods are in seperate commands.
	-- Edited so that it supports mods assigned to specific players. It loops through the whole mod reading code for each player and then sends the data to the functions seen at the top of the file, for each player separately. Probably a bit messy and unoptimized, but it does the trick.
	for plr=1,prefix_amount_enabled_players do
		
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
		while curmod[plr]<= #prefix_mods and beat>=prefix_mods[curmod[plr]][1] do
			if prefix_mods[curmod[plr]][3] then
				if prefix_enabled_players_no[plr] == prefix_mods[curmod[plr]][3] then
					add_mod(prefix_mods[curmod[plr]][2])
					curmod[plr] = curmod[plr]+1
				else
					curmod[plr] = curmod[plr]+1
				end
			else
				add_mod(prefix_mods[curmod[plr]][2])
				curmod[plr] = curmod[plr]+1
			end			
		end

		execute_mods(prefix_enabled_players_no[plr])
	end

-- In case of .xml, add this to UpdateCommand
	----------------------------------------------------------
	-- Mod reader code, beat-based and oITG editor friendly --
	----------------------------------------------------------
	-- Small edit on WinDEU's take on the code originally by TaroNuke
	-- Loop through the tables in prefix_mods[], first checking the first element of the table (which holds the beat value).
	-- If the mod needs to be applied, check whether the table holds three values (which indicates the mod being targeted at a specific player).
	-- The mod is then applied, either for a specific player or for both.
	for i,v in pairs(prefix_mods) do
		if beat >= v[1] and (beat-v[1]) < 1 then
			if table.getn(v) == 3 then
				GAMESTATE:ApplyGameCommand('mod,'..v[2],v[3])
			else
				GAMESTATE:ApplyGameCommand('mod,'..v[2])
			end
		end
	end



-- ===================================================================
-- ===================================================================
-- === CODE THAT NEEDS TO BE RUN CONTINUOUSLY FOR A CERTAIN PERIOD ===
-- ===================================================================
-- ===================================================================
-- Anything that needs to be run continuously between beats x and y
	
-- Add this anywhere inside of UpdateCommand / song_update() as long as it's after the 'local beat = GAMESTATE:GetSongBeat()' line. Replace x and y with the desired values.
	if beat > x and beat < y then
		-- Your code here
	end



-- =================================================================================
-- =================================================================================
-- === REUSABLE CODE THAT NEEDS TO BE RUN ONCE AFTER PASSING THE DESIGNATED BEAT ===
-- =================================================================================
-- =================================================================================
-- This allows you to for example apply animations to the screen or player fields starting at a specific beat

-- Add this to OnCommand / song_init()
	prefix_curmessage = 1;
	-- {beat, name of message, ignoreIfAhead}
	prefix_messages = {
		{99.5, 'YourMessageNameHere_'},
		{125, 'AnotherMessageName_'},
	}

-- Add this to UpdateCommand / song_update()
	while prefix_curmessage<= #prefix_messages and GAMESTATE:GetSongBeat()>=prefix_messages[prefix_curmessage][1] do
		if prefix_messages[prefix_curmessage][3] and GAMESTATE:GetSongBeat()>=prefix_messages[prefix_curmessage][1]+5 then
			prefix_curmessage = prefix_curmessage+1;
		else
			MESSAGEMAN:Broadcast(prefix_messages[prefix_curmessage][2])
			prefix_curmessage = prefix_curmessage+1;
		end
	end

-- In case of .lua, add the following inside the ActorFrame
	Def.Quad{
		OnCommand= cmd(diffuse,0,0,0,1;diffusealpha,0;zoomto,6,SCREEN_HEIGHT;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y),
		
		YourMessageNameHere_MessageCommand= function(self)
			-- Add your code here
		end,
		AnotherMessageName_MessageCommand= function(self)
			-- Add your code here
		end,
	},

-- In case of .xml, add the following at the bottom inside of the ActorFrame
	<Layer
		Type="Quad"
		InitCommand="%function(self) self:hidden(1) end"
		YourMessageNameHere_MessageCommand="%function(self)
			-- Your code here
		end"
		AnotherMessageName_MessageCommand="%function(self)
			-- Your code here
		end"
	/>



-- =======================================================================
-- =======================================================================
-- === OBTAINING AND STORING PLAYERS' INITIAL SPEED MOD TYPE AND VALUE ===
-- =======================================================================
-- =======================================================================
-- This bit of script reads out the speed mod for all present players and saves it in a table. Useful for example for applying per-player-tailored speed mods. In fact, in its current state the script already assumes you're going to do that since the call to prefix_inject_speed_mods() is already in there. You can remove it if you don't need it.

-- Add this to OnCommand / song_init()
	prefix_player_init_speeds = {} -- prefix_player_init_speeds is a table containing tables of the following format: {player_no, speed_type, init_value}

-- In case of .lua, add this to the initialization if-statement inside song_update()
	-- Obtain initial speed settings of the players, then add speed mods to the mod table based on these initial speeds. During normal game mode, either P1 or P2 are assumed to be present.
	-- Thanks to Jerros for sharing very useful code to make this easier!
	if SCREENMAN:GetTopScreen():GetChild('PlayerP1') or SCREENMAN:GetTopScreen():GetChild('PlayerP2') then
		-- SCREENMAN:SystemMessage('Game mode')
		for pn=1,prefix_amount_enabled_players do
			local s = GAMESTATE:GetPlayerState('PlayerNumber_P' .. prefix_enabled_players_no[pn]):GetPlayerOptionsString('ModsLevel_Song')
			local f = string.find(s,'x,')
			prefix_player_init_speeds[pn] = {prefix_enabled_players_no[pn], nil, 1}
			if f then
				-- Player set XMod.
				prefix_player_init_speeds[pn][3] = tonumber(string.sub(s,1,f-1))
				prefix_player_init_speeds[pn][2] = 'x'
			elseif string.sub(s,1,1) == 'C' then
				-- Player set CMod.
				local len = string.find(s,',')-1
				prefix_player_init_speeds[pn][3] = tonumber(string.sub(s,2,len))
				prefix_player_init_speeds[pn][2] = 'C'
			elseif string.sub(s,1,1) == 'm' then
				-- Player set mMod.
				local len = string.find(s,',')-1
				prefix_player_init_speeds[pn][3] = tonumber(string.sub(s,2,len))
				prefix_player_init_speeds[pn][2] = 'm'
			end
		end
		
		prefix_inject_speed_mods()
	else
		-- If we end up here, the PlayerP1/2 children don't exist, which probably means we're in the editor
		-- SCREENMAN:SystemMessage('SM5 editor mode')
		prefix_enabled_players_no = {1}
		prefix_player_init_speeds[1] = {1, 'x', 2.5}
		prefix_inject_speed_mods()
	end
	
	-- The mod reading code doesn't work correctly when the table is unsorted, so we sort them based on the beat here.
	local function compare(a,b)
		return a[1] < b[1]
	end
	table.sort(prefix_mods, compare)

-- In case of .xml, add this to the initialization if-statement inside UpdateCommand
	-- Obtain initial speed settings of the players, then add speed mods to the mod table based on these initial speeds. During normal game mode, either P1 or P2 are assumed to be present.
	-- Thanks to Jerros for sharing very useful code to make this easier!
	if SCREENMAN:GetTopScreen():GetChild('PlayerP1') or SCREENMAN:GetTopScreen():GetChild('PlayerP2') then
		if SCREENMAN:GetTopScreen():GetChild('PlayerOptionsP1') or SCREENMAN:GetTopScreen():GetChild('PlayerOptionsP2') then
			-- SCREENMAN:SystemMessage('Game mode')
			for pn=1,prefix_amount_enabled_players do
				local s = SCREENMAN:GetTopScreen():GetChild('PlayerOptionsP' .. prefix_enabled_players_no[pn]):GetText()
				local f = string.find(s,'x,')
				prefix_player_init_speeds[pn] = {prefix_enabled_players_no[pn], nil, 1}
				if f then
					-- Player set XMod.
					prefix_player_init_speeds[pn][3] = tonumber(string.sub(s,1,f-1))
					prefix_player_init_speeds[pn][2] = 'x'
				elseif string.sub(s,1,1) == 'C' then
					-- Player set CMod.
					local len = string.find(s,',')-1
					prefix_player_init_speeds[pn][3] = tonumber(string.sub(s,2,len))
					prefix_player_init_speeds[pn][2] = 'C'
				elseif string.sub(s,1,1) == 'm' then
					-- Player set MMod.
					local len = string.find(s,',')-1
					prefix_player_init_speeds[pn][3] = tonumber(string.sub(s,2,len))
					prefix_player_init_speeds[pn][2] = 'm'
				end
			end
			
			prefix_inject_speed_mods()
		else
			-- Apparently PlayerOptionsP1/2 returns nil, which means we're in FUCK's editor
			-- SCREENMAN:SystemMessage('FUCK editor mode')
			for pn=1,2 do
				prefix_player_init_speeds[pn] = {pn, 'x', 2.5}
			end
			prefix_enabled_players_no = {1,2}
			prefix_inject_speed_mods()
		end
	else
		-- Apparently PlayerP1/2 returns nil, which means we're in the SM3.95/oITG editor
		-- SCREENMAN:SystemMessage('oITG editor mode')
		prefix_enabled_players_no = {1}
		prefix_player_init_speeds[1] = {1, 'x', 2.5}
		prefix_inject_speed_mods()
	end
	
	-- The mod reading code doesn't work correctly when the table is unsorted, so we sort them based on the beat here.
	local function compare(a,b)
		return a[1] < b[1]
	end
	table.sort(prefix_mods, compare)



-- =================================================================
-- =================================================================
-- === FUNCTION FOR INJECTING SPEED MODS BASED ON PLAYER OPTIONS ===
-- =================================================================
-- =================================================================
-- This function is used together with the code that reads out and stores the players' speed mod type and its value.
-- Using this function, it's possible to add speed mod attacks for individual players based on their initial speed mod, allowing for player-unique scroll speed (de)compression effects.

-- Add this to OnCommand / song_init()
	prefix_bpm = [BPM of song here]
	
-- For .lua, add this anywhere in the file. For .xml, put this at the top inside of OnCommand (DON'T FORGET TO REMOVE THE local KEYWORD IN CASE OF XML)
	local function prefix_inject_speed_mods()
		local prev_player_speed = {} -- We need to remember the 'old' speed when we want to calculate the stuff for the new speed, so we save the 'old' speed for each player in this array.
		
		-- This function is used to retrieve the index of a specific player in the prefix_enabled_players_no array. We need this for speed mods that target specific players.
		local function get_pn_index(pn)
			for index, value in ipairs(prefix_enabled_players_no) do
				if value == pn then
					return index
				end
			end

			return false
		end
				
		-- In the beginning, the 'old' speed is of course the speed that the player starts with.
		for i=1,prefix_amount_enabled_players do
			prev_player_speed[i] = prefix_player_init_speeds[i][3]
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
			local xrate = scroll_speed / prefix_bpm
			local xrate_diff
			local scroll_diff
			local index
			
			if pn then
				if SCREENMAN:GetTopScreen():GetChild('PlayerP' .. pn) then
					index = get_pn_index(pn)
					
					if prefix_player_init_speeds[index][2] == 'x' then
						xrate_diff = math.abs(xrate - prev_player_speed[index])
						prefix_mods[#prefix_mods+1] = {beat, '\' *' .. base_rate * xrate_diff .. ' ' .. xrate .. 'x', pn}
						prev_player_speed[index] = xrate
					elseif prefix_player_init_speeds[index][2] == 'C' then
						scroll_diff = math.abs(scroll_speed - prev_player_speed[index])
						prefix_mods[#prefix_mods+1] = {beat, '\' *' .. (base_rate * scroll_diff) / prefix_bpm .. ' ' .. 'C' .. scroll_speed, pn}
						prev_player_speed[index] = scroll_speed
					elseif prefix_player_init_speeds[index][2] == 'm' then
						scroll_diff = math.abs(scroll_speed - prev_player_speed[index])
						prefix_mods[#prefix_mods+1] = {beat, '\' *' .. base_rate * scroll_diff .. ' ' .. 'm' .. scroll_speed, pn}
						prev_player_speed[index] = scroll_speed
					else
						-- We shouldn't be ending up here, if we do, something went wrong.
						SCREENMAN:SystemMessage('[ERROR] No valid speed type detected for Player ' .. pn)
					end
				end
			else
				for i,v in pairs(prefix_player_init_speeds) do
					if v[2] == 'x' then
						xrate_diff = math.abs(xrate - prev_player_speed[i])
						prefix_mods[#prefix_mods+1] = {beat, '\' *' .. base_rate * xrate_diff .. ' ' .. xrate .. 'x', v[1]}
						prev_player_speed[i] = xrate
					elseif v[2] == 'C' then
						scroll_diff = math.abs(scroll_speed - prev_player_speed[i])
						prefix_mods[#prefix_mods+1] = {beat, '\' *' .. (base_rate * scroll_diff) / prefix_bpm .. ' ' .. 'C' .. scroll_speed, v[1]}
						prev_player_speed[i] = scroll_speed
					elseif v[2] == 'm' then
						scroll_diff = math.abs(scroll_speed - prev_player_speed[i])
						prefix_mods[#prefix_mods+1] = {beat, '\' *' .. base_rate * scroll_diff .. ' ' .. 'm' .. scroll_speed, v[1]}
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
					speed = multiplier * prefix_player_init_speeds[index][3]
					speed_diff = math.abs(speed - prev_player_speed[index])
					
					if prefix_player_init_speeds[index][2] == 'x' then
						prefix_mods[#prefix_mods+1] = {beat, '\' *' .. base_rate * speed_diff .. ' ' .. speed .. 'x', pn}
						prev_player_speed[index] = speed
					elseif prefix_player_init_speeds[index][2] == 'C' then
						prefix_mods[#prefix_mods+1] = {beat, '\' *' .. (base_rate * speed_diff) / prefix_bpm .. ' ' .. 'C' .. speed, pn}
						prev_player_speed[index] = speed
					elseif prefix_player_init_speeds[index][2] == 'm' then
						prefix_mods[#prefix_mods+1] = {beat, '\' *' .. base_rate * speed_diff .. ' ' .. 'm' .. speed, pn}
						prev_player_speed[index] = speed
					else
						-- We shouldn't be ending up here, if we do, something went wrong.
						SCREENMAN:SystemMessage('[ERROR] No valid speed type detected for Player ' .. pn)
					end
				end
			else
				for i,v in pairs(prefix_player_init_speeds) do
					speed = multiplier * v[3]
					speed_diff = math.abs(speed - prev_player_speed[i])
					
					if v[2] == 'x' then
						prefix_mods[#prefix_mods+1] = {beat, '\' *' .. base_rate * speed_diff .. ' ' .. speed .. 'x', v[1]}
						prev_player_speed[i] = speed
					elseif v[2] == 'C' then
						prefix_mods[#prefix_mods+1] = {beat, '\' *' .. (base_rate * speed_diff) / prefix_bpm .. ' ' .. 'C' .. speed, v[1]}
						prev_player_speed[i] = speed
					elseif v[2] == 'm' then
						prefix_mods[#prefix_mods+1] = {beat, '\' *' .. base_rate * speed_diff .. ' ' .. 'm' .. speed, v[1]}
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
					
					if prefix_player_init_speeds[index][2] == 'x' then
						prefix_mods[#prefix_mods+1] = {beat, '\' *' .. base_rate * speed_diff .. ' ' .. speed .. 'x', pn}
						prefix_mods[#prefix_mods+1] = {beat+undo_after, '\' *' .. base_rate * speed_diff .. ' ' .. prev_player_speed[index] .. 'x', pn}
					elseif prefix_player_init_speeds[index][2] == 'C' then
						prefix_mods[#prefix_mods+1] = {beat, '\' *' .. (base_rate * speed_diff) / prefix_bpm .. ' ' .. 'C' .. speed, pn}
						prefix_mods[#prefix_mods+1] = {beat+undo_after, '\' *' .. (base_rate * speed_diff) / prefix_bpm .. ' ' .. 'C' .. prev_player_speed[index], pn}
					elseif prefix_player_init_speeds[index][2] == 'm' then
						prefix_mods[#prefix_mods+1] = {beat, '\' *' .. base_rate * speed_diff .. ' ' .. 'm' .. speed, pn}
						prefix_mods[#prefix_mods+1] = {beat+undo_after, '\' *' .. base_rate * speed_diff .. ' ' .. 'm' .. prev_player_speed[index], pn}
					else
						-- We shouldn't be ending up here, if we do, something went wrong.
						SCREENMAN:SystemMessage('[ERROR] No valid speed type detected for Player ' .. pn)
					end
				end
			else
				for i,v in pairs(prefix_player_init_speeds) do
					speed = multiplier * prev_player_speed[i]
					speed_diff = math.abs(speed - prev_player_speed[i])
					
					if v[2] == 'x' then
						prefix_mods[#prefix_mods+1] = {beat, '\' *' .. base_rate * speed_diff .. ' ' .. speed .. 'x', v[1]}
						prefix_mods[#prefix_mods+1] = {beat+undo_after, '\' *' .. base_rate * speed_diff .. ' ' .. prev_player_speed[i] .. 'x', v[1]}
					elseif v[2] == 'C' then
						prefix_mods[#prefix_mods+1] = {beat, '\' *' .. (base_rate * speed_diff) / prefix_bpm .. ' ' .. 'C' .. speed, v[1]}
						prefix_mods[#prefix_mods+1] = {beat+undo_after, '\' *' .. (base_rate * speed_diff) / prefix_bpm .. ' ' .. 'C' .. prev_player_speed[i], v[1]}
					elseif v[2] == 'm' then
						prefix_mods[#prefix_mods+1] = {beat, '\' *' .. base_rate * speed_diff .. ' ' .. 'm' .. speed, v[1]}
						prefix_mods[#prefix_mods+1] = {beat+undo_after, '\' *' .. base_rate * speed_diff .. ' ' .. 'm' .. prev_player_speed[i], v[1]}
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
		
	end
	