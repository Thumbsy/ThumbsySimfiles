-- Bits and pieces throughout based on script from Puurokulho's wndrwll: https://www.youtube.com/watch?v=KDWAGbwdA_w
-- Thumbsy's terrible template last updated on 2023.03.29

local function song_init()
	-- Check which features are implemented for this mod script. Set the appropriate flags based on this which can be used to include/exclude code in the rest of the script.
	-- set_module_enabled_flags()
	
	luamod_enabled_players = {} -- This table will contain the currently enabled players (the actual children)
	luamod_player_init_speeds = {} -- luamod_player_init_speeds is a table containing tables that contain information about the player's settings for the speed modifiers
	luamod_mod_counter = {} -- Contains integers (one for each player) that act as a counter for the mods. Helps to time/sync mod effects.
	main__topscreen_table = {}
	
	
	-- Create debug file handle and open for writing
	if user_content__enable_debugging then
		debug_file_handle = RageFileUtil.CreateRageFile()
		debugging__open_log_file(debug_file_handle)
	end
	
	general__set_flags()
	
	if general__flag_is_sm5 then
		-- SCREENMAN:SystemMessage("Hello world! Test value: " .. tostring(user_content__bpm))
		if user_content__enable_debugging then debugging__log_to_file(debug_file_handle, "Main BPM: " .. tostring(user_content__bpm)) end
	end

	checked = false;
end

local function song_update()
	general_values = {}
	general__get_current_global_values(general_values)

	-- Initialization stuff that can't be executed in song_init()
	if general_values.beat >= 0 and not checked then
		
		misc__init_topscreen_table(main__topscreen_table)
		if user_content__enable_debugging then debugging__log_to_file(debug_file_handle, "Topscreen table:\n" .. debugging__table_to_string(main__topscreen_table, 1)) end
		
		players__init_players(luamod_enabled_players)
		if user_content__enable_debugging then debugging__log_to_file(debug_file_handle, "Player table:\n" .. debugging__table_to_string(luamod_enabled_players, 1)) end
		
		players__get_players_init_speeds(luamod_player_init_speeds, luamod_enabled_players)
		if user_content__enable_debugging then debugging__log_to_file(debug_file_handle, "Player init speeds:\n" .. debugging__table_to_string(luamod_player_init_speeds)) end
		
		player_mods__init_player_mod_counters(luamod_mod_counter, luamod_enabled_players)
		if user_content__enable_debugging then debugging__log_to_file(debug_file_handle, "Initialized mod counters:\n" .. debugging__table_to_string(luamod_mod_counter)) end
		
		player_mods__inject_speed_mods(luamod_enabled_players, luamod_player_init_speeds)
		if user_content__enable_debugging then debugging__log_to_file(debug_file_handle, "Mod table (unsorted):\n" .. debugging__table_to_string(user_content__mods, 1)) end
		
		-- The mod reading code doesn't work correctly when the table is unsorted, so we sort them by beat.
		local function compare(a, b)
			return a[1] < b[1]
		end
		table.sort(user_content__mods, compare)
		if user_content__enable_debugging then debugging__log_to_file(debug_file_handle, "Mod table (sorted):\n" .. debugging__table_to_string(user_content__mods, 1)) end
		
		checked = true
		
		if user_content__enable_debugging then debugging__close_log_file(debug_file_handle) end
	end
	
	for k in pairs(luamod_enabled_players) do
		player_mods__process_players_mods_table(luamod_mod_counter, user_content__mods, k, general_values.beat)
	end
	
	players__process_oneshot_lua(general_values.beat, luamod_enabled_players)
	misc__process_oneshot_screen_lua(general_values.beat)
	user_content__on_update_other()
end

-- This ActorFrame helps to keep our script 'alive' by letting it sleep (and not disappear) for a long enough amount of time
return Def.ActorFrame{
	-- Call song_init() and then repeatedly call song_update()
	OnCommand= function(self)
		song_init()
		self:SetUpdateFunction(song_update)
	end,
	
	-- Create a quad that is invisible and does nothing, this is the actual part that keeps the ActorFrame (and therefore the script) alive
	Def.Quad{
		Name= "I may be sleeping, but I preserve the world.",
		InitCommand= cmd(visible,false),
		OnCommand= cmd(sleep,1000),
	},
	
	-- Here we load external files. Including files this way makes everything easier to manage and read.
	LoadActor("debugging.lua"),
	LoadActor("general.lua"),
	LoadActor("misc.lua"),
	LoadActor("players.lua"),
	LoadActor("player_mods.lua"),
	LoadActor("user_content.lua"),
	
}
