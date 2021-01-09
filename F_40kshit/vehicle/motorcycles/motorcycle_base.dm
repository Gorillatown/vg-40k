//TODO: Merge COMPLEX vehicle and this into one object group when I am not feelin lazy
//For now you get a standard vehicle.
/obj/effect/overlay/assault_bike_pdf
	name = "Assault Bike"
	icon = 'F_40kshit/icons/complex_vehicle/motorcycles_64x64.dmi'
	icon_state = "pdf_color_1_over"
	plane = ABOVE_HUMAN_PLANE
	layer = VEHICLE_LAYER

	vis_flags = VIS_INHERIT_ID|VIS_INHERIT_DIR

/obj/effect/overlay/assault_bike_ork
	name = "Assault Bike"
	icon = 'F_40kshit/icons/complex_vehicle/motorcycles_64x64.dmi'
	icon_state = "ork_color_1_over"
	plane = ABOVE_HUMAN_PLANE
	layer = VEHICLE_LAYER

	vis_flags = VIS_INHERIT_ID|VIS_INHERIT_DIR
	
/*
	ORK ASSAULT BIKE
*/
/obj/structure/bed/chair/vehicle/assault_bike/orks
	name = "Ork Assault Bike"
	icon_state = "ork_color_1_under"

/obj/structure/bed/chair/vehicle/assault_bike/orks/handle_overlay()
	over_mob_segment = new /obj/effect/overlay/assault_bike_ork
	vis_contents += over_mob_segment

/*
	STANDARD ASSAULT BIKE
*/
/obj/structure/bed/chair/vehicle/assault_bike
	name = "Assault Bike"
	desc = "Unlike the motorcycle you know, this one is made for assaults in the 41st millenium"
	icon = 'F_40kshit/icons/complex_vehicle/motorcycles_64x64.dmi'
	icon_state = "pdf_color_1_under" //Its a two part icon
	plane = ABOVE_OBJ_PLANE
	layer =  FACEHUGGER_LAYER
	var/obj/effect/overlay/over_mob_segment
	var/acceleration = 0
	var/turning_inertia = 0
	var/engine_toggle = FALSE
	var/engine_cooldown = FALSE
	var/enginemaster_sleep_time = 1
	var/movement_warning_oncd = FALSE
	var/sound_loop = 0 //SOUJND LOOSPS
	movement_delay = 3 //Speed of turning
	health = 1000
	max_health = 1000

/obj/structure/bed/chair/vehicle/assault_bike/New()
	..()
	new /datum/action/toggle_engine(src)
	processing_objects += src
	handle_overlay()
	switch(dir)
		if(NORTH)
			pixel_y = 0
			pixel_x = -16
			bound_height = 64
			bound_width = 32
		if(SOUTH)
			pixel_y = 0
			pixel_x = -16
			bound_height = 64
			bound_width = 32
		if(EAST)
			pixel_y = -16
			pixel_x = 0
			bound_height = 32
			bound_width = 64
		if(WEST)
			pixel_y = -16
			pixel_x = 0
			bound_height = 32
			bound_width = 64

/obj/structure/bed/chair/vehicle/assault_bike/proc/handle_overlay()
	over_mob_segment = new /obj/effect/overlay/assault_bike_pdf
	vis_contents += over_mob_segment

/obj/structure/bed/chair/vehicle/assault_bike/make_offsets()
	offsets = list(
		"[SOUTH]" = list("x" = 0, "y" = 14 * PIXEL_MULTIPLIER),
		"[WEST]" = list("x" = 24 * PIXEL_MULTIPLIER, "y" = 0 * PIXEL_MULTIPLIER),
		"[NORTH]" = list("x" = 0, "y" = 16 * PIXEL_MULTIPLIER),
		"[EAST]" = list("x" = 8 * PIXEL_MULTIPLIER, "y" = 0 * PIXEL_MULTIPLIER)
		)

/obj/structure/bed/chair/vehicle/assault_bike/handle_layer()
	return

/obj/structure/bed/chair/vehicle/assault_bike/Destroy()
	..()
	
	for(var/datum/action/action in vehicle_actions)
		action.Remove(action.owner)
		qdel(action)
		vehicle_actions -= action
	
	vis_contents.Cut()
	qdel(over_mob_segment)
	over_mob_segment = null

