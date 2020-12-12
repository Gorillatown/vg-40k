/obj/item/projectile/bullet/needler
	name = "\improper Needler Round"
	icon = 'F_40kshit/icons/obj/projectiles.dmi'
	icon_state = "needle"
	damage = 15
	damage_type = TOX
	bounce_type = PROJREACT_WALLS //Yeah I want it to bounce off walls.

/obj/item/ammo_casing/needler
	name = "Needle Round"
	icon = 'F_40kshit/icons/obj/ammo.dmi'
	icon_state = "needle"
	desc = "Its a needler round"
	caliber = NEEDLERROUND
	projectile_type = /obj/item/projectile/bullet/needler
	w_type = RECYK_METAL

/obj/item/ammo_storage/magazine/needlermag
	name = "Needler Magazine"
	desc = "A magazine that fits into a needler, if you ever find one."
	icon = 'F_40kshit/icons/obj/ammo.dmi'
	icon_state = "needlermag-20"
	origin_tech = Tc_COMBAT + "=2"
	ammo_type = "/obj/item/ammo_casing/needler" //We don't use regular bullets here.
	max_ammo = 20
	multiple_sprites = TRUE
	sprite_modulo = 10

/obj/item/ammo_storage/box/needler
	name = "Needler Ammo Box"
	desc = "A box of Needler Ammo. Holds 20 rounds."
	icon_state = "9mmred"
	origin_tech = Tc_COMBAT + "=2"
	ammo_type = "/obj/item/ammo_casing/stubber"
	caliber = NEEDLERROUND
	max_ammo = 20