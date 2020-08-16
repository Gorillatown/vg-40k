
/datum/loada_gen/proc/loada_cleanup_and_detailing()
	var/base_turf = get_base_turf(1)
	for(var/turf/T in world)
		if(istype(T, /turf/space/)) //If T is a space turf
			if(locate(/turf/unsimulated/outside/water/deep) in oview(T, 1))
				if(prob(50)) //We have a 50% probability to be either shallow water or
					T.ChangeTurf(/turf/unsimulated/outside/water/shallow)
					new /area/warhammer/water(T)
				else
					T.ChangeTurf(base_turf)
					new /area/warhammer/desert
			else
				T.ChangeTurf(base_turf)
				new /area/warhammer/desert

		if(istype(T, /turf/unsimulated/outside/sand)) //If we are sand
			if(locate(/turf/unsimulated/outside/water/shallow) in oview(T, 1)) //And we see Shallow water around us
				T.ChangeTurf(/turf/unsimulated/outside/smoothingcoastline) //Then we form smoothing coastline turfs in place.
	
		if(istype(T, /turf/unsimulated/outside/sand)) //If we are sand
			if(locate(/turf/unsimulated/outside/footpath) in oview(T, 1)) //And we see footpath centers around us
				T.ChangeTurf(/turf/unsimulated/outside/smoothingfootpath) //Then we form smoothing turflines around us.
	
	//CleanupSpace()
	//CreateCoastline()
	//CreatePathline()

	if(ASS.dd_debug)
		log_startup_progress("CLEANUP AND DETAILING LOADA INITIATED")
