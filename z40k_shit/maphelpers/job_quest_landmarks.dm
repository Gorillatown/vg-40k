/obj/effect/landmark/mimefalsewall //This will create the stash from which the mime gets a special blade.
	name = "Mime False Wall"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x"
	anchored = 1
	invisibility = 100

/obj/effect/landmark/mimeequipmentdrop //Spawns the blade.
	name = "Mime Equipment Drop"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x"
	anchored = 1
	invisibility = 100

/obj/effect/landmark/mimeopponentdrop //Drops an opponent in the stash so they don't get it for nothing. Not nearly as difficult as the mandrake, but still something. Some kind shade I think. Purple, of coarse.
	name = "Mime Opponent Drop"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x"
	anchored = 1
	invisibility = 100

/obj/effect/landmark/lordpsykerbook
	name = "Lord Psyker Book"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x"
	anchored = 1
	invisibility = 100

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