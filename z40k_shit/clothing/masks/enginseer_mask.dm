/obj/item/clothing/mask/gas/enginseer_mask
	name = "intimidating visor mask"
	desc = "A mask that fits perfectly in your helmet."
	icon = 'z40k_shit/icons/obj/clothing/masks.dmi'
	icon_state = "mech_mask_on" //Check: Its there
	item_state = "mech_mask_on" //Check: Its there
	siemens_coefficient = 0.7
	body_parts_covered = FACE
	w_class = W_CLASS_SMALL
	eyeprot = 3

	can_flip = 0
	canstage = 0
	var/on = FALSE
	var/list/color_matrix = list(0.8, 0, 0 ,\
								0 , 1, 0 ,\
								0 , 0, 0.8) //equivalent to #CCFFCC
	species_restricted = list("Human")
	canremove = 0 
 
/obj/item/clothing/mask/gas/enginseer_mask/attack_hand(mob/user)
	if(alert("Toggle Nightvision or Remove Mask?",,"Nightvision","Remove") == "Nightvision")
		togglemask()
	else
		..()

/obj/item/clothing/mask/gas/enginseer_mask/proc/apply_color(mob/living/carbon/user)	//for altering the color of the wearer's vision while active
	if(color_matrix)
		if(user.client)
			var/client/C = user.client
			C.color =  color_matrix

/obj/item/clothing/mask/gas/enginseer_mask/proc/remove_color(mob/living/carbon/user)
	if(color_matrix)
		if(user.client)
			var/client/C = user.client
			C.color = initial(C.color)

/obj/item/clothing/mask/gas/enginseer_mask/equipped(var/mob/user, var/slot, hand_index = 0)
	..()
	if(istype(user, /mob/living/carbon/monkey))
		var/mob/living/carbon/monkey/O = user
		if(O.wear_mask != src)
			return
	else if(istype(user, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = user
		if(H.wear_mask != src)
			return
	else
		return
	if(on)
		if(iscarbon(user))
			apply_color(user)


/obj/item/clothing/mask/gas/enginseer_mask/unequipped(mob/user, var/from_slot = null)
	if(from_slot == slot_wear_mask)
		if(on)
			if(iscarbon(user))
				remove_color(user)
	..()

/*
/obj/item/clothing/mask/gas/enginseer_mask/update_icon()
	if(on)
		icon_state = "mech_mask_on"
	else
		icon_state = "mech_mask_off"
*/
/obj/item/clothing/mask/gas/enginseer_mask/togglemask()
	var/mob/C = usr
	if (!usr)
		if (!ismob(loc))
			return
		C = loc

	if (C.incapacitated())
		return

	if(on)
		C.see_in_dark_override = 0
		C.see_invisible_override = 0
		disable(C)
	else
		C.see_in_dark_override = 8
		C.see_invisible_override = SEE_INVISIBLE_OBSERVER_NOLIGHTING
		enable(C)

	update_icon()
	C.update_inv_wear_mask()

/obj/item/clothing/mask/gas/enginseer_mask/proc/enable(var/mob/C)
	on = TRUE
	to_chat(C, "You turn \the [src] on.")
	if(iscarbon(loc))
		if(istype(loc, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = C
			if(H.wear_mask && (H.wear_mask == src))
				apply_color(H)

/obj/item/clothing/mask/gas/enginseer_mask/proc/disable(var/mob/C)
	on = FALSE
	to_chat(C, "You turn \the [src] off.")
	if(iscarbon(loc))
		if(istype(loc, /mob/living/carbon/monkey))
			var/mob/living/carbon/monkey/M = C
			if(M.wear_mask && (M.wear_mask == src))
				remove_color(M)
		else if(istype(loc, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = C
			if(H.wear_mask && (H.wear_mask == src))
				remove_color(H)
