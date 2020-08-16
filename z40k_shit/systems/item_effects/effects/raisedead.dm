/datum/item_artifact/raise
	name = "Summon Spectre Effect"
	desc = "Makes you call the dead."

/datum/item_artifact/raise/item_act(var/mob/living/M)
	for(var/mob/dead/G in world)
		if(G.mind && G.key)
			G.loc = get_turf(M)
			var/mob/living/S = new /mob/living/simple_animal/shade(M.loc)
			S.name = "Spectre"
			S.real_name = "Spectre"
			G.mind.transfer_to(S)
			S.key = G.key
			