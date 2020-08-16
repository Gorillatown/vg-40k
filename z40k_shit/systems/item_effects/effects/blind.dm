/datum/item_artifact/blind
	name = "Blindness Effect"
	desc = "A curse that robs a victim of their sight, for a time."
	charge = 200

/datum/item_artifact/stone/item_act(var/mob/living/M)
	to_chat(M,"<span class='warning'>You go blind!</span>")
	M.eye_blind = 10
	