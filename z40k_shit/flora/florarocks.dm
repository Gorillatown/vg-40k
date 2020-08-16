//a rock is flora according to where the icon file is
//and now these defines
/obj/structure/flora/rock
	name = "rock"
	desc = "a rock"
	icon_state = "rock1"
	icon = 'icons/obj/flora/rocks.dmi'
	anchored = 1
	shovelaway = TRUE

/obj/structure/flora/rock/New()
	..()
	icon_state = "rock[rand(1,5)]"

/obj/structure/flora/rock/pile
	name = "rocks"
	desc = "A bunch of small rocks."
	icon_state = "rockpile1"

/obj/structure/flora/rock/pile/New()
	..()
	icon_state = "rockpile[rand(1,5)]"

/obj/structure/flora/rock/pile/snow
	name = "rocks"
	desc = "A bunch of small rocks, these ones are covered in a thick frost layer."
	icon_state = "srockpile1"

/obj/structure/flora/rock/pile/snow/New()
	..()
	icon_state = "srockpile[rand(1,5)]"
