/turf/unsimulated/outside/metalplating
	name = "Metal Plate Floor"
	desc = "Its metal, and on the floor. What more could you ask for?"
	icon = 'z40k_shit/icons/turfs/metalfloors.dmi'
	thermal_conductivity = 0.025
	heat_capacity = 325000
	soot_type = null
	melt_temperature = 0 // Doesn't melt.
	floragen = FALSE
	footprints = FALSE

/turf/unsimulated/outside/metalplating/attackby(obj/item/C, mob/user)
	return

/turf/unsimulated/outside/metalplating/ex_act(severity)
	return

/turf/unsimulated/outside/metalplating/attack_construct(mob/user)
	return 0

/*
	Guess we gonna split these up into categories really.
*/
//Metal Squares------------------------------
/turf/unsimulated/outside/metalplating/metalsquare
	name = "Segmented Metal Plate Floor"
	desc = "Seems theres a square in the center of some bars, who knows why."
	icon_state = "1metalsquare"

/turf/unsimulated/outside/metalplating/metalsquare/two
	icon_state = "2metalsquare"
/turf/unsimulated/outside/metalplating/metalsquare/three
	icon_state = "3metalsquare"
/turf/unsimulated/outside/metalplating/metalsquare/four
	icon_state = "4metalsquare"
/turf/unsimulated/outside/metalplating/metalsquare/five
	icon_state = "5metalsquare"

//Metal Riveted Floors-------------------------------
/turf/unsimulated/outside/metalplating/metalrivets
	name = "Riveted Metal Plate Floor"
	desc = "Plates riveted down, wow!"
	icon_state = "1metalrivets"
/turf/unsimulated/outside/metalplating/metalrivets/two
	icon_state = "2metalrivets"
/turf/unsimulated/outside/metalplating/metalrivets/three
	icon_state = "3metalrivets"
/turf/unsimulated/outside/metalplating/metalrivets/four
	icon_state = "4metalrivets"
/turf/unsimulated/outside/metalplating/metalrivets/five
	icon_state = "5metalrivets"
//Metal Fullplates-----------------------------------
/turf/unsimulated/outside/metalplating/metalplate
	name = "Metal Plate Floor"
	desc = "While not as exotic as the many other forms of metal plate floor, this one gets the job done."
	icon_state = "1metalplate"
/turf/unsimulated/outside/metalplating/metalplate/two
	icon_state = "2metalplate"
/turf/unsimulated/outside/metalplating/metalplate/three
	icon_state = "3metalplate"
/turf/unsimulated/outside/metalplating/metalplate/four
	icon_state = "4metalplate"
/turf/unsimulated/outside/metalplating/metalplate/fouralt
	icon_state = "4metalplatealt"
/turf/unsimulated/outside/metalplating/metalplate/five
	icon_state = "5metalplate"
/turf/unsimulated/outside/metalplating/metalplate/fivealt
	icon_state = "5metalplatealt"
//Metal Grate Floors--------------------------------
/turf/unsimulated/outside/metalplating/metalgrate
	name = "Metal Plate Floor with a Grate"
	desc = "Its the same metal plate floor, this time with a grate on it."
	icon_state = "1metalgrate"

/turf/unsimulated/outside/metalplating/metalgrate/two
	icon_state = "2metalgrate"
/turf/unsimulated/outside/metalplating/metalgrate/three
	icon_state = "3metalgrate"
/turf/unsimulated/outside/metalplating/metalgrate/four
	icon_state = "4metalgrate"
/turf/unsimulated/outside/metalplating/metalgrate/five
	icon_state = "5metalgrate"

//Metal Popout Pattern------------------------------------------
/turf/unsimulated/outside/metalplating/metalpopout
	name = "Patterned Metal Plate Floor"
	desc = "It is the crème de la crème of the local metal plate floor varieties."
	icon_state = "1metalpopout"
/turf/unsimulated/outside/metalplating/metalpopout/two
	icon_state = "2metalpopout"
/turf/unsimulated/outside/metalplating/metalpopout/three
	icon_state = "3metalpopout"

//Metal Tiled Floors-------------------------------------------
/turf/unsimulated/outside/metalplating/metaltile
	name = "Tiled Metal Plating"
	desc = "Sometimes one must learn to split, your metal plating."
	icon_state = "1metaltile"
/turf/unsimulated/outside/metalplating/metaltile/two
	icon_state = "2metaltile"
/turf/unsimulated/outside/metalplating/metaltile/three
	icon_state = "3metaltile"
/turf/unsimulated/outside/metalplating/metaltile/four
	icon_state = "4metaltile"
