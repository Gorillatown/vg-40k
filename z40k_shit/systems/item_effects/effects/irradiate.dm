/datum/item_artifact/radiate
	name = "Radiation Effect"
	desc = "Makes you get radiation problems."

/datum/item_artifact/tk/item_act(var/mob/living/M)
		randmutb(M)
		randmutb(M)
		M.apply_effect(50,IRRADIATE,0)
		M.update_mutations()
		