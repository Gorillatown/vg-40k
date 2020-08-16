/mob/living/hostage_brain
	name = "host brain"
	real_name = "host brain"

/mob/living/hostage_brain/say(var/message)
	to_chat(src, "<span class='warning'>You feel yourself attempt to speak, but your body doesn't obey.</span>")
	to_chat(src, "<span class='warning'>Somethings clearly wrong with this dream.</span>")
	return

/mob/living/hostage_brain/emote(act, m_type = null, message = null, ignore_status = FALSE)
	return
