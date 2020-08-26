/obj/structure/orktrophybanner
	name = "Ork Banner"
	icon = 'z40k_shit/icons/obj/64xstructures.dmi'
	icon_state = "orkbanner"
	desc = "How did this get here?"
	density = 0
	anchored = 1
	plane = ABOVE_HUMAN_PLANE
	layer = WINDOOR_LAYER

	var/list/mounted_list = list()

/obj/structure/orktrophybanner/New()
	..()

/obj/structure/orktrophybanner/Destroy()
	for(var/obj/item/I in mounted_list)
		I.forceMove(get_turf(src))
		mounted_list -= I
	..()
///obj/item/deer_head
/obj/structure/orktrophybanner/examine(mob/user)
	..()
	if(mounted_list.len)
		for(var/obj/item/I in mounted_list)
			if(istype(I,/obj/item/organ/external/head))
				var/obj/item/organ/external/head/H = I
				to_chat(user, "<span class='info'>You recognize the head of [H.origin_body.real_name] on this banner.</span>")
			else
				to_chat(user, "<span class='info'>You see [I.name] on attached.</span>")

/obj/structure/orktrophybanner/attack_hand(mob/user, params, var/proximity)
	..()
	if(mounted_list.len)
		var/input = input("Select a object to remove!", "Remove Object", null, null) as null|anything in mounted_list
		var/obj/item/O = input
		O.forceMove(get_turf(src))
		mounted_list -= O
		mount_overlay_proc()
	else
		to_chat(user, "<span class='warning'> Theres nothin ta grab, ya git.</span>")

/obj/structure/orktrophybanner/attackby(obj/item/weapon/W, mob/user)
	..()
	if(istype(W,/obj/item))
		if(mounted_list.len >= 3)
			to_chat(user,"<span class='warning'> Theres no more places to hang a head, ya git. </span> ")
			return
		if(user.drop_item(W, src))
			if(istype(W, /obj/item/organ/external/head))
				if(isork(user))
					var/obj/item/organ/external/head/H = W
					var/mob/living/carbon/human/the_ork = user
					if(!H.used)
						the_ork.grow_nigga(50)
						to_chat(user,"<span class='good'> You feel yaself gro a bit.</span>")
						H.used = TRUE
			mounted_list += W
			mount_overlay_proc()

/obj/structure/orktrophybanner/proc/mount_overlay_proc()
	overlays.Cut()
	for(var/i=0 to mounted_list.len)
		var/obj/item/ASS = mounted_list[i]
		switch(i)
			if(1) //Left_hook
				var/image/left_hook = new(src)
				left_hook.dir = SOUTH
				left_hook.appearance = ASS.appearance
				left_hook.pixel_x = -10
				left_hook.pixel_y = 13
				left_hook.plane = ABOVE_HUMAN_PLANE
				left_hook.layer = OPEN_CURTAIN_LAYER
				overlays += left_hook.appearance
			if(2) //Right book
				var/image/right_hook = new(src)
				right_hook.dir = SOUTH
				right_hook.appearance = ASS.appearance
				right_hook.pixel_x = 24
				right_hook.pixel_y = 14
				right_hook.plane = ABOVE_HUMAN_PLANE
				right_hook.layer = OPEN_CURTAIN_LAYER
				overlays += right_hook.appearance
			if(3) //Top Hook
				var/image/top_spike = new(src)
				top_spike.dir = SOUTH
				top_spike.appearance = ASS.appearance
				top_spike.pixel_y = 38
				top_spike.pixel_x = 7
				top_spike.plane = ABOVE_HUMAN_PLANE
				top_spike.layer = OPEN_CURTAIN_LAYER
				overlays += top_spike.appearance
