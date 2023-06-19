user_content__max_players = 32	-- The maximum amount of players that could potentially be expected for your environment
user_content__bpm = 114			-- The main bpm of the song (used for timing speed mods, does not apply to songs with fluctuating tempos since those cannot be easily timed)

user_content__editor_player_speed_table = {1, 'x', 3.5}  -- For use when previewing in editor mode. Should be equal to the speed settings set in the editor.

user_content__enable_debugging = false  -- Turn debug logging on/off

user_content__msg_broadcast_cnt = 1
user_content__msg_broadcasts = {
	'ThumbseyePopup',
	'ThumbseyePopup2',
}



-- Assign any type of mod you want to a particular player or everyone, activation based on current beat.
-- Put your mods in the following table with the following format (it's a table of tables):
-- {beat, mod, player (optional)},
user_content__mods = {
	{72.000, '*0.5 100% Drunk'},
	{102.000, '*10000 No Drunk'},
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

local function plr_effect1(i, plr)
	plr:accelerate(0.525):zoom(4)
end

local function plr_effect2(i, plr)
	plr:linear(0.789):zoom(2)
	plr:vibrate():effectmagnitude(10,10,0)
end

local function plr_effect3(i, plr)
	plr:linear(0.263):zoom(1):vibrate():effectmagnitude(0,0,0)
end

local function plr_effect4(i, plr)
	plr:linear(0.131):zoom(1.2):rotationz(-10)
end

local function plr_effect5(i, plr)
	plr:linear(0.131):zoom(1.4):rotationz(10)
end

local function plr_effect6(i, plr)
	plr:linear(0.131):zoom(1.6):rotationz(-10)
end

local function plr_effect7(i, plr)
	plr:linear(0.131):zoom(1):rotationz(0)
end

local function plr_effect8(i, plr)
	plr:linear(0.527):zoom(0.3)
end

local function plr_effect9(i, plr)
	plr:linear(0.527):zoom(1.3)
end

local function plr_effect10(i, plr)
	plr:linear(0.263):zoom(1)
end

local function plr_effect11(i, plr)
	plr:linear(0.132):x(luamod_enabled_players[i].initial_x_pos+30)
end

local function plr_effect12(i, plr)
	plr:linear(0.132):rotationz(20)
end

local function plr_effect13(i, plr)
	plr:linear(0.132):y(luamod_enabled_players[i].initial_y_pos-30)
end

local function plr_effect14(i, plr)
	plr:linear(0.132):x(luamod_enabled_players[i].initial_x_pos-30):y(luamod_enabled_players[i].initial_y_pos):rotationz(-10)
end

local function plr_effect15(i, plr)
	plr:bounce():effectmagnitude(0,50,0):effectperiod(0.5):effectclock('beat')
end

local function plr_effect16(i, plr)
	plr:linear(0.132):zoom(0.8)
end

local function plr_effect17(i, plr)
	plr:linear(0.132):zoom(0.6)
end

local function plr_effect18(i, plr)
	plr:linear(0.132):zoom(0.4)
end

local function plr_effect19(i, plr)
	plr:linear(0.132):x(luamod_enabled_players[i].initial_x_pos):zoom(1):rotationz(0)
end

local function plr_effect20(i, plr)
	plr:linear(0.132):rotationz(20 * (-1)^i)
end

local function plr_effect21(i, plr)
	plr:linear(0.132):rotationz(-20 * (-1)^i)
end

local function plr_effect22(i, plr)
	plr:linear(0.132):x(luamod_enabled_players[i].initial_x_pos - (30 * (-1)^i))
end

local function plr_effect23(i, plr)
	plr:linear(0.132):zoomx(1.5)
end

local function plr_effect24(i, plr)
	plr:linear(0.132):rotationz(0)
end

local function plr_effect25(i, plr)
	plr:accelerate(1.052):zoomx(1):x(luamod_enabled_players[i].initial_x_pos):rotationz(360 * (-1)^i)
	plr:linear(0.0001):rotationz(0)
end

local function plr_effect26(i, plr)
	plr:linear(4.210):zoomy(0.5)
	plr:wag():effectperiod(2):effectclock('beat')
end

local function plr_effect27(i, plr)
	plr:linear(0.132):zoomy(1):zoom(1.5)
end

local function plr_effect28(i, plr)
	plr:linear(0.132):zoom(2)
end

local function plr_effect29(i, plr)
	plr:linear(0.132):zoom(2.5)
end

local function plr_effect30(i, plr)
	plr:linear(0.263):zoom(2):rotationz(20)
end

local function plr_effect31(i, plr)
	plr:linear(0.263):zoom(1.5):rotationz(-20)
end

local function plr_effect32(i, plr)
	plr:linear(0.263):zoom(1):rotationz(0)
end

local function plr_effect33(i, plr)
	plr:linear(0.263):zoomy(2)
end

local function plr_effect34(i, plr)
	plr:linear(0.263):zoomy(1)
end

local function plr_effect35(i, plr)
	plr:linear(9.474):wag():effectperiod(4):effectclock('beat')
end

local function plr_effect36(i, plr)
	plr:linear(0.001):rotationx(180)
end

local function plr_effect37(i, plr)
	plr:linear(0.001):rotationx(0)
end

local function plr_effect38(i, plr)
	math.randomseed(GetTimeSinceStart())
	plr:linear(0.132):rotationx(math.random(5,10)):rotationy(math.random(5,10)):rotationz(math.random(5,10))
end

local function plr_effect39(i, plr)
	math.randomseed(GetTimeSinceStart())
	plr:linear(0.132):rotationx(math.random(-20,-10)):rotationy(math.random(-20,-10)):rotationz(math.random(-20,-10))
end

local function plr_effect40(i, plr)
	math.randomseed(GetTimeSinceStart())
	plr:linear(0.132):rotationx(math.random(20,40)):rotationy(math.random(20,40)):rotationz(math.random(20,40))
end

local function plr_effect41(i, plr)
	math.randomseed(GetTimeSinceStart())
	plr:linear(0.132):rotationx(math.random(-60,-40)):rotationy(math.random(-60,-40)):rotationz(math.random(-60,-40))
end

local function plr_effect42(i, plr)
	plr:linear(0.132):rotationx(0):rotationy(0):rotationz(0)
end

local function plr_effect43(i, plr)
	plr:linear(0.132):x(luamod_enabled_players[i].initial_x_pos - 30)
end

local function plr_effect44(i, plr)
	plr:linear(0.132):x(luamod_enabled_players[i].initial_x_pos + 30)
end

local function plr_effect45(i, plr)
	plr:linear(0.132):x(luamod_enabled_players[i].initial_x_pos)
end

local function plr_effect46(i, plr)
	plr:accelerate(0.263):zoom(0.25)
end

local function plr_effect47(i, plr)
	plr:linear(0.132):rotationz(20)
end

local function plr_effect48(i, plr)
	plr:linear(0.132):y(luamod_enabled_players[i].initial_y_pos - 20)
end

local function plr_effect49(i, plr)
	plr:linear(0.132):zoomx(0.7):rotationz(0)
end

local function plr_effect50(i, plr)
	plr:linear(0.132):zoomy(1.5)
end

local function plr_effect51(i, plr)
	plr:linear(0.132):zoom(0)
end

local function plr_effect52(i, plr)
	plr:linear(0.789):zoom(2)
	plr:vibrate():effectmagnitude(0,20,0)
end

local function plr_effect53(i, plr)
	plr:linear(0.263):zoom(1)
	plr:vibrate():effectmagnitude(0,0,0)
end

local function plr_effect54(i, plr)
	plr:linear(0.132):y(luamod_enabled_players[i].initial_y_pos)
end

local function plr_effect55(i, plr)
	plr:linear(0.132):rotationz(-15)
end

local function plr_effect56(i, plr)
	plr:linear(0.132):rotationz(-35)
end

local function plr_effect57(i, plr)
	plr:linear(0.132):rotationz(-70)
end

local function plr_effect58(i, plr)
	plr:linear(0.132):rotationz(0):zoomx(1.5)
end

local function plr_effect59(i, plr)
	plr:linear(0.132):zoomx(2)
end

local function plr_effect60(i, plr)
	plr:linear(0.132):zoomx(2.5)
end

local function plr_effect61(i, plr)
	plr:linear(0.132):zoomy(0.8)
end

local function plr_effect62(i, plr)
	plr:linear(0.132):zoomy(0.6)
end

local function plr_effect63(i, plr)
	plr:linear(0.132):zoomy(0.4)
end

local function plr_effect64(i, plr)
	plr:linear(0.789):zoomto(1,1):rotationy(360)
end

local function plr_effect64a(i, plr)
	plr:rotationy(0)
end

local function plr_effect65(i, plr)
	plr:linear(0.132):rotationx(180)
end

local function plr_effect66(i, plr)
	plr:linear(0.132):rotationx(0)
end

local function plr_effect67(i, plr)
	plr:linear(0.132):rotationy(20 * (-1)^i)
end

local function plr_effect68(i, plr)
	plr:linear(0.132):zoomx(1.2)
end

local function plr_effect69(i, plr)
	plr:linear(0.132):zoom(1.3)
end

local function plr_effect70(i, plr)
	plr:linear(0.132):zoom(1.6)
end

local function plr_effect71(i, plr)
	plr:linear(0.132):zoom(1.9)
end

local function plr_effect72(i, plr)
	plr:linear(0.132):zoom(0):rotationy(0)
end

local function plr_effect73(i, plr)
	plr:linear(0.132):zoom(1 + 0.2 * (-1)^i)
end

local function plr_effect74(i, plr)
	plr:linear(0.132):zoom(1 + 0.4 * (-1)^i)
end

local function plr_effect75(i, plr)
	plr:linear(0.132):zoomy(1 - 0.2 * (-1)^i)
end

local function plr_effect76(i, plr)
	plr:linear(0.132):x(luamod_enabled_players[i].initial_x_pos - 30 * (-1)^i)
end

local function plr_effect77(i, plr)
	plr:linear(0.132):rotationz(-20 * (-1)^i)
end

local function plr_effect78(i, plr)
	plr:accelerate(0.790):rotationz(8*360 * (-1)^i)
end

local function plr_effect79(i, plr)
	plr:linear(0.132):zoom(1):rotationz(0):x(luamod_enabled_players[i].initial_x_pos)
end

local function plr_effect80(i, plr)
	plr:linear(4.210):bob():effectperiod(2):effectclock('beat'):effectmagnitude(50,0,0)
end

local function plr_effect81(i, plr)
	plr:linear(0.132):zoom(0.75)
end

local function plr_effect82(i, plr)
	plr:linear(0.132):zoom(0.5)
end

local function plr_effect83(i, plr)
	plr:linear(0.132):zoom(0.25)
end

local function plr_effect84(i, plr)
	plr:linear(0.263):zoom(1):rotationz(-50)
end

local function plr_effect85(i, plr)
	plr:linear(0.263):zoom(1.75):rotationz(50)
end

local function plr_effect86(i, plr)
	plr:linear(0.263):zoom(4):rotationz(0)
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
	-- {1.000, func = plr_effect0},
	{11.500, func = plr_effect1},
	{12.500, func = plr_zoom_reset},
	{16.000, func = plr_effect2},
	{17.500, func = plr_effect3},
	{28.000, func = plr_effect4},
	{28.500, func = plr_effect5},
	{29.000, func = plr_effect6},
	{31.000, func = plr_effect5},
	{31.500, func = plr_effect4},
	{32.000, func = plr_effect7},
	{34.000, func = plr_effect8},
	{35.000, func = plr_effect9},
	
	-- Active time
	{36.000, func = plr_effect10},
	{37.000, func = plr_effect11},
	{37.500, func = plr_effect12},
	{38.500, func = plr_effect13},
	{39.500, func = plr_effect14},
	{40.000, func = plr_effect15},
	{40.000, func = plr_effect16},
	{40.500, func = plr_effect17},
	{41.000, func = plr_effect18},
	{41.500, func = plr_stopeffect},
	{44.000, func = plr_effect19},
	{44.500, func = plr_effect20},
	{45.000, func = plr_effect21},
	{45.500, func = plr_effect22},
	{46.500, func = plr_effect23},
	{47.500, func = plr_effect24},
	{48.000, func = plr_effect25},

	-- Dreamy
	{52.000, func = plr_effect26},
	{60.000, func = plr_stopeffect},
	{60.000, func = plr_effect27},
	{60.500, func = plr_effect28},
	{61.000, func = plr_effect29},
	{63.500, func = plr_effect30},
	{64.500, func = plr_effect31},
	{65.500, func = plr_effect32},
	{70.000, func = plr_effect33},
	{71.000, func = plr_effect34},

	-- Dump
	{72.000, func = plr_effect35},
	{102.000, func = plr_stopeffect},
	{102.500, func = plr_effect36},
	{103.000, func = plr_effect37},

	-- Active time pt.2
	{104.000, func = plr_effect38},
	{105.000, func = plr_effect39},
	{105.500, func = plr_effect40},
	{106.500, func = plr_effect41},
	{107.500, func = plr_effect42},
	{108.000, func = plr_effect43},
	{108.500, func = plr_effect44},
	{109.000, func = plr_effect45},
	{111.500, func = plr_effect46},
	{112.000, func = plr_zoom_reset},
	{112.500, func = plr_effect47},
	{113.000, func = plr_effect48},
	{113.500, func = plr_effect49},
	{114.500, func = plr_effect50},
	{115.500, func = plr_effect51},
	{116.000, func = plr_effect52},
	{117.500, func = plr_effect53},
	{120.000, func = plr_effect54},
	{121.000, func = plr_effect55},
	{121.500, func = plr_effect56},
	{122.500, func = plr_effect57},
	{123.500, func = plr_effect56},
	{124.500, func = plr_effect55},
	{125.500, func = plr_effect56},
	{126.000, func = plr_effect57},
	{127.000, func = plr_effect56},
	{128.000, func = plr_effect58},
	{128.500, func = plr_effect59},
	{129.000, func = plr_effect60},
	{131.000, func = plr_effect61},
	{131.500, func = plr_effect62},
	{132.000, func = plr_effect63},
	{134.000, func = plr_effect64},

	-- Active time pt.3 (which is actually just a repetition of the first half of the song)
	{136.000, func = plr_effect10},
	{136.000, func = plr_effect64a},
	{137.000, func = plr_effect65},
	{137.500, func = plr_effect66},
	{138.500, func = plr_effect67},
	{139.500, func = plr_effect68},
	{140.000, func = plr_effect15},
	{140.000, func = plr_effect69},
	{140.500, func = plr_effect70},
	{141.000, func = plr_effect71},
	{141.500, func = plr_stopeffect},
	{144.000, func = plr_effect72},
	{144.500, func = plr_effect73},
	{145.000, func = plr_effect74},
	{145.500, func = plr_effect75},
	{146.500, func = plr_effect76},
	{147.500, func = plr_effect77},
	{148.000, func = plr_effect78},
	{150.000, func = plr_effect79},

	{152.000, func = plr_effect80},
	{160.000, func = plr_stopeffect},
	{160.000, func = plr_effect81},
	{160.500, func = plr_effect82},
	{161.000, func = plr_effect83},
	{163.500, func = plr_effect84},
	{164.500, func = plr_effect85},
	{165.500, func = plr_effect86},
}

-- ==================================================================================
-- Insert one-shot lua functions below that affects the gameplay screen
-- ==================================================================================
local function scrn_effect0(screen)
	screen:linear(0.132):zoom(3)
	screen:x(main__topscreen_table.initial_x_pos - (3*SCREEN_WIDTH - SCREEN_WIDTH)/2)
	screen:y(main__topscreen_table.initial_y_pos - (3*SCREEN_HEIGHT - SCREEN_HEIGHT)/2)
end

local function scrn_effect1(screen)
	screen:linear(0.132):zoom(1.2)
	screen:x(main__topscreen_table.initial_x_pos - (1.2*SCREEN_WIDTH - SCREEN_WIDTH)/2)
	screen:y(main__topscreen_table.initial_y_pos - (1.2*SCREEN_HEIGHT - SCREEN_HEIGHT)/2)
end

local function scrn_effect2(screen)
	screen:linear(0.132):zoom(1.4)
	screen:x(main__topscreen_table.initial_x_pos - (1.4*SCREEN_WIDTH - SCREEN_WIDTH)/2)
	screen:y(main__topscreen_table.initial_y_pos - (1.4*SCREEN_HEIGHT - SCREEN_HEIGHT)/2)
end

local function scrn_effect3(screen)
	screen:linear(0.132):zoom(1.6)
	screen:x(main__topscreen_table.initial_x_pos - (1.6*SCREEN_WIDTH - SCREEN_WIDTH)/2)
	screen:y(main__topscreen_table.initial_y_pos - (1.6*SCREEN_HEIGHT - SCREEN_HEIGHT)/2)
end

local function scrn_effect4(screen)
	screen:linear(0.132):zoom(0.8)
	screen:x(main__topscreen_table.initial_x_pos - (0.8*SCREEN_WIDTH - SCREEN_WIDTH)/2)
	screen:y(main__topscreen_table.initial_y_pos - (0.8*SCREEN_HEIGHT - SCREEN_HEIGHT)/2)
end

local function scrn_effect5(screen)
	screen:linear(0.132):zoom(0.6)
	screen:x(main__topscreen_table.initial_x_pos - (0.6*SCREEN_WIDTH - SCREEN_WIDTH)/2)
	screen:y(main__topscreen_table.initial_y_pos - (0.6*SCREEN_HEIGHT - SCREEN_HEIGHT)/2)
end

local function scrn_effect6(screen)
	screen:linear(0.132):zoom(0.4)
	screen:x(main__topscreen_table.initial_x_pos - (0.4*SCREEN_WIDTH - SCREEN_WIDTH)/2)
	screen:y(main__topscreen_table.initial_y_pos - (0.4*SCREEN_HEIGHT - SCREEN_HEIGHT)/2)
end

local function scrn_effect_rst(screen)
	screen:linear(0.132):zoom(1)
	screen:x(main__topscreen_table.initial_x_pos - (1*SCREEN_WIDTH - SCREEN_WIDTH)/2)
	screen:y(main__topscreen_table.initial_y_pos - (1*SCREEN_HEIGHT - SCREEN_HEIGHT)/2)
end

local function scrn_reset(screen)
	screen:stopeffect():stoptweening():x(SCREEN_LEFT):y(SCREEN_TOP):rotationz(0):zoom(1)
end

-- The functions you defined above should now be put in this table.
-- These functions will be called only once after the chart is past the specified beat.
-- {start_beat, function_name},
user_content__oneshot_screen_lua_functions = {
	-- {1.000, func = scrn_effect0},
	{42.000, func = scrn_effect1},
	{42.500, func = scrn_effect2},
	{43.000, func = scrn_effect3},
	{44.000, func = scrn_effect_rst},
	{142.000, func = scrn_effect4},
	{142.500, func = scrn_effect5},
	{143.000, func = scrn_effect6},
	{144.000, func = scrn_effect_rst},
}


-- ==================================================================================
-- Insert custom lua functions below
-- ==================================================================================
function user_content__on_update_other()
	if general_values.beat >= 11.5 and user_content__msg_broadcasts[user_content__msg_broadcast_cnt] == 'ThumbseyePopup' then
		-- SCREENMAN:SystemMessage("popup")
		MESSAGEMAN:Broadcast('ThumbseyePopup')
		user_content__msg_broadcast_cnt = user_content__msg_broadcast_cnt + 1
	end

	if general_values.beat >= 111.5 and user_content__msg_broadcasts[user_content__msg_broadcast_cnt] == 'ThumbseyePopup2' then
		MESSAGEMAN:Broadcast('ThumbseyePopup2')
		user_content__msg_broadcast_cnt = user_content__msg_broadcast_cnt + 1
	end
end

return Def.ActorFrame{
	-- Create a quad that is invisible and does nothing, this is the actual part that keeps the ActorFrame alive
	Def.Quad{
		Name= "I may be sleeping, but I preserve the world.",
		InitCommand= cmd(visible,false),
		OnCommand= cmd(sleep,1000),
	},

	Def.Sprite{
		Name="Mii",
		Texture="assets/Thumbseye.png",
		OnCommand=function(self)
			self:SetWidth(400):SetHeight(400):x(SCREEN_CENTER_X):y(SCREEN_BOTTOM+200)
		end,

		ThumbseyePopupMessageCommand=function(self)
			self:linear(0.263):y(SCREEN_BOTTOM - 200)
				:sleep(0.263):y(SCREEN_BOTTOM + 200)
		end,

		ThumbseyePopup2MessageCommand=function(self)
			self:SetWidth(1.5*SCREEN_WIDTH):linear(0.263):y(SCREEN_BOTTOM - 200)
				:sleep(0.263):y(SCREEN_BOTTOM + 200)
		end,
	},
	
}
