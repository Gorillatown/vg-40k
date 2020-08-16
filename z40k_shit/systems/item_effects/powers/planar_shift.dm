/datum/item_power/phase
	name = "Planar Shift"
	desc = "Throws you through the warp a few tiles forward."

/datum/item_power/phase/init(var/obj/O)
	O.verbs.Add(/datum/item_power/phase/proc/verb_act)
	return

/datum/item_power/phase/proc/verb_act()
	set category = "item"
	set name = "Planar Shift"
	set src in usr

	var/mob/living/carbon/human/U = usr
	var/turf/destination = get_teleport_loc(U.loc,U,4,1,3,1,0,1) //A bit like phase jaunt but not as far.
	var/turf/mobloc = get_turf(U.loc)//To make sure that certain things work properly below.
	if(destination&&istype(mobloc, /turf))//The turf check prevents unusual behavior. Like teleporting out of cryo pods, cloners, mechs, etc.
		to_chat(U, "You feel the [src.name] drag you through the warp!")
		spawn(0)
			anim(mobloc,src,'icons/mob/mob.dmi',,"dust_h",,U.dir)
		U.loc = destination
		spawn(0)
			anim(U.loc,U,'icons/mob/mob.dmi',,"shadow",,U.dir)
	else
		to_chat(U, "<span class='warning'> You are unable to do this at the time, <B>planar shift failed</B>.</span>")
		