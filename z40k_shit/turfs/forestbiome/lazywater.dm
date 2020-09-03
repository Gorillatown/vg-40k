//I do not feel like... working on this much more tbqh
/turf/unsimulated/outside/swampwater
	name = "swampwater"
	desc = "It looks like something you should probably avoid walking through"
	icon_state = "water"
	floragen = FALSE 
	footprints = FALSE

/turf/unsimulated/outside/swampwater/center
	icon_state = "water"
/turf/unsimulated/outside/swampwater/north
	icon_state = "water2"
/turf/unsimulated/outside/swampwater/south
	icon_state = "water6"
/turf/unsimulated/outside/swampwater/east
	icon_state = "water4"
/turf/unsimulated/outside/swampwater/west
	icon_state = "water8"
/turf/unsimulated/outside/swampwater/northeast
	icon_state = "water3"
/turf/unsimulated/outside/swampwater/southeast
	icon_state = "water5"
/turf/unsimulated/outside/swampwater/northwest
	icon_state = "water1"
/turf/unsimulated/outside/swampwater/southwest
	icon_state = "water7"


/*

     NW(9)  N(1) NE(5)
		\	|   /
W(8)---- *****  ---- E(4)
		/	|	\
   SE(6)  S(2)  SW(10)

*/
/turf/unsimulated/outside/swampwater/smooth

	icon = 'z40k_shit/icons/turfs/42x42water.dmi'
	icon_state = "water"
	plane = BELOW_TURF_PLANE
	pixel_x = -3
	pixel_y = -3
//	icon_state = "water15-30"
	
//Having issues iwth smoothing, so ill try my own proc
//Issue with
/turf/unsimulated/outside/swampwater/smooth/proc/ghetto_smoothing()
	var/turf/T
	var/cumsum = 0 //We add the value of the directions. cardinals
	var/diksum = 0 //Diagonals
	for(var/cdir in cardinal)
		T = get_step(src,cdir)
		if(istype(T,/turf/unsimulated/outside/swampwater/smooth))
			cumsum += cdir
		
	for(var/ddir in diagonal)
		T = get_step(src,ddir)
		if(istype(T,/turf/unsimulated/outside/swampwater/smooth))
			diksum += ddir
		
	icon_state = "water[cumsum]-[diksum]"

/turf/unsimulated/outside/swampwater/smooth/New()
	..()

/turf/unsimulated/outside/swampwater/smooth/initialize()
	..()
//	ghetto_smoothing()


