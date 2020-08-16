/datum/item_artifact/tk
	name = "Telekinesis Effect"
	desc = "Makes you very clever."

/datum/item_artifact/tk/item_act(var/mob/living/M)
		M.mutations.Add(M_TK)
		M.update_mutations()
		