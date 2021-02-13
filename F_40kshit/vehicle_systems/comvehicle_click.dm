/**************************
		MouseDropTo
**************************/
/obj/com_vehicle/MouseDropTo(mob/M, mob/user)
	if(M != user || !Adjacent(M) || !Adjacent(user))
		return
	enter_exit_handler(M)

/**************************
		MouseDropFrom
**************************/
/obj/com_vehicle/MouseDropFrom(atom/over)
	if(!over || !Adjacent(usr) || !Adjacent(over))
		return
	
	if(istype(usr.loc,/obj/com_vehicle))
		var/mob/pilot = get_pilot()
		if(usr != pilot)
			return

	var/turf/T = get_turf(over)
	if(!occupants.Find(usr))
		var/mob/pilot = get_pilot()
		if(pilot)
			visible_message("<span class='notice'>[usr] start pulling [pilot.name] out of \the [src].</span>")
			if(do_after(usr, usr, 2 SECONDS))
				move_outside(pilot, T)
			return

	if(!Adjacent(T) || T.density)
		return
	if(occupants.Find(usr))
		if(do_after(usr, usr, 1 SECONDS))
			move_outside(usr,T)

/**************************
	click_action_control
**************************/
/obj/com_vehicle/proc/click_action_control(atom/target, mob/living/user)
	if(mechanically_disabled || user.incapacitated() || src == target || !target)
		return
	
	if(user != get_pilot()) //If user is not pilot return false
		return

	var/dir_to_target = get_dir(src,target)
	if(dir_to_target && !(dir_to_target & dir))//wrong direction
		return
	
	if(Adjacent(target))
		if(world.time > next_melee_time)
			if(vehicle_melee(target))
				next_melee_time = world.time + melee_time
	
	if(comvehicle_parts.equipment_systems.len)
		for(var/obj/item/vehicle_parts/vehicle_part in comvehicle_parts.equipment_systems)
			if(vehicle_part.systems_online)
				vehicle_part.action(target)
				sleep(1)