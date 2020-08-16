//TODO: Jam shit in.

/turf/simulated/floor/woodruin
	name = "Ruined Wood floor"
	icon = 'z40k_shit/icons/turfs/ruinfloors.dmi'


/*
	Wood Stuffs
				*/

/turf/simulated/floor/woodruin/wood
	name = "Wood Floor"
	desc = "Looks like its seen better days."
	floor_tile = null
	autoignition_temperature = AUTOIGNITION_WOOD
	fire_fuel = 10
	soot_type = null
	melt_temperature = 0 // Doesn't melt.

/turf/simulated/floor/woodruin/wood/New()
	floor_tile = new /obj/item/stack/tile/wood
	..()

/turf/simulated/floor/woodruin/wood/regstate1
	icon_state = "housewood1"
/turf/simulated/floor/woodruin/wood/regstate2
	icon_state = "housewood2"
/turf/simulated/floor/woodruin/wood/regstate3
	icon_state = "housewood3"

/turf/simulated/floor/woodruin/wood/dmgstate1
	icon_state = "housewood-dam1"
/turf/simulated/floor/woodruin/wood/dmgstate2
	icon_state = "housewood-dam2"
/turf/simulated/floor/woodruin/wood/dmgstate3
	icon_state = "housewood-dam3"
/turf/simulated/floor/woodruin/wood/dmgstate4
	icon_state = "housewood-dam4"
/turf/simulated/floor/woodruin/wood/dmgstate5
	icon_state = "housewood-dam5"

/*
	Carpet Stuffs
					*/

/turf/simulated/floor/woodruin/carpet
	name = "Carpet"
	desc = "This carpet has probably seen more action than you."
	floor_tile = null

/turf/simulated/floor/woodruin/carpet/New()
	if(floor_tile)
		qdel(floor_tile)
		floor_tile = null
	floor_tile = new /obj/item/stack/tile/carpet
	..()

/turf/simulated/floor/woodruin/carpet/first
	icon_state = "carpet"
/turf/simulated/floor/woodruin/carpet/one
	icon_state = "torncarpet1"
/turf/simulated/floor/woodruin/carpet/two
	icon_state = "torncarpet2"
/turf/simulated/floor/woodruin/carpet/three
	icon_state = "torncarpet3"
/turf/simulated/floor/woodruin/carpet/four
	icon_state = "torncarpet4"
/turf/simulated/floor/woodruin/carpet/five
	icon_state = "torncarpet5"
/turf/simulated/floor/woodruin/carpet/six
	icon_state = "torncarpet6"
/turf/simulated/floor/woodruin/carpet/seven
	icon_state = "torncarpet7"
/turf/simulated/floor/woodruin/carpet/eight
	icon_state = "torncarpet8"
/turf/simulated/floor/woodruin/carpet/nine
	icon_state = "torncarpet9"
/turf/simulated/floor/woodruin/carpet/ten
	icon_state = "torncarpet10"
/turf/simulated/floor/woodruin/carpet/eleven
	icon_state = "torncarpet11"
/turf/simulated/floor/woodruin/carpet/twelve
	icon_state = "torncarpet12"
/turf/simulated/floor/woodruin/carpet/thirteen
	icon_state = "torncarpet13"
/turf/simulated/floor/woodruin/carpet/fourteen
	icon_state = "torncarpet14"
/turf/simulated/floor/woodruin/carpet/fifteen
	icon_state = "torncarpet15"
/turf/simulated/floor/woodruin/carpet/sixteen
	icon_state = "torncarpet16"
