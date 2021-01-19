/datum/action/linked_parts_buttons/toggle_weapon
	name = "Toggle Weapon"
	button_icon_state = "weapons_off"
	systems_online = FALSE
	pilot_only = TRUE

/datum/action/linked_parts_buttons/toggle_weapon/Trigger()
	..()
	var/obj/com_vehicle/S = target
	
	systems_online = !systems_online
	
	if(systems_online)
		button_icon_state = "weapons_on"
	else
		button_icon_state = "weapons_off"
	UpdateButtonIcon()
	
	S.toggle_part(systems_online, id)


/datum/action/linked_parts_buttons/toggle_engine
	name = "Toggle Engine"
	button_icon_state = "engine_off"

/datum/action/linked_parts_buttons/toggle_engine/Trigger()
	var/obj/com_vehicle/S = target
	S.toggle_engine()
	 
	if(S.engine_online)
		button_icon_state = "engine_on"
	else
		button_icon_state = "engine_off"
	UpdateButtonIcon()