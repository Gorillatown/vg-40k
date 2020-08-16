/obj/effect/landmark/bedguitar
	name = "Celeb Guitar Spawn"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x"
	anchored = 1
	invisibility = 100

/obj/effect/landmark/crashclue
	name = "Crash Clue"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x"
	anchored = 1
	invisibility = 100

/obj/effect/landmark/chaosladder
	name = "Ladder Spawn"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x"
	anchored = 1
	invisibility = 100
	var/obj/structure/ladder/chaosruin/ground/ourladder

/obj/effect/landmark/chaosladder/New()
	..()
	ourladder = new /obj/structure/ladder/chaosruin/ground(src)