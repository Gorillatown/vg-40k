/datum/item_artifact/harm
	name = "Harming Effect"
	desc = "An effect that harms."
	charge = 200

/datum/item_artifact/harm/item_act(var/mob/living/M)
	to_chat(M, "<span class='warning'>You feel an intense pain throughout all of your body!</span>")
	M.adjustOxyLoss(10)
	M.take_organ_damage(10,0)
	M.take_organ_damage(0,10)
	M.adjustToxLoss(10)
	