/spell/targeted/battle_dance
	name = "Battle Dance"
	desc = "Jump from person to person."
	override_base = "cult" //The area behind tied into the panel we are attached to
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	//overlay_icon_state = "spell"
	//hud_state = "slaanesh" //name of the icon used in generating the spell hud object ontop of the base
	school = "mime"
	panel = "Mime"
	invocation_type = SpI_NONE
	charge_max = 500
	spell_flags = INCLUDEUSER
	range = 0
	max_targets = 1

//	hud_state = "mime_oath"
//	override_base = "const"

/spell/targeted/battle_dance/cast(list/targets)
	for(var/mob/living/carbon/human/H in targets)
		if(H.gender == MALE)
			var/mimelaugh = pick('z40k_shit/sounds/mimelaugh1.ogg','z40k_shit/sounds/mimelaugh2.ogg')
			playsound(H.loc, mimelaugh, 75, 0)
		else
			var/mimelaugh = pick('z40k_shit/sounds/mimelaughf1.ogg','z40k_shit/sounds/mimelaughf2.ogg')
			playsound(H.loc, mimelaugh, 75, 0)
		var/datum/effect/effect/system/smoke_spread/smoke = new /datum/effect/effect/system/smoke_spread()
		smoke.set_up(10, 0, H.loc)
		smoke.time_to_live = 10 SECONDS //unusually short smoke
		smoke.start()
		H.dodging = TRUE
		for(var/mob/living/O in viewers(world.view, H.loc))
			if(O == H)
				continue
			H.loc = O.loc
			if(ishuman(O))
				to_chat(O, "<font color='red'>[H] Lunges at you!</font>")
				O.apply_effects(0,4)
			sleep(10)
		H.dodging = FALSE

