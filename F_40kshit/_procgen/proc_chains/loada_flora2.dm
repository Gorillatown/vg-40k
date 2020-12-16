//Forest Biome
/datum/loada_gen/proc/loada_floragen2()
	var/datum/mapGenerator/forest/N = new()
	var/turf/start = locate(1,1,1)
	var/turf/end = locate(world.maxx,world.maxy,1)
	N.defineRegion(start, end)
	N.generate()
	
	if(ASS.dd_debug)
		log_startup_progress("FLORA LOAD SUCCESSFUL")

//TODO: We are going to sort a block of turfs on our own outside of the map generator. 
//Basically we need to iterate over it a few times for different types of flora,
//Taller Flora will be unable to be placed 2 turfs near something with opacity.
//So basically the list will be sorted and we will remove things that have opacity set to true

//A proc to put a list into it manually
/datum/mapGenerator/loada_flora2
	modules = list(/datum/mapGeneratorModule/swamptrees,
					/datum/mapGeneratorModule/swampgrass,
					/datum/mapGeneratorModule/swampbushes,
					/datum/mapGeneratorModule/swamprocks) 

/*
/datum/mapGenerator/loada_flora2/proc/turf_scan_time()
//	var/list/turf_list = list()
	map += block(locate(1, 1, 1), locate(world.maxx, world.maxy, 1))

	for(var/turf/T in map)
		if(T.opacity)
			if((T.x > 2)&&(T.y > 2)&&(T.x+2 < world.maxx)&&(T.y+2 < world.maxy))
				map -= block(locate(T.x-2,T.y-2,1), locate(T.x+2,T.y+2,1))

//				for(var/turf/T1 in block(locate(T.x-2,T.y-2,1), locate(T.x+2,T.y+2,1)))
//					map -= T1
*/
//	map = turf_list