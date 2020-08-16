/turf/simulated/floor/metalplating
	name = "Metal Plate Floor"
	desc = "Its metal, and on the floor. What more could you ask for?"
	icon = 'z40k_shit/icons/turfs/metalfloors.dmi'
	thermal_conductivity = 0.025
	heat_capacity = 325000
	soot_type = null
	melt_temperature = 0 // Doesn't melt.

/turf/simulated/floor/metalplating/burn_tile()
	return

/turf/simulated/floor/metalplating/attackby(obj/item/C, mob/user)
	return

/turf/simulated/floor/metalplating/make_plating()
	return

/turf/simulated/floor/metalplating/ex_act(severity)
	return

/turf/simulated/floor/metalplating/attack_construct(mob/user)
	return 0

/*
	Guess we gonna split these up into categories really.
*/
//Metal Squares------------------------------
/turf/simulated/floor/metalplating/metalsquare
	name = "Segmented Metal Plate Floor"
	desc = "Seems theres a square in the center of some bars, who knows why."
	icon_state = "1metalsquare"

/turf/simulated/floor/metalplating/metalsquare/two
	icon_state = "2metalsquare"
/turf/simulated/floor/metalplating/metalsquare/three
	icon_state = "3metalsquare"
/turf/simulated/floor/metalplating/metalsquare/four
	icon_state = "4metalsquare"
/turf/simulated/floor/metalplating/metalsquare/five
	icon_state = "5metalsquare"

//Metal Riveted Floors-------------------------------
/turf/simulated/floor/metalplating/metalrivets
	name = "Riveted Metal Plate Floor"
	desc = "Plates riveted down, wow!"
	icon_state = "1metalrivets"
/turf/simulated/floor/metalplating/metalrivets/two
	icon_state = "2metalrivets"
/turf/simulated/floor/metalplating/metalrivets/three
	icon_state = "3metalrivets"
/turf/simulated/floor/metalplating/metalrivets/four
	icon_state = "4metalrivets"
/turf/simulated/floor/metalplating/metalrivets/five
	icon_state = "5metalrivets"
//Metal Fullplates-----------------------------------
/turf/simulated/floor/metalplating/metalplate
	name = "Metal Plate Floor"
	desc = "While not as exotic as the many other forms of metal plate floor, this one gets the job done."
	icon_state = "1metalplate"
/turf/simulated/floor/metalplating/metalplate/two
	icon_state = "2metalplate"
/turf/simulated/floor/metalplating/metalplate/three
	icon_state = "3metalplate"
/turf/simulated/floor/metalplating/metalplate/four
	icon_state = "4metalplate"
/turf/simulated/floor/metalplating/metalplate/fouralt
	icon_state = "4metalplatealt"
/turf/simulated/floor/metalplating/metalplate/five
	icon_state = "5metalplate"
/turf/simulated/floor/metalplating/metalplate/fivealt
	icon_state = "5metalplatealt"
//Metal Grate Floors--------------------------------
/turf/simulated/floor/metalplating/metalgrate
	name = "Metal Plate Floor with a Grate"
	desc = "Its the same metal plate floor, this time with a grate on it."
	icon_state = "1metalgrate"

/turf/simulated/floor/metalplating/metalgrate/two
	icon_state = "2metalgrate"
/turf/simulated/floor/metalplating/metalgrate/three
	icon_state = "3metalgrate"
/turf/simulated/floor/metalplating/metalgrate/four
	icon_state = "4metalgrate"
/turf/simulated/floor/metalplating/metalgrate/five
	icon_state = "5metalgrate"

//Metal Popout Pattern------------------------------------------
/turf/simulated/floor/metalplating/metalpopout
	name = "Patterned Metal Plate Floor"
	desc = "It is the crème de la crème of the local metal plate floor varieties."
	icon_state = "1metalpopout"
/turf/simulated/floor/metalplating/metalpopout/two
	icon_state = "2metalpopout"
/turf/simulated/floor/metalplating/metalpopout/three
	icon_state = "3metalpopout"

//Metal Tiled Floors-------------------------------------------
/turf/simulated/floor/metalplating/metaltile
	name = "Tiled Metal Plating"
	desc = "Sometimes one must learn to split, your metal plating."
	icon_state = "1metaltile"
/turf/simulated/floor/metalplating/metaltile/two
	icon_state = "2metaltile"
/turf/simulated/floor/metalplating/metaltile/three
	icon_state = "3metaltile"
/turf/simulated/floor/metalplating/metaltile/four
	icon_state = "4metaltile"
