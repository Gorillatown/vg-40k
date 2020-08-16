
/datum/item_artifact/hulk
	name = "Hulk Effect"
	desc = "Makes you big and strong."

/datum/item_artifact/hulk/item_act(var/mob/living/M)
		M.mutations.Add(M_HULK)
		M.update_mutations()
		