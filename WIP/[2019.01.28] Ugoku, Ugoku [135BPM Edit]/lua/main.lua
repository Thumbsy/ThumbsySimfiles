-- Template based on Puurokulho's wndrwll: https://www.youtube.com/watch?v=KDWAGbwdA_w
-- Template last updated on 2018.12.xx

local function song_init()
	-- Check which features are implemented for this mod script. Set the appropriate flags based on this which can be used to include/exclude code in the rest of the script.
	-- set_module_enabled_flags()
	
	luamod_enabled_players = {} -- This table will contain the currently enabled players (the actual children)
	luamod_player_init_speeds = {} -- luamod_player_init_speeds is a table containing tables of the following format: {player_no, speed_type, init_value}
	luamod_mod_counter = {} -- Timed mod management, curmod contains a counter for each player
	
	
	-- Create debug file handle and open for writing
	debug_file_handle = RageFileUtil.CreateRageFile()
	debugging__open_log_file(debug_file_handle)
	
	general__set_flags()
	
	if general__flag_is_sm5 then
		-- SCREENMAN:SystemMessage("Hello world! Test value: " .. tostring(user_content__bpm))
		debugging__log_to_file(debug_file_handle, "Main BPM: " .. tostring(user_content__bpm))
	end

	checked = false;
end

local function song_update()
	local beat = GAMESTATE:GetSongBeat()

	-- Initialization stuff that can't be executed in song_init()
	if beat >= 0 and not checked then
		
		players__init_players(luamod_enabled_players)
		debugging__log_to_file(debug_file_handle, "Player table:\n" .. debugging__2dtable_to_string(luamod_enabled_players))
		
		players__get_players_init_speeds(luamod_player_init_speeds, luamod_enabled_players)
		debugging__log_to_file(debug_file_handle, "Player init speeds:\n" .. debugging__2dtable_to_string(luamod_player_init_speeds))
		
		player_mods__init_player_mod_counters(luamod_mod_counter, luamod_enabled_players)
		debugging__log_to_file(debug_file_handle, "Initialized mod counters:\n" .. debugging__1dtable_to_string(luamod_mod_counter))
		
		player_mods__inject_speed_mods(luamod_enabled_players, luamod_player_init_speeds)
		debugging__log_to_file(debug_file_handle, "Mod table (unsorted):\n" .. debugging__2dtable_to_string(user_content__mods))
		
		-- The mod reading code doesn't work correctly when the table is unsorted, so we sort them based on the beat here.
		local function compare(a, b)
			return a[1] < b[1]
		end
		table.sort(user_content__mods, compare)
		debugging__log_to_file(debug_file_handle, "Mod table (sorted):\n" .. debugging__2dtable_to_string(user_content__mods))
		
		checked = true
		
		debugging__close_log_file(debug_file_handle)
	end
	
	for k in pairs(luamod_enabled_players) do
		player_mods__process_players_mods_table(luamod_mod_counter, user_content__mods, k, beat)
	end
end

-- This ActorFrame helps to keep our script 'alive' by letting it sleep (and not disappear) for a long enough amount of time
return Def.ActorFrame{
	OnCommand= function(self)
		song_init()
		self:SetUpdateFunction(song_update)
	end,
	Def.Quad{
		Name= "Lua script keepalive",
		InitCommand= cmd(visible,false),
		OnCommand= cmd(sleep,1000),
	},
	
	-- Here we load external files. Including files this way makes everything easier to manage and read.
	LoadActor("debugging.lua"),
	LoadActor("general.lua"),
	LoadActor("players.lua"),
	LoadActor("player_mods.lua"),
	LoadActor("user_content.lua"),
	
}
