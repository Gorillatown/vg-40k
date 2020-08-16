/spell/aoe_turf/waaagh1	//Raaagh
	name = "WAAAGH!"
	abbreviation = "WG"
	desc = "Makes ya faster (And heals if theres more than 4 orks around you)"
	panel = "Racial Abilities"
	override_base = "ork"
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	hud_state = "racial_waagh"
	spell_flags = INCLUDEUSER
	charge_type = Sp_RECHARGE
	charge_max = 190
	invocation_type = SpI_NONE
	range = 4
	cast_sound = 'z40k_shit/sounds/waagh1.ogg'
	still_recharging_msg = "<span class='notice'>You ain't ready yet idiot..</span>"

/spell/aoe_turf/waaagh1/cast(list/targets, mob/user)
	//var/healcounter
	for(var/T in targets)
		var/mob/living/carbon/human/H = T
		H.vis_contents += new /obj/effect/overlay/weak_green_circle(H,10)
		H.movement_speed_modifier += 0.2
		//healcounter++
		spawn(3 SECONDS)
			H.movement_speed_modifier -= 0.2

	/*		
	if(healcounter >= 5)
		for(var/T in targets)
			var/mob/living/carbon/human/H = T
			H.vis_contents += new /obj/effect/overlay/greensparkles(H,10)
			H.adjustBruteLoss(-15)
			H.adjustFireLoss(-15)
			H.adjustToxLoss(-15)
			H.adjustOxyLoss(-15)
			to_chat(H,"Your body courses with energy.")
			for(var/datum/organ/internal/I in H.internal_organs)
				if(prob(50))
					if(I && I.damage > 0)
						I.damage = max(0, I.damage - 4)
					if(I)
						I.status &= ~ORGAN_BROKEN
						I.status &= ~ORGAN_SPLINTED
						I.status &= ~ORGAN_BLEEDING
			for(var/datum/organ/external/O in H.organs)
				if(prob(50))
					O.status &= ~ORGAN_BROKEN
					O.status &= ~ORGAN_SPLINTED
					O.status &= ~ORGAN_BLEEDING
	*/
	
	if(isgretchin(user))
		user.say("AaAaAaHH!")
		playsound(user, 'z40k_shit/sounds/gretscream3.ogg',100)
	else
		user.say("WAAAAGH!")
		playsound(user, 'z40k_shit/sounds/waagh1.ogg', 100)

/spell/aoe_turf/waaagh1/choose_targets(var/mob/user = usr)
	var/list/targets = list()
	for(var/mob/living/carbon/C in view(4, user))
		if(isork(C))
			if(C.stat != DEAD)
				targets += C

	if (!targets.len)
		to_chat(user, "<span class='warning'>There are no targets.</span>")
		return FALSE

	return targets

/spell/aoe_turf/warbosswaaagh	//Raaagh
	name = "WAAAGH!"
	abbreviation = "WG"
	desc = "Makes ya faster and stronger.(Along with ya boyz)"
	panel = "Racial Abilities"
	override_base = "racial"
	hud_state = "racial_waagh"
	spell_flags = INCLUDEUSER
	charge_type = Sp_RECHARGE
	charge_max = 150
	invocation_type = SpI_NONE
	range = 8
	cast_sound = 'z40k_shit/sounds/waagh1.ogg'
	still_recharging_msg = "<span class='notice'>You ain't ready yet idiot..</span>"

/spell/aoe_turf/warbosswaaagh/cast(list/targets, mob/user)
	for(var/T in targets)
		var/mob/living/carbon/human/H = T
		H.vis_contents += new /obj/effect/overlay/strong_green_circle(H,12 SECONDS)
		H.movement_speed_modifier += 1.0
		H.attribute_strength += 5
		to_chat(H,"Your body courses with power.")
		spawn(12 SECONDS)
			H.attribute_strength -= 5
			H.movement_speed_modifier -= 1.0

	user.say("WAAAAGH!")
	playsound(user, 'z40k_shit/sounds/warbosswaaagh.ogg', 100)

/spell/aoe_turf/warbosswaaagh/choose_targets(var/mob/user = usr)
	var/list/targets = list()
	for(var/mob/living/carbon/C in view(8, user))
		if(isork(C))
			if(C.stat != DEAD)
				targets += C

	if (!targets.len)
		to_chat(user, "<span class='warning'>There are no targets.</span>")
		return FALSE

	return targets

