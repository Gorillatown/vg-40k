//Toggle Engine
/datum/action/toggle_engine
	name = "Toggle Engine"
	icon_icon = 'F_40kshit/icons/complex_vehicle/actionbuttons.dmi' //The symbol file
	background_icon_state = "bg_pod" //background icon state
	button_icon = 'F_40kshit/icons/complex_vehicle/actionbuttons.dmi' //background button file
	button_icon_state = "engine_off"
	var/sounds = list('sound/items/flashlight_on.ogg','sound/items/flashlight_off.ogg')

/datum/action/toggle_engine/New(var/obj/structure/bed/chair/vehicle/Target)
	..()
	Target.vehicle_actions += src

/datum/action/toggle_engine/Trigger()
	if(!..())
		return FALSE
	var/obj/structure/bed/chair/vehicle/assault_bike/S = target
	S.toggle_engine_yeah()
	if(S.engine_toggle)
		button_icon_state = "engine_on"
		playsound(S,'F_40kshit/sounds/misc_effects/bike_start.ogg',50)
	else
		button_icon_state = "engine_off"
	UpdateButtonIcon()

/obj/structure/bed/chair/vehicle/assault_bike/proc/toggle_engine_yeah()

	engine_toggle = !engine_toggle

	if(engine_toggle) //If Engine toggle is true, and we are not on cooldown
		if(acceleration < 10)
			acceleration += 5 //We set acceleration back to neutral if the engine is turned off.
		if(!engine_cooldown) //if engine cooldown is false
			engine_cooldown = TRUE //Engine cooldown becomes true
			spawn(10) //we spawn to give everything time to finish so we don't lock them up
				trigger_engine() //Then we trigger engine which has a while loop (that would lock them up)
			spawn(30)
				engine_cooldown = FALSE
