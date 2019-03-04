-- Save all currently enabled players in the table enabled_players
function players__init_players(enabled_players)
	for i=1,user_content__max_players do
		if SCREENMAN:GetTopScreen():GetChild('PlayerP' .. i) then
			enabled_players[i] = {SCREENMAN:GetTopScreen():GetChild('PlayerP' .. i), i}
		end
	end
end

-- Obtain initial speed settings of the players, then add speed mods to the mod table based on these initial speeds. During normal game mode, either P1 or P2 are assumed to be present.
-- Thanks to Jerros for sharing very useful code to make this easier!
function players__get_players_init_speeds(plr_init_speed, enabled_players)
	if SCREENMAN:GetTopScreen():GetChild('PlayerP1') or SCREENMAN:GetTopScreen():GetChild('PlayerP2') then
		-- SCREENMAN:SystemMessage('Game mode')
		for k, v in pairs(enabled_players) do
			local s = GAMESTATE:GetPlayerState('PlayerNumber_P' .. k):GetPlayerOptionsString('ModsLevel_Song')
			local f = string.find(s,'x,')
			plr_init_speed[k] = {v[2], nil, 1}
			if f then
				-- Player set XMod
				plr_init_speed[k][3] = tonumber(string.sub(s,1,f-1))
				plr_init_speed[k][2] = 'x'
			elseif string.sub(s,1,1) == 'C' then
				-- Player set CMod
				local len = string.find(s,',')-1
				plr_init_speed[k][3] = tonumber(string.sub(s,2,len))
				plr_init_speed[k][2] = 'C'
			elseif string.sub(s,1,1) == 'm' then
				-- Player set mMod
				local len = string.find(s,',')-1
				plr_init_speed[k][3] = tonumber(string.sub(s,2,len))
				plr_init_speed[k][2] = 'm'
			end
		end
	else
		-- If we end up here, the PlayerP1/2 children don't exist, which probably means we're in the editor
		-- SCREENMAN:SystemMessage('SM5 editor mode')
		plr_init_speed[1] = user_content__editor_player_speed_table
		enabled_players[1] = {'DUMMY_PLAYER', 1}
	end
end
