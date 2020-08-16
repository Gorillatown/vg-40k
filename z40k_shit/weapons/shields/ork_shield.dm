/obj/item/weapon/shield/orkshield
	name = "ork shield"
	desc = "WAAAGH, I AIN'T GETTIN HIT BY SHIT (about 50% of the time)."
	icon = 'z40k_shit/icons/obj/orks/orkequipment.dmi'
	icon_state = "nobshield"
	item_state = "nobshield"
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/orkequipment_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/orkequipment_right.dmi')
	siemens_coefficient = 1
	slot_flags = SLOT_BACK
	force = 15
	throwforce = 5.0
	throw_speed = 1
	throw_range = 4
	w_class = W_CLASS_LARGE
	starting_materials = list(MAT_IRON = 1000, MAT_GLASS = 7500)
	melt_temperature = MELTPOINT_GLASS
	origin_tech = Tc_MATERIALS + "=2"
	attack_verb = list("shoves", "bashes")
	stance = "blocking"
	var/cooldown = 0 //shield bash cooldown. based on world.time
	actions_types = list(/datum/action/item_action/warhams/heavydef_swap_stance)

/obj/item/weapon/shield/orkshield/suicide_act(mob/user)
	to_chat(viewers(user), "<span class='danger'>[user] is smashing \his face into the [src.name]! It looks like \he's  trying to commit suicide!</span>")
	return (SUICIDE_ACT_BRUTELOSS)

/obj/item/weapon/shield/orkshield/IsShield()
	return 1
 
/obj/item/weapon/shield/orkshield/prepickup(mob/living/user)
	if(isork(user))
		item_state = "nobshield"
		update_icon()
		return 0

	if(user.attribute_strength >= 13)
		item_state = "nobshield_nonork"
		update_icon()
		return 0
	else
		to_chat(user,"<span class='bad'> You lack the strength required to pick up this heavy metal object.</span>")
		return 1

/obj/item/weapon/shield/orkshield/attackby(obj/item/weapon/W, mob/user )
	if(istype(W, /obj/item))
		if(cooldown < world.time - 25)
			user.visible_message("<span class='warning'>[user] bashes [src] with [W]!</span>")
			playsound(user.loc, 'sound/effects/shieldbash.ogg', 50, 1)
			cooldown = world.time
	else
		..()

/obj/item/weapon/shield/orkshield/interpret_powerwords(mob/living/target, mob/living/user, def_zone, var/originator = null)
	..()
	var/mob/living/carbon/human/H = user
	var/mob/living/carbon/human/T = target

	switch(H.word_combo_chain)
		if("blockknockbackknockback") //block knockback knockback
			user.visible_message("<span class='danger'>[H] shieldbashes [T]!</span>")
			if(T.attribute_constitution >= H.attribute_strength+3)
				var/turf/TT = get_edge_target_turf(src, H.dir)
				T.adjustBruteLoss(15)
				T.throw_at(TT,1,2)
			else
				T.Dizzy(30)
				T.adjustBruteLoss(15)
