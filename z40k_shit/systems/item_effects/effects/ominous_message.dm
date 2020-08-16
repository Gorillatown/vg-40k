/datum/item_artifact/ominous
	name = "Ominous Effect"
	desc = "Makes a superstitious person spooked."
/datum/item_artifact/ominous/item_act(var/mob/living/M)
	to_chat(M, "<span class='warning'> A scream enters your mind and fades away!</span>")
	