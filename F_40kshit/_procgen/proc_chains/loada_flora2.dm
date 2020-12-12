//Forest Biome
/datum/loada_gen/proc/loada_floragen2()
	var/datum/mapGenerator/forest/N = new()
	var/turf/start = locate(1,1,1)
	var/turf/end = locate(world.maxx,world.maxy,1)
	N.defineRegion(start, end)
	N.generate()
	
	if(ASS.dd_debug)
		log_startup_progress("FLORA LOAD SUCCESSFUL")