/spell/aoe_turf/telekine_dome
	name = "Telekine Dome"
	desc = "Blessing - Erects cover around ."
	abbreviation = "GL"

	school = "vampire"
	user_type = USER_TYPE_PSYKER
	specialization = SSTELEKINESIS
	charge_type = Sp_RECHARGE
	charge_max = 3 MINUTES
	invocation_type = SpI_NONE
	hud_state = "telekine_dome"
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	override_base = "ork"
	range = 0
	inner_radius = 0
	warpcharge_cost = 140

/spell/aoe_turf/telekine_dome/choose_targets(var/mob/user = usr)
	return list(user)

/spell/aoe_turf/telekine_dome/cast(var/list/targets, var/mob/living/user)
	set waitfor = 0
	//Why is this like this? Because im lazy, and we can get all the points we need.
	//Just from knowing the range to the nearest wall from the center(not counting the center)
	var/list/alltheboys = list()

	var/will_duration = user.attribute_willpower
	var/warp_sens = round(user.attribute_sensitivity/500)
	var/x2wall = 2 + warp_sens //width
	var/y2wall = 2 + warp_sens//and height
	var/turf/center = get_turf(user)

	var/turf/bottom_left = locate(center.x-x2wall, center.y-y2wall, center.z)
	var/turf/top_left = locate(center.x-x2wall, center.y+y2wall, center.z)
	
	var/turf/top_right = locate(center.x+x2wall, center.y+y2wall, center.z)
	var/turf/bottom_right = locate(center.x+x2wall, center.y-y2wall, center.z)


	//TBQH: This 2nd rework is nasty, but we also solve the issue of people shooting in through the corners.
	//Bottom left to top left, so we are west
	for(var/turf/T in block(bottom_left, top_left))
		var/obj/effect/telekine_dome/THEBOYS = new(T)
		THEBOYS.dir = WEST
		alltheboys += THEBOYS

	//top left to right right, so we are north
	for(var/turf/T in block(top_left, top_right))
		var/obj/effect/telekine_dome/THEBOYS = new(T)
		THEBOYS.dir = NORTH
		alltheboys += THEBOYS
 
	//top right to bottom right, so we are east
	for(var/turf/T in block(top_right, bottom_right))
		var/obj/effect/telekine_dome/THEBOYS = new(T)
		THEBOYS.dir = EAST
		alltheboys += THEBOYS

	//bottom right to bottom left, so we are south
	for(var/turf/T in block(bottom_right, bottom_left))
		var/obj/effect/telekine_dome/THEBOYS = new(T)
		THEBOYS.dir = SOUTH
		alltheboys += THEBOYS

	sleep(will_duration SECONDS)
	
	for(var/obj/effect/telekine_dome/MYBOYS in alltheboys)
		qdel(MYBOYS)

/obj/effect/telekine_dome
	name = "Psychic Wall"
	desc = "A telepathic dome's force field."
	icon = 'z40k_shit/icons/32x32effects.dmi'
	icon_state = "telekine_dome"
	anchored = 1
	opacity = 0
	density = 1
	invisibility = 0
	var/health = 500

	var/explosion_block = 90 //making this spell marginally more useful

/obj/effect/telekine_dome/New()
	..()

/obj/effect/telekine_dome/attackby(obj/item/weapon/W, mob/user)
	if(W.damtype == BRUTE || W.damtype == BURN)
		user.delayNextAttack(10)
		health -= W.force
		user.visible_message("<span class='warning'>\The [user] hits \the [src] with \the [W].</span>", \
		"<span class='warning'>You hit \the [src] with \the [W].</span>")
		healthcheck(user)
		return

/obj/effect/telekine_dome/proc/healthcheck(var/mob/M, var/sound = 1)
	if(health <= 0)
		visible_message("<span class='warning'>[src] shatters like crystalline glass!</span>")
		setDensity(FALSE)
		qdel(src)

/obj/effect/telekine_dome/Cross(atom/movable/mover, turf/target, height = 1.5, air_group = 0)
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
/obj/effect/telekine_dome/proc/check_cover(obj/item/projectile/P, turf/from)
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
			visible_message("<span class='warning'>[src] shatters!</span>")
			setDensity(FALSE)
			qdel(src)
			return 1
	return 1

