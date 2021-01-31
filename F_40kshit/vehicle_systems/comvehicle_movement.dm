
/**************************
		relaymove
**************************/
/obj/com_vehicle/relaymove(mob/user, direction)
	if(user != get_pilot() || move_delayer.blocked())
		return 0
	
	if(!engine_online || mechanically_disabled)
		if(!movement_warning_oncd)
			to_chat(user, "<span class='notice'> You mash the pedals and move the controls in the unpowered [src].</span>")
			movement_warning_oncd = TRUE
			spawn(20)
				movement_warning_oncd = FALSE
			return 0
		else
			return 0
	
	set_glide_size(DELAY2GLIDESIZE(movement_delay))
	
	switch(direction)
		if(NORTH)
			if(speed < 1000 && speed < max_speed) //1000 is the peak of the acceleration scale
				speed += acceleration
		if(SOUTH)
			if(speed > 0 && !can_reverse) //If we can't reverse and our speed is greater than 0 we can brake
				speed -= acceleration
			else
				if(speed > -1000 && can_reverse && speed > max_reverse_speed) //If we can reverse and we are above -1000 keep goin
					speed -= acceleration
		if(EAST)
			if(inverse_handling)
				dir = turn(dir, 90) //Tank controls
			else
				dir = turn(dir,-90)
			
			if(turning_sounds)
				playsound(src,pick(turning_sounds),50)
		if(WEST)
			if(inverse_handling)
				dir = turn(dir, -90) //Technically its reversed too
			else
				dir = turn(dir, 90)
			
			if(turning_sounds)
				playsound(src,pick(turning_sounds),50)
			
	to_chat(user,"We are currently at [speed] speed")
	move_delayer.delayNext(round(movement_delay,world.tick_lag)) //Delay

/**************************
	engine_fire_loop
**************************/
/obj/com_vehicle/proc/engine_fire_loop()
	set waitfor = 0
	if(engine_looping)
		return
	while(engine_online)
		engine_looping = TRUE
		switch(speed)
			if(-1000 to -700)
				engine_fire_delay = 3
			if(-700 to -400)
				engine_fire_delay = 4
			if(-400 to -200)
				engine_fire_delay = 6
			if(-200 to -50)
				engine_fire_delay = 8
			if(-50 to 0)
				engine_fire_delay = 12
			if(0 to 50)
				engine_fire_delay = 12
			if(50 to 200)
				engine_fire_delay = 8
			if(200 to 300)
				engine_fire_delay = 4
			if(300 to 400)
				engine_fire_delay = 3
			if(400 to 500)
				engine_fire_delay = 2
			if(500 to 700)
				engine_fire_delay = 1
			if(700 to 800)
				engine_fire_delay = 1
			if(800 to 900)
				engine_fire_delay = 0.8
			if(900 to 1000)
				engine_fire_delay = 0.5
		
		switch(speed)
			if(-1000 to -50)
				Move(get_step(src,turn(dir, -180)), dir)
				if(movement_sounds)
					playsound(src,pick(movement_sounds),50)
			if(-50 to 50)
				if(idle_output)
					if(speed >= 0)
						Move(get_step(src,dir), dir)
						if(movement_sounds)
							playsound(src,pick(movement_sounds),50)
					else
						Move(get_step(src,turn(dir, -180)), dir)
						if(movement_sounds)
							playsound(src,pick(movement_sounds),50)
			if(50 to 1000)
				Move(get_step(src,dir), dir)
				if(movement_sounds)
					playsound(src,pick(movement_sounds),50)
	
		sleep(engine_fire_delay)
	
	engine_looping = FALSE

/**************************
		Process
**************************/
/obj/com_vehicle/proc/Process()
	switch(speed)
		if(-1000 to -50)
			speed += speed_loss
		
		if(-50 to 50)
			if(!engine_online)
				speed = FALSE

		if(50 to 1000)
			speed -= speed_loss


/**************************
		toggle_engine
One day this will be replaced by
Just a generic engine part but for now
Its a static object
**************************/
/obj/com_vehicle/proc/toggle_engine()
	if(!engine_cooldown) //if engine cooldown is false
		engine_cooldown = TRUE //Engine cooldown becomes true
		spawn(2 SECONDS)
			engine_cooldown = FALSE
	else
		return
	
	if(usr!=get_pilot())
		to_chat(src.get_pilot(), "<span class='average'> [usr] reaches forward and flips the engine switch in front of you.")
	
	if(mechanically_disabled)
		to_chat(get_pilot(), "<span class='notice'> The engine makes a little noise but ultimately does nothing.</span>")
		playsound(src, 'sound/items/flashlight_on.ogg', 50, 1)
		return
	
	engine_online = !engine_online
	
	if(mechanically_disabled)
		engine_online = FALSE
		return
	
	if(engine_online) //If Engine toggle is true, and we are not on cooldown
		speed = 25
		if(engine_startup_noise)
			playsound(src,pick(engine_startup_noise),50)
		engine_fire_loop()
	else
		speed = 0 //We set acceleration back to neutral if the engine is turned off.
	
	to_chat(usr, "<span class='notice'>Engine [engine_online?"starting up":"shutting down"].</span>")
	playsound(src, 'sound/items/flashlight_on.ogg', 50, 1) 