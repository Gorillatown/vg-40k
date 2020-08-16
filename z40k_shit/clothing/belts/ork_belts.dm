/*
	Belts
	*/
/obj/item/weapon/storage/belt/basicbelt
	name = "Basic Belt"
	desc = "A basic belt for a basic bitch."
	icon_state = "orkbelt1"
	item_state = "orkbelt1"
	max_combined_w_class = 200
	fits_max_w_class = 5
	w_class = W_CLASS_LARGE
	storage_slots = 14
	can_only_hold = list(
	"/obj/item/weapon/grenade/stikkbomb",
	"/obj/item/ammo_casing/rocket_rpg/rokkit",
	"/obj/item/weapon/gun/projectile/automatic/slugga",
	"/obj/item/weapon/gun/projectile/shotgun/shotta",
	"/obj/item/weapon/choppa",
	"/obj/item/ammo_casing/orkbullet",
	"/obj/item/ammo_storage/box/piles/sluggabulletpile",
	"/obj/item/ammo_storage/box/piles/buckshotpile",
	"/obj/item/ammo_storage/magazine/sluggamag",
	"/obj/item/ammo_storage/magazine/shottamag",
	"/obj/item/ammo_storage/magazine/kustom_shoota_belt")
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	species_fit = list("Ork", "Ork Nob", "Ork Warboss") 

/obj/item/weapon/storage/belt/basicbelt/stikkbombs/New()
	..()
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)

/obj/item/weapon/storage/belt/basicbelt/rokkitbelt/New()
	..()
	new /obj/item/ammo_casing/rocket_rpg/rokkit(src)
	new /obj/item/ammo_casing/rocket_rpg/rokkit(src)
	new /obj/item/ammo_casing/rocket_rpg/rokkit(src)
	new /obj/item/ammo_casing/rocket_rpg/rokkit(src)
	new /obj/item/ammo_casing/rocket_rpg/rokkit(src)
	new /obj/item/ammo_casing/rocket_rpg/rokkit(src)
	new /obj/item/ammo_casing/rocket_rpg/rokkit(src)

/obj/item/weapon/storage/belt/armorbelt
	name = "Belt with Plates"
	desc = "A belt with armored plates attached to it."
	icon_state = "orkbelt1dev1"
	item_state = "orkbelt1dev1"
	max_combined_w_class = 200
	fits_max_w_class = 5
	body_parts_covered = LOWER_TORSO|LEGS
	armor = list(melee = 10, bullet = 10, laser = 10,energy = 10, bomb = 10, bio = 10, rad = 0)
	w_class = W_CLASS_LARGE
	storage_slots = 7
	can_only_hold = list(
	"/obj/item/weapon/grenade/stikkbomb",
	"/obj/item/ammo_casing/rocket_rpg/rokkit",
	"/obj/item/weapon/gun/projectile/automatic/slugga",
	"/obj/item/weapon/gun/projectile/shotgun/shotta",
	"/obj/item/weapon/choppa",
	"/obj/item/ammo_casing/orkbullet",
	"/obj/item/ammo_storage/box/piles/sluggabulletpile",
	"/obj/item/ammo_storage/box/piles/buckshotpile",
	"/obj/item/ammo_storage/magazine/sluggamag",
	"/obj/item/ammo_storage/magazine/shottamag",
	"/obj/item/ammo_storage/magazine/kustom_shoota_belt")
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	species_fit = list("Ork", "Ork Nob", "Ork Warboss") 

/obj/item/weapon/storage/belt/armorbelt/rokkitbelt/New()
	..()
	new /obj/item/ammo_casing/rocket_rpg/rokkit(src)
	new /obj/item/ammo_casing/rocket_rpg/rokkit(src)
	new /obj/item/ammo_casing/rocket_rpg/rokkit(src)
	new /obj/item/ammo_casing/rocket_rpg/rokkit(src)
	new /obj/item/ammo_casing/rocket_rpg/rokkit(src)
	new /obj/item/ammo_casing/rocket_rpg/rokkit(src)
	new /obj/item/ammo_casing/rocket_rpg/rokkit(src)
	
/*
	Belts
	*/
/obj/item/weapon/storage/belt/warboss
	name = "Leather Belt with Metal Skull"
	desc = "A not very basic belt."
	icon_state = "warboss_belt"
	item_state = "warboss_belt"
	w_class = W_CLASS_LARGE
	storage_slots = 14
	max_combined_w_class = 200
	fits_max_w_class = 5
	can_only_hold = list(
	"/obj/item/weapon/,")
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	species_fit = list("Ork Warboss") 

/obj/item/weapon/storage/belt/warboss/New()
	..()
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)