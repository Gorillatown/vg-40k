//I do not feel like... working on this much more tbqh
/turf/unsimulated/outside/swampwater
	name = "swamp water"
	desc = "It looks like something you probably shouldn't trust forever."
	icon_state = "water"
	floragen = FALSE 
	footprints = FALSE

/turf/unsimulated/outside/swampwater/center
	icon_state = "water"
/turf/unsimulated/outside/swampwater/north
	icon_state = "water2"
/turf/unsimulated/outside/swampwater/south
	icon_state = "water6"
/turf/unsimulated/outside/swampwater/east
	icon_state = "water4"
/turf/unsimulated/outside/swampwater/west
	icon_state = "water8"
/turf/unsimulated/outside/swampwater/northeast
	icon_state = "water3"
/turf/unsimulated/outside/swampwater/southeast
	icon_state = "water5"
/turf/unsimulated/outside/swampwater/northwest
	icon_state = "water1"
/turf/unsimulated/outside/swampwater/southwest
	icon_state = "water7"


/*

     NW(9)  N(1) NE(5)
		\	|   /
W(8)---- *****  ---- E(4)
		/	|	\
   SE(6)  S(2)  SW(10)

*/

/turf/unsimulated/outside/swampwater/smooth
	icon = 'F_40kshit/icons/turfs/42x42water.dmi'
	icon_state = "water"
	plane = BELOW_TURF_PLANE
	pixel_x = -3
	pixel_y = -3
	turf_speed_multiplier = 1.4
	water_reflections = TRUE
	var/obj/effect/overlay/viscons/water_reflection/REFL
	var/busy = 0 	//Something's being washed at the moment

/obj/effect/overlay/viscons/water_reflection
	name = "Water Reflection"
	desc = "A reflection is both real, and not real."
	vis_flags = VIS_INHERIT_ID

/obj/effect/overlay/viscons/water_reflection/New()
	..()

/turf/unsimulated/outside/swampwater/smooth/New()
	..()
/*	REFL = new(src.loc)
	REFL.layer = layer+1
	vis_contents += REFL
	REFL.alpha = 20
	REFL.color = "#383733"
	var/matrix/M = matrix()
	REFL.pixel_y = 9
	REFL.pixel_x = 3 
	M.Turn(180)
	REFL.transform = M*/

/turf/unsimulated/outside/swampwater/smooth/initialize()
	..()

/turf/unsimulated/outside/swampwater/smooth/Entered(atom/A, atom/OL)
	..()

	if(istype(A,/mob/living))
		var/mob/living/L = A
		if(!L.water_effects)
			L.vis_contents += viscon_overlays[1]
			L.water_effects = TRUE

	/*	var/turf/T = get_step(src,SOUTH)
		if(istype(T,/turf/unsimulated/outside/swampwater/smooth))
			var/turf/unsimulated/outside/swampwater/smooth/TT = T
			TT.REFL.vis_contents += L*/

/turf/unsimulated/outside/swampwater/smooth/Exited(atom/A, atom/newloc)
	..()
	if(istype(A,/mob/living))
		var/mob/living/L = A
		if(L.water_effects)
			if(!istype(newloc,/turf/unsimulated/outside/swampwater))
				for(var/obj/effect/overlay/viscons/water_overlay/augh in L.vis_contents)
					L.vis_contents -= augh
				L.water_effects = FALSE
		
	/*	var/turf/T = get_step(src,SOUTH)
		if(istype(T,/turf/unsimulated/outside/swampwater/smooth))
			var/turf/unsimulated/outside/swampwater/smooth/TT = T
			TT.REFL.vis_contents -= L*/

