/datum/roguelike_effects/teleportation
	name = "Teleportation Effect"
	desc = "An effect that teleports."
	cooldown_max = 10

/datum/roguelike_effects/teleportation/re_effect_act(mob/living/M, obj/item/I)
	..()
	to_chat(M,"<span class='warning'>You suddenly appear somewhere else!</span>")
	do_teleport(M, get_turf(M), 20, asoundin = 'sound/effects/phasein.ogg')