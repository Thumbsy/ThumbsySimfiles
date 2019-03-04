function debugging__open_log_file(file)
	local song_path = GAMESTATE:GetCurrentSong():GetSongDir()
	local file_path = song_path .. 'lua/debug/' .. 'debug' .. '.log'
	file:Open(file_path, 2) -- 2 = Write
end

function debugging__close_log_file(file)
	file:Close()
end

function debugging__1dtable_to_string(t)
	local s = {"{\n"}
	for k, v in pairs(t) do
		s[#s+1] = "\t[key: " .. k .. "] "
		s[#s+1] = tostring(v)
		s[#s+1] = ",\n"
	end
	s[#s+1] = "}"
	s = table.concat(s)
	
	return s
end

function debugging__2dtable_to_string(t)
	local s = {"{\n"}
	for k, v in pairs(t) do
		s[#s+1] = "\t[key: " .. k .. "] "
		s[#s+1] = "{"
		for j=1,#v do
			s[#s+1] = tostring(v[j])
			s[#s+1] = ","
		end
		s[#s+1] = "},\n"
	end
	s[#s+1] = "}"
	s = table.concat(s)
	
	return s
end

-- Takes the file handler, filename for the log file and the data to log
function debugging__log_to_file(file, str)
	file:PutLine(str)
end
