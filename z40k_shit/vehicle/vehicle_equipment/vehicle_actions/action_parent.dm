/datum/action/complex_vehicle_equipment
	icon_icon = 'z40k_shit/icons/complex_vehicle/actionbuttons.dmi' //The symbol file
	button_icon_state = "default" // The button symbol state
	button_icon = 'z40k_shit/icons/complex_vehicle/actionbuttons.dmi' //background button file
	background_icon_state = "bg_pod" //background icon state
	var/pilot_only = FALSE //Is this restricted to the pilot/driver only?
	var/id = 0//We should inherit the ID from the object that gave us life.
	var/weapon_toggle = FALSE //For weapon toggles
	var/attached_part = FALSE //For attached Parts

/datum/action/complex_vehicle_equipment/Trigger()
	..()
	var/obj/S = target
	if(!istype(S))
		qdel(src)
		return

/datum/action/complex_vehicle_equipment/New(var/obj/complex_vehicle/Target)
	..()

