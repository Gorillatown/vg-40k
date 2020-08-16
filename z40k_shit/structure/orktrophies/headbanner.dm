/obj/structure/orktrophybanner
	name = "Ork Banner"
	icon = 'z40k_shit/icons/obj/64xstructures.dmi'
	icon_state = "orkbanner"
	desc = "How did this get here?"
	density = 0
	anchored = 1
	plane = ABOVE_HUMAN_PLANE
	layer = WINDOOR_LAYER
//	var/list/headlist = list()
//	var/obj/item/organ/external/head/lefthook
//	var/obj/item/organ/external/head/righthook
//	var/obj/item/organ/external/head/topspike
	var/image/left_hook = null
	var/image/right_hook = null
	var/image/top_spike = null
	var/filled = FALSE //temporary, mostly because im feelin lazy atm

/obj/structure/orktrophybanner/New()
	..()

/obj/structure/orktrophybanner/Destroy()
	for(var/obj/item/I in contents)
		I.forceMove(get_turf(src))
	left_hook = null
	right_hook = null
	top_spike = null
	..()

/obj/structure/orktrophybanner/examine(mob/user)
	..()
	if(contents.len)
		for(var/obj/item/organ/external/head/H in contents)
			to_chat(user, "<span class='info'>You recognize the head of [H.origin_body.real_name] on this banner.</span>")

/obj/structure/orktrophybanner/attackby(obj/item/weapon/W, mob/user)
	..()
	if(istype(W, /obj/item/organ/external/head))
		if(filled)
			to_chat(user,"<span class='warning'> Theres no more places to hang a head, ya git. </span> ")
			return
		var/obj/item/organ/external/head/H = W
		if(isork(user))
			var/mob/living/carbon/human/the_ork = user
			if(!H.used)
				the_ork.grow_nigga(50)
				H.used = TRUE
		if(user.drop_item(H, src))
			H.dir = SOUTH
			if(!left_hook)
				left_hook = new(src)
				left_hook.dir = SOUTH
				left_hook.appearance = H.appearance
				left_hook.pixel_x = -10
				left_hook.pixel_y = 13
				left_hook.plane = ABOVE_HUMAN_PLANE
				left_hook.layer = OPEN_CURTAIN_LAYER
				overlays += left_hook.appearance
				return
			else if(!right_hook)
				right_hook = new(src)
				right_hook.dir = SOUTH
				right_hook.appearance = H.appearance
				right_hook.pixel_x = 24
				right_hook.pixel_y = 14
				right_hook.plane = ABOVE_HUMAN_PLANE
				right_hook.layer = OPEN_CURTAIN_LAYER
				overlays += right_hook.appearance
				return
			else if(!top_spike)
				top_spike = new(src)
				top_spike.dir = SOUTH
				top_spike.appearance = H.appearance
				top_spike.pixel_y = 38
				top_spike.pixel_x = 7
				top_spike.plane = ABOVE_HUMAN_PLANE
				top_spike.layer = OPEN_CURTAIN_LAYER
				overlays += top_spike.appearance
				return
				filled = TRUE
