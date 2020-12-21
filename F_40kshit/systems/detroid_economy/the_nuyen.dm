/obj/item/weapon/nuyen
	name = "Detroid Nuyen"
	icon = 'F_40kshit/icons/obj/32x32misc_obj.dmi'
	icon_state = "detroid_nuyen"
	desc = "A solid gold overly gaudy symbol picked by someone upon Detroid for currency long ago. One could be quite suspicious of it unless they were from around these parts."
	force = 5
	throw_speed = 1
	w_class = W_CLASS_TINY
	throw_range = 10
	var/amount = 100
//F_40kshit/sounds/misc_effects/nuyen_sound.wav

/obj/item/weapon/nuyen/New()
	..()
	src.pixel_x = rand(-5, 5) * PIXEL_MULTIPLIER
	src.pixel_y = rand(-5, 5) * PIXEL_MULTIPLIER

/obj/item/weapon/nuyen/throw_impact(atom/hit_atom, speed, mob/user)
	
	playsound(src.loc, 'F_40kshit/sounds/misc_effects/nuyen_sound.wav', 50, 1)

/obj/item/weapon/nuyen/dropped(mob/user)
	playsound(src.loc, 'F_40kshit/sounds/misc_effects/nuyen_sound.wav', 50, 1)

/obj/item/weapon/nuyen/examine(mob/user)
	..()
	to_chat(user, "There is currently [amount] worth Nuyen in this pile.")

