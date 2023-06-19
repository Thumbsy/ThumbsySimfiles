misc__oneshot_screen_lua_counter = 1

-- Store the top screen actor in the table along with its initial xy positions and width/height
function misc__init_topscreen_table(topscreen_table)
	topscreen_table["actor"] = SCREENMAN:GetTopScreen()
	topscreen_table["initial_x_pos"] = topscreen_table.actor:GetX()
	topscreen_table["initial_y_pos"] = topscreen_table.actor:GetY()
	topscreen_table["initial_width"] = DISPLAY:GetDisplayWidth()
	topscreen_table["initial_height"] = DISPLAY:GetDisplayHeight()
end

-- Execute the one-shot Lua functions that affects the gameplay screen
function misc__process_oneshot_screen_lua(beat)
	if misc__oneshot_screen_lua_counter <= #user_content__oneshot_screen_lua_functions and beat > user_content__oneshot_screen_lua_functions[misc__oneshot_screen_lua_counter][1] then
		user_content__oneshot_screen_lua_functions[misc__oneshot_screen_lua_counter].func(main__topscreen_table.actor)
		misc__oneshot_screen_lua_counter = misc__oneshot_screen_lua_counter + 1
	end
end
