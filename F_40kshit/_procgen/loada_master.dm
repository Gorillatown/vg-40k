/*
	Basically below is the procedural generation datum.
														*/

/* 
You may ask, why would we handle it this way?
Well the answer is that we need the coordinates of certain things to build off each other.
When I do it via just using global procs, it works yes, but what if I need,
Information from one of the procedures? I'd have to pass it somewhere, so we might as well hold
All the information I need in a datum. As for why its in this folder now? Mostly so Its relicensed,
And so I can find it easily.

As for the plan here, we will do things in stages like before except now we can use information!.
Heres a rough outline relevant as of 4/27/2020. The stages are basically markers of the steps
Of the old way.
Appends are what we can do using information saved in the datum/other thoughts.

Stage 1 - We generate random templates
Append - We can run through and place objective objects.
Stage 2 - We generate the Spawns
Append - We can now generate a town
Append - We can now place objective items/add them to the global list.
Stage 3 - We generate rivers/lakes
Append - We can now place roads.
Stage 4 - We do cleanup and detailing
Stage 5 - We load all the flora in.
Append - We load in some Fauna
*/

/datum/loada_gen
	var/datum/map/active/ASS //The map datum we are tied to.
	//Basically these coords are the bottom left coordinates of each template after calculations.
	var/s1_z1_coord = 1 //Z level will always be 1
	var/s1_x1_coord = 0 //spawn 1 x1 coord
	var/s1_y1_coord = 0 //spawn 1 y1 coord

	var/s2_z2_coord = 1 //Placement of the opposing template
	var/s2_x2_coord = 0 //spawn 2 x1 coord
	var/s2_y2_coord = 0 //spawn 2 y2 coord


/*
	Plotter Gen Vars
	- I had to take them off defines because we now have more than 1 set.
*/
	var/map_area
	var/percent_land = 0.20
	var/max_badplotter_per_seed = 32
//setting SEED_FACTOR lower will reduce the likelihood of many islands.
//to define a specific number of seeds, define it as "(n / MAP_AREA)" where n is the desired number of seeds.
	var/seed_factor
	var/map_scale = 3
	var/seeds
	var/land_turfs
	var/expansions = 500
	//#define EXPANSIONS (LAND_TURFS) - SEEDS //This is the default setting - 1/13/2020


/datum/loada_gen/New(var/datum/map/active/map_datum,var/gen_cycle) //We pass the map datum, and what cycle to pick.
	ASS = map_datum
	map_area = (world.maxx * world.maxy)
	land_turfs = (map_area * percent_land)

	switch(gen_cycle)
		if("prototype_desert")
			percent_land = 0.20
			seed_factor = (1/map_area)
			seeds = round(map_area * seed_factor, 1)
			loada_prototype_desert()
			log_startup_progress("Prototype Desert Generation Selected")
		if("flora_generation")
			var/florawatch = start_watch()
			loada_floragen()
			log_startup_progress("Finished with floragen in [stop_watch(florawatch)]s.")
		if("prototype_swamp")
//			percent_land = 0.20
//			seed_factor = (1/map_area)
//			percent_land = 0.20
//			seed_factor = 0.002
//			seeds = round(map_area * seed_factor, 1)
			loada_prototype_swamp()
			log_startup_progress("Prototype Swamp Generation Selected")
		if("flora_generation2")
			var/florawatch = start_watch()
			loada_floragen2()
			log_startup_progress("Finished with floragen in [stop_watch(florawatch)]s.")

/datum/loada_gen/proc/loada_prototype_swamp()
//	var/waterwatch = start_watch()
//	loada_swamp1()
//	log_startup_progress("Finished with placing pools of fluid in [stop_watch(waterwatch)]s")

	var/florawatch = start_watch()
	loada_floragen2()
	log_startup_progress("Finished with floragen2 in [stop_watch(florawatch)]s.")

/datum/loada_gen/proc/loada_prototype_desert()

	var/templatewatch = start_watch()
	loada_generate_template()
	log_startup_progress("Finished with generating templates in [stop_watch(templatewatch)]s.")

	var/spawnwatch = start_watch()
	loada_spawns()
	log_startup_progress("Finished with generating spawns in [stop_watch(spawnwatch)]s.")

	var/villagewatch = start_watch()
	loada_village()
	log_startup_progress("Finished with generating factionless town in [stop_watch(villagewatch)]s.")

	var/roadwatch = start_watch()
	loada_roadsystem()
	log_startup_progress("Finished with generating road paths in [stop_watch(roadwatch)]s.")
	
	var/river2lakewatch = start_watch()
	loada_river2lake1()
	log_startup_progress("Finished with rivers and lakes in [stop_watch(river2lakewatch)]s.")

	var/florawatch = start_watch()
	loada_floragen()
	log_startup_progress("Finished with floragen in [stop_watch(florawatch)]s.")

	var/cleanupwatch = start_watch()
	loada_cleanup_and_detailing()
	log_startup_progress("Finished with cleanup/detailing. [stop_watch(cleanupwatch)]s.")

	var/jectiewatch = start_watch()
	loada_objectivegen()
	log_startup_progress("Finished placing objectives in [stop_watch(jectiewatch)]s")

	var/faunawatch = start_watch()
	loada_fauna()
	log_startup_progress("Finished Placing Fauna in [stop_watch(faunawatch)]s")

