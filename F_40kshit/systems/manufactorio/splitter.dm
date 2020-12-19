/obj/machinery/splitter
	name = "Splitter"
	icon = 'F_40kshit/icons/obj/industrialmadness64x64.dmi'
	icon_state = "splitter"
	machine_flags = WRENCHMOVE|FIXED2WORK
	density = TRUE
	anchored = TRUE
	var/turf/in_T
	var/turf/out_T
	var/turf/split_T
	var/splitter = 1
	pixel_x = 0
	pixel_y = 0

/obj/machinery/splitter/New()
	..()

/obj/machinery/splitter/initialize()
	..()
	handle_rotation()

/obj/machinery/splitter/process()
	for(var/atom/movable/A in in_T)
		if(A.anchored)
			continue
		switch(splitter)
			if(1)
				A.loc = out_T
				splitter = 2
			if(2)
				A.loc = split_T
				splitter = 1

/obj/machinery/splitter/proc/handle_rotation()
	out_T = get_step(src,dir)
	switch(dir)
		if(SOUTH)
			in_T = get_step(src, turn(dir,180))
			split_T = get_step(out_T,turn(dir,90))
			bound_height = 32
			bound_width = 64
		if(NORTH)
			in_T = get_step(src, turn(dir,180))
			split_T = get_step(out_T,turn(dir, -90))
			bound_height = 32
			bound_width = 64
		if(EAST)
			in_T = get_step(src, turn(dir,135))
			split_T = get_step(out_T,turn(dir,90))
			//split_T = get_step(out_T,turn(dir,-180))
			bound_height = 64
			bound_width = 32
		if(WEST)
			in_T = get_step(src,turn(dir,180))
			split_T = get_step(out_T, turn(dir, -90))
			bound_height = 64
			bound_width = 32

/obj/machinery/splitter/attackby(var/obj/item/W, mob/user)
	if(!W.is_wrench(user))
		return ..()
	if(src.machine_flags & WRENCHMOVE)
		handle_rotation()
		return ..()