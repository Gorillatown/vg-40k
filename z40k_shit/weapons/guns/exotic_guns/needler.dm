/obj/item/weapon/gun/projectile/needler
	name = "\improper Needler"
	desc = "An exotic expensive weapon that you should only ever see once in your life."
	icon = 'z40k_shit/icons/obj/guns.dmi'
	icon_state = "needler"
	ammo_type = "/obj/item/ammo_casing/needler"
	mag_type = "/obj/item/ammo_storage/magazine/needlermag"
	max_shells = 20
	caliber = list(NEEDLERROUND = 1)
	origin_tech = Tc_COMBAT + "=3"
	fire_sound = 'sound/weapons/ebow.ogg'
	load_method = 2
	gun_flags = EMPTYCASINGS
	w_class = W_CLASS_SMALL
	flags = NO_STORAGE_MSG

/obj/item/weapon/gun/projectile/needler/update_icon()
	..()
	icon_state = "needler[chambered ? "" : "-e"]"