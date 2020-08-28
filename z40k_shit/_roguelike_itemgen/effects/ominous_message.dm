/datum/roguelike_effects/ominous
	name = "Ominous Effect"
	desc = "Makes a superstitious person spooked."

/datum/roguelike_effects/ominous/re_effect_act(mob/living/M, obj/item/I)
	if(..())
		return
	to_chat(M, "<span class='warning'> A scream enters your mind and fades away!</span>")
	