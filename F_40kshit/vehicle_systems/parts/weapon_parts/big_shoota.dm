/obj/item/vehicle_parts/weaponery/big_shoota
	name = "Big Shoota"
	projectile_type = /obj/item/projectile/bullet/punisherbullet
	projectiles_per_shot = 3
	tied_action = /datum/action/linked_parts_buttons/toggle_weapon
	fire_delay = 1 //Delay on when next action can be done.
	fire_sound = list('F_40kshit/sounds/punisher1.ogg',
					'F_40kshit/sounds/punisher2.ogg',
					'F_40kshit/sounds/punisher3.ogg',
					'F_40kshit/sounds/punisher4.ogg'
					)
	vis_con_overlay = /obj/effect/overlay/big_shoota_overlay

//Basically when you click with the switch toggled on, it performs this proc.
/obj/item/vehicle_parts/weaponery/big_shoota/action(atom/target)
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

/obj/effect/overlay/big_shoota_overlay
	name = "Big Shoota"
	icon = 'F_40kshit/icons/complex_vehicle/vehicle_overlays64x64.dmi'
	icon_state = "big_shoota-Killa Kan"
	plane = ABOVE_HUMAN_PLANE
	layer = VEHICLE_LAYER

	vis_flags = VIS_INHERIT_ID|VIS_INHERIT_DIR