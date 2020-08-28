/datum/roguelike_effects/curses/ignite
	name = "Fire Curse"
	desc = "A curse that sets people on fire."
	cooldown_max = 5

/datum/roguelike_effects/curses/ignite/re_effect_act(mob/living/M, obj/item/I)
	if(..())
		return
	to_chat(M, "<span class='warning'> You burst into flames!</span>")
	M.fire_stacks += 5
	M.IgniteMob()
