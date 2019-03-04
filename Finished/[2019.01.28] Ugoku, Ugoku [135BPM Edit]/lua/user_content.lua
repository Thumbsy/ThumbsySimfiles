user_content__max_players = 32	-- The maximum amount of players that could potentially be expected for your environment
user_content__bpm = 135			-- The main bpm of the song (used for timing speed mods, does not apply to songs with fluctuating tempos since those cannot be easily timed)

user_content__editor_player_speed_table = {1, 'x', 3.5}  -- For use when previewing in editor mode. Should be equal to the speed settings set in the editor.

-- Put your mods in the following table with the following format:
-- {beat, mod, player (optional)}
user_content__mods = {
	{92, '*1000 100% Stealth'},
	{92.125, '*1000 No Stealth'},
	{92.25, '*1000 100% Stealth'},
	{92.375, '*1000 No Stealth'},
	{92.5, '*1000 100% Stealth'},
	{92.625, '*1000 No Stealth'},
	{92.75, '*1000 100% Stealth'},
	{92.875, '*1000 No Stealth'},
	{93, '*1000 100% Stealth'},
	{93.125, '*1000 No Stealth'},
	{93.25, '*1000 100% Stealth'},
	{93.375, '*1000 No Stealth'},
	{93.5, '*1000 100% Stealth'},
	{93.625, '*1000 No Stealth'},
	{93.75, '*1000 100% Stealth'},
	{93.875, '*1000 No Stealth'},
}

-- You can add all speed mod related function calls in the function below
function user_content__speed_mods()
	player_mods__add_speed_mod_absolute(2, 0.889, user_content__bpm)
	player_mods__add_speed_mod_relative(15, 0.055, 1)
	
	player_mods__linear_breathing(30, 1, 0.444, 0.7)
	
	player_mods__add_speed_mod_relative(33.5, 0.222, 0.85)
	player_mods__add_speed_mod_relative(35.5, 0.222, 1)
	player_mods__add_speed_mod_relative(37.5, 0.222, 0.85)
	player_mods__add_speed_mod_relative(39.5, 0.222, 1)
	player_mods__add_speed_mod_relative(41.5, 0.222, 0.85)
	player_mods__add_speed_mod_relative(43.5, 0.222, 1)
	player_mods__add_speed_mod_relative(45.5, 0.222, 0.85)
	player_mods__add_speed_mod_relative(47.5, 0.222, 1)
	player_mods__add_speed_mod_relative(49.5, 0.222, 0.85)
	player_mods__add_speed_mod_relative(51.5, 0.222, 1)
	player_mods__add_speed_mod_relative(53.5, 0.222, 0.85)
	player_mods__add_speed_mod_relative(55.5, 0.222, 1)
	player_mods__add_speed_mod_relative(57.5, 0.222, 0.85)
	player_mods__add_speed_mod_relative(59.5, 0.222, 1)
	player_mods__add_speed_mod_relative(61.5, 0.222, 0.85)
	player_mods__add_speed_mod_relative(63.5, 0.222, 1)
	
	player_mods__add_speed_mod_relative(64.25, 0.777, 0.4)
	player_mods__add_speed_mod_relative(66, 0.111, 1.1)
	player_mods__add_speed_mod_relative(66.25, 0.777, 0.4)
	player_mods__add_speed_mod_relative(68, 0.111, 1.1)
	player_mods__add_speed_mod_relative(68.25, 0.777, 0.4)
	player_mods__add_speed_mod_relative(70, 0.111, 1.1)
	player_mods__add_speed_mod_relative(70.25, 0.777, 0.4)
	player_mods__add_speed_mod_relative(72, 0.111, 1.1)
	player_mods__add_speed_mod_relative(72.25, 0.777, 0.4)
	player_mods__add_speed_mod_relative(74, 0.111, 1.1)
	player_mods__add_speed_mod_relative(74.25, 0.777, 0.4)
	player_mods__add_speed_mod_relative(76, 0.111, 1.1)
	player_mods__add_speed_mod_relative(76.25, 0.777, 0.4)
	player_mods__add_speed_mod_relative(78, 0.111, 1.1)
	player_mods__add_speed_mod_relative(78.25, 0.777, 0.4)
	
	player_mods__add_speed_mod_relative(80.00, 3.556, 0.6)
	player_mods__add_speed_mod_relative(88.00, 1.7778, 1)
	
	player_mods__add_speed_mod_absolute(94, 0.888, user_content__bpm)
	player_mods__add_speed_mod_absolute(115, 0.055, 2*user_content__bpm)
	player_mods__add_speed_mod_absolute(131.5, 0.055, user_content__bpm)
	player_mods__add_speed_mod_absolute(151, 0.055, 2*user_content__bpm)
	
	player_mods__add_speed_mod_absolute(160, 0.055, 2.2*user_content__bpm)
	player_mods__add_speed_mod_absolute(161, 0.055, 2.3*user_content__bpm)
	player_mods__add_speed_mod_absolute(162, 0.055, 2.4*user_content__bpm)
	player_mods__add_speed_mod_absolute(162.75, 0.055, 2.5*user_content__bpm)
	player_mods__add_speed_mod_absolute(163.5, 0.055, 2.6*user_content__bpm)
	player_mods__add_speed_mod_relative(164, 1.333, 1)
	
	player_mods__linear_breathing(231, 0.5, 0.222, 0.5)
	
	player_mods__add_speed_mod_absolute(264, 0.055, user_content__bpm)
	
	player_mods__add_speed_mod_relative(275, 0.055, 1)
end
