/obj/item/projectile/bullet/stubber
	name = "\improper 10mm Stubber Bullet"
	damage = 10
	bounce_type = PROJREACT_WALLS //Yeah I want it to bounce off walls.

/obj/item/ammo_casing/stubber
	name = "10mm Stubber Bullet"
	desc = "A bullet of questionable quality, its 10mm"
	caliber = STUBBERBULLET
	projectile_type = /obj/item/projectile/bullet/stubber
	w_type = RECYK_METAL

 
/obj/item/ammo_storage/magazine/stubbermag
	name = "Stubber Magazine"
	desc = "A magazine that holds 10mm Bullets, that fits in most stubbers around these parts"
	icon = 'z40k_shit/icons/obj/ammo.dmi'
	icon_state = "10mm"
	origin_tech = Tc_COMBAT + "=2"
	ammo_type = "/obj/item/ammo_casing/stubber" //We don't use regular bullets here.
	max_ammo = 10
	multiple_sprites = TRUE
	sprite_modulo = 2

/obj/item/ammo_storage/box/tenmm
	name = "stubber ammo box (.10mm)"
	desc = "A box of 10mm bullets. Holds 24 rounds."
	icon_state = "9mmred"
	origin_tech = Tc_COMBAT + "=2"
	ammo_type = "/obj/item/ammo_casing/stubber"
	caliber = STUBBERBULLET
	max_ammo = 24