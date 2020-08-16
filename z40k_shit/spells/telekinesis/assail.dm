/spell/aoe_turf/assail
	name = "Assail"
	desc = "Witchfire(Beam) - Sends forth earth, and a lot of it."
	abbreviation = "GOKU"
	user_type = USER_TYPE_PSYKER
	specialization
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	override_base = "ork"
	charge_type = Sp_RECHARGE
	charge_max = 500
	spell_flags = 0
	spell_aspect_flags = SPELL_GROUND
	range = 20
	invocation_type = SpI_NONE
	var/beam_length = 20
	still_recharging_msg = "<span class='notice'>You ain't ready yet idiot..</span>"

	hud_state = "assail"
	warpcharge_cost = 30

/spell/aoe_turf/assail/cast(list/targets, mob/living/user)
	set waitfor = 0
	user.anchored = TRUE

	var/turf/user_turf = get_turf(user)
	var/turf/starting_turf = get_step(user_turf, user.dir)
	var/turf/bound_adjustment

	if(do_after(user,user,30))
		if(user.attribute_sensitivity >= 800 && user.attribute_willpower >= 15)
			/*Logic: 	3 2 1 $ 1 2 3
						& & & & & & &				
						$ 1 2 3 4 5 6
										*/	
			switch(user.dir)
				if(NORTH)
					bound_adjustment = get_step(starting_turf,turn(user.dir,90))
					for(var/i=1 to 2) //2 and 3.
						bound_adjustment = get_step(bound_adjustment,turn(user.dir,90))
				if(SOUTH)
					bound_adjustment = get_step(starting_turf,turn(user.dir,-90))
					for(var/i=1 to 2) //2 and 3.
						bound_adjustment = get_step(bound_adjustment,turn(user.dir,-90))
				if(EAST)
					bound_adjustment = get_step(starting_turf,turn(user.dir,-90))
					for(var/i=1 to 2) //2 and 3.
						bound_adjustment = get_step(bound_adjustment,turn(user.dir,-90))
				if(WEST)
					bound_adjustment = get_step(starting_turf,turn(user.dir,90))
					for(var/i=1 to 2) //2 and 3.
						bound_adjustment = get_step(bound_adjustment,turn(user.dir,90))

			new /obj/effect/super_thrown_rock/head(bound_adjustment,user.dir,beam_length)

		else
			/*Logic:	1 $ 1
						& & &
						$ 1 2		*/
			switch(user.dir)
				if(NORTH)
					bound_adjustment = get_step(starting_turf,turn(user.dir, 90)) //1
				if(SOUTH)
					bound_adjustment = get_step(starting_turf,turn(user.dir,-90)) //1
				if(EAST)
					bound_adjustment = get_step(starting_turf,turn(user.dir,-90)) //1
				if(WEST)
					bound_adjustment = get_step(starting_turf,turn(user.dir, 90)) //1
			new /obj/effect/thrown_rock/head(bound_adjustment,user.dir,beam_length)
	else
		to_chat(user,"<span class='bad'> Your casting was disrupted</span>")

/spell/aoe_turf/assail/choose_targets(var/mob/user = usr)
	return list(user)

/*
	BIG ASSAIL
						*/

/obj/effect/super_thrown_rock
	name = "Assail"
	desc = "What a psyker whom is high powered can do"
	density = 1
	w_type = NOT_RECYCLABLE
	anchored = 1

/obj/effect/super_thrown_rock/head
	var/traveled_length = 0 //How much of it we have done

/obj/effect/super_thrown_rock/head/New(var/turf/T, var/direction, var/beam_length)
	..()

	switch(direction)
		if(NORTH)
			icon = 'z40k_shit/icons/224x32molten_beam.dmi'
			icon_state = "assail_head"
			bound_width = 7 * WORLD_ICON_SIZE
		if(SOUTH)
			icon = 'z40k_shit/icons/224x32molten_beam.dmi'
			icon_state = "assail_head"
			bound_width = 7 * WORLD_ICON_SIZE
		if(EAST)
			icon = 'z40k_shit/icons/32x224molten_beam.dmi'
			icon_state = "assail_east"
			bound_height = 7 * WORLD_ICON_SIZE
		if(WEST)
			icon = 'z40k_shit/icons/32x224molten_beam.dmi'
			icon_state = "assail_west"
			bound_height = 7 * WORLD_ICON_SIZE

	var/turf/ARGH
	for(var/i=1 to beam_length)
		traveled_length++
		if(beam_length > traveled_length)
			if(step(src,direction))
				ARGH = get_step(src,turn(direction,180))
				new /obj/effect/super_thrown_rock/tail(ARGH, direction)
				sleep(3)

	if(traveled_length <= beam_length)
		qdel(src)

/obj/effect/super_thrown_rock/head/to_bump(atom/A)
	consume(A)

/obj/effect/super_thrown_rock/head/Bumped(atom/A)
	consume(A)

/obj/effect/super_thrown_rock/head/Crossed(atom/movable/A)
	consume(A)

/obj/effect/super_thrown_rock/head/proc/consume(atom/A)
	var/obj/complex_vehicle/CV = A
	if(istype(A,/obj/complex_vehicle))
		CV.health -= 1000

	var/turf/simulated/T = A
	if(istype(A,/turf/simulated))
		T.ChangeTurf(get_base_turf(src.z))
	
	if(iscarbon(A))
		var/mob/living/carbon/C = A
		C.adjustBruteLoss(25)
		C.Knockdown(12)
		C.Stun(12)
		to_chat(C,"<span class='bad'>You've been hit by a large chunk of earth.")

	var/obj/structure/ST = A
	if(istype(A, /obj/structure))
		qdel(ST)

	var/obj/machinery/MACH = A
	if(istype(A,/obj/machinery))
		qdel(MACH)


