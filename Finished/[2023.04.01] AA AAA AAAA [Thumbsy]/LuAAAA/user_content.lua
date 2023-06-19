user_content__max_players = 32	-- The maximum amount of players that could potentially be expected for your environment
user_content__bpm = 150			-- The main bpm of the song (used for timing speed mods, does not apply to songs with fluctuating tempos since those cannot be easily timed)

user_content__editor_player_speed_table = {1, 'x', 3.5}  -- For use when previewing in editor mode. Should be equal to the speed settings set in the editor.

user_content__enable_debugging = true  -- Turn debug logging on/off



-- Assign any type of mod you want to a particular player or everyone, activation based on current beat.
-- Put your mods in the following table with the following format (it's a table of tables):
-- {beat, mod, player (optional)},
user_content__mods = {
	
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
local function plr_effect1(i, plr)
	plr:accelerate(0.401):zoomx(1.5)
end

local function plr_effect2(i, plr)
	plr:accelerate(0.401):zoomx(1)
end

local function plr_effect3(i, plr)
	plr:linear(0.129):zoomto(2, 1.2)
end

local function plr_effect4(i, plr)
	plr:linear(0.257):zoomto(1, 1)
end

local function plr_effect5(i, plr)
	plr:linear(0.065):zoomto(4, 1.2):vibrate():effectmagnitude(20,20,0)
end



local function plr_zoom_reset(i, plr)
	plr:zoom(1)
end

local function plr_stopeffect(i, plr)
	plr:stopeffect()
end

local function plr_reset(i, plr)
	plr:stopeffect():stoptweening():x(luamod_enabled_players[i].initial_x_pos):y(luamod_enabled_players[i].initial_y_pos):rotationz(0):zoom(1)
end

-- The functions you defined above should now be put in this table.
-- These functions will be called only once after the chart is past the specified beat.
-- {start_beat, function_name},
user_content__oneshot_plr_lua_functions = {
	{4.000, func = plr_effect1},
	{5.250, func = plr_effect2},
	{12.000, func = plr_effect3},
	{15.000, func = plr_effect4},
	{20.000, func = plr_effect5},

}

-- ==================================================================================
-- Insert one-shot lua functions below that affects the gameplay screen
-- ==================================================================================
local function scrn_effect1(screen)
	screen:linear(0.132):zoom(1.2)
	screen:x(main__topscreen_table.initial_x_pos - (1.2*SCREEN_WIDTH - SCREEN_WIDTH)/2)
	screen:y(main__topscreen_table.initial_y_pos - (1.2*SCREEN_HEIGHT - SCREEN_HEIGHT)/2)
end

-- The functions you defined above should now be put in this table.
-- These functions will be called only once after the chart is past the specified beat.
-- {start_beat, function_name},
user_content__oneshot_screen_lua_functions = {
	{42.000, func = scrn_effect1},
}


-- ==================================================================================
-- Insert custom lua functions below
-- ==================================================================================
function user_content__on_update_other()
	if general_values.beat >= 30.07 then
		MESSAGEMAN:Broadcast('BlackOut')
	end
end

return Def.ActorFrame{
	Def.Quad{
		Name="Blackout",
		OnCommand=function(self)
			self:FullScreen():diffuse(Color.Black):diffusealpha(0)
		end,
		BlackOutMessageCommand=function(self)
			self:diffusealpha(1)
		end,
	},
}
