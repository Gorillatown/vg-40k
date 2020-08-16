/spell/aoe_turf/molten_beam
	name = "Molten Beam"
	desc = "Witchfire(Beam) - Set your heart ablaze!"
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	override_base = "cult"
	abbreviation = "GOKU"
	user_type = USER_TYPE_PSYKER
	specialization = SSPYROMANCY

	charge_type = Sp_RECHARGE
	charge_max = 500
	spell_flags = 0
	spell_aspect_flags = SPELL_FIRE
	range = 20
	invocation_type = SpI_NONE
	var/beam_length = 20
	still_recharging_msg = "<span class='notice'>You ain't ready yet idiot..</span>"

	hud_state = "molten_beam"
	warpcharge_cost = 160

/spell/aoe_turf/molten_beam/cast(list/targets, mob/living/user)
	set waitfor = 0

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

			new /obj/effect/super_molten_beam/head(bound_adjustment,user.dir,beam_length)

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
			new /obj/effect/molten_beam/head(bound_adjustment,user.dir,beam_length)
	else
		to_chat(user,"<span class='bad'> Your casting was disrupted</span>")

/spell/aoe_turf/molten_beam/choose_targets(var/mob/user = usr)
	return list(user)

/*
	SUPER MOLTEN BEAM
						*/

/obj/effect/super_molten_beam
	name = "ascended molten beam"
	desc = "What a psyker whom is high powered can do"
	density = 1
	w_type = NOT_RECYCLABLE
	anchored = 1

/obj/effect/super_molten_beam/to_bump(atom/A)
	consume(A)

/obj/effect/super_molten_beam/Bumped(atom/A)
	consume(A)

/obj/effect/super_molten_beam/Crossed(atom/movable/A)
	consume(A)

/obj/effect/super_molten_beam/proc/consume(atom/A)
	var/obj/item/O = A
	if(istype(A,/obj/item))
		qdel(O)

	var/obj/complex_vehicle/CV = A
	if(istype(A,/obj/complex_vehicle))
		CV.health -= 2000
	
	var/turf/simulated/T = A
	if(istype(A,/turf/simulated))
		T.ChangeTurf(get_base_turf(src.z))

	if(iscarbon(A))
		var/mob/living/carbon/C = A
		C.gib()

	var/obj/structure/ST = A
	if(istype(A, /obj/structure))
		qdel(ST)

	var/obj/machinery/MACH = A
	if(istype(A,/obj/machinery))
		qdel(MACH)

/obj/effect/super_molten_beam/head
	var/list/segments = list() //we recordo ur segments
	var/traveled_length = 0 //How much of it we have done

/obj/effect/super_molten_beam/head/New(var/turf/T, var/direction, var/beam_length)
	..()

	switch(direction)
		if(NORTH)
			icon = 'z40k_shit/icons/224x32molten_beam.dmi'
			icon_state = "beamhead_north"
			bound_width = 7 * WORLD_ICON_SIZE
		if(SOUTH)
			icon = 'z40k_shit/icons/224x32molten_beam.dmi'
			icon_state = "beamhead_south"
			bound_width = 7 * WORLD_ICON_SIZE
		if(EAST)
			icon = 'z40k_shit/icons/32x224molten_beam.dmi'
			icon_state = "beamhead_east"
			bound_height = 7 * WORLD_ICON_SIZE
		if(WEST)
			icon = 'z40k_shit/icons/32x224molten_beam.dmi'
			icon_state = "beamhead_west"
			bound_height = 7 * WORLD_ICON_SIZE

	var/turf/ARGH
	for(var/i=1 to beam_length)
		traveled_length++
		if(beam_length > traveled_length)
			if(step(src,direction))
				ARGH = get_step(src,turn(direction,180))
				var/obj/effect/super_molten_beam/tail/AH = new(ARGH, direction)
				segments += AH			
				sleep(3)

	if(traveled_length <= beam_length)
		beam_end()

/obj/effect/super_molten_beam/head/proc/beam_end()
	for(var/obj/effect/super_molten_beam/tail/AH in segments)
		qdel(AH)

	qdel(src)

/obj/effect/super_molten_beam/tail

