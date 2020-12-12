/obj/item/weapon/gun/projectile/stubpistol
	name = "\improper Stubber pistol"
	desc = "A crude pistol made to shoot inexpensive high caliber, low velocity rounds inaccurately. Uses 10mm ammo."
	icon = 'F_40kshit/icons/obj/guns.dmi'
	icon_state = "stub"
	ammo_type = "/obj/item/ammo_casing/stubber"
	mag_type = "/obj/item/ammo_storage/magazine/stubbermag"
	max_shells = 10
	caliber = list(STUBBERBULLET = 1)
	origin_tech = Tc_COMBAT + "=3"
	fire_sound = 'sound/weapons/semiauto.ogg'
	load_method = 2
	gun_flags = EMPTYCASINGS

/obj/item/weapon/gun/projectile/stubpistol/update_icon()
	..()
	icon_state = "stub[chambered ? "" : "-e"]"


