/obj/fluids

/obj/fluids/placeholder_one
	name = "Water"
	desc = "Looks kinda dirty"
	icon = 'F_40kshit/icons/obj/fluids.dmi'
	icon_state = "water1"

/obj/fluids/placeholder_one/New()
	..()
	var/turf/T = loc
	for(var/obj/fluids/OTHERS in T)
		if(OTHERS != src)
			qdel(OTHERS)