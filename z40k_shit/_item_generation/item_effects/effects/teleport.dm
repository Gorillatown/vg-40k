/datum/item_artifact/tele
	name = "Teleportation Effect"
	desc = "An effect that teleports."
	charge = 200

/datum/item_artifact/tele/item_act(var/mob/living/M)
	to_chat(M,"<span class='warning'>You suddenly appear somewhere else!</span>")
	do_teleport(M, get_turf(M), 20, asoundin = 'sound/effects/phasein.ogg')
	