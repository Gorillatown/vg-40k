/obj/item/weapon/boss_choppa
	name = "large choppa"
	desc = "It seems to be a hammer, made from scrap.."
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/64x64huge_choppa_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/64x64huge_choppa_right.dmi')
	icon = 'z40k_shit/icons/obj/orks/32x64_ork_obj.dmi'
	icon_state = "big_choppa"
	item_state = "big_choppa"
	hitsound = 'z40k_shit/sounds/big_choppa.ogg'
	flags = TWOHANDABLE | MUSTTWOHAND
	siemens_coefficient = 1
	force = 90
	throwforce = 50
	throw_speed = 5
	throw_range = 7
	w_class = W_CLASS_LARGE
	sharpness = 50
	sharpness_flags = SHARP_TIP | SHARP_BLADE | CHOPWOOD | CUT_WALL | CUT_AIRLOCK
	attack_verb = list("attacks", "smashes",  "bludgeons", "tenderizes", "whams", "bops", "slamdunks")
	actions_types = list(/datum/action/item_action/warhams/basic_swap_stance,
						/datum/action/item_action/warhams/heavydef_swap_stance)

/obj/item/weapon/boss_choppa/prepickup(mob/living/user)
	if(user.attribute_strength >= 13)
		return 0
	else
		to_chat(user,"<span class='bad'> You lack the strength required to pick up this heavy metal blunt instrument.</span>")
		return 1

/obj/item/weapon/boss_choppa/interpret_powerwords(mob/living/target, mob/living/user, def_zone, var/originator = null)
	..()
	var/mob/living/carbon/human/H = user
	//var/mob/living/carbon/human/T = target

	switch(H.word_combo_chain)
		if("hurthurthurthurthurt")
			user.visible_message("<span class='danger'>[H] swings and cleaves everything in front of them!")
			H.stat_increase(ATTR_STRENGTH,25)
			var/turf/starter = get_step(user,user.dir)
			var/turf/sideone = get_step(starter,turn(user.dir,90))
			var/turf/sidetwo = get_step(starter,turn(user.dir,-90))
			for(var/turf/RAAAGH in list(starter, sideone, sidetwo))
				for(var/mob/living/MENS in RAAAGH)
					H.health += 10
					MENS.attackby(src,user)
			H.word_combo_chain = ""
			H.update_powerwords_hud(clear = TRUE)
