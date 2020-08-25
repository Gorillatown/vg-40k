/obj/item/weapon/gun/projectile/automatic/slugga
	name = "\improper Slugga"
	desc = "What dis?"
	icon = 'z40k_shit/icons/obj/orks/orkequipment.dmi'
	icon_state = "slugga"
	item_state = "slugga"
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/ork_guns_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/ork_guns_right.dmi')
	origin_tech = Tc_COMBAT + "=5;" + Tc_MATERIALS + "=2"
	w_class = W_CLASS_MEDIUM
	max_shells = 8
	burst_count = 1
	caliber = list(ORKSCRAPBULLET = 1)
	ammo_type = "/obj/item/ammo_casing/orkbullet"
	mag_type = "/obj/item/ammo_storage/magazine/sluggamag"
	fire_sound = 'z40k_shit/sounds/slugga_1.ogg'
	load_method = 2
	gun_flags = AUTOMAGDROP | EMPTYCASINGS
	actions_types = list(/datum/action/item_action/warhams/basic_swap_stance)

/obj/item/weapon/gun/projectile/automatic/slugga/update_icon()
	..() //Yeah Sorry, just basic shit here man, this is the only commented section you are getting lol.
	icon_state = "slugga[stored_magazine ? "" : "-e"]"

/obj/item/weapon/gun/projectile/automatic/slugga/Fire(atom/target, mob/living/user, params, reflex = 0, struggle = 0)
	if(!isork(user))
		if(user.attribute_strength <= 11)
			if(prob(30))
				user.drop_item(src)
				if(istype(user,/mob/living/carbon/human/))
					var/mob/living/carbon/human/H = user
					if(prob(25))
						H.visible_message("[src] flies out of [user]'s hands and into their mouth.", "The [src] flies from your hands and knocks your teeth out.")
						H.knock_out_teeth()
						H.adjustBruteLoss(5)
						H.Knockdown(5)
					else
						src.throw_at(get_edge_target_turf(src,turn(H.dir,180)),3,3)
						H.visible_message("[src] flies out of [user]'s hands.", "The [src] flies out of your hands.")
	..()