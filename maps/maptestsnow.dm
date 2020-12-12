#ifndef MAP_OVERRIDE
//**************************************************************
// Map Datum -- maptestsnow
// testbed of the first proc gen ork vs ig map
//**************************************************************

/datum/map/active
	nameShort = "maptestsnow"
	nameLong = "Snowtest IG vs ORK"
	map_dir = "maptestsnow"
	tDomeX = 128
	tDomeY = 58
	tDomeZ = 2
	zLevels = list(
		/datum/zLevel/snow{
			name = "station"
		},
		)
	enabled_jobs = list()

	load_map_elements = list()
	daynight_cycle = STATION_Z // TURN IT ON

	center_x = 50
	center_y = 50
	only_spawn_map_exclusive_vaults = FALSE
	can_enlarge = FALSE
	map_vault_area = /area/warhammer/snow

/****************************
**	Day and Night Lighting **
**	See: daynightcycle.dm  **
****************************/
/datum/subsystem/daynightcycle
	flags = SS_FIRE_IN_LOBBY
	daynight_z_lvl = STATION_Z


////////////////////////////////////////////////////////////////
#include "maptestsnow.dmm"
#endif
