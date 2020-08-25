
/obj/item/weapon/gun/projectile/shotgun/shotta
	name = "shotta"
	desc = "A crude shotgun, what more is there to say?"
	icon = 'z40k_shit/icons/obj/orks/orkequipment.dmi'
	icon_state = "shotta"
	item_state = "slugga" //Lame but I can't be assed to spend time on this atm.
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/ork_guns_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/ork_guns_right.dmi')
	origin_tech = Tc_COMBAT + "=6;" + Tc_MATERIALS + "=3"
	fire_sound = 'z40k_shit/sounds/shotta.ogg'
	ammo_type = "/obj/item/ammo_casing/shotgun"
	mag_type = "/obj/item/ammo_storage/magazine/shottamag"
	max_shells = 5
	load_method = 2
	slot_flags = 0
	gun_flags = EMPTYCASINGS 
	actions_types = list(/datum/action/item_action/warhams/basic_swap_stance)

/obj/item/weapon/gun/projectile/shotgun/shotta/update_icon()
	..()
	icon_state = "shotta[stored_magazine ? "" : "-e"]"

/obj/item/weapon/gun/projectile/shotgun/shotta/Fire(atom/target, mob/living/user, params, reflex = 0, struggle = 0)
	if(!isork(user))
		if(user.attribute_strength <= 11)
			user.drop_item(src)
			if(istype(user,/mob/living/carbon/human/))
				var/mob/living/carbon/human/H = user
				if(prob(50))
					H.visible_message("[src] flies out of [user]'s hands and into their mouth.", "The [src] flies from your hands and knocks your teeth out.")
					H.knock_out_teeth()
					H.adjustBruteLoss(5)
					H.Knockdown(5)
				else
					src.throw_at(get_edge_target_turf(src,turn(H.dir,180)),3,3)
					H.visible_message("[src] flies out of [user]'s hands.", "The [src] flies out of your hands.")
	..()