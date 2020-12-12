
/datum/loada_gen/proc/CreatePools()
	var/list/badplotter = list()
	var/turf/T
	var/obj/helper/badplotter_swamp/bplot

	for(var/i in 1 to seeds)
		//make a new single segment
		while(1) //For now I'll hardcode this.
			T = locate(120,89,1)
//			T = locate(rand(1, world.maxx), rand(1, world.maxy), 1)
//			var/located = FALSE
//			for(var/obj/fluids/placeholder_one in T)
//				located = TRUE
//			if(!T.floragen) 
//				continue
//			else if(located)
//				continue
//			else
			new /obj/fluids/placeholder_one(T)
			for(var/botCount in 1 to rand(1, max_badplotter_per_seed))
				bplot = new(T)
				badplotter += bplot
			break
			


	//add on to existing segments
	for(var/j in 1 to expansions)
		while(1)
			bplot = pick(badplotter)
			if(bplot.roam()) 
				break

	for(bplot in badplotter) 
		qdel(bplot)

	if(ASS.dd_debug)
		log_startup_progress("------Loada Lakes(SMALLPOOLS)----")
		log_startup_progress("Seeds: [seeds] A Location: [T]")
		log_startup_progress("Expansions: [expansions]")

//Basically handles chunk generation
/obj/helper/badplotter_swamp //This is basically an object that moves around and does stuff on its own.
	name = "badplotter"
	desc = "he plottin somein real bad"
	density = 0
	var/list/cardinalDirs = list(1, 2, 4, 8)

/obj/helper/badplotter_swamp/proc/roam()
	var/newDir = pick(cardinalDirs)
	var/turf/T = get_step(src, newDir)
	var/located = FALSE
	for(var/obj/fluids/placeholder_one in T)
		located = TRUE
	if(T)
		loc = T
		if(!located)
			if(istype(T, /turf)) //Nowe get all of them
				new /obj/fluids/placeholder_one(T)
				return 1
