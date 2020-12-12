

/obj/complex_vehicle/Move(NewLoc, Dir = 0, step_x = 0, step_y = 0, glide_size_override = 0)
	var/oldloc = loc
	. = ..()
	if(Dir && (oldloc != NewLoc))
		loc.Entered(src, oldloc)

/obj/complex_vehicle/relaymove(mob/user, direction) //Relaymove basically sends the user and the direction when we hit the buttons
	if(user != get_pilot()) //If user is not pilot return false
		return 0 //Stop hogging the wheel!
	if(move_delayer.blocked()) //If we are blocked from moving by move_delayer, return false. Delay
		return 0
	if(!engine_toggle || vehicle_broken_husk)
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
			//Move(get_step(src,src.dir), src.dir) //How we move
			if(acceleration <= 1000) //var to max
				acceleration += 25

		if(SOUTH)
			//Move(get_step(src,turn(src.dir, -180)), src.dir)
			if(acceleration >= 0) //var to min
				acceleration -= 25
	
		if(EAST)
			dir = turn(src.dir, 90) //Tank controls

		if(WEST)
			dir = turn(src.dir, -90) //Technically its reversed too

	//This tries to keep us relatively centered
	switch(dir)
		if(NORTH)
			GT.pixel_x = -14
			pixel_x = 0
		if(SOUTH)
			GT.pixel_x = -14
			pixel_x = 0
		if(EAST)
			GT.pixel_x = 0
			pixel_x = 0
		if(WEST)
			GT.pixel_x = -32
			pixel_x = -32
	
	to_chat(user,"We are currently at [acceleration] acceleration")
	to_chat(user,"And we are currently at [movement_delay] movement_delay")

	accelerationscale()

	move_delayer.delayNext(round(movement_delay,world.tick_lag)) //Delay

//Basically the plan is that while they have the switch on we will run this loop.
//This loop will basically check to make sure theres someone in the tank.
//We will time based on world time between each action.

/obj/complex_vehicle/proc/trigger_engine()
	while(engine_toggle)
		enginemove()
		sleep(enginemaster_sleep_time)

/obj/complex_vehicle/proc/enginemove()
	if(vehicle_broken_husk)
		return
	if(acceleration >= 400) //If we are moving forward
		Move(get_step(src,src.dir), src.dir)
		acceleration -= 5
	if(acceleration <= 300) //If we are in reverse
		Move(get_step(src,turn(src.dir, -180)), src.dir)
		acceleration += 5
	
	GT.acceleration = acceleration

/obj/complex_vehicle/proc/accelerationscale()
	switch(acceleration)
		if(0 to 100) //Max reverse
			enginemaster_sleep_time = 3 //Delay between each movement loop
		if(100 to 200) //Mid Reverse
			enginemaster_sleep_time = 6
			movement_delay = 3
		if(200 to 300) //Low Reverse
			movement_delay = 4
			enginemaster_sleep_time = 10
		if(300 to 400) //Neutral
			return
		if(400 to 500) //Min Forward
			movement_delay = 4
			enginemaster_sleep_time = 12
		if(500 to 600) //Med Forward
			movement_delay = 3
			enginemaster_sleep_time = 6
		if(600 to 700) //Med-High Forward
			enginemaster_sleep_time = 4
		if(700 to 900) //Max Forward
			enginemaster_sleep_time = 1
			movement_delay = 2
		if(900 to 1000)
			enginemaster_sleep_time = 1
			movement_delay = 2
