#ifndef MAP_OVERRIDE
//**************************************************************
// Map Datum -- Desert Gulch
// Overhaul map, preset and holds a new mode.
//**************************************************************

/datum/map/active
	nameShort = "DesertGulch"
	nameLong = "Desert Gulch"
	map_dir = "desertGulch"
	tDomeX = 128
	tDomeY = 58
	tDomeZ = 2
	zLevels = list(
		/datum/zLevel/desert{
			name = "station"
		},
		/datum/zLevel/centcomm,
		)
	enabled_jobs = list()

	load_map_elements = list()

	center_x = 125
	center_y = 125
	only_spawn_map_exclusive_vaults = FALSE
	can_enlarge = FALSE

	map_vault_area = /area/warhammer/desert

/datum/map/active/map_specific_init()
	new /datum/loada_gen(src, "flora_generation")

////////////////////////////////////////////////////////////////
#include "desertgulch.dmm"
#endif