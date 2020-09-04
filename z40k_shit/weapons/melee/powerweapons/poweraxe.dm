/obj/item/weapon/enginseer_poweraxe 
	name = "Gear Poweraxe"
	desc = "Its a axe that is normally attached to a enginseer at all times, doubles as a set of tools too."
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/32x32axes_swords_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/32x32axes_swords_right.dmi')
	icon = 'z40k_shit/icons/obj/weapons.dmi'
	icon_state = "mechaxe"
	item_state = "mechaxe"
	hitsound = 'sound/weapons/bloodyslice.ogg'
	siemens_coefficient = 1
	force = 30
	throwforce = 5
	throw_speed = 5
	throw_range = 7
	w_class = W_CLASS_MEDIUM
	sharpness = 1.2
	sharpness_flags = SHARP_TIP | SHARP_BLADE | SERRATED_BLADE | CHOPWOOD | CUT_WALL | CUT_AIRLOCK | HOT_EDGE
	attack_verb = list("attacks", "slashes",  "slices", "tears", "rips", "dices", "cuts", "slamdunks")
	actions_types = list(/datum/action/item_action/warhams/basic_swap_stance)

	var/obj/item/enginseer_powerpack/our_pack

/obj/item/weapon/enginseer_poweraxe/New()
	..()

/obj/item/weapon/enginseer_poweraxe/is_screwdriver(var/mob/user)
	return TRUE

/obj/item/weapon/enginseer_poweraxe/is_wrench(var/mob/user)
	return TRUE

/obj/item/weapon/enginseer_poweraxe/Destroy()
	our_pack = null
	..()

/obj/item/weapon/enginseer_poweraxe/dropped(mob/user) //If we drop this, we return to pack.
	..()
	if(our_pack)
		our_pack.axe_out = FALSE
		src.forceMove(our_pack)
		our_pack.update_icon()
		update_icon()

/obj/item/weapon/enginseer_poweraxe/throw_impact(atom/hit_atom, mob/user) //If we throw this, we return to pack.
	..()
	if(isturf(hit_atom))
		src.forceMove(our_pack)
		update_icon()

	if(our_pack)
		our_pack.axe_out = FALSE
		our_pack.update_icon()

/obj/item/weapon/enginseer_poweraxe/interpret_powerwords(mob/living/target, mob/living/user, def_zone, var/originator = null)
	..()
	var/mob/living/carbon/human/H = user
	var/mob/living/carbon/human/T = target

	switch(H.word_combo_chain)
		if("hurthurtknockbackhurt") //hurt hurt knockback hurt
			user.visible_message("<span class='danger'>[H] lands a extra hard swing on [T]!</span>")
			target.adjustBruteLoss(35)
			H.word_combo_chain = ""
//			H.update_powerwords_hud(clear = TRUE)
		if("hurthurthurthurthurt")
			user.visible_message("<span class='danger'>[H] swings and cleaves everything in front of them!")
			var/turf/starter = get_step(user,user.dir)
			var/turf/sideone = get_step(starter,turn(user.dir,90))
			var/turf/sidetwo = get_step(starter,turn(user.dir,-90))
			for(var/turf/RAAAGH in list(starter, sideone, sidetwo))
				for(var/mob/living/MENS in RAAAGH)
					MENS.attackby(src,user)
			H.word_combo_chain = ""
//			H.update_powerwords_hud(clear = TRUE)
		if("chargeknockbackhurt")
			user.visible_message("<span class='danger'>[H] follows up with a lunge into [T]!")
			target.adjustBruteLoss(15)
			T.attackby(src,user)
			H.word_combo_chain = ""
//			H.update_powerwords_hud(clear = TRUE)