/obj/structure/bed/chair/vehicle/assault_bike/relaymove(var/mob/living/user, direction)
	if(user.incapacitated())
		unlock_atom(user)
		return
	if(!check_key(user))
		if(can_warn())
			to_chat(user, "<span class='notice'>You'll need the key in one of your hands or inside the ignition slot to drive \the [src].</span>")
		return 0
	if(empstun > 0)
		if(user && can_warn(user))
			to_chat(user, "<span class='warning'>\The [src] is unresponsive.</span>")
		return 0
	if(move_delayer.blocked())
		return 0
	
	set_glide_size(DELAY2GLIDESIZE(movement_delay))

	switch(direction)
		if(NORTH)
			if(engine_toggle)
				if(acceleration < 200) //acceleration is not free
					acceleration += 10
			else
				if(!movement_warning_oncd)
					to_chat(user, "<span class='notice'> You turn the bar on the [src.name] only to achieve nothing as the engine is off.</span>")
					movement_warning_oncd = TRUE
					spawn(20)
						movement_warning_oncd = FALSE
					return 0
				else
					return 0
		if(SOUTH)
			if(acceleration < 0) //braking is free
				acceleration -= 5
			else
				acceleration = FALSE
				if(engine_toggle)
					engine_toggle = FALSE
					to_chat(user, "Your engine stalls and dies")
				else
					to_chat(user, "You brake achieving more movement than before.")
		if(EAST)
			dir = turn(src.dir, 90) //ahaha ahah aha
			turning_inertia += 10
			user.dir = dir

		if(WEST)
			dir = turn(src.dir, -90) //Technically its reversed too
			turning_inertia += 10
			user.dir = dir
	
	switch(dir)
		if(NORTH)
			pixel_y = 0
			pixel_x = -16
			bound_height = 64
			bound_width = 32
		if(SOUTH)
			pixel_y = 0
			pixel_x = -16
			bound_height = 64
			bound_width = 32
		if(EAST)
			pixel_y = -16
			pixel_x = 0
			bound_height = 32
			bound_width = 64
		if(WEST)
			pixel_y = -16
			pixel_x = 0
			bound_height = 32
			bound_width = 64
	
	update_mob()
	
	move_delayer.delayNext(round(movement_delay,world.tick_lag)) //Delay
	if(!movement_warning_oncd)
		to_chat(user,"We are currently accelerating at [acceleration] of 200")
		movement_warning_oncd = TRUE
		spawn(20)
			movement_warning_oncd = FALSE
		return 0
	else
		return 0
	
/obj/structure/bed/chair/vehicle/assault_bike/proc/trigger_engine()
	while(acceleration)
		switch(acceleration)
			if(-4 to 20)
				enginemaster_sleep_time = 8
			if(20 to 30)
				enginemaster_sleep_time = 6
			if(30 to 60)
				enginemaster_sleep_time = 4
			if(60 to 90)
				enginemaster_sleep_time = 3
			if(90 to 120)
				enginemaster_sleep_time = 2
			if(120 to 160)
				enginemaster_sleep_time = 1
			if(160 to 200)
				enginemaster_sleep_time = 0.8
		
		Move(get_step(src,src.dir), src.dir)
		
		switch(turning_inertia)
			if(10 to 30)
				turning_inertia -= 10
			if(30 to 100)
				throw_they_ass_off() //We turned too much, now we(them) pay the price
				turning_inertia = 0
				acceleration = 0
				engine_toggle = FALSE
				break

		sleep(enginemaster_sleep_time)

/obj/structure/bed/chair/vehicle/assault_bike/process()
	
	if(engine_toggle)
		sound_loop++
		if(sound_loop >= 2)
			sound_loop = 0
			switch(acceleration)
				if(0 to 20)
					playsound(src,'F_40kshit/sounds/misc_effects/bike_idle.ogg',50)
				else
					playsound(src,'F_40kshit/sounds/misc_effects/bike_acceleration.ogg',50)
	
	switch(acceleration)
		if(-5 to 10)
			if(!engine_toggle)
				acceleration = FALSE
			else
				acceleration = 6
		if(10 to 300)
			acceleration -= 2
	
/obj/structure/bed/chair/vehicle/assault_bike/proc/throw_they_ass_off()
	var/mob/living/L = occupant
	if(L)
		switch(acceleration)
			if(60 to 120)
				unlock_atom(L)
				L.throw_at(get_edge_target_turf(loc, loc.dir), 5, 5)
				L.Stun(8)
				L.Knockdown(12)
				L.adjustBruteLoss(rand(10,20))
			if(120 to 220)
				unlock_atom(L)
				L.throw_at(get_edge_target_turf(loc, loc.dir), 20, 10)
				L.Stun(8)
				L.Knockdown(12)
				L.adjustBruteLoss(rand(40,90))

/obj/structure/bed/chair/vehicle/assault_bike/die() //called when health <= 0
	density = 0
	visible_message("<span class='warning'>\The [nick] explodes!</span>")
	explosion(src.loc,2,3,3,7,TRUE)
	throw_they_ass_off()

	qdel(src)

/obj/structure/bed/chair/vehicle/assault_bike/to_bump(var/atom/movable/obstacle)
	if(obstacle == src || (is_locking(/datum/locking_category/buckle/chair/vehicle, subtypes=TRUE) && obstacle == get_locked(/datum/locking_category/buckle/chair/vehicle, subtypes=TRUE)[1]))
		return

	if(iswall(obstacle))
		switch(acceleration)
			if(0 to 30)
				acceleration = 0
			if(30 to 120)
				acceleration = 0
				throw_they_ass_off()
			if(120 to 220)
				die()

	if(istype(obstacle, /obj/structure))
		if(obstacle.anchored)
			switch(acceleration)
				if(0 to 30)
					acceleration = 0
				if(30 to 120)
					acceleration = 0
					throw_they_ass_off()
				if(120 to 220)
					die()
	
	if(isliving(obstacle))
		var/mob/living/L = obstacle
		switch(acceleration)
			if(0 to 30)
				acceleration = 0
				L.Knockdown(12)
				L.adjustBruteLoss(rand(5,10))
			if(30 to 120)
				L.throw_at(get_edge_target_turf(loc, loc.dir), 7, 5)
				L.Knockdown(12)
				L.adjustBruteLoss(rand(15,25))
			if(120 to 220)
				L.throw_at(get_edge_target_turf(loc, loc.dir), 7, 5)
				L.Stun(8)
				L.Knockdown(12)
				L.adjustBruteLoss(rand(40,90))
	..()