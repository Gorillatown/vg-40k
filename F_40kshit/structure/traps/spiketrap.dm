
/obj/structure/traps/spiked_floortrap
	name = "Dangerous Spikes"
	desc = "These looked mighty dangerous in every fictional setting you've ever seen them in."
	icon = 'F_40kshit/icons/obj/trap_madness.dmi'
	icon_state = "spike_off" //The onstate is well... "spike_on"
	anchored = 1
	density = 0
	currently_active = FALSE
	tied_id = ""

/obj/structure/traps/spiked_floortrap/active
	currently_active = TRUE
	icon_state = "spike_on"
	density = 1

/obj/structure/traps/spiked_floortrap/New()
	..()

/obj/structure/traps/spiked_floortrap/Bumped(atom/AM)
	if(istype(AM, /mob/living))
		if(iscarbon(AM))
			var/mob/living/carbon/M = AM
			playsound(src, 'F_40kshit/sounds/spike_ring.ogg', 100, 1)
			M.adjustBruteLoss(30)
			M.Knockdown(12)

/obj/structure/traps/spiked_floortrap/Cross(atom/movable/mover, turf/target, height = 1.5, air_group = 0)
	if(!density)
		return 1
	if(air_group || !height) //The mover is an airgroup
		return 1 //We aren't airtight, only exception to PASSGLASS
	if(istype(mover,/obj/item/projectile))
		return 1
	if(ismob(mover))
		var/mob/M = mover
		if(M.flying || M.highflying)
			return 1
	return 0

/obj/structure/traps/spiked_floortrap/turn_my_ass_over()
	playsound(src, 'F_40kshit/sounds/spike_ring.ogg', 100, 1)
	if(!currently_active)
		currently_active = TRUE
		icon_state = "spike_on"
		density = 1
		//for(var/mob/living/carbon/M in range(0,src))
		for(var/mob/living/carbon/M in loc)
			M.adjustBruteLoss(70)
			break
	else
		currently_active = FALSE
		icon_state = "spike_off"
		density = 0

/obj/structure/traps/spiked_floortrap/to_bump(atom/movable/AM)
	if(ismob(AM))
		playsound(src, 'F_40kshit/sounds/spike_ring.ogg', 100, 1)
		var/mob/living/carbon/M = AM
		M.adjustBruteLoss(30)
		return
	..()
	

