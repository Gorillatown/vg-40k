/obj/item/ammo_casing/rocket_rpg/d_rocket
	name = "Rocket"
	desc = "For some reason the Detroid and Ork missiles share many similarities but different platforms."
	icon = 'F_40kshit/icons/obj/ammo.dmi'
	icon_state = "d_rocket"
	caliber = DETROID_ROCKET
	projectile_type = "/obj/item/projectile/rocket/d_rocket"
	starting_materials = list(MAT_IRON = 15000)
	w_type = RECYK_METAL
	w_class = W_CLASS_MEDIUM // Rockets don't exactly fit in pockets and cardboard boxes last I heard, try your backpack
	shrapnel_amount = 4
	
/obj/item/ammo_casing/rocket_rpg/rokkit/update_icon()
	return

/obj/item/projectile/rocket/d_rocket
	name = "D-missile"
	icon = 'F_40kshit/icons/obj/projectiles.dmi'
	icon_state = "d_rocket"
	damage = 40
	weaken = 10
	exdev 	= 1
	exheavy = 1
	exlight = 3
	exflash = 8