/obj/effect/super_thrown_rock/tail
	name = "Gouge in the earth"
	desc = "Its a gouge in the earth."
	density = 0
	slowdown_modifier = 2

/obj/effect/super_thrown_rock/tail/New(var/turf/T,direction)
	..()
	
	switch(direction)
		if(NORTH)
			icon = 'z40k_shit/icons/224x32molten_beam.dmi'
			icon_state = "assailmiddle"
			bound_width = 7 * WORLD_ICON_SIZE
		if(SOUTH)
			icon = 'z40k_shit/icons/224x32molten_beam.dmi'
			icon_state = "assailmiddle"
			bound_width = 7 * WORLD_ICON_SIZE
		if(EAST)
			icon = 'z40k_shit/icons/32x224molten_beam.dmi'
			icon_state = "assailmiddle"
			bound_height = 7 * WORLD_ICON_SIZE
		if(WEST)
			icon = 'z40k_shit/icons/32x224molten_beam.dmi'
			icon_state = "assailmiddle"
			bound_height = 7 * WORLD_ICON_SIZE

/obj/effect/super_thrown_rock/tail/proc/cya_boys()
	set waitfor = 0
	sleep(30 SECONDS)
	qdel(src)

/*
	REGULAR MOLTEN BEAM
						*/

/obj/effect/thrown_rock
	name = "Sand Wave"
	desc = "What a psyker whom is high powered can do"
	density = 1
	w_type = NOT_RECYCLABLE
	anchored = 1
	slowdown_modifier = 2

/obj/effect/thrown_rock/head
	var/traveled_length = 0

/obj/effect/thrown_rock/head/New(var/turf/T, var/direction, var/beam_length)
	..()

	switch(direction)
		if(NORTH)
			icon = 'z40k_shit/icons/96x32molten_beam.dmi'
			icon_state = "assail_head"
			bound_width = 3 * WORLD_ICON_SIZE
		if(SOUTH)
			icon = 'z40k_shit/icons/96x32molten_beam.dmi'
			icon_state = "assail_head"
			bound_width = 3 * WORLD_ICON_SIZE
		if(EAST)
			icon = 'z40k_shit/icons/32x96molten_beam.dmi'
			icon_state = "assail_east"
			bound_height = 3 * WORLD_ICON_SIZE
		if(WEST)
			icon = 'z40k_shit/icons/32x96molten_beam.dmi'
			icon_state = "assail_west"
			bound_height = 3 * WORLD_ICON_SIZE

	var/turf/ARGH
	for(var/i=1 to beam_length)
		traveled_length++
		if(beam_length > traveled_length)
			if(step(src,direction))
				ARGH = get_step(src,turn(direction,180))
				new /obj/effect/thrown_rock/tail(ARGH, direction)
				sleep(3)
	
	if(traveled_length <= beam_length)
		qdel(src)

/obj/effect/thrown_rock/head/to_bump(atom/A)
	consume(A)

/obj/effect/thrown_rock/head/Bumped(atom/A)
	consume(A)

/obj/effect/thrown_rock/head/Crossed(atom/movable/A)
	consume(A)

/obj/effect/thrown_rock/head/proc/consume(atom/A)
	if(istype(A,/mob/living/carbon))
		var/mob/living/carbon/C = A
		C.adjustBruteLoss(25)
		C.Knockdown(12)
		C.Stun(12)
		to_chat(C,"<span class='bad'>You've been hit by a large chunk of earth.")

	var/obj/complex_vehicle/CV = A
	if(istype(A,/obj/complex_vehicle))
		CV.health -= 1000

	var/turf/simulated/T = A
	if(istype(A,/turf/simulated))
		T.ChangeTurf(get_base_turf(src.z))

	var/obj/structure/ST = A
	if(istype(A, /obj/structure))
		qdel(ST)

	var/obj/machinery/MACH = A
	if(istype(A,/obj/machinery))
		qdel(MACH)

/obj/effect/thrown_rock/tail
	name = "Gouge in the earth"
	desc = "Its a gouge in the earth."
	slowdown_modifier = 2
	density = 0

/obj/effect/thrown_rock/tail/proc/cya_boys()
	set waitfor = 0
	sleep(30 SECONDS)
	qdel(src)

/obj/effect/thrown_rock/tail/New(var/turf/T,direction)
	..()

	switch(direction)
		if(NORTH)
			icon = 'z40k_shit/icons/96x32molten_beam.dmi'
			icon_state = "assailmiddle"
			bound_width = 3 * WORLD_ICON_SIZE
		if(SOUTH)
			icon = 'z40k_shit/icons/96x32molten_beam.dmi'
			icon_state = "assailmiddle"
			bound_width = 3 * WORLD_ICON_SIZE
		if(EAST)
			icon = 'z40k_shit/icons/32x96molten_beam.dmi'
			icon_state = "assailmiddle"
			bound_height = 3 * WORLD_ICON_SIZE
		if(WEST)
			icon = 'z40k_shit/icons/32x96molten_beam.dmi'
			icon_state = "assailmiddle"
			bound_height = 3 * WORLD_ICON_SIZE
