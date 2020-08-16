/turf/simulated/wall/rockcrete
	name = "Rockcrete Wall"
	desc = "Its harder than you will ever be. Bitch."
	icon = 'z40k_shit/icons/turfs/ruinwalls.dmi'
	explosion_block = 9999
	hardness = 100 // Hulk can't do dick.
	penetration_dampening = 40
	opacity = 1
	density = 1
	can_thermite = 0
	girder_type = /obj/structure/girder/reinforced

/turf/simulated/wall/rockcrete/dismantle_wall()
	return

/turf/simulated/wall/rockcrete/ex_act(severity)
	return // :^)

/turf/simulated/wall/rockcrete/attack_animal()
	return

/turf/simulated/wall/invulnerable/attackby(obj/item/W, mob/user)
	return

/turf/simulated/wall/invulnerable/attack_construct(mob/user)
	return 0

/turf/simulated/wall/rockcrete/reinforced
	name = "Solid Looking Rockcrete Wall"
	desc = "Unlike most things you gaze upon from the realm of local walls, this one appears to be still shapely and well defined."
	icon_state = "crete0"
	walltype = "crete"

/turf/simulated/wall/rockcrete/regruined
	name = "Crumbling Rockcrete Wall"
	desc = "Not all rockcrete is equal as most things go, as you can see by the crumbling of this segment of it."
	icon_state = "ruins0"
	walltype = "ruins"
 
/*
	BACKDROP WALLS

These shouldn't smooth since they are more or less so you can create detailed mapping with them
*/
/turf/simulated/wall/rockcrete/backdrop
	name = "Backdrops"
	desc = "A parent for walls that aren't supposed to smooth."

/turf/simulated/wall/rockcrete/backdrop/New()
	..()

/turf/simulated/wall/rockcrete/backdrop/relativewall()
	return

/turf/simulated/wall/rockcrete/backdrop/canSmoothWith()
	return null

/*
	The reinforced variant
							*/
/turf/simulated/wall/rockcrete/backdrop/reinforced
	name = "Solid Looking Rockcrete Wall"
	desc = "Unlike most things you gaze upon from the realm of local walls, this one appears to be still shapely and well defined."

/turf/simulated/wall/rockcrete/backdrop/reinforced/zero
	icon_state = "crete0"
/turf/simulated/wall/rockcrete/backdrop/reinforced/one
	icon_state = "crete1"
/turf/simulated/wall/rockcrete/backdrop/reinforced/two
	icon_state = "crete2"
/turf/simulated/wall/rockcrete/backdrop/reinforced/three
	icon_state = "crete3"
/turf/simulated/wall/rockcrete/backdrop/reinforced/four
	icon_state = "crete4"
/turf/simulated/wall/rockcrete/backdrop/reinforced/five
	icon_state = "crete5"
/turf/simulated/wall/rockcrete/backdrop/reinforced/six
	icon_state = "crete6"
/turf/simulated/wall/rockcrete/backdrop/reinforced/seven
	icon_state = "crete7"
/turf/simulated/wall/rockcrete/backdrop/reinforced/eight
	icon_state = "crete8"
/turf/simulated/wall/rockcrete/backdrop/reinforced/nine
	icon_state = "crete9"
/turf/simulated/wall/rockcrete/backdrop/reinforced/ten
	icon_state = "crete10"
/turf/simulated/wall/rockcrete/backdrop/reinforced/eleven
	icon_state = "crete11"
/turf/simulated/wall/rockcrete/backdrop/reinforced/twelve
	icon_state = "crete12"
/turf/simulated/wall/rockcrete/backdrop/reinforced/thirteen
	icon_state = "crete13"
/turf/simulated/wall/rockcrete/backdrop/reinforced/fourteen
	icon_state = "crete14"
/turf/simulated/wall/rockcrete/backdrop/reinforced/fifteen
	icon_state = "crete15"
/turf/simulated/wall/rockcrete/backdrop/reinforced/bottom
	icon_state = "cretebottom"
/turf/simulated/wall/rockcrete/backdrop/reinforced/vertical
	icon_state = "cretevertical"
/turf/simulated/wall/rockcrete/backdrop/reinforced/top
	icon_state = "cretetop"
/turf/simulated/wall/rockcrete/backdrop/reinforced/left
	icon_state = "creteleft"
/turf/simulated/wall/rockcrete/backdrop/reinforced/horizontal
	icon_state = "cretehorizontal"
/turf/simulated/wall/rockcrete/backdrop/reinforced/right
	icon_state = "creteright"

/*
	The regular variant
						*/
/turf/simulated/wall/rockcrete/backdrop/regruined
	name = "Crumbling Rockcrete Wall"
	desc = "Not all rockcrete is equal as most things go, as you can see by the crumbling of this segment of it."

/turf/simulated/wall/rockcrete/backdrop/regruined/zero
	icon_state = "ruins0"
/turf/simulated/wall/rockcrete/backdrop/regruined/one
	icon_state = "ruins1"
/turf/simulated/wall/rockcrete/backdrop/regruined/onealt
	icon_state = "ruins1alt"
/turf/simulated/wall/rockcrete/backdrop/regruined/two
	icon_state = "ruins2"
/turf/simulated/wall/rockcrete/backdrop/regruined/twoalt
	icon_state = "ruins2alt"
/turf/simulated/wall/rockcrete/backdrop/regruined/three
	icon_state = "ruins3"
/turf/simulated/wall/rockcrete/backdrop/regruined/four
	icon_state = "ruins4"
/turf/simulated/wall/rockcrete/backdrop/regruined/fouralt
	icon_state = "ruins4alt"
/turf/simulated/wall/rockcrete/backdrop/regruined/five
	icon_state = "ruins5"
/turf/simulated/wall/rockcrete/backdrop/regruined/six
	icon_state = "ruins6"
/turf/simulated/wall/rockcrete/backdrop/regruined/seven
	icon_state = "ruins7"
/turf/simulated/wall/rockcrete/backdrop/regruined/eight
	icon_state = "ruins8"
/turf/simulated/wall/rockcrete/backdrop/regruined/eightalt
	icon_state = "ruins8alt"
/turf/simulated/wall/rockcrete/backdrop/regruined/nine
	icon_state = "ruins9"
/turf/simulated/wall/rockcrete/backdrop/regruined/ten
	icon_state = "ruins10"
/turf/simulated/wall/rockcrete/backdrop/regruined/eleven
	icon_state = "ruins11"
/turf/simulated/wall/rockcrete/backdrop/regruined/twelve
	icon_state = "ruins12"
/turf/simulated/wall/rockcrete/backdrop/regruined/thirteen
	icon_state = "ruins13"
/turf/simulated/wall/rockcrete/backdrop/regruined/fourteen
	icon_state = "ruins14"
/turf/simulated/wall/rockcrete/backdrop/regruined/fifteen
	icon_state = "ruins15"