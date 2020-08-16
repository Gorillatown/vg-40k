/obj/structure/pressure_plate
	name = "Odd Pressure Plate"
	desc = "A plate of some kind, seeing as you aren't dumb you can discern its some kind of pressure plate."
	icon = 'z40k_shit/icons/obj/structures.dmi'
	icon_state = "pressure_plate_fun"
	anchored = TRUE
	density = FALSE
	var/fire_delay = 3 SECONDS
	var/last_fired
	var/activated = FALSE

/obj/structure/pressure_plate/New()
	..()
	tzeentchpads += src

/obj/structure/pressure_plate/Destroy()
	tzeentchpads -= src
	..()

//Entered
/obj/structure/pressure_plate/Crossed(atom/movable/mover, turf/target, height = 1.5, air_group = 0)
	if(ishuman(mover))
		var/mob/living/carbon/human/H = mover
		if(H.species.name == "Human")
			if(!H.mind.job_quest && H.stat != DEAD)
				activated = TRUE
				playsound(src,'sound/misc/click.ogg',30,0,-1)
				visible_message("<span class='warning'>\The [src] clicks!</span>")
				spawn(4 SECONDS)
					if(H.loc == loc)
						SS_Scenario.check_pads(H,TRUE)

//Exited
/obj/structure/pressure_plate/Uncrossed(var/atom/movable/mover)
	if(ishuman(mover))
		if(activated)
			activated = FALSE
			playsound(src,'sound/misc/click.ogg',30,0,-1)
			visible_message("<span class='warning'>\The [src] clicks!</span>")
	