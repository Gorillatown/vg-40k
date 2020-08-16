/datum/item_artifact/heal
	name = "Healing Effect"
	desc = "An effect that heals."
	charge = 200

/datum/item_artifact/heal/item_act(var/mob/living/M)
	to_chat(M,"<span class='warning'>You feel much better.</span>")
	M.adjustOxyLoss(-25)
	M.heal_organ_damage(25,0)
	M.heal_organ_damage(0,25)
	M.adjustToxLoss(-25)
	