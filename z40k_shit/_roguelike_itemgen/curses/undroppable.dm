/datum/roguelike_effects/undroppable
	name = "Undroppable Item"
	desc = "Curses the item so that any victim who tries to pick it up will not be able to drop it, as it will be stuck to them."
	cooldown_max = 10

/datum/roguelike_effects/undroppable/re_effect_act(mob/living/M, obj/item/I)
	I.canremove = FALSE
