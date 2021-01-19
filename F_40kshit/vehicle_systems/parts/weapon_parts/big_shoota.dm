/obj/item/projectile/bullet/big_shoota_bullet
	name = "big shoota bullet"
	icon = 'F_40kshit/icons/obj/projectiles.dmi'
	icon_state = "punisher"
	damage = 40
	kill_count = 20

/obj/item/vehicle_parts/weaponery/big_shoota
	name = "Big Shoota"
	projectile_type = /obj/item/projectile/bullet/big_shoota_bullet
	projectiles_per_shot = 3
	tied_action = /datum/action/linked_parts_buttons/toggle_weapon
	fire_delay = 1 SECONDS //Delay on when next action can be done.
	fire_sound = list('F_40kshit/sounds/punisher1.ogg',
					'F_40kshit/sounds/punisher2.ogg',
					'F_40kshit/sounds/punisher3.ogg',
					'F_40kshit/sounds/punisher4.ogg'
					)
	vis_con_overlay = /obj/effect/overlay/big_shoota_overlay

//Basically when you click with the switch toggled on, it performs this proc.
/obj/item/vehicle_parts/weaponery/big_shoota/action(atom/target)
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

/obj/effect/overlay/big_shoota_overlay
	name = "Big Shoota"
	icon = 'F_40kshit/icons/complex_vehicle/vehicle_overlays64x64.dmi'
	icon_state = "big_shoota"
	plane = ABOVE_HUMAN_PLANE
	layer = VEHICLE_LAYER

	vis_flags = VIS_INHERIT_ID|VIS_INHERIT_DIR