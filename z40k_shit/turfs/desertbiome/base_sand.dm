/turf/unsimulated/outside/sand
	name = "Sand"
	icon = 'z40k_shit/icons/turfs/desertsand.dmi'
	icon_state = "sand1"
	plane = PLATING_PLANE

	can_border_transition = 0
	floragen = TRUE
	footprint_color = "#BC8F4B" 


/turf/unsimulated/outside/sand/New()
	..()
	if(prob(1))
		if(prob(5))
			icon_state = "sand[rand(2,4)]"
	else
		icon_state = "sand1"

/turf/unsimulated/outside/vaultsand //Basically so we can differ from baseturf and the above
	name = "Sand"
	icon = 'z40k_shit/icons/turfs/desertsand.dmi'
	icon_state = "sand1"
	plane = PLATING_PLANE

	can_border_transition = 0
	floragen = FALSE
	footprint_color = "#BC8F4B" 

/turf/unsimulated/outside/vaultsand/New()
	..()
	if(prob(1))
		if(prob(5))
			icon_state = "sand[rand(2,4)]"
	else
		icon_state = "sand1"