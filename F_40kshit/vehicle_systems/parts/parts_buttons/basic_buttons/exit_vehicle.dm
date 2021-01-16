/*
	Basically this button just exits the vehicle
*/
/datum/action/linked_parts_buttons/exit_vehicle
	name = "Exit Vehicle"
	button_icon_state = "exit"

/datum/action/linked_parts_buttons/exit_vehicle/Trigger()
	..()
	var/obj/com_vehicle/S = target
	S.enter_exit_handler(owner)