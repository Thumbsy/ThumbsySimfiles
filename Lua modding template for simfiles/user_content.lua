user_content__max_players = 32	-- The maximum amount of players that could potentially be expected for your environment
user_content__bpm = 100			-- The main bpm of the song (used for timing speed mods, does not apply to songs with fluctuating tempos since those cannot be easily timed)

user_content__editor_player_speed_table = {1, 'x', 3.5}  -- For use when previewing in editor mode. Should be equal to the speed settings set in the editor.

user_content__enable_debugging = false  -- Turn debug logging on/off

user_content__msg_broadcast_cnt = 1
user_content__msg_broadcasts = {
	
}



-- Assign any type of mod you want to a particular player or everyone, activation based on current beat.
-- Put your mods in the following table with the following format (it's a table of tables):
-- {beat, mod, player (optional)},
user_content__mods = {
	{},
}

-- You can add all speed mod related function calls in the function below as a more precise alternative to doing it in the general mod table
-- These dedicated speed mod functions (see player_mods.lua) inject speed mods in the mod table that are timed exactly how you define them
function user_content__speed_mods()
	-- player_mods__add_speed_mod_absolute(5, 1.2, 0.75*user_content__bpm)
	-- player_mods__add_speed_mod_relative(8, 0.4, 1)
end

-- ==================================================================================
-- Insert one-shot lua functions below that affects player actors
-- ==================================================================================
local function plr_effect0(i, plr)
	-- plr:linear(0.263):zoom(2)
	SCREENMAN:SystemMessage(plr:GetBaseZoomX())
end

local function plr_reset(i, plr)
	plr:stopeffect():stoptweening():x(luamod_enabled_players[i].initial_x_pos):y(luamod_enabled_players[i].initial_y_pos):rotationz(0):zoom(1)
end

-- The functions you defined above should now be put in this table.
-- These functions will be called only once after the chart is past the specified beat.
-- {start_beat, function_name},
user_content__oneshot_plr_lua_functions = {
	-- {1.000, func = plr_effect0},
}

-- ==================================================================================
-- Insert one-shot lua functions below that affects the gameplay screen
-- ==================================================================================
local function scrn_effect0(screen)
	screen:x(main__topscreen_table.initial_x_pos - (3*SCREEN_WIDTH - SCREEN_WIDTH)/2)
	screen:y(main__topscreen_table.initial_y_pos - (3*SCREEN_HEIGHT - SCREEN_HEIGHT)/2)
end

-- The functions you defined above should now be put in this table.
-- These functions will be called only once after the chart is past the specified beat.
-- {start_beat, function_name},
user_content__oneshot_screen_lua_functions = {
	-- {1.000, func = scrn_effect0},
}


-- ==================================================================================
-- Insert custom lua functions below
-- ==================================================================================
function user_content__on_update_other()

end

return Def.ActorFrame{
	-- Create a quad that is invisible and does nothing, this is the actual part that keeps the ActorFrame alive
	Def.Quad{
		Name= "I may be sleeping, but I preserve the world.",
		InitCommand= cmd(visible,false),
		OnCommand= cmd(sleep,1000),
	},
}
