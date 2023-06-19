-- Check for existence of certain contents and/or other flags to determine which modules are used
function general__set_flags()
	general__flag_is_sm5 = false






	-- Silly but sufficient way to determine whether we're dealing with SM5 or oITG/SM3.95
	if ProductID() then
		general__flag_is_sm5 = true
	end
end

function general__get_current_global_values(values)
	values["beat"] = GAMESTATE:GetSongBeat()
	values["elapsed_seconds_song"] = GAMESTATE:GetSongPosition():GetMusicSeconds()
end
