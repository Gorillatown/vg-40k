/*
	MAP GENERATOR INITS
						*/

//This file is where all the generation is stored.
//To activate it just use the zLevel path on your map loading file.
/* Example:
/datum/map/active
	nameShort = "snowfort"
	nameLong = "Snowfort Station"
	map_dir = "snowstation"
	zLevels = list(
		/datum/zLevel/snow{
			name = "station"
			movementChance = ZLEVEL_BASE_CHANCE * ZLEVEL_STATION_MODIFIER
		},
		/datum/zLevel/centcomm,
		/datum/zLevel/snow{
			name = "CrashedSat" ;
			},
		/datum/zLevel/snow{
			name = "derelict" ;
			},
		/datum/zLevel/snow,
		/datum/zLevel/snow{
			name = "spacePirateShip" ;
			},
		)
*/
/datum/zLevel/desert

	name = "desert"
	teleJammed = 1
	base_turf = /turf/unsimulated/outside/sand
	transitionLoops = TRUE
	movementJammed = TRUE

//for snowmap
/datum/zLevel/snowsurface
	name = "snowy surface"
	base_turf = /turf/unsimulated/floor/snow
	base_area = /area/surface/snow
	movementJammed = TRUE //Prevents you from accessing the z level by drifting.
	transitionLoops = TRUE // Basically going off the Z border just wraps you around.

/datum/zLevel/snow
	name = "snow"
	base_turf = /turf/unsimulated/floor/snow

/datum/zLevel/snow/post_mapload()
	var/lake_density = rand(2,8)
	for(var/i = 0 to lake_density)
		var/turf/T = locate(rand(1, world.maxx),rand(1, world.maxy), z)
		if(!istype(T, base_turf))
			continue
		var/generator = pick(typesof(/obj/structure/radial_gen/cellular_automata/ice))
		new generator(T)

	var/tree_density = rand(25,45)
	for(var/i = 0 to tree_density)
		var/turf/T = locate(rand(1,world.maxx),rand(1, world.maxy), z)
		if(!istype(T, base_turf))
			continue
		var/generator = pick(typesof(/obj/structure/radial_gen/movable/snow_nature/snow_forest) + typesof(/obj/structure/radial_gen/movable/snow_nature/snow_grass))
		new generator(T)