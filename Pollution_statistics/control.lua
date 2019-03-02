local display_rate = settings.global["stat-display-rate"].value
local polling_rate = settings.global["stat-polling-rate"].value
local scale_constant = 1/(settings.global["stat-scale-constant"].value)

if display_rate == polling_rate then
	stat_error = true
end
script.on_nth_tick(display_rate, function()
	if global.stat_init == false then
		global.stats_player_stats.on_flow("pollution",global.stat_new_pollution)
	end
end)

script.on_nth_tick(polling_rate, function()
	if game.forces["enemy"] and game.forces["player"] and not stat_error then
		if global.stat_init == true then
			global.stats_player_stats = game.forces['player'].item_production_statistics
			global.last_evo = game.forces['enemy'].evolution_factor_by_pollution
			global.stat_init = false
		end
		local evo = game.forces['enemy'].evolution_factor_by_pollution
		local new_pollution = math.floor((evo - global.last_evo)*10^6) --1000000000; tick= 240
		global.stat_new_pollution = new_pollution*(240/polling_rate)*display_rate*scale_constant
		global.last_pollution = new_pollution
		global.last_evo = evo
	else
		if stat_error then
			game.print("ERROR: POLLING RATE MUST NOT EQUAL DISPLAY RATE")
		else
			game.print("ERROR: The pollution statistics mod only works in singleplayer or in multiplayer for only the 'player' force.")
			game.print("Player or enemy force not found.")
		end
	end
end)

script.on_init(function()
	global.stat_init = true
	global.last_evo = 0
	global.last_pollution = 0	
	global.stat_new_pollution = 0
end)