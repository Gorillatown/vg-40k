/datum/action/linked_parts_buttons
	icon_icon = 'F_40kshit/icons/complex_vehicle/actionbuttons.dmi' //The symbol file
	button_icon_state = "default" // The button symbol state
	button_icon = 'F_40kshit/icons/complex_vehicle/actionbuttons.dmi' //background button file
	background_icon_state = "bg_pod" //background icon state
	
	var/pilot_only = FALSE //Is this restricted to the pilot/driver only?
	
	var/id = 0//We should inherit the ID from the object that gave us life.
	var/systems_online = FALSE //For toggled parts

//Basically the param links the atom to Target, letting us ref it
/datum/action/linked_parts_buttons/New(var/obj/com_vehicle/Target)
	..()

/datum/action/linked_parts_buttons/Trigger()
	if(!..())
		return FALSE
	var/obj/S = target
	if(!istype(S))
		qdel(src)
		return
		