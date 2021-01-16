/obj/item/vehicle_parts/weaponery/multi_laser
	name = "Multi Laser"
	tied_action = /datum/action/linked_parts_buttons/toggle_weapon
	projectile_type = /obj/item/projectile/beam/maxpower
	projectiles_per_shot = 5 //How many projectiles come out
	fire_delay = 1 //Delay on when next action can be done.
	fire_sound = list('F_40kshit/sounds/Lasgun0.ogg')
	vis_con_overlay = /obj/effect/overlay/multi_laser_overlay

//Basically when you click with the switch toggled on, it performs this proc.
/obj/item/vehicle_parts/weaponery/multi_laser/action(atom/target)
	if(next_firetime > world.time)
		return
	var/turf/targloc = get_turf(target) //Target location is the turf of the target
	var/olddir //Basically a holder outside the for loop, so we break if they turn.
	var/changedloc_variant = get_turf(my_atom) // A holder for height
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
		changedloc_variant = get_step(changedloc_variant,my_atom.dir)
		playsound(src, pick(fire_sound), 50, 1, 12)
		var/obj/item/projectile/A = new projectile_type(changedloc_variant)
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

/obj/effect/overlay/multi_laser_overlay
	name = "Multi Laser"
	icon = 'F_40kshit/icons/complex_vehicle/vehicle_overlays64x64.dmi'
	icon_state = "multi_laser-Sentinel"
	plane = ABOVE_HUMAN_PLANE
	layer = VEHICLE_LAYER

	vis_flags = VIS_INHERIT_ID|VIS_INHERIT_DIR