/obj/effect/super_molten_beam/tail/New(var/turf/T,direction)
	..()
	
	switch(direction)
		if(NORTH)
			icon = 'z40k_shit/icons/224x32molten_beam.dmi'
			icon_state = "beammiddle"
			bound_width = 7 * WORLD_ICON_SIZE
		if(SOUTH)
			icon = 'z40k_shit/icons/224x32molten_beam.dmi'
			icon_state = "beammiddle"
			bound_width = 7 * WORLD_ICON_SIZE
		if(EAST)
			icon = 'z40k_shit/icons/32x224molten_beam.dmi'
			icon_state = "beammiddle"
			bound_height = 7 * WORLD_ICON_SIZE
		if(WEST)
			icon = 'z40k_shit/icons/32x224molten_beam.dmi'
			icon_state = "beammiddle"
			bound_height = 7 * WORLD_ICON_SIZE

/*
	REGULAR MOLTEN BEAM
						*/

/obj/effect/molten_beam
	name = "regular molten beam"
	desc = "What a psyker whom is high powered can do"
	density = 1
	w_type = NOT_RECYCLABLE
	anchored = 1

/obj/effect/molten_beam/to_bump(atom/A)
	consume(A)

/obj/effect/molten_beam/Bumped(atom/A)
	consume(A)

/obj/effect/molten_beam/Crossed(atom/movable/A)
	consume(A)

/obj/effect/molten_beam/proc/consume(atom/A)
	var/obj/item/O = A
	if(istype(A,/obj/item))
		qdel(O)

	var/obj/complex_vehicle/CV = A
	if(istype(A,/obj/complex_vehicle))
		CV.health -= 1000

	var/turf/simulated/T = A
	if(istype(A,/turf/simulated))
		T.ChangeTurf(get_base_turf(src.z))

	var/mob/living/carbon/C = A
	if(istype(A,/mob/living/carbon))
		C.gib()

	var/obj/structure/ST = A
	if(istype(A, /obj/structure))
		qdel(ST)

/obj/effect/molten_beam/head
	var/list/segments = list() //record our segments
	var/traveled_length = 0

/obj/effect/molten_beam/head/New(var/turf/T, var/direction, var/beam_length)
	..()

	switch(direction)
		if(NORTH)
			icon = 'z40k_shit/icons/96x32molten_beam.dmi'
			icon_state = "beamhead_north"
			bound_width = 3 * WORLD_ICON_SIZE
		if(SOUTH)
			icon = 'z40k_shit/icons/96x32molten_beam.dmi'
			icon_state = "beamhead_south"
			bound_width = 3 * WORLD_ICON_SIZE
		if(EAST)
			icon = 'z40k_shit/icons/32x96molten_beam.dmi'
			icon_state = "beamhead_east"
			bound_height = 3 * WORLD_ICON_SIZE
		if(WEST)
			icon = 'z40k_shit/icons/32x96molten_beam.dmi'
			icon_state = "beamhead_west"
			bound_height = 3 * WORLD_ICON_SIZE

	var/turf/ARGH
	for(var/i=1 to beam_length)
		traveled_length++
		if(beam_length > traveled_length)
			if(step(src,direction))
				ARGH = get_step(src,turn(direction,180))
				var/obj/effect/molten_beam/tail/AH = new(ARGH, direction)
				segments += AH			
				sleep(3)
	
	if(traveled_length <= beam_length)
		beam_end()

/obj/effect/molten_beam/head/proc/beam_end()
	for(var/obj/effect/molten_beam/tail/AH in segments)
		qdel(AH)

	qdel(src)

/obj/effect/molten_beam/tail

/obj/effect/molten_beam/tail/New(var/turf/T,direction)
	..()

	switch(direction)
		if(NORTH)
			icon = 'z40k_shit/icons/96x32molten_beam.dmi'
			icon_state = "beammiddle"
			bound_width = 3 * WORLD_ICON_SIZE
		if(SOUTH)
			icon = 'z40k_shit/icons/96x32molten_beam.dmi'
			icon_state = "beammiddle"
			bound_width = 3 * WORLD_ICON_SIZE
		if(EAST)
			icon = 'z40k_shit/icons/32x96molten_beam.dmi'
			icon_state = "beammiddle"
			bound_height = 3 * WORLD_ICON_SIZE
		if(WEST)
			icon = 'z40k_shit/icons/32x96molten_beam.dmi'
			icon_state = "beammiddle"
			bound_height = 3 * WORLD_ICON_SIZE

