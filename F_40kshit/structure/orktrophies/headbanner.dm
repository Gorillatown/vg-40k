/obj/structure/orktrophybanner
	name = "Ork Banner"
	icon = 'F_40kshit/icons/obj/64xstructures.dmi'
	icon_state = "orkbanner"
	desc = "A ork banner, looks like its the goff clan."
	density = 1
	anchored = 1
	plane = ABOVE_HUMAN_PLANE
	layer = WINDOOR_LAYER
	pixel_x = -6
	var/obj/item/organ/external/head/mounted_head = null

/obj/structure/orktrophybanner/New()
	..()

/obj/structure/orktrophybanner/Destroy()
	mounted_head.forceMove(get_turf(src))
	..()

/obj/structure/orktrophybanner/examine(mob/user)
	..()
	if(mounted_head)
		to_chat(user, "<span class='info'>You recognize the head of [mounted_head.origin_body.real_name] on this banner.</span>")

/obj/structure/orktrophybanner/attackby(obj/item/weapon/W, mob/user)
	..()
	if(istype(W, /obj/item/organ/external/head))
		if(mounted_head)
			to_chat(user,"<span class='warning'> Theres no more places to hang a head, ya git. </span> ")
			return
		if(user.drop_item(W, src))
			mounted_head = W
			mounted_head.used = TRUE
			if(isork(user))
				var/mob/living/carbon/human/the_ork = user
				if(!mounted_head.used)
					the_ork.grow_nigga(50)
					to_chat(user,"<span class='good'> You feel yaself gro a bit.</span>")
			var/image/mounted_head_img = new(src)
			mounted_head_img.dir = SOUTH
			mounted_head_img.appearance = mounted_head.appearance
			mounted_head_img.plane = ABOVE_HUMAN_PLANE
			mounted_head_img.layer = OPEN_CURTAIN_LAYER
			mounted_head_img.pixel_y = 37
			mounted_head_img.pixel_x = 7
			overlays += mounted_head_img.appearance

