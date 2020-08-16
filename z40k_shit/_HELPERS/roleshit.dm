// Will return a list of active candidates. It increases the buffer 5 times until it finds a candidate which is active within the buffer.
//Unlike the other ones, we don't require a role_id here. But for lazy sake i ain't removin the shit for proc param order.
/proc/get_all_active_candidates(var/role_id=null, var/buffer=ROLE_SELECT_AFK_BUFFER, var/poll=0)
	var/list/candidates = list() //List of candidate mobs to assume control of the new larva ~fuck you
	var/i = 0
	while(candidates.len <= 0 && i < 5)
		roleselect_debug("get_active_candidates(role_id=[role_id], buffer=[buffer], poll=[poll]): Player list is [player_list.len] items long.")
		for(var/mob/dead/observer/G in player_list)
			if(G.mind && G.mind.current && G.mind.current.stat != DEAD)
				roleselect_debug("get_active_candidates(role_id=[role_id], buffer=[buffer], poll=[poll]): Skipping [G]  - Shitty candidate.")
				continue

			if(((G.client.inactivity/10)/60) > buffer + i) // the most active players are more likely to become an alien
				roleselect_debug("get_active_candidates(role_id=[role_id], buffer=[buffer], poll=[poll]): Skipping [G]  - Inactive.")
				continue

			roleselect_debug("get_active_candidates(role_id=[role_id], buffer=[buffer], poll=[poll]): Selected [G] as candidate.")
			candidates += G
		i++
	return candidates

//Basically its a brute motherfucker, cause it donm't giver a shit n shit
/proc/brute_get_candidates()
	. = list()
	for(var/mob/dead/observer/G in player_list)
		if(!(G.mind && G.mind.current && G.mind.current.stat != DEAD))
			if(!G.client.is_afk())
				. += G.client
				