/obj/item/weapon/powersword
	name = "Powersword Parent"
	desc = "This is a parent, it does not much. You shouldn't see this spawned anyways."
	icon = 'z40k_shit/icons/obj/weapons.dmi'
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/IGequipment_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/IGequipment_right.dmi')
	item_state = "powersword"
	sharpness = 1.5 //very very sharp
	sharpness_flags = SHARP_BLADE | HOT_EDGE
	heat_production = 3500
	source_temperature = TEMPERATURE_PLASMA
	sterility = 0
	force = 30
	var/sharpness_on = 1.5 //so badmins can VV this!
	var/active = 0
	var/activeforce = 30
	var/onsound = 'sound/weapons/saberon.ogg'
	var/base_state = "sword"
	actions_types = list(/datum/action/item_action/warhams/piercing_blow,
					/datum/action/item_action/warhams/basic_swap_stance)
	armor_penetration = 100

/obj/item/weapon/powersword/suicide_act(mob/user)
	to_chat(viewers(user), pick("<span class='danger'>[user] is slitting \his stomach open with the [src.name]! It looks like \he's trying to commit seppuku.</span>", \
						"<span class='danger'>[user] is falling on the [src.name]! It looks like \he's trying to commit suicide.</span>"))
	return (SUICIDE_ACT_BRUTELOSS|SUICIDE_ACT_FIRELOSS)

/obj/item/weapon/powersword/is_hot()
	if(active)
		return source_temperature
	return 0

/obj/item/weapon/powersword/is_sharp()
	if(active)
		return sharpness
	return 0

/obj/item/weapon/powersword/activated/New()
	..()
	active = 1
	sterility = 100
	force = 30
	w_class = W_CLASS_LARGE
	sharpness = sharpness_on
	sharpness_flags = SHARP_TIP | SHARP_BLADE | INSULATED_EDGE | HOT_EDGE | CHOPWOOD | CUT_WALL | CUT_AIRLOCK
	armor_penetration = 100
	hitsound = "sound/weapons/blade1.ogg"
	update_icon()


/obj/item/weapon/powersword/IsShield()
	if(active)
		return 1
	return 0

/obj/item/weapon/powersword/New()
	..()
	update_icon()

/obj/item/weapon/powersword/attack_self(mob/living/user)
	if(!(flags & TWOHANDABLE))
		if (clumsy_check(user) && prob(50) && active) //only an on blade can cut
			to_chat(user, "<span class='danger'>You accidentally cut yourself with [src]!</span>")
			user.take_organ_damage(5,5)
			return
		toggleActive(user)
		
		return
	..()


/obj/item/weapon/powersword/proc/toggleActive(mob/user, var/togglestate = "") //you can use togglestate to manually set the sword on or off
	switch(togglestate)
		if("on")
			active = 1
		if("off")
			active = 0
		else
			active = !active
	if(active)
		force = activeforce
		sterility = 100
		w_class = W_CLASS_LARGE
		sharpness = sharpness_on
		sharpness_flags = SHARP_TIP | SHARP_BLADE | INSULATED_EDGE | HOT_EDGE | CHOPWOOD | CUT_WALL | CUT_AIRLOCK
		armor_penetration = 100
		hitsound = "sound/weapons/blade1.ogg"
		if(onsound)
			playsound(user, onsound, 50, 1)
		to_chat(user, "<span class='notice'> [src] is now active.</span>")
	else
		force = 20
		sterility = 0
		w_class = W_CLASS_SMALL
		sharpness = 0
		sharpness_flags = 0
		armor_penetration = initial(armor_penetration)
		if(onsound)
			playsound(user, 'sound/weapons/saberoff.ogg', 50, 1)
		hitsound = "sound/weapons/empty.ogg"
		to_chat(user, "<span class='notice'> [src] can now be concealed.</span>")
	update_icon()

/obj/item/weapon/powersword/update_icon()
	icon_state = "[base_state][active]"

/obj/item/weapon/powersword/interpret_powerwords(mob/living/target, mob/living/user, def_zone, var/originator = null)
	..()
	var/mob/living/carbon/human/H = user
	var/mob/living/carbon/human/T = target

	switch(H.word_combo_chain)
		if("piercechargehurt") //parry piercing hurt
			user.visible_message("<span class='danger'>[H] lunges into [T] with a piercing strike!</span>")
			target.adjustBruteLoss(15)
			T.attackby(src,user)
			H.word_combo_chain = ""
			H.update_powerwords_hud(clear = TRUE)
		if("pierceparryknockback")
			user.visible_message("<span class='danger'>[H] retaliates with a piercing thrust with their [name] into [T].")
			H.adjustBruteLoss(20)
			step_away(T,H,2)
			H.word_combo_chain = ""
			H.update_powerwords_hud(clear = TRUE)