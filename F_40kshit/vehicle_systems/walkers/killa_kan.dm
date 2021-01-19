/obj/com_vehicle/killa_kan
	name = "Killa Kan"
	icon = 'F_40kshit/icons/complex_vehicle/walkers64x64.dmi'
	icon_state = "killa_kan"

	maxHealth = 2000
	contains_occupants = TRUE
	movement_sounds = list('F_40kshit/sounds/vehicles/killakan_move_loop.ogg')
	turning_sounds = list('F_40kshit/sounds/vehicles/killakan_turn.ogg')
	engine_startup_noise = list('F_40kshit/sounds/vehicles/which.ogg')
	
	var/list/kkan_melee_sounds = list('F_40kshit/sounds/vehicles/KanKlaw0.ogg',
									'F_40kshit/sounds/vehicles/KanKlaw1.ogg',
									'F_40kshit/sounds/vehicles/KanKlaw2.ogg')
	
	var/list/kkan_fun_sounds = list('F_40kshit/sounds/vehicles/stomp.ogg',
									'F_40kshit/sounds/vehicles/stompem.ogg',
									'F_40kshit/sounds/vehicles/stompy.ogg')
	pixel_x = -16

/*****************************
	Engine Master Variables
*****************************/
	can_reverse = FALSE
	idle_output = FALSE
	speed_loss = 5
	max_speed = 310
	acceleration = 5
 
/obj/com_vehicle/killa_kan/New()
	..()
	var/obj/item/I = new /obj/item/vehicle_parts/weaponery/big_shoota(loc)
	comvehicle_parts.parts_insertion(null,I)

/obj/com_vehicle/killa_kan/MouseDropTo(mob/M, mob/user)
	if(isgretchin(M))
		..()
	else
		visible_message("<span class='danger'>The [M] can't seem to squeeze in, maybe its ment for a grot!</span>")

//Eventually we will have a marker for melee parts, for now the proc just goes here as a test_case
/obj/com_vehicle/killa_kan/vehicle_melee(atom/target)
	if(isliving(target))
		var/mob/living/L = target
		L.adjustBruteLoss(60)
		visible_message("<span class='danger'>The [name] saws brutally into [L]!</span>")
		playsound(src,pick(kkan_melee_sounds),100)
		if(prob(8))
			playsound(src,pick(kkan_fun_sounds))

	for(var/target_type in destroyable_obj)
		if(istype(target, target_type) && hascall(target, "attackby"))
			to_chat(get_pilot(),"You hit the [target]!")
			visible_message("<span class='danger'>[name] hits [target]</span>")
			target:attackby(src,get_pilot())
			playsound(src,pick(kkan_fun_sounds))
			break

	if(istype(target,/turf/simulated/wall))
		var/turf/simulated/wall/W = target
		visible_message("<span class='danger'>The [name] saws into the wall damaging it!</span>")
		W.health_update(60)
		playsound(src,pick(kkan_fun_sounds))
	
	if(istype(target,/obj/structure/girder))
		var/obj/structure/girder/G = target
		visible_message("<span class='danger'>The [name] saws the girder apart!</span>")
		G.health_update(100)
		playsound(src,pick(kkan_fun_sounds))

	if(istype(target,/obj/structure/nubarricade/metal))
		var/obj/structure/nubarricade/metal/cade = target
		cade.health -= 100
		cade.healthcheck()
		visible_message("<span class='danger'>The [name] saws halfway through the metal barricade!.</span>")
		playsound(src,pick(kkan_melee_sounds),100)
		if(prob(8))
			playsound(src,pick(kkan_fun_sounds))
	return 1

/obj/com_vehicle/killa_kan/adjust_health(damage, direction)
	..()
	if(prob(8))
		playsound(src,pick(kkan_fun_sounds))