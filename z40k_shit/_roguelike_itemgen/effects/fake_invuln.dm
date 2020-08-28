/datum/roguelike_effects/fake
	name = "Feeling of Invincibility"
	desc = "Appears to make one feel invincible at a glance."

/datum/roguelike_effects/fake/re_effect_act(mob/living/M, obj/item/I)
	..()
	to_chat(M, "<span class='warning'> You feel invincible!</span>")
