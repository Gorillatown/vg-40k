#ifndef MAP_OVERRIDE
//**************************************************************
// Map Datum -- maptestdesert
// testbed of the first proc gen ork vs ig map
//**************************************************************

/datum/map/active
	nameShort = "maptestdesert"
	nameLong = "Sandtest IG vs ORK"
	map_dir = "maptestdesert"
	tDomeX = 128
	tDomeY = 58
	tDomeZ = 2
	zLevels = list(
		/datum/zLevel/desert{
			name = "station"
		},
		)
	enabled_jobs = list()

	load_map_elements = list()

	center_x = 125
	center_y = 125
	only_spawn_map_exclusive_vaults = FALSE
	can_enlarge = FALSE

	map_vault_area = /area/warhammer/desert

//loada_spawn variables
	spawn_overwrite = TRUE //EX: This being true means template 2 can overwrite template 1
	spawn_template_1 = /datum/map_element/vault/bases/ig_base_one
	spawn_template_2 = /datum/map_element/vault/bases/ork_base_one
	spawn_alignment = "horizontals"
	
	//Debug textvar on all the mapgen 
	//so you can just read it out on dream daemon instead of actually joining game.
	dd_debug = FALSE

/datum/map/active/map_specific_init()
	new /datum/loada_gen(src, "prototype_desert")

////////////////////////////////////////////////////////////////
#include "maptestdesert.dmm"
#endif
 