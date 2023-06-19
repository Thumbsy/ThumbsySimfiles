players__oneshot_plr_lua_counter = 1

-- Save all currently enabled players in the table enabled_players
function players__init_players(enabled_players)
	for i=1,user_content__max_players do
		if main__topscreen_table.actor:GetChild('PlayerP' .. i) then
			enabled_players[i] = {main__topscreen_table.actor:GetChild('PlayerP' .. i), i}
			enabled_players[i]["difficulty"] = GAMESTATE:GetCurrentSteps(i-1):GetDifficulty()
			enabled_players[i]["initial_x_pos"] = main__topscreen_table.actor:GetChild('PlayerP' .. i):GetX()
			enabled_players[i]["initial_y_pos"] = main__topscreen_table.actor:GetChild('PlayerP' .. i):GetY()
		end
	end
end

-- Obtain initial speed settings of the players, then add speed mods to the mod table based on these initial speeds. During normal game mode, either P1 or P2 are assumed to be present.
-- Thanks to Jerros for sharing very useful code to make this easier!
function players__get_players_init_speeds(plr_init_speed, enabled_players)
	if main__topscreen_table.actor:GetChild('PlayerP1') or main__topscreen_table.actor:GetChild('PlayerP2') then
		-- SCREENMAN:SystemMessage('Game mode')
		for k, v in pairs(enabled_players) do
			local s = GAMESTATE:GetPlayerState('PlayerNumber_P' .. k):GetPlayerOptionsString('ModsLevel_Song')
			local f = string.find(s,'x,')
			-- plr_init_speed[k] = {v[2], nil, 1}
			plr_init_speed[k] = {}
			plr_init_speed[k].playerNo = v[2]
			plr_init_speed[k].speedModType = 'unknown'
			plr_init_speed[k].speedModValue = 1
			if f then
				-- Player set XMod
				plr_init_speed[k].speedModValue = tonumber(string.sub(s,1,f-1))
				plr_init_speed[k].speedModType = 'x'
			elseif string.sub(s,1,1) == 'C' then
				-- Player set CMod
				local len = string.find(s,',')-1
				plr_init_speed[k].speedModValue = tonumber(string.sub(s,2,len))
				plr_init_speed[k].speedModType = 'C'
			elseif string.sub(s,1,1) == 'm' then
				-- Player set mMod
				local len = string.find(s,',')-1
				plr_init_speed[k].speedModValue = tonumber(string.sub(s,2,len))
				plr_init_speed[k].speedModType = 'm'
			end
		end
	else
		-- If we end up here, the PlayerP1/2 children don't exist, which probably means we're in the editor
		-- SCREENMAN:SystemMessage('SM5 editor mode')
		plr_init_speed[1] = user_content__editor_player_speed_table
		enabled_players[1] = {'DUMMY_PLAYER', 1}
	end
end

-- Execute the one-shot Lua functions that affect Player actors
function players__process_oneshot_lua(beat, enabled_players)
	if players__oneshot_plr_lua_counter <= #user_content__oneshot_plr_lua_functions and beat > user_content__oneshot_plr_lua_functions[players__oneshot_plr_lua_counter][1] then
		for plr_k, plr_v in pairs(enabled_players) do
			user_content__oneshot_plr_lua_functions[players__oneshot_plr_lua_counter].func(plr_k, plr_v[1])
		end
		players__oneshot_plr_lua_counter = players__oneshot_plr_lua_counter + 1
	end
end