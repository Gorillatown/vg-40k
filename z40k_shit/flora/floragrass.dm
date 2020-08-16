//snow grass
/obj/structure/flora/grass
	name = "grass"
	icon = 'icons/obj/flora/snowflora.dmi'
	anchored = 1
	shovelaway = TRUE

/obj/structure/flora/grass/brown
	icon_state = "snowgrass1bb"

/obj/structure/flora/grass/brown/New()
	..()
	icon_state = "snowgrass[rand(1, 3)]bb"


/obj/structure/flora/grass/green
	icon_state = "snowgrass1gb"

/obj/structure/flora/grass/green/New()
	..()
	icon_state = "snowgrass[rand(1, 3)]gb"

/obj/structure/flora/grass/both
	icon_state = "snowgrassall1"

/obj/structure/flora/grass/both/New()
	..()
	icon_state = "snowgrassall[rand(1, 3)]"

/obj/structure/flora/grass/white
	icon_state = "snowgrass3"

/obj/structure/flora/grass/white/New()
	..()
	icon_state = "snowgrass_[rand(1, 6)]"

//Dry grass

/obj/structure/flora/grass/drygrass
	name = "dry motherfuckin grass"
	icon = 'z40k_shit/icons/doodads/flora32x32.dmi'

/obj/structure/flora/grass/drygrass/New()
	..()
	icon_state = "tall_grass_[rand(1,8)]"