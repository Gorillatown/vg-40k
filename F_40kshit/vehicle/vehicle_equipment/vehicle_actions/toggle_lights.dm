
//Toggle Lights
/datum/action/complex_vehicle_equipment/toggle_lights
	name = "Toggle lights"
	button_icon_state = "toggle_lights"
	pilot_only = TRUE

/datum/action/complex_vehicle_equipment/toggle_lights/Trigger()
	..()
	var/obj/complex_vehicle/S = target
	S.toggle_lights()
	
	