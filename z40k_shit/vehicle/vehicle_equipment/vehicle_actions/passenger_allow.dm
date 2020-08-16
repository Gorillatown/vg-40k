
//Toggle Passenger Allowance
/datum/action/complex_vehicle_equipment/toggle_passengers
	name = "Toggle Passenger Allowance"
	button_icon_state = "lock_open"
	pilot_only = TRUE

/datum/action/complex_vehicle_equipment/toggle_passengers/Trigger()
	..()
	var/obj/complex_vehicle/S = target
	S.toggle_passengers()
	if(S.passengers_allowed)
		button_icon_state = "lock_open"
	else
		button_icon_state = "lock_closed"
	UpdateButtonIcon()

