
/obj/item/weapon/attachment/bayonet //Bayonet
	name = "bayonet"
	desc = "A bayonet made to be attached to a lasgun."
	icon_state = "bayonet"
	item_state = "bayonet"
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/IGequipment_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/IGequipment_right.dmi')
	force = 10.0
	throwforce = 10.0
	throw_speed = 3
	throw_range = 7
	
	//Attachment variables
	atch_effect_flags = MELEE_DMG | MELEE_SOUNDSWAP

/obj/item/weapon/attachment/bayonet/attackby(obj/item/weapon/W, mob/user)
	..()
	if(user.is_in_modules(src))
		return
	if(iswelder(W))
		var/obj/item/weapon/weldingtool/WT = W
		if(WT.remove_fuel(1, user))
			to_chat(user, "You slice the handle off of \the [src].")
			playsound(user, 'sound/items/Welder.ogg', 50, 1)
			if(src.loc == user)
				user.drop_item(src, force_drop = 1)
				var/obj/item/weapon/metal_blade/I = new (get_turf(user))
				user.put_in_hands(I)
			else
				new /obj/item/weapon/metal_blade(get_turf(src.loc))
			qdel(src)
			return

