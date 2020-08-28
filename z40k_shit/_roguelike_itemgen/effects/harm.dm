/datum/roguelike_effects/harm
	name = "Harming Effect"
	desc = "An effect that harms."
	cooldown_max = 10

/datum/roguelike_effects/harm/re_effect_act(mob/living/M, obj/item/I)
	..()
	to_chat(M, "<span class='warning'>You feel an intense pain throughout all of your body!</span>")
	M.adjustOxyLoss(10)
	M.take_organ_damage(10,0)
	M.take_organ_damage(0,10)
	M.adjustToxLoss(10)