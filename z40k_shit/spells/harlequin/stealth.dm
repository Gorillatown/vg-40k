/spell/targeted/stealth
	name = "Stealth"
	desc = "Hiding is like second nature to you."
	override_base = "cult" //The area behind tied into the panel we are attached to
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	school = "mime"
	panel = "Mime"
	invocation_type = SpI_NONE
	charge_max = 500
	spell_flags = INCLUDEUSER
	range = 0
	max_targets = 1

//	hud_state = "mime_oath"
//	override_base = "const"

/spell/targeted/stealth/cast(list/targets)
	set waitfor = 0
	for(var/mob/living/carbon/human/H in targets)
		H.invisibility = INVISIBILITY_LEVEL_TWO
		anim(H.loc,H,'z40k_shit/icons/mob/mobs.dmi',,"cloak",,H.dir)
		H.alpha = 1
		H.alphas["invisspell"] = 1
		to_chat(H, "<span class='notice'> You are now invisible to normal detection.</span>")
		
		for(var/mob/O in oviewers(H))
			O.show_message("[H.name] vanishes into thin air!",1)
		
	sleep(12 SECONDS)
	
	for(var/mob/living/carbon/human/H in targets)
		anim(H.loc,H,'z40k_shit/icons/mob/mobs.dmi',,"uncloak",,H.dir)
		H.alpha = initial(H.alpha)
		H.alphas.Remove("invisspell")
		to_chat(H, "<span class='notice'> You are now visible.</span>")
		for(var/mob/O in oviewers(H))
			O.show_message("[H.name] appears from thin air!",1)
		H.invisibility = 0