/turf/unsimulated/outside/swampwater/smooth/attackby(obj/item/O, mob/user)
	if(busy)
		to_chat(user, "<span class='warning'>Someone's already washing here.</span>")
		return

	if(istype(O, /obj/item/weapon/mop))
		return

	if(istype(O, /obj/item/weapon/reagent_containers))
		var/obj/item/weapon/reagent_containers/RG = O
		if(RG.reagents.total_volume >= RG.reagents.maximum_volume)
			to_chat(user, "<span class='warning'>\The [RG] is full.</span>")
			return
		if(istype(RG, /obj/item/weapon/reagent_containers/chempack)) //Chempack can't use amount_per_transfer_from_this, so it needs its own if statement.
			var/obj/item/weapon/reagent_containers/chempack/C = RG
			C.reagents.add_reagent(WATER, C.fill_amount)
		else
			RG.reagents.add_reagent(WATER, min(RG.volume - RG.reagents.total_volume, RG.amount_per_transfer_from_this))
		user.visible_message("<span class='notice'>[user] fills \the [RG] using \the [src].</span>","<span class='notice'>You fill the [RG] using \the [src].</span>")
		return

	if(istype(O,/obj/item/trash/plate))
		var/obj/item/trash/plate/the_plate = O
		the_plate.clean = TRUE
		O.update_icon()

	else if (istype(O, /obj/item/weapon/melee/baton))
		var/obj/item/weapon/melee/baton/B = O
		if (B.bcell && B.bcell.charge > 0 && B.status == 1)
			flick("baton_active", src)
			user.Stun(10)
			user.stuttering = 10
			user.Knockdown(10)
			if(isrobot(user))
				var/mob/living/silicon/robot/R = user
				R.cell.charge -= 20
			else
				B.deductcharge(1)
			user.visible_message( \
				"<span class='warning'>[user] was stunned by \his wet [O.name]!</span>", \
				"<span class='warning'>You have wet \the [O.name], it shocks you!</span>")
			return

	if(isitem(O))
		to_chat(user, "<span class='notice'>You start washing \the [O].</span>")
		busy = TRUE

		if(do_after(user,src, 40))
			O.clean_blood()
			if(O.current_glue_state == GLUE_STATE_TEMP)
				O.unglue()
			user.visible_message( \
				"<span class='notice'>[user] washes \a [O] using \the [src].</span>", \
				"<span class='notice'>You wash \a [O] using \the [src].</span>")

		busy = FALSE

/*
	Contamination one day....
*/
/turf/unsimulated/outside/swampwater/smooth/verb/empty_container_into()
	set name = "Empty container into"
	set category = "Object"
	set src in oview(1)

	if(!usr || !isturf(usr.loc))
		return
	var/obj/item/weapon/reagent_containers/container = usr.get_active_hand()
	if(!istype(container))
		to_chat(usr, "<span class='warning'>You need a reagent container in your active hand to do that.</span>")
		return
	return container.drain_into(usr, src)

/turf/unsimulated/outside/swampwater/smooth/AltClick()
	if(Adjacent(usr))
		return empty_container_into()
	return ..()

/turf/unsimulated/outside/swampwater/smooth/attack_hand(mob/M)
	if(isrobot(M) || isAI(M))
		return

	if(!Adjacent(M))
		return

	if(busy)
		to_chat(M, "<span class='warning'>Someone's already washing here.</span>")
		return

	to_chat(usr, "<span class='notice'>You start washing your hands.</span>")

	busy = 1
	sleep(40)
	busy = 0

	if(!Adjacent(M))
		return		//Person has moved away from the sink

	M.clean_blood()
	if(ishuman(M))
		M:update_inv_gloves()
	for(var/mob/V in viewers(src, null))
		V.show_message("<span class='notice'>[M] washes their hands using \the [src].</span>")

/turf/unsimulated/outside/swampwater/smooth/mop_act(obj/item/weapon/mop/M, mob/user)
	if(busy)
		return 1
	user.visible_message("<span class='notice'>[user] puts \the [M] into the swamp water.","<span class='notice'>You put \the [M] underneath the swamp water.</span>")
	busy = 1
	sleep(40)
	busy = 0
	M.clean_blood()
	if(M.reagents.maximum_volume > M.reagents.total_volume)
		playsound(src, 'sound/effects/slosh.ogg', 25, 1)
		M.reagents.add_reagent(WATER, min(M.reagents.maximum_volume - M.reagents.total_volume, 50))
		user.visible_message("<span class='notice'>[user] finishes soaking \the [M], \he could clean the outpost with that.</span>","<span class='notice'>You finish soaking \the [M], you feel as if you could clean anything now, even a ork's ass...</span>")
	else
		user.visible_message("<span class='notice'>[user] removes \the [M], cleaner than before.</span>","<span class='notice'>You remove \the [M] from \the [src], it's all nice and sparkly now but somehow didnt get it any wetter.</span>")
	return 1