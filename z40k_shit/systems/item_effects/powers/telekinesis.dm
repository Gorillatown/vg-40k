/datum/item_power/tele
	name = "Tele Mutation"
	desc = "Makes you a TK."

/datum/item_power/tele/init_mob(var/mob/living/carbon/H)
	H.mutations.Add(M_TK)
	H.update_mutations()
