
/obj/complex_vehicle/MouseDropTo(mob/M, mob/user)
	if(M != user)
		return
	if(!Adjacent(M) || !Adjacent(user))
		return
	attempt_move_inandout(M, user)

/obj/complex_vehicle/MouseDropFrom(atom/over)
	if(!usr || !over)
		return
	if(!Adjacent(usr) || !Adjacent(over))
		return
	var/turf/T = get_turf(over)
	if(!occupants.Find(usr))
		var/mob/pilot = get_pilot()
		if(pilot)
			visible_message("<span class='notice'>[usr] start pulling [pilot.name] out of \the [src].</span>")
			if(do_after(usr, usr, 4 SECONDS))
				move_outside(pilot, T)
			return
	if(!Adjacent(T) || T.density)
		return
	for(var/atom/movable/A in T.contents)
		if(A.density)
			if((A == src) || istype(A, /mob))
				continue
			return
	if(occupants.Find(usr))
		if(do_after(usr, usr, 4 SECONDS))
			move_outside(usr,T)

/obj/complex_vehicle/proc/click_action_control(atom/target,mob/user)
	if(vehicle_broken_husk)
		return
	if(user != get_pilot()) //If user is not pilot return false
		return
	if(user.stat)
		return
	if(src == target)
		return
	var/dir_to_target = get_dir(src,target)
	if(dir_to_target && !(dir_to_target & src.dir))//wrong direction
		return
		if(!target)
			return
	if(get_dist(src, target)>1)
		if(ES.equipment_systems.len)
			for(var/obj/item/device/vehicle_equipment/weaponry/COCK in ES.equipment_systems)
				if(COCK.weapon_online)
					COCK.action(target)
					sleep(1)
