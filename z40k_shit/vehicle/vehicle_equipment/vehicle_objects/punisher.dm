
/*
	Projectile		---------------------------------------
				*/

/obj/item/projectile/bullet/punisherbullet
	name = "punisher gatling bullet"
	icon = 'z40k_shit/icons/obj/projectiles.dmi'
	icon_state = "punisher"
	damage = 40
	kill_count = 20

/*
	Equipment Segment		--------------------------------------
						*/

/obj/item/device/vehicle_equipment/weaponry/punisher
	name = "Punisher Gatling Cannon"
	desc = "This is gonna hurt"
	icon_state = "punisher_cannon"
	projectile_type = /obj/item/projectile/bullet/punisherbullet
	projectiles_per_shot = 5
	tied_action = /datum/action/complex_vehicle_equipment/toggle_punisher //Action tied to weapon
	weapon_online = FALSE
	fire_delay = 1 //Delay on when next action can be done.
	fire_sound = list('z40k_shit/sounds/punisher1.ogg',
					'z40k_shit/sounds/punisher2.ogg',
					'z40k_shit/sounds/punisher3.ogg',
					'z40k_shit/sounds/punisher4.ogg'
					)
	

/obj/item/device/vehicle_equipment/weaponry/punisher/New()
	..()

/obj/item/device/vehicle_equipment/weaponry/punisher/action(atom/target)
	if(next_firetime > world.time)
		return
	var/turf/targloc = get_turf(target) //Target location is the turf of the target
	var/olddir //Basically a holder outside the for loop, so we break if they turn.
	var/changedloc_variant = get_turf(my_atom) // A holder for height
	var/obj/complex_vehicle/DICKMASTER = my_atom

	for(var/i=1 to projectiles_per_shot) //For 1 to minimum 1 to protections per shot
		var/turf/curloc = get_turf(my_atom) //Our current location is gotten from our source turf
		dir = my_atom.dir //Direction is the direction of our atom
		if(!olddir)
			olddir = dir //olddirection is our direction
		switch(dir) //We enter a switch based on the direction
			if(NORTH) //If its north
				changedloc_variant = get_turf(my_atom)
				for(var/p=1 to DICKMASTER.vehicle_height) //Our actual object will always be in the bottom left corner
					changedloc_variant = get_step(changedloc_variant, NORTH) //Then we get the turf to the north of that one
				changedloc_variant = get_step(changedloc_variant, EAST)
				if(DICKMASTER.acceleration >= 600)
					changedloc_variant = get_step(changedloc_variant,NORTH)
			if(SOUTH)
				changedloc_variant = get_turf(my_atom)
				changedloc_variant = get_step(changedloc_variant, SOUTH)
				changedloc_variant = get_step(changedloc_variant, EAST)
				if(DICKMASTER.acceleration >= 600)
					changedloc_variant = get_step(changedloc_variant,SOUTH)
			if(EAST)
				changedloc_variant = get_turf(my_atom)
				for(var/q=1 to DICKMASTER.vehicle_width)
					changedloc_variant = get_step(changedloc_variant, EAST)
				changedloc_variant = get_step(changedloc_variant, NORTH)
				if(DICKMASTER.acceleration >= 600)
					changedloc_variant = get_step(changedloc_variant,EAST)
			if(WEST)
				changedloc_variant = get_turf(my_atom)
				changedloc_variant = get_step(changedloc_variant, WEST)
				changedloc_variant = get_step(changedloc_variant, NORTH)
				if(DICKMASTER.acceleration >= 600)
					changedloc_variant = get_step(changedloc_variant,WEST)
		if(!targloc || !curloc)
			continue
		if(targloc == curloc)
			continue
		if(dir != olddir) //If old direction is not the same as our current direction
			break //We break
		playsound(src, pick(fire_sound), 50, 1, 12)
		var/obj/item/projectile/A = new projectile_type(changedloc_variant)
		A.vehicle = my_atom
		A.firer = usr
		A.original = target
		A.current = changedloc_variant
		A.starting = changedloc_variant
		A.yo = targloc.y - curloc.y
		A.xo = targloc.x - curloc.x
		A.OnFired()
		A.process()
		sleep(2)
	
	next_firetime = world.time + fire_delay
	return
