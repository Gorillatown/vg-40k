/turf/unsimulated/floor/asteroid/air/deepcave
	name = "cave floor"
	icon = 'z40k_shit/icons/turfs/cavernfloors.dmi'
	icon_state = "deepcave_1"
	sand_type = /obj/item/stack/ore/glass/cave

/turf/unsimulated/floor/asteroid/air/deepcave/New()
	..()
	icon_state = "deepcave_[rand(1,4)]"

/turf/unsimulated/floor/asteroid/air
	name = "cavern floor"
	oxygen = MOLES_O2STANDARD
	nitrogen = MOLES_N2STANDARD
	temperature = T20C
	icon_state = "regcave_1"
	icon = 'z40k_shit/icons/turfs/cavernfloors.dmi'

/turf/unsimulated/floor/asteroid/air/New()
	..()
	if(prob(5))
		icon_state = "regcave_[rand(2,13)]"
