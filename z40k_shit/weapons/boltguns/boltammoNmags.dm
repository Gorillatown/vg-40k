/obj/item/projectile/bullet/bolt
	name = "\improper Bolt"
	damage = 50
	bounce_type = PROJREACT_WALLS //Yeah I want it to bounce off walls.
	icon = 'z40k_shit/icons/obj/projectiles.dmi'
	icon_state = "bolter"

/obj/item/ammo_casing/bolter
	name = "Bolt"
	desc = "A large gyrojet round."
	caliber = STANDARDBOLTER
	projectile_type = /obj/item/projectile/bullet/bolt
	w_type = RECYK_METAL

/obj/item/ammo_storage/magazine/boltpistol
	name = "Boltpistol Mag"
	icon = 'z40k_shit/icons/obj/ig/IGequipment.dmi'
	icon_state = "boltpistolmag"
	desc = "16 Shots, thats all you get."
	origin_tech = Tc_COMBAT + "=2"
	ammo_type = "/obj/item/ammo_casing/bolter" //For some reason it won't take the children, bitchass.
	max_ammo = 16
	multiple_sprites = 1
	sprite_modulo = 16
	exact = 0
