-- GLOBALS
local player_mods__plr_init_speed = {}
local prev_player_speed = {} -- We need to remember the 'old' speed when we want to calculate the stuff for the new speed, so we save the 'old' speed for each player in this array.
local mods_this_frame = {}


-- ============================================================================================================
-- LOCAL FUNCTIONS
-- ============================================================================================================

local function song_mod_internal(str, pn)
	local ps= GAMESTATE:GetPlayerState(pn)
	local pmods= ps:GetPlayerOptionsString('ModsLevel_Song')
	ps:SetPlayerOptions('ModsLevel_Song', pmods .. ', ' .. str)
end


local function song_mod(str, pn)
	song_mod_internal(str, 'PlayerNumber_P' .. pn)
end

-- add_mod() stores all the mods that need to be applied to the player (corresponding to the current iteration of the for loop), it receives the mods from the while loop below
local function add_mod(mod_str)
	mods_this_frame[#mods_this_frame+1]= mod_str
end

-- execute_mods() walks through mods_this_frame[] and concatenates all the different mods to be applied in this frame for the player, into one string. This string is then passed to song_mod()
local function execute_mods(pn)
	if #mods_this_frame <= 0 then return end
	local total_mod_str= ""
	for i, ms in ipairs(mods_this_frame) do
		if #total_mod_str > 0 then
			total_mod_str= total_mod_str .. ", "
		end
		total_mod_str= total_mod_str .. ms
	end
	song_mod(total_mod_str, pn)
end

-- ============================================================================================================
-- GLOBAL FUNCTIONS
-- ============================================================================================================

-- ============================================================================================================
-- The following functions are used to add tables in the mod table that will apply the speed mods to players.
-- We can't use double-quotation characters, so we escape the apostrophe instead.

-- Tween timing of speed mods works as follows. Starting with XMod as an example, a transition rate of *1 means that the tween is applied with a speed of -/+1x in one second.
-- So if for example we would like the notes to go from 1x to 2x in half a second, you would only have to put '*2 2x'. If you want it to go from 1x to 3x in half a second, you'd put '*4 2x'. Etcetera.
-- For CMod it's a bit confusing. Timing-wise, you need to treat it as if it were XMod. So you'll have to convert your CMod values to the XMod equivalent first to get your timing right.
-- Let's say we have a song with a tempo of 200 BPM, and the player has set their speed to C300. We want the notes to tween from C300 to C500 in half a second. This would be the equivalent of tweening from 1.5x to 2.5x
-- (a difference of 1x). Thus, what we would put is '*2 C500'.
-- Finally MMod. Tween timing with MMod is completely different. With MMod, a transition rate of *1 means that the MMod value will de-/increment with -/+1 in one second.
-- Thus, if the player has set m300 and you want it to go to m500 in half a second, you'd put '*400 m500'. Just like with XMod, you won't need to take the song's tempo into account (yay).

-- If we want our speed mod tweens to be in time to the beat, we need to calculate what I call the 'base rate', since the transition rates are based on time and not beats.
-- We do this by dividing 1 by the amount of time (in seconds) you want the transition to take.
-- But that's only half of the required calculations, as the above examples have already shown. The amount of change that needs to be made from the current value to the next value will also determine the final transition rate.
-- ============================================================================================================


-- Apply a speed mod with a specific value to the player(s). tween_time in seconds. scroll_speed is expressed in BPM at 1x. A specific player can be targeted with pn (optional).
function player_mods__add_speed_mod_absolute(beat, tween_time, scroll_speed, pn)
	local base_rate = 1 / tween_time
	local xrate = scroll_speed / user_content__bpm
	local xrate_diff
	local scroll_diff
	
	if pn then
		if main__topscreen_table.actor:GetChild('PlayerP' .. pn) then
			
			if player_mods__plr_init_speed[pn].speedModType == 'x' then
				xrate_diff = math.abs(xrate - prev_player_speed[pn])
				user_content__mods[#user_content__mods+1] = {beat, '*' .. base_rate * xrate_diff .. ' ' .. xrate .. 'x', pn}
				prev_player_speed[pn] = xrate
			elseif player_mods__plr_init_speed[pn].speedModType == 'C' then
				scroll_diff = math.abs(scroll_speed - prev_player_speed[pn])
				user_content__mods[#user_content__mods+1] = {beat, '*' .. (base_rate * scroll_diff) / user_content__bpm .. ' ' .. 'C' .. scroll_speed, pn}
				prev_player_speed[pn] = scroll_speed
			elseif player_mods__plr_init_speed[pn].speedModType == 'm' then
				scroll_diff = math.abs(scroll_speed - prev_player_speed[pn])
				user_content__mods[#user_content__mods+1] = {beat, '*' .. base_rate * scroll_diff .. ' ' .. 'm' .. scroll_speed, pn}
				prev_player_speed[pn] = scroll_speed
			else
				-- We shouldn't be ending up here, if we do, something went wrong.
				SCREENMAN:SystemMessage('[ERROR] No valid speed type detected for Player ' .. pn)
			end
		end
	else
		for i,v in pairs(player_mods__plr_init_speed) do		
			if v.speedModType == 'x' then
				xrate_diff = math.abs(xrate - prev_player_speed[i])
				user_content__mods[#user_content__mods+1] = {beat, '*' .. base_rate * xrate_diff .. ' ' .. xrate .. 'x', v.playerNo}
				prev_player_speed[i] = xrate
			elseif v.speedModType == 'C' then
				scroll_diff = math.abs(scroll_speed - prev_player_speed[i])
				user_content__mods[#user_content__mods+1] = {beat, '*'.. (base_rate * scroll_diff) / user_content__bpm .. ' ' .. 'C' .. scroll_speed, v.playerNo}
				prev_player_speed[i] = scroll_speed
			elseif v.speedModType == 'm' then
				scroll_diff = math.abs(scroll_speed - prev_player_speed[i])
				user_content__mods[#user_content__mods+1] = {beat, '*' .. base_rate * scroll_diff .. ' ' .. 'm' .. scroll_speed, v.playerNo}
				prev_player_speed[i] = scroll_speed
			else
				-- We shouldn't be ending up here, if we do, something went wrong.
				SCREENMAN:SystemMessage('[ERROR] No valid speed type detected for Player ' .. v.playerNo)
			end
		end
	end
end

-- Apply speed mod to the player(s) that is a multiple of their own chosen speed. tween_time in seconds. A specific player can be targeted with pn (optional).
function player_mods__add_speed_mod_relative(beat, tween_time, multiplier, pn)
	local base_rate = 1 / tween_time
	local speed
	local speed_diff
	
	if pn then
		if main__topscreen_table.actor:GetChild('PlayerP' .. pn) then
			speed = multiplier * player_mods__plr_init_speed[pn].speedModValue
			speed_diff = math.abs(speed - prev_player_speed[pn])
			
			if player_mods__plr_init_speed[pn].speedModType == 'x' then
				user_content__mods[#user_content__mods+1] = {beat, '*' .. base_rate * speed_diff .. ' ' .. speed .. 'x', pn}
				prev_player_speed[pn] = speed
			elseif player_mods__plr_init_speed[pn].speedModType == 'C' then
				user_content__mods[#user_content__mods+1] = {beat, '*' .. (base_rate * speed_diff) / user_content__bpm .. ' ' .. 'C' .. speed, pn}
				prev_player_speed[pn] = speed
			elseif player_mods__plr_init_speed[pn].speedModType == 'm' then
				user_content__mods[#user_content__mods+1] = {beat, '*' .. base_rate * speed_diff .. ' ' .. 'm' .. speed, pn}
				prev_player_speed[pn] = speed
			else
				-- We shouldn't be ending up here, if we do, something went wrong.
				SCREENMAN:SystemMessage('[ERROR] No valid speed type detected for Player ' .. pn)
			end
		end
	else
		for i,v in pairs(player_mods__plr_init_speed) do
			speed = multiplier * v.speedModValue
			speed_diff = math.abs(speed - prev_player_speed[i])
			
			if v.speedModType == 'x' then
				user_content__mods[#user_content__mods+1] = {beat, '*' .. base_rate * speed_diff .. ' ' .. speed .. 'x', v.playerNo}
				prev_player_speed[i] = speed
			elseif v.speedModType == 'C' then
				user_content__mods[#user_content__mods+1] = {beat, '*' .. (base_rate * speed_diff) / user_content__bpm .. ' ' .. 'C' .. speed, v.playerNo}
				prev_player_speed[i] = speed
			elseif v.speedModType == 'm' then
				user_content__mods[#user_content__mods+1] = {beat, '*' .. base_rate * speed_diff .. ' ' .. 'm' .. speed, v.playerNo}
				prev_player_speed[i] = speed
			else
				-- We shouldn't be ending up here, if we do, something went wrong.
				SCREENMAN:SystemMessage('[ERROR] No valid speed type detected for Player ' .. v.playerNo)
			end
		end
	end
end

-- Derived function for the 'breathing' effect, allowing you to easily add a effect where the notes compress/decompress from/to the previous speed before the function was called.
-- The going back and forth happens symmetrically in time (in other words, it takes as long for the new speed to be applied as it takes for it to be undone).
function player_mods__linear_breathing(beat, undo_after, tween_time, multiplier, pn)
	local base_rate = 1 / tween_time
	local speed
	local speed_diff
	
	if pn then
		if main__topscreen_table.actor:GetChild('PlayerP' .. pn) then
			speed = multiplier * prev_player_speed[pn]
			speed_diff = math.abs(speed - prev_player_speed[pn])
			
			if player_mods__plr_init_speed[pn].speedModType == 'x' then
				user_content__mods[#user_content__mods+1] = {beat, '*' .. base_rate * speed_diff .. ' ' .. speed .. 'x', pn}
				user_content__mods[#user_content__mods+1] = {beat+undo_after, '*' .. base_rate * speed_diff .. ' ' .. prev_player_speed[pn] .. 'x', pn}
			elseif player_mods__plr_init_speed[pn].speedModType == 'C' then
				user_content__mods[#user_content__mods+1] = {beat, '*' .. (base_rate * speed_diff) / user_content__bpm .. ' ' .. 'C' .. speed, pn}
				user_content__mods[#user_content__mods+1] = {beat+undo_after, '*' .. (base_rate * speed_diff) / user_content__bpm .. ' ' .. 'C' .. prev_player_speed[pn], pn}
			elseif player_mods__plr_init_speed[pn].speedModType == 'm' then
				user_content__mods[#user_content__mods+1] = {beat, '*' .. base_rate * speed_diff .. ' ' .. 'm' .. speed, pn}
				user_content__mods[#user_content__mods+1] = {beat+undo_after, '*' .. base_rate * speed_diff .. ' ' .. 'm' .. prev_player_speed[pn], pn}
			else
				-- We shouldn't be ending up here, if we do, something went wrong.
				SCREENMAN:SystemMessage('[ERROR] No valid speed type detected for Player ' .. pn)
			end
		end
	else
		for i,v in pairs(player_mods__plr_init_speed) do
			speed = multiplier * prev_player_speed[i]
			speed_diff = math.abs(speed - prev_player_speed[i])
			
			if v.speedModType == 'x' then
				user_content__mods[#user_content__mods+1] = {beat, '*' .. base_rate * speed_diff .. ' ' .. speed .. 'x', v.playerNo}
				user_content__mods[#user_content__mods+1] = {beat+undo_after, '*' .. base_rate * speed_diff .. ' ' .. prev_player_speed[i] .. 'x', v.playerNo}
			elseif v.speedModType == 'C' then
				user_content__mods[#user_content__mods+1] = {beat, '*' .. (base_rate * speed_diff) / user_content__bpm .. ' ' .. 'C' .. speed, v.playerNo}
				user_content__mods[#user_content__mods+1] = {beat+undo_after, '*' .. (base_rate * speed_diff) / user_content__bpm .. ' ' .. 'C' .. prev_player_speed[i], v.playerNo}
			elseif v.speedModType == 'm' then
				user_content__mods[#user_content__mods+1] = {beat, '*' .. base_rate * speed_diff .. ' ' .. 'm' .. speed, v.playerNo}
				user_content__mods[#user_content__mods+1] = {beat+undo_after, '*' .. base_rate * speed_diff .. ' ' .. 'm' .. prev_player_speed[i], v.playerNo}
			else
				-- We shouldn't be ending up here, if we do, something went wrong.
				SCREENMAN:SystemMessage('[ERROR] No valid speed type detected for Player ' .. v.playerNo)
			end
		end
	end
end

-- ============================================================================================================

-- Initialize all players' mod counters. Each item's index corresponds to the table with the enabled players (see players__init_players())
function player_mods__init_player_mod_counters(curmod, enabled_players)
	for k in pairs(enabled_players) do
		curmod[k] = 1
	end
end

-- Takes care of inserting all custom speed mod changes with their appropriate values to the mods table
function player_mods__inject_speed_mods(enabled_players, plr_init_speed)
	-- In the beginning, the 'old' speed is of course the speed that the player starts with.
	for k in pairs(enabled_players) do
		prev_player_speed[k] = plr_init_speed[k].speedModValue
	end
	
	player_mods__plr_init_speed = plr_init_speed
	
	-- Get the player-based speed mods added
	user_content__speed_mods()
end

function player_mods__process_players_mods_table(curmod, player_mods, plr, beat)
	-- Go through the mod table and check what mods need to be applied this frame.
	-- If there is a specific player assigned to the mod and it matches the current iteration, add it to the mod string. Otherwise do nothing (except for increasing the counter).
	-- If there is no player specified, add it to the mod string since the mod is meant for all players.
	mods_this_frame = {}
	
	while curmod[plr] <= #player_mods and beat >= player_mods[curmod[plr]][1] do
		if player_mods[curmod[plr]][3] then
			if plr == player_mods[curmod[plr]][3] then
				add_mod(player_mods[curmod[plr]][2])
				curmod[plr] = curmod[plr]+1
			else
				curmod[plr] = curmod[plr]+1
			end
		else
			add_mod(player_mods[curmod[plr]][2])
			curmod[plr] = curmod[plr]+1
		end			
	end

	execute_mods(plr)
end
