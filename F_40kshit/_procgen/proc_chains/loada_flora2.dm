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