
/obj/item/projectile/tankshell
	name = "Tank Shells"
	desc = "Not quite a rocket, not quite a bullet"
	icon = 'z40k_shit/icons/obj/projectiles.dmi'
	icon_state = "demolisher"
	damage = 50
	var/exdev = 0 //Ex 1
	var/exheavy = 0 // Ex 2
	var/exlight = 0 // Ex 3
	var/exflash = 0 // ex 4
	var/explosive = 1 //are we explosive?

/obj/item/projectile/tankshell/OnDeath()
	explosion(get_turf(src), exdev, exheavy, exlight, exflash)

/obj/item/projectile/tankshell/to_bump(var/atom/A)
	if(explosive)
		explosion(A, exdev, exheavy, exlight, exflash) 
		if(!gcDestroyed)
			qdel(src)
	else
		..()
		if(!gcDestroyed)
			qdel(src)
