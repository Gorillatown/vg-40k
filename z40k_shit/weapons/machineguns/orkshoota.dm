/obj/item/weapon/gun/projectile/automatic/shoota
	name = "\improper Shoota"
	desc = "What dis?"
	icon = 'z40k_shit/icons/obj/orks/orkequipment.dmi'
	icon_state = "ork_shoota"
	item_state = "ork_shoota"
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/ork_guns_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/ork_guns_right.dmi')
	origin_tech = Tc_COMBAT + "=5;" + Tc_MATERIALS + "=2"
	w_class = W_CLASS_MEDIUM
	max_shells = 30
	burst_count = 5
	caliber = list(ORKSCRAPBULLET = 1)
	ammo_type = "/obj/item/ammo_casing/orkbullet"
	mag_type = "/obj/item/ammo_storage/magazine/sluggamag"
	fire_sound = 'z40k_shit/sounds/Shoota1.ogg'
	load_method = 2
	gun_flags = AUTOMAGDROP | EMPTYCASINGS
	actions_types = list(/datum/action/item_action/warhams/basic_swap_stance)

/obj/item/weapon/gun/projectile/automatic/shoota/update_icon()
	..() //Yeah Sorry, just basic shit here man, this is the only commented section you are getting lol.
	icon_state = "ork_shoota[stored_magazine ? "" : "-e"]"
	item_state = "ork_shoota[wielded ? "-wielded" : "-unwielded"]"

/obj/item/weapon/gun/projectile/automatic/shoota/Fire(atom/target, mob/living/user, params, reflex = 0, struggle = 0)
	var/atom/newtarget = target
	if(!isork(user))
		if(user.attribute_strength <= 11)
			if(prob(40))
				user.visible_message("[user] can't handle the recoil of [src]", "The ork gun goes backwards and slams into your chest")
				user.Knockdown(12)
				user.Stun(12)
				user.adjustBruteLoss(5)
	if(!wielded)
		newtarget = get_inaccuracy(target,1+recoil) //Inaccurate when not wielded
	..(newtarget,user,params,reflex,struggle)

/obj/item/weapon/gun/projectile/automatic/shoota/update_wield(mob/user)
	..()
	force = wielded ? 30 : 15
	update_icon()

/obj/item/weapon/gun/projectile/automatic/shoota/attack_hand(mob/user)
	if(user.get_inactive_hand() == src)
		RemoveMag(user)
	else
		..()

/obj/item/weapon/gun/projectile/automatic/shoota/attack_self(mob/user) //Unloading (Need special handler for unattaching.)
	if(user.get_active_hand() == src)
		if(!wielded)
			wield(user)
			src.update_wield(user)
		else
			unwield(user)
			src.update_wield(user)

