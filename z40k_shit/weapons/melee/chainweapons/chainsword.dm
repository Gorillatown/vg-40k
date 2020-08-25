/obj/item/weapon/chainsword
	name = "Chainsword"
	desc = "A chainsword, that can probably saw through a great many things."
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/IGequipment_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/IGequipment_right.dmi')
	icon = 'z40k_shit/icons/obj/ig/IGequipment.dmi'
	icon_state = "chainsword"
	item_state = "chainsword"
	hitsound = 'z40k_shit/sounds/chainsword_swing.ogg'
	siemens_coefficient = 1
	slot_flags = SLOT_BELT
	force = 40
	throwforce = 5
	throw_speed = 5
	throw_range = 7
	w_class = W_CLASS_MEDIUM
	sharpness = 1.2
	sharpness_flags = SHARP_TIP | SHARP_BLADE | SERRATED_BLADE | CHOPWOOD | CUT_AIRLOCK
	attack_verb = list("attacks", "slashes",  "slices", "tears", "rips", "dices", "cuts", "saws")
	actions_types = list(/datum/action/item_action/warhams/begin_sawing,
						/datum/action/item_action/warhams/basic_swap_stance)

/obj/item/weapon/chainsword/New()
	. = ..()

/obj/item/weapon/chainsword/interpret_powerwords(mob/living/target, mob/living/user, def_zone, var/originator = null)
	..()
	var/mob/living/carbon/human/H = user
	var/mob/living/carbon/human/T = target

	switch(H.word_combo_chain)
		if("hurthurtknockbackhurt") //hurt hurt knockback hurt
			user.visible_message("<span class='danger'>[H] lands a extra hard swing!</span>")
			target.adjustBruteLoss(15)
			H.word_combo_chain = ""
			H.update_powerwords_hud(clear = TRUE)
		if("hurthurthurthurthurt")
			user.visible_message("<span class='danger'>[H] swings and cleaves everything in front of them!")
			var/turf/starter = get_step(user,user.dir)
			var/turf/sideone = get_step(starter,turn(user.dir,90))
			var/turf/sidetwo = get_step(starter,turn(user.dir,-90))
			for(var/turf/RAAAGH in list(starter, sideone, sidetwo))
				for(var/mob/living/MENS in RAAAGH)
					MENS.attackby(src,user)
			H.word_combo_chain = ""
			H.update_powerwords_hud(clear = TRUE)
		if("chargeknockbackhurt")
			user.visible_message("<span class='danger'>[H] follows up with a lunge into [T]!")
			target.adjustBruteLoss(15)
			T.attackby(src,user)
			H.word_combo_chain = ""
			H.update_powerwords_hud(clear = TRUE)