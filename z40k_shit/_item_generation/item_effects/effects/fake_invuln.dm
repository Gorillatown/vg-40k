/datum/item_artifact/fake
	name = "Fake Effect"
	desc = "Makes a gullible person die."
	
/datum/item_artifact/fake/item_act(var/mob/living/M)
	to_chat(M, "<span class='warning'> You feel invincible!</span>")
	