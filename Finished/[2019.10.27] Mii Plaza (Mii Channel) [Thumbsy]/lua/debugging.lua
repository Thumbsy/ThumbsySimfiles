-- ============================================================================================================
-- LOCAL FUNCTIONS
-- ============================================================================================================

local function tprint_to_str(tbl, tblstr, max_recur, indent)
	if not indent then indent = 0 end
	
	if max_recur and (max_recur == indent) then
		tblstr[#tblstr+1] = "{"
		for k, v in pairs(tbl) do
			tblstr[#tblstr+1] = tostring(v) .. ","
		end
		tblstr[#tblstr+1] = "}\n"
	else
		for k, v in pairs(tbl) do
			formatting = string.rep("  ", indent) .. k .. ": "
			if type(v) == 'table' then
				if max_recur and ((max_recur-1) == indent) then
					tblstr[#tblstr+1] = formatting
				else
					tblstr[#tblstr+1] = formatting .. "\n"
				end
				tprint_to_str(v, tblstr, max_recur, indent+1)
			elseif type(v) == 'boolean' then
				tblstr[#tblstr+1] = formatting .. tostring(v) .. "\n"
			else
				tblstr[#tblstr+1] = formatting .. v .. "\n"
			end
		end
	end
	
	return tblstr
end

-- ============================================================================================================
-- GLOBAL FUNCTIONS
-- ============================================================================================================

function debugging__open_log_file(file)
	local song_path = GAMESTATE:GetCurrentSong():GetSongDir()
	local file_path = song_path .. 'lua/debug/' .. 'debug' .. '.log'
	file:Open(file_path, 2) -- 2 = Write
end

function debugging__close_log_file(file)
	file:Close()
end

-- Takes a table and turns it into a string that can later on be neatly formattedly printed for debugging purposes.
-- If you want to specify a maximum depth to the printing of the table contents (e.g. for tables that contain tables), you can set that with max_recur.
function debugging__table_to_string(tbl, max_recur)
	local tblstr = {}
	tblstr = tprint_to_str(tbl, tblstr, max_recur)
	tblstr = table.concat(tblstr)
	return tblstr
end

-- Takes the file handler, filename for the log file and the data to log
function debugging__log_to_file(file, str)
	file:PutLine(str)
end
