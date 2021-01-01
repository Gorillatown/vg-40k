




/*
	Speed Adjuster
*/
/*
/obj/machinery/bumper_speed_adjuster
	icon_state = "speed_adjuster"
	var/step_delay = 1
	var/frequency = 1367
	var/datum/radio_frequency/radio_connection

/obj/machinery/bumper_speed_adjuster/Crossed(atom/movable/AM)
	for(var/obj/structure/tracker_object/T in AM.contents)
		T.our_controller.step_delay = step_delay
*/
