/obj/structure/flora/desertdunelarge
	name = "sanddune"
	desc = "its sand except fancy"
	icon_state = "desertdunelarge"
	icon = 'z40k_shit/icons/doodads/desertdune151x40.dmi'
	pixel_x = -32
	anchored = 1
	shovelaway = TRUE

/obj/structure/flora/desertdunesmall
	name = "sanddune"
	desc = "its sand except fancy"
	icon_state = "desertdunesmall"
	icon = 'z40k_shit/icons/doodads/desertdune78x16.dmi'
	pixel_x = -75
	anchored = 1
	shovelaway = TRUE

/obj/structure/flora/rngduneholder
	name = "megoaway"

/obj/structure/flora/rngduneholder/New()
	..()

	for(var/atom/A in loc)
		if(istype(A,/obj/effect/decal/ruinshit/rubble/rubblefull))
			qdel(src)
			return

	if(prob(5))
		if(prob(50))
			new /obj/structure/flora/desertdunelarge(loc)
			qdel(src)
		else
			new /obj/structure/flora/desertdunesmall(loc)
			qdel(src)
	else
		qdel(src)

