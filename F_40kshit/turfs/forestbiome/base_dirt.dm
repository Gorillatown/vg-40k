/turf/unsimulated/outside/sumdirt
	name = "Dirt"
	desc = "Its brown, and dirty"
//	icon = 'F_40kshit/icons/turfs/desertsand.dmi'
	icon_state = "sumdirt1"
	plane = PLATING_PLANE

	can_border_transition = 0
	floragen = TRUE
	footprint_color = "#271a08" 


/turf/unsimulated/outside/sumdirt/New()
	..()

/turf/unsimulated/outside/sumdirt/no_floragen
	desc = "This dirt doesn't seem to have much flora on it."
	floragen = FALSE