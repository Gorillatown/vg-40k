/obj/structure/flora/desertrock
	name = "rock"
	desc = "a rock"
	icon = 'z40k_shit/icons/doodads/desertrocks32x32.dmi'
	anchored = 1
	shovelaway = TRUE

/obj/structure/flora/desertrock/New()
	..()
	icon_state = "desertrock[rand(1,4)]"

	if(prob(50))
		qdel(src)
	for(var/atom/A in loc)
		if(istype(A,/obj/effect/decal/ruinshit/rubble/rubblefull))
			qdel(src)
			return