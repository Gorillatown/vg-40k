/datum/item_power/hulk
	name = "Hulk Mutation"
	desc = "Makes you a hulk."

/datum/item_power/hulk/init_mob(var/mob/living/carbon/H)
	H.mutations.Add(M_HULK)
	H.update_mutations()