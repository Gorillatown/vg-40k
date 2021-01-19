/obj/item/projectile/beam/multi_laser
	name = "powerful laser"
	damage = 45

/obj/item/vehicle_parts/weaponery/multi_laser
	name = "Multi Laser"
	tied_action = /datum/action/linked_parts_buttons/toggle_weapon
	projectile_type = /obj/item/projectile/beam/multi_laser
	projectiles_per_shot = 5 //How many projectiles come out
	fire_delay = 2 SECONDS //Delay on when next action can be done.
	fire_sound = list('F_40kshit/sounds/Lasgun0.ogg')
	vis_con_overlay = /obj/effect/overlay/multi_laser_overlay

//Basically when you click with the switch toggled on, it performs this proc.
/obj/item/vehicle_parts/weaponery/multi_laser/action(atom/target)
	if(next_firetime > world.time || performing_action)
		return
	performing_action = TRUE
	var/turf/targloc = get_turf(target) //Target location is the turf of the target
	var/olddir //Basically a holder outside the for loop, so we break if they turn.
	for(var/i=1 to projectiles_per_shot) //For 1 to minimum 1 to protections per shot
		var/turf/curloc = get_turf(my_atom) //Our current location is gotten from our source turf
		dir = my_atom.dir //Direction is the direction of our atom
		if(!olddir)
			olddir = dir //olddirection is our direction
		if(!targloc || !curloc)
			continue
		if(targloc == curloc)
			continue
		if(dir != olddir) //If old direction is not the same as our current direction
			break //We break
		playsound(src, pick(fire_sound), 50, 1, 12)
		var/obj/item/projectile/A = new projectile_type(curloc)
		A.firer = usr
		A.original = target
		A.current = curloc
		A.starting = curloc
		A.yo = targloc.y - curloc.y
		A.xo = targloc.x - curloc.x
		A.OnFired()
		A.process()
		sleep(2)
	
	next_firetime = world.time + fire_delay
	performing_action = FALSE
	return

/obj/effect/overlay/multi_laser_overlay
	name = "Multi Laser"
	icon = 'F_40kshit/icons/complex_vehicle/vehicle_overlays64x64.dmi'
	icon_state = "multi_laser"
	plane = ABOVE_HUMAN_PLANE
	layer = VEHICLE_LAYER

	vis_flags = VIS_INHERIT_ID|VIS_INHERIT_DIR
