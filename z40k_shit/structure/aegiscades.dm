/obj/item/weapon/aegisline_parts
	name = "aegisline parts" //Currently unused, mostly because i don't give a shit about
	desc = "Parts of a larger piece of metal." //Spriting a barricade tbqh
	icon = 'z40k_shit/icons/obj/barricadesmk2.dmi' //nmevermind lol
	icon_state = "aegisline_parts"
	siemens_coefficient = 1
	starting_materials = list(MAT_IRON = 3750)
	w_type = RECYK_METAL
	melt_temperature=MELTPOINT_STEEL
	var/sheet_amount = 1

/obj/item/weapon/aegisline_parts/attackby(obj/item/weapon/W, mob/user)
	..()
	if (W.is_wrench(user))
		drop_stack(sheet_type, user.loc, sheet_amount, user)
		qdel(src)
		return

/obj/item/weapon/aegisline_parts/attack_self(mob/user)
	if(do_after(user, src, 10)) //Takes a while because it is a barricade f*g
		var/obj/structure/aegisline/BR = new /obj/structure/aegisline(user.loc)

		BR.handle_direction(user.dir)
		user.drop_item(src, force_drop = 1)
		qdel(src)

/obj/structure/aegisline
	name = "Aegisline Barricade"
	desc = "A metal barricade, taller than most and made to take a heavier brunt of hits while letting you retaliate.."
	icon = 'z40k_shit/icons/obj/barricadesmk2.dmi'
	icon_state = "aegisline"
	anchored = 1
	density = 1
	opacity = 0 //what the fck is wrong with you
	var/health = 200 //Fairly strong
	var/busy = FALSE //Handles disassembly
	throwpass = TRUE //can we throw shit over
	var/parts = /obj/item/weapon/aegisline_parts
	var/obj/structure/aegisinvis/mirrorcade

/obj/structure/aegisline/New()
	..()
	mirrorcade = new()

/obj/structure/aegisline/Destroy()
	vis_contents.Cut()
	qdel(mirrorcade)
	..()

/obj/structure/aegisline/proc/handle_direction(var/direction)
	if(direction)
		dir = direction

	vis_contents.Cut()
	
	mirrorcade.loc = get_step(src,src.dir)
	mirrorcade.dir = turn(dir,180)

	switch(dir)
		if(NORTH)
			plane = OBJ_PLANE
			layer = SIDE_WINDOW_LAYER
			icon_state = "aegisline_north"
			vis_contents += barricadepool[1]
		if(SOUTH)
			plane = ABOVE_HUMAN_PLANE
			layer = OPEN_CURTAIN_LAYER
			icon_state = "aegisline_south"
			vis_contents += barricadepool[2]
		if(EAST)
			icon_state = "aegisline_east"
			plane = ABOVE_HUMAN_PLANE
			layer = WINDOOR_LAYER
			vis_contents += barricadepool[3]
			vis_contents += barricadepool[4]
		if(WEST)
			icon_state = "aegisline_west"
			plane = ABOVE_HUMAN_PLANE
			layer = WINDOOR_LAYER
			vis_contents += barricadepool[5]
			vis_contents += barricadepool[6]

/obj/structure/aegisline/proc/healthcheck(var/mob/M, var/sound = 1)
	if(health <= 0)
		visible_message("<span class='warning'>[src] breaks down!</span>")
		new parts(loc)
		setDensity(FALSE)
		qdel(src)

/obj/structure/aegisline/attack_hand(mob/user)
	//Bang against the barricade
	if(usr.a_intent == I_HURT)
		user.delayNextAttack(10)
		health -= 2
		healthcheck()
		user.visible_message("<span class='warning'>[user] bangs against \the [src]!</span>", \
		"<span class='warning'>You bang against \the [src]!</span>", \
		"You hear banging.")
	//Knock against it
	else
		user.delayNextAttack(10)
		user.visible_message("<span class='notice'>[user] knocks on \the [src].</span>", \
		"<span class='notice'>You knock on \the [src].</span>", \
		"You hear knocking.")
	..() //Hulk
	return

/obj/structure/aegisline/attackby(obj/item/weapon/W, mob/user)
	if(iscrowbar(W) && user.a_intent == I_HURT && !busy) //Only way to deconstruct, needs harm intent
		W.playtoolsound(loc, 75)
		user.visible_message("<span class='warning'>[user] starts struggling to pry \the [src] back into parts.</span>", \
		"<span class='notice'>You start struggling to pry \the [src] back into parts.</span>")
		busy = 1
		if(do_after(user, src, 50)) //Takes a while because it is a barricade instant kill
			playsound(loc, 'sound/items/Deconstruct.ogg', 75, 1)
			user.visible_message("<span class='warning'>[user] finishes turning \the [src] back into parts.</span>", \
			"<span class='notice'>You finish turning \the [src] back into parts.</span>")
			busy = 0
			new parts(loc)
			setDensity(FALSE)
			qdel(src)
			return
		else
			busy = 0
	if(W.damtype == BRUTE || W.damtype == BURN)
		user.delayNextAttack(10)
		health -= W.force
		user.visible_message("<span class='warning'>\The [user] hits \the [src] with \the [W].</span>", \
		"<span class='warning'>You hit \the [src] with \the [W].</span>")
		healthcheck(user)
		return
	else
		..() //Weapon checks for weapons without brute or burn damage type and grab check

/obj/structure/aegisline/Cross(atom/movable/mover, turf/target, height = 1.5, air_group = 0)
	if(air_group || !height) //The mover is an airgroup
		return 1 //We aren't airtight, only exception to PASSGLASS
	if(istype(mover,/obj/item/projectile))
		return (check_cover(mover,target))
	if(ismob(mover))
		var/mob/M = mover
		if(M.flying || M.highflying)
			return 1
	if(get_dir(loc, target) == dir || get_dir(loc, mover) == dir)
		return !density
	else
		return 1
	return 0


//checks if projectile 'P' from turf 'from' can hit whatever is behind the table. Returns 1 if it can, 0 if bullet stops.
/obj/structure/aegisline/proc/check_cover(obj/item/projectile/P, turf/from)
	var/shooting_at_the_barricade_directly = P.original == src
	var/chance = 70
	if(!shooting_at_the_barricade_directly)
		if(get_dir(loc, from) != dir) // It needs to be flipped and the direction needs to be right
			return 1
		if(get_dist(P.starting, loc) <= 1) //Tables won't help you if people are THIS close
			return 1
		if(ismob(P.original))
			var/mob/M = P.original
			if(M.lying)
				chance += 20 //Lying down lets you catch less bullets
	if(shooting_at_the_barricade_directly || prob(chance))
		health -= P.damage/2
		if(health > 0)
			visible_message("<span class='warning'>[P] hits \the [src]!</span>")
			return 0
		else
			visible_message("<span class='warning'>[src] breaks down!</span>")
			new parts(loc)
			setDensity(FALSE)
			qdel(src)
			return 1
	return 1

/obj/structure/aegisinvis
	anchored = 1
	density = 1
	invisibility = 101
	throwpass = TRUE //can we throw shit over

/obj/structure/aegisinvis/Cross(atom/movable/mover, turf/target, height = 1.5, air_group = 0)
	if(air_group || !height) //The mover is an airgroup
		return 1 //We aren't airtight, only exception to PASSGLASS
	if(ismob(mover))
		var/mob/M = mover
		if(M.flying || M.highflying)
			return 1
	if(get_dir(loc, target) == dir || get_dir(loc, mover) == dir)
		return !density
	else
		return 1
	return 0
