/obj/com_vehicle/killa_kan
	name = "Killa Kan"
	icon = 'F_40kshit/icons/complex_vehicle/walkers64x64.dmi'
	icon_state = "killa_kan"

	maxHealth = 2000
	contains_occupants = TRUE
	movement_sounds = list('F_40kshit/sounds/vehicles/killakan_move_loop.ogg')
	turning_sounds = list('F_40kshit/sounds/vehicles/killakan_turn.ogg')
	engine_startup_noise = list('F_40kshit/sounds/vehicles/which.ogg')
	
	var/list/kkan_melee_sounds = list('F_40kshit/sounds/vehicles/KanKlaw0.wav',
									'F_40kshit/sounds/vehicles/KanKlaw1.wav',
									'F_40kshit/sounds/vehicles/KanKlaw2.wav')
	
	var/list/kkan_fun_sounds = list('F_40kshit/sounds/vehicles/stomp.ogg',
									'F_40kshit/sounds/vehicles/stompem.ogg',
									'F_40kshit/sounds/vehicles/stompy.ogg')

/*****************************
	Engine Master Variables
*****************************/
	can_reverse = FALSE
	speed_loss = 5
	max_speed = 500
	acceleration = 10

/obj/com_vehicle/killa_kan/New()
	..()
	var/obj/item/I = new /obj/item/vehicle_parts/weaponery/big_shoota(loc)
	comvehicle_parts.parts_insertion(null,I)

/obj/com_vehicle/killa_kan/vehicle_melee(atom/target)
	if(isliving(target))
		var/mob/living/L = target
		L.adjustBruteLoss(60)

	if(istype(target,/obj/structure/nubarricade/metal))
		var/obj/structure/nubarricade/metal/cade = target
		cade.health -= 100
		cade.healthcheck()

	playsound(src,pick(kkan_melee_sounds))
	return 1

/obj/com_vehicle/killa_kan/adjust_health(damage, direction)
	..()
	if(prob(8))
		playsound(src,pick(kkan_fun_sounds))