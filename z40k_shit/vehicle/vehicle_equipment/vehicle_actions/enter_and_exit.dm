//Toggle Engine
/datum/action/complex_vehicle_equipment/enter_and_exit
	name = "Exit Vehicle"
	button_icon_state = "exit"

/datum/action/complex_vehicle_equipment/enter_and_exit/Trigger()
	..()
	var/obj/complex_vehicle/S = target
	S.attempt_move_inandout(owner)

/obj/complex_vehicle/proc/attempt_move_inandout(var/mob/user)
	if(occupants.Find(user))
		if(pilot_zoom && user == get_pilot())
			user.regenerate_icons()
			var/client/C = user.client
			C.changeView(C.view - vehicle_zoom)
			pilot_zoom = FALSE
		move_outside(user, get_turf(src))
		return

	if(user.incapacitated() || user.lying) //are you cuffed, dying, lying, stunned or other
		return
	if (!ishigherbeing(user))
		return

	visible_message("<span class='notice'>[user] starts to climb into \the [src].</span>")

	if(do_after(user, user, 4 SECONDS))
		var/list/passengers = get_passengers()
		if(!get_pilot() || passengers.len < passenger_limit)
			move_into_vehicle(user)
		else
			to_chat(user, "<span class = 'warning'>Not enough room inside \the [src].</span>")
	else
		to_chat(user, "You stop entering \the [src].")
	return