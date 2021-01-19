/obj/com_vehicle/sentinel
	name = "Sentinel"
	icon = 'F_40kshit/icons/complex_vehicle/walkers64x64.dmi'
	icon_state = "sentinel"
	
	maxHealth = 1500
	contains_occupants = TRUE
	movement_sounds = list('F_40kshit/sounds/vehicles/sentinel_move_loop.ogg')
	turning_sounds = list('F_40kshit/sounds/vehicles/sentinel_turn.ogg')

	pixel_x = -16
/*****************************
	Engine Master Variables
*****************************/
	can_reverse = TRUE
	idle_output = FALSE
	speed_loss = 5
	max_speed = 500
	max_reverse_speed = -300
	acceleration = 25
	movement_delay = 3

/obj/com_vehicle/sentinel/New()
	..()
	var/obj/item/I = new /obj/item/vehicle_parts/weaponery/multi_laser(loc)
	comvehicle_parts.parts_insertion(null,I)