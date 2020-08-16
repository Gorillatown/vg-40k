/datum/item_artifact/ignite
	name = "Fire Curse"
	desc = "A curse that sets people on fire."
	charge = 100

/datum/item_artifact/ignite/item_act(var/mob/living/M)
	to_chat(M, "<span class='warning'> You burst into flames!</span>")
	M.fire_stacks += 5
	M.IgniteMob()
