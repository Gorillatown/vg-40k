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
	turf_speed_multiplier = 1.4
	water_reflections = TRUE
	var/obj/effect/overlay/viscons/water_reflection/REFL

/obj/effect/overlay/viscons/water_reflection
	name = "Water Reflection"
	desc = "A reflection is both real, and not real."
	vis_flags = VIS_INHERIT_ID

/obj/effect/overlay/viscons/water_reflection/New()
	..()

/turf/unsimulated/outside/swampwater/smooth/New()
	..()
	REFL = new(src.loc)
	REFL.layer = layer+1
	vis_contents += REFL
	REFL.alpha = 20
	REFL.color = "#383733"
	var/matrix/M = matrix()
	REFL.pixel_y = 9
	REFL.pixel_x = 3 
	M.Turn(180)
	REFL.transform = M

/turf/unsimulated/outside/swampwater/smooth/initialize()
	..()

/turf/unsimulated/outside/swampwater/smooth/Entered(atom/A, atom/OL)
	..()

	if(istype(A,/mob/living))
		var/mob/living/L = A
		if(!L.water_effects)
			L.vis_contents += viscon_overlays[1]
			L.water_effects = TRUE

		var/turf/T = get_step(src,SOUTH)
		if(istype(T,/turf/unsimulated/outside/swampwater/smooth))
			var/turf/unsimulated/outside/swampwater/smooth/TT = T
			TT.REFL.vis_contents += L

/turf/unsimulated/outside/swampwater/smooth/Exited(atom/A, atom/newloc)
	..()
	if(istype(A,/mob/living))
		var/mob/living/L = A
		if(L.water_effects)
			if(!istype(newloc,/turf/unsimulated/outside/swampwater))
				for(var/obj/effect/overlay/viscons/water_overlay/augh in L.vis_contents)
					L.vis_contents -= augh
				L.water_effects = FALSE
		
		var/turf/T = get_step(src,SOUTH)
		if(istype(T,/turf/unsimulated/outside/swampwater/smooth))
			var/turf/unsimulated/outside/swampwater/smooth/TT = T
			TT.REFL.vis_contents -= L

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

