/datum/roguelike_effects/raise
	name = "Warp Effect"
	desc = "Beckons things from the warp"
	cooldown_max = 10
	var/daemonette_limit = 0

/datum/roguelike_effects/raise/re_effect_act(mob/living/M, obj/item/I)
	if(..())
		return
	for(var/mob/dead/G in player_list)
		daemonette_limit++
		if(!G.client)
			continue
		else
			if(G.mind && G.key)
				var/mob/living/S = new /mob/living/simple_animal/hostile/retaliate/daemon/daemonette(M.loc)
				G.mind.transfer_to(S)
		if(daemonette_limit > 3)
			daemonette_limit = 0
			break