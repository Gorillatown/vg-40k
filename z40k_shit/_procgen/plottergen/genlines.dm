//Stolen from some dumb zip i had on my desktop for archipalegos
//I realized I could just reverse the islands and ocean, and work with it.
//Ironically pathed objects has better performance/quality than just doing large calculations.

#define MAP_AREA (world.maxx * world.maxy) //Map area

//customization is handled by calculating percentages of map area, so a given set of settings
//should scale to larger or smaller maps.

//Sets - Marsh
//#define PERCENT_LAND 0.20
//#define MAX_BADPLOTTER_PER_SEED 32
//#define SEED_FACTOR 0.002

#define PERCENT_LAND 0.20
#define MAX_BADPLOTTER_PER_SEED 32
#define SEED_FACTOR (1 / MAP_AREA)

//setting SEED_FACTOR lower will reduce the likelihood of many islands.
//to define a specific number of seeds, define it as "(n / MAP_AREA)" where n is the desired number of seeds.

#define MAP_SCALE 3

#define SEEDS round(MAP_AREA * SEED_FACTOR, 1)
#define LAND_TURFS (MAP_AREA * PERCENT_LAND)
//#define EXPANSIONS (LAND_TURFS) - SEEDS //This is the default setting - 1/13/2020
//500 kind of acceptable
#define EXPANSIONS 800

/datum/loada_gen/proc/CreateDeeps()
	var/list/badplotter = list()
	var/turf/T
	var/obj/helper/badplotter/bplot

	for(var/i in 1 to SEEDS)
		//make a new single segment
		while(1)
			T = locate(rand(1, world.maxx), rand(1, world.maxy), 1)
			if(istype(T, /turf/unsimulated/outside/water/deep)) 
				continue
			else
				new /turf/unsimulated/outside/water/deep(T)
				new /area/warhammer/water(T)
				for(var/botCount in 1 to rand(1, MAX_BADPLOTTER_PER_SEED))
					bplot = new(T)
					badplotter += bplot
				break

	//add on to existing segments
	for(var/j in 1 to EXPANSIONS)
		while(1)
			bplot = pick(badplotter)
			if(bplot.roam()) 
				break

	for(bplot in badplotter) 
		qdel(bplot)

	if(ASS.dd_debug)
		log_startup_progress("------Loada Lakes(Deeps&Shallows)----")
		log_startup_progress("Seeds: [SEEDS] A Location: [T]")
		log_startup_progress("Expansions: [EXPANSIONS]")

/*

     NW(9)  N(1) NE(5)
		\	|   /
W(8)---- *****  ---- E(4)
		/	|	\
   SE(6)  S(2)  SW(10)

*/
//We will start at a edge.
//The goal is to move the object north, have it generate turfs, repeat.
//If a node exists, we will instead step to it.

//1-12-2020
//TODO: River Deviation.


/datum/loada_gen/proc/CreateRiver()
	var/turf/TT
	var/turf/PP
	var/obj/helper/badliner/bline
	var/obj/helper/nodeliner/node

	for(var/i in 1 to ASS.rivercount)
		PP = locate(rand(1, world.maxx), world.maxy, 1) //PP needs to be at the top/end
		TT = locate(rand(1,world.maxx), 1, 1) //TT needs to be at the bottom/start
		node = new(PP)
		bline = new(TT)
		break
		
	for(var/i in 1 to world.maxy + world.maxx)
		bline.roam2node(node)
		if(bline.loc == PP)
			break
	
	if(ASS.dd_debug)
		log_startup_progress("---------LOADA RIVER----------")
		log_startup_progress("LINEPLOTSTART: X: [TT.x], Y: [TT.y]")

/datum/loada_gen/proc/CreateRiver2Lake(var/deviant) //Deviant is river deviation
	var/list/badplotter = list()
	var/turf/T
	var/turf/TT
	var/obj/helper/badplotter/bplot
	var/obj/helper/nodeliner/node
	var/obj/helper/badliner/bline

	for(var/i in 1 to SEEDS)
		//make a new single segment
		while(1)
			T = locate(rand(1, world.maxx), rand(1, world.maxy), 1)
			if(istype(T, /turf/unsimulated/outside/water/deep)) 
				continue
			else
				new /turf/unsimulated/outside/water/deep(T)
				new /area/warhammer/water(T) //Area Change
				node = new(T)
				for(var/botCount in 1 to rand(1, MAX_BADPLOTTER_PER_SEED))
					bplot = new(T)
					badplotter += bplot
				break

	for(var/i in 1 to SEEDS)
		TT = locate(rand(1,world.maxx), world.maxy, 1) //we flow from top
		bline = new(TT)
		break

	//add on to existing segments
	for(var/j in 1 to EXPANSIONS)
		while(1)
			bplot = pick(badplotter)
			if(bplot.roam()) 
				break

	for(var/i in 1 to 2000) //2000 loops should be good enough for us.
		bline.roam2node(node, ASS.deviant)
		if(bline.y == node.y && bline.x == node.x)
			if(ASS.dd_debug)
				log_startup_progress("NODE AND LINE COMPLETED AND DELETED AT X: [bline.x], Y: [bline.y]")
			qdel(bline)
			qdel(node)
			break //We break if we get there before that

	for(bplot in badplotter) 
		qdel(bplot)

	if(ASS.dd_debug)
		log_startup_progress("---LOADA RIVER2LAKE(Deeps&Shallows&River)---")
		log_startup_progress("LAKE NODE: X: [T.x], Y: [T.y] LINEPLOTSTART: X: [TT.x], Y: [TT.y]")
		log_startup_progress("Seeds: [SEEDS]")