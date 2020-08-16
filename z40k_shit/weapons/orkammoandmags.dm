

/obj/item/projectile/bullet/orkscrapbullet
	name = "\improper Ork Scrap Bullet"
	damage = 30
	bounce_type = PROJREACT_WALLS //Yeah I want it to bounce off walls.

/obj/item/ammo_casing/orkbullet
	name = "Scrapmetal Bullet"
	desc = "A bullet that looks of questionable quality."
	caliber = ORKSCRAPBULLET
	projectile_type = /obj/item/projectile/bullet/orkscrapbullet
	w_type = RECYK_METAL

/obj/item/ammo_casing/orkbullet/attackby(var/atom/A, var/mob/user) //now with loading
	..()
	var/obj/item/ammo_casing/AC = A
	if(istype(A,/obj/item/ammo_casing/orkbullet))
		if(!AC.BB)
			to_chat(user, "<span class='notice'>The bullet appears to be already spent.</span>")
			return
		var/obj/item/ammo_storage/box/piles/sluggabulletpile/PP = new(src.loc)
		user.drop_item(A, PP)
		user.drop_item(src,PP)
		PP.stored_ammo += AC
		PP.stored_ammo += src
		user.put_in_any_hand_if_possible(PP) //pp hands lol
		PP.update_icon()
	
		PP.good2go = TRUE

	if(istype(A,/obj/item/ammo_storage/box/piles/sluggabulletpile))
		var/obj/item/ammo_storage/box/piles/sluggabulletpile/PP = A
		user.drop_item(src,A)
		PP.stored_ammo += src
		PP.update_icon()

/obj/item/ammo_storage/box/piles
	name = "A pile of something you shouldn't see"
	desc = "Someone fucked up."
	icon = 'z40k_shit/icons/obj/orks/orkbulletpilesandmags.dmi'
	icon_state = "sluggapile"
	max_ammo = 0
	var/good2go = FALSE //I don't feel like digging through the shit ass ammo_storage code to implement this properly.

/obj/item/ammo_storage/box/piles/update_icon()
	..()
	if(good2go && !stored_ammo.len)
		qdel(src)


/*
	SLUGGA BULLET PILES
						*/

/obj/item/ammo_storage/box/piles/sluggabulletpile
	name = "A pile of live bullets"
	desc = "Its a pile of bullets alright."
	icon = 'z40k_shit/icons/obj/orks/orkbulletpilesandmags.dmi'
	icon_state = "sluggapile"
	ammo_type = "/obj/item/ammo_casing/orkbullet"
	max_ammo = 30
	multiple_sprites = 1
	starting_ammo = 0

/obj/item/ammo_storage/box/piles/sluggabulletpile/max_pile
	name = "A pile of live bullets"
	desc = "Its a pile of bullets alright."
	icon = 'z40k_shit/icons/obj/orks/orkbulletpilesandmags.dmi'
	icon_state = "sluggapile"
	ammo_type = "/obj/item/ammo_casing/orkbullet"
	max_ammo = 30
	starting_ammo = 30
	multiple_sprites = 1
	good2go = TRUE


/*
	BUCKSHOT PILES AND BUCKSHOT ATTACKBY TO MAKE A PILE
														*/
/obj/item/ammo_storage/box/piles/buckshotpile
	name = "A pile of unspent buckshot"
	desc = "Its a pile of buckshot alright."
	icon = 'z40k_shit/icons/obj/orks/orkbulletpilesandmags.dmi'
	icon_state = "buckshotpile"
	ammo_type = "/obj/item/ammo_casing/shotgun/buckshot"
	max_ammo = 12
	multiple_sprites = 1
	starting_ammo = 0

/obj/item/ammo_storage/box/piles/buckshotpile/max_pile
	name = "A pile of unspent buckshot"
	desc = "Its a pile of buckshot alright."
	icon = 'z40k_shit/icons/obj/orks/orkbulletpilesandmags.dmi'
	icon_state = "buckshotpile"
	ammo_type = "/obj/item/ammo_casing/shotgun/buckshot"
	max_ammo = 12
	starting_ammo = 12
	multiple_sprites = 1
	good2go = TRUE

/obj/item/ammo_casing/shotgun/buckshot/attackby(var/atom/A, var/mob/user) //now with loading
	..()
	var/obj/item/ammo_casing/AC = A
	if(istype(A,/obj/item/ammo_storage/box/piles/buckshotpile))
		if(!AC.BB)
			to_chat(user, "<span class='notice'>The bullet appears to be already spent.</span>")
			return
		var/obj/item/ammo_storage/box/piles/buckshotpile/PP = new(src.loc)
		user.drop_item(A, PP)
		user.drop_item(src,PP)
		PP.stored_ammo += AC
		PP.stored_ammo += src
		user.put_in_any_hand_if_possible(PP) //pp hands lol
		PP.update_icon()
	
		PP.good2go = TRUE
	
	if(istype(A,/obj/item/ammo_storage/box/piles/buckshotpile))
		var/obj/item/ammo_storage/box/piles/buckshotpile/PP = A
		user.drop_item(src,A)
		PP.stored_ammo += src
		PP.update_icon()

/*
	MAGAZINES AND AMMO BELTS AND SHIT
										*/

/obj/item/ammo_storage/magazine/sluggamag
	name = "Magazine"
	desc = "Fits more than you"
	icon = 'z40k_shit/icons/obj/orks/orkbulletpilesandmags.dmi'
	icon_state = "sluggamag"
	desc = "A magazine for a slugga"
	origin_tech = Tc_COMBAT + "=2"
	ammo_type = "/obj/item/ammo_casing/orkbullet" //We don't use regular bullets here.
	max_ammo = 30
	multiple_sprites = 1
	sprite_modulo = 30

/obj/item/ammo_storage/magazine/shottamag
	name = "Shotta Mag"
	icon = 'z40k_shit/icons/obj/orks/orkbulletpilesandmags.dmi'
	icon_state = "shottamag"
	desc = "Why pump when you can just dump.... Up to 5 shots"
	origin_tech = Tc_COMBAT + "=2"
	ammo_type = "/obj/item/ammo_casing/shotgun/buckshot" //For some reason it won't take the children, bitchass.
	max_ammo = 5
	multiple_sprites = 1
	sprite_modulo = 5
	exact = 0

/obj/item/ammo_storage/magazine/kustom_shoota_belt
	name = "kustom shoota Belt"
	icon = 'z40k_shit/icons/obj/orks/orkbulletpilesandmags.dmi'
	icon_state = "ammobelt"
	desc = "A ammobelt for feeding into a kustom shoota"
	ammo_type = "/obj/item/ammo_casing/orkbullet"
	max_ammo = 30
	sprite_modulo = 2
	multiple_sprites = TRUE
