#ifndef MAP_OVERRIDE
//**************************************************************
// Map Datum -- Desert Gulch
// Overhaul map, preset and holds a new mode.
//**************************************************************

/datum/map/active
	nameShort = "GreenGulch"
	nameLong = "Green Gulch"
	map_dir = "greenGulch"
	tDomeX = 128
	tDomeY = 58
	tDomeZ = 2
	zLevels = list(
		/datum/zLevel/forest{
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
//	new /datum/loada_gen(src, "prototype_swamp")

/****************************
**	Day and Night Lighting **
**	See: daynightcycle.dm  **
****************************/
/datum/subsystem/daynightcycle
	flags = SS_FIRE_IN_LOBBY
	daynight_z_lvl = STATION_Z

////////////////////////////////////////////////////////////////
#include "greenGulch.dmm"
#endif