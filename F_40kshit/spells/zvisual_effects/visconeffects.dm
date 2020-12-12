/obj/effect/overlay/viscons/generic
	name = "Special Effect"
	desc = "For when you want it to be extra special"

	vis_flags = VIS_INHERIT_ICON|VIS_UNDERLAY|VIS_INHERIT_ICON_STATE

/obj/effect/overlay/viscons/generic/New(var/mob/M, var/effect_duration)
	set waitfor = 0
	..()
	sleep(effect_duration)
	M.vis_contents -= src
	qdel(src)

/obj/effect/overlay/viscons/afterimages
	name = "Afterimage"
	desc = "H-hes fast!"
	vis_flags = VIS_INHERIT_ICON|VIS_UNDERLAY|VIS_INHERIT_ICON_STATE

/obj/effect/overlay/viscons/afterimages/New(var/mob/M,var/effect_duration)
	set waitfor = 0
	..()
	switch(M.dir)
		if(NORTH)
			pixel_y = -24
		if(SOUTH)
			pixel_y = 24
		if(WEST)
			pixel_x = 24
		if(EAST)
			pixel_x = -24

	sleep(effect_duration)
	M.vis_contents -= src
	qdel(src)

/obj/effect/overlay/viscons/highperformance
	name = "Pulsing Aura"
	desc = "Looks pretty sinister."

	vis_flags = VIS_INHERIT_ICON|VIS_UNDERLAY|VIS_INHERIT_ICON_STATE

/obj/effect/overlay/viscons/highperformance/New(var/mob/M,var/effect_duration)
	set waitfor = 0
	..()
	filters += filter(type="drop_shadow", x=0, y=0, size=5, offset=2, color=rgb(249, 62, 255))
	var/f1 = filters[filters.len]
	var/start = filters.len
	var/X
	var/Y
	var/rsq
	var/i
	var/f2
	for(i=1, i<=7, ++i)
		// choose a wave with a random direction and a period between 10 and 30 pixels
		do
			X = 60*rand() - 30
			Y = 60*rand() - 30
			rsq = X*X + Y*Y
		while(rsq<100 || rsq>900)   // keep trying if we don't like the numbers
		// keep distortion (size) small, from 0.5 to 3 pixels
		// choose a random phase (offset)
		filters += filter(type="wave", x=X, y=Y, size=rand()*2.5+0.5, offset=rand())
	for(i=1, i<=7, ++i)
		// animate phase of each wave from its original phase to phase-1 and then reset;
		// this moves the wave forward in the X,Y direction
		f2 = filters[start+i]
		animate(f2, offset=f2:offset, time=0, loop=-1, flags=ANIMATION_PARALLEL)
		animate(offset=f2:offset-1, time=rand()*20+10)

	sleep(effect_duration)
	filters -= f1
	filters -= f2
	M.vis_contents -= src
	qdel(src)