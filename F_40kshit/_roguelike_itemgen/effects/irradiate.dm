/datum/roguelike_effects/radiate
	name = "Radiation Effect"
	desc = "Erupts in radiation."

/datum/roguelike_effects/radiate/re_effect_act(mob/living/M, obj/item/I)
	if(..())
		return
	randmutb(M)
	randmutb(M)
	M.apply_radiation(25, RAD_EXTERNAL)
	M.update_mutations()
		