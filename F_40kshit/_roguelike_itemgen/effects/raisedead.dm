/datum/roguelike_effects/raise
	name = "Beckons spirits"
	desc = "Beckons things from the warp, along with those who have recently passed."
	cooldown_max = 10

/datum/roguelike_effects/raise/re_effect_act(mob/living/M, obj/item/I)
	if(..())
		return
	for(var/mob/dead/G in player_list)
		if(!G.client)
			continue
		else
			if(G.mind && G.key)
				var/mob/living/S = new /mob/living/simple_animal/hostile/retaliate/daemon/daemonette(M.loc)
				G.mind.transfer_to(S)
