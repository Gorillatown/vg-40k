//Basically our salvage structure
/datum/salvage_structure
	var/list/mybitches = list()
	var/attachpoint
	var/list/salvage_items = list()
	var/currently_cleansed = FALSE
	var/currently_unanchored = FALSE

/datum/salvage_structure/proc/unanchor_the_boys()
	if(!currently_unanchored)
		for(var/obj/structure/shipping_containers/YAYA in mybitches)
			YAYA.anchored = FALSE
			currently_unanchored = TRUE
			spawn(10)
				YAYA.anchored = TRUE
		return 0
	return 1

/datum/salvage_structure/proc/unleash_contents(mob/user)
	if(salvage_items.len)
		var/item_picked = salvage_items[rand(1,salvage_items.len)]
		var/item_spawned

		item_spawned = salvage_items[item_picked]
		var/actual_amount = rand(1,item_spawned)
		var/leftover = (item_spawned-actual_amount)

		if(0 >= leftover)
			salvage_items -= item_picked
		else
			salvage_items[item_picked] = leftover

		if(ispath(item_picked, /obj/item/stack))
			item_spawned = new item_picked(get_turf(user), actual_amount)
			to_chat(user,"<span class='good'> You find [actual_amount] [item_spawned].</span>")
			return 1
		else
			if(actual_amount > 1)
				for(var/i=1 to actual_amount)
					item_spawned = new item_picked(get_turf(user))
				to_chat(user,"<span class='good'> You find [actual_amount] [item_spawned].</span>")
				return 1
			else
				item_spawned = new item_picked(get_turf(user))
				to_chat(user,"<span class='good'> You find a [item_spawned].</span>")
				return 1
	else
		to_chat(user,"<span class='bad'> Appears theres nothing of note left.</span>")
		return 0

/datum/salvage_structure/proc/cleanitup()
	if(!currently_cleansed)
		for(var/obj/I in mybitches)
			qdel(I)

/datum/locking_category/shipping_container_left
	x_offset = -1

/datum/locking_category/shipping_container_right
	x_offset = 1

/obj/structure/shipping_containers/lock_atom(var/atom/movable/AM, var/datum/locking_category/category)
	. = ..()
	if(!.)
		return

/obj/structure/shipping_containers/unlock_atom(var/atom/movable/AM, var/datum/locking_category/category)
	. = ..()
	if(!.)
		return

/*
	See: Salvage Lists for the actual drop lists
	As to why, we can cut down drastically on lists, shits handled on the single datum per 3 objects anyways.
*/
/obj/structure/shipping_containers
	name = "Shipping Container"
	desc = "At some point something was shipped, obviously."
	icon = 'z40k_shit/icons/obj/containers.dmi'
	var/datum/salvage_structure/SLVS
	density = 1
	anchored = TRUE
	bound_height = 64

/obj/structure/shipping_containers/Destroy()
	SLVS.cleanitup()
	..()

/obj/structure/shipping_containers/attack_hand(mob/user)
	user.visible_message("<span class='average'>[user] begins searching through the [src].</span>")
	if(do_after(user, src, 50))
		SLVS.unleash_contents(user)

/*
/obj/structure/shipping_containers/Bumped(atom/user)
	if(ismob(user))
		var/mob/living/L = user
		if(L.attribute_strength >= 14)
			SLVS.unanchor_the_boys()
*/			

//The middle will be special, it contains the primary datum and will be the scanning point.
/obj/structure/shipping_containers/left
/obj/structure/shipping_containers/middle
/obj/structure/shipping_containers/right

/obj/structure/shipping_containers/middle/New()
	..()

/obj/structure/shipping_containers/middle/initialize()
	..()
	SLVS = new(src)
	SLVS.salvage_items = container_salvage_contents_basic.Copy()
	SLVS.attachpoint = src
	SLVS.mybitches += src
	var/turf/T1 = get_step(src,EAST)
	var/turf/T2 = get_step(src,WEST)
	for(var/turf/TURFZ in list(T1,T2))
		for(var/obj/structure/shipping_containers/SCONTZ in TURFZ.contents)
			SLVS.mybitches += SCONTZ
			SCONTZ.SLVS = SLVS
			
/*
	Clean Containers
						*/
/obj/structure/shipping_containers/left/blue
	icon_state = "1blue_1"
/obj/structure/shipping_containers/middle/blue
	icon_state = "1blue_2"
/obj/structure/shipping_containers/right/blue
	icon_state = "1blue_3"


/obj/structure/shipping_containers/left/red
	icon_state = "1red_1"
/obj/structure/shipping_containers/middle/red
	icon_state = "1red_2"
/obj/structure/shipping_containers/right/red
	icon_state = "1red_3"


/obj/structure/shipping_containers/left/green
	icon_state = "1green_1"
/obj/structure/shipping_containers/middle/green
	icon_state = "1green_2"
/obj/structure/shipping_containers/right/green
	icon_state = "1green_3"

/obj/structure/shipping_containers/left/purple
	icon_state = "1purple_1"
/obj/structure/shipping_containers/middle/purple
	icon_state = "1purple_2"
/obj/structure/shipping_containers/right/purple
	icon_state = "1purple_3"


/*
	Rusty/fucked up containers
								*/

/obj/structure/shipping_containers/left/bluetwo
	icon_state = "2blue_1"
/obj/structure/shipping_containers/middle/bluetwo
	icon_state = "2blue_2"
/obj/structure/shipping_containers/right/bluetwo
	icon_state = "2blue_3"

/obj/structure/shipping_containers/left/bluethree
	icon_state = "3blue_1"
/obj/structure/shipping_containers/middle/bluethree
	icon_state = "3blue_2"
/obj/structure/shipping_containers/right/bluethree
	icon_state = "3blue_3"

/obj/structure/shipping_containers/left/redtwo
	icon_state = "2red_1"
/obj/structure/shipping_containers/middle/redtwo
	icon_state = "2red_2"
/obj/structure/shipping_containers/right/redtwo
	icon_state = "2red_3"

/obj/structure/shipping_containers/left/greentwo
	icon_state = "2green_1"
/obj/structure/shipping_containers/middle/greentwo
	icon_state = "2green_2"
/obj/structure/shipping_containers/right/greentwo
	icon_state = "2green_3"

/obj/structure/shipping_containers/left/purpletwo
	icon_state = "2purple_1"
/obj/structure/shipping_containers/middle/purpletwo
	icon_state = "2purple_2"
/obj/structure/shipping_containers/right/purpletwo
	icon_state = "2purple_3"

/obj/structure/shipping_containers/left/purplethree
	icon_state = "3purple_1"
/obj/structure/shipping_containers/middle/purplethree
	icon_state = "3purple_2"
/obj/structure/shipping_containers/right/purplethree
	icon_state = "3purple_3"

/*
	Armored Containers
						*/

/obj/structure/shipping_containers/left/sblue
	icon_state = "1sblue_1"
/obj/structure/shipping_containers/middle/sblue
	icon_state = "1sblue_2"
/obj/structure/shipping_containers/right/sblue
	icon_state = "1sblue_3"


/obj/structure/shipping_containers/left/sred
	icon_state = "1sred_1"
/obj/structure/shipping_containers/middle/sred
	icon_state = "1sred_2"
/obj/structure/shipping_containers/right/sred
	icon_state = "1sred_3"


/obj/structure/shipping_containers/left/sgreen
	icon_state = "1sgreen_1"
/obj/structure/shipping_containers/middle/sgreen
	icon_state = "1sgreen_2"
/obj/structure/shipping_containers/right/sgreen
	icon_state = "1sgreen_3"