/datum/roguelike_effects/raise
	name = "Beckons spirits"
	desc = "Will summon those who have recently passed in a twisted form."

/datum/roguelike_effects/raise/re_effect_act(mob/living/M, obj/item/I)
	if(..())
		return
	for(var/mob/dead/G in player_list)
		if(G.mind && G.key)
			G.loc = get_turf(M)
			var/mob/living/S = new /mob/living/simple_animal/shade(M.loc)
			S.name = "Spectre"
			S.real_name = "Spectre"
			G.mind.transfer_to(S)
