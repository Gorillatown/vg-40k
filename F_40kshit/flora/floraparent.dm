//trees
/obj/structure/flora
	name = "flora"
	var/icon/clicked //Because BYOND can't give us runtime icon access, this is basically just a click catcher
	var/shovelaway = FALSE

/obj/structure/flora/New()
	..()
	update_icon()

/obj/structure/flora/update_icon()
	clicked = new/icon(src.icon, src.icon_state, src.dir)

/obj/structure/flora/attackby(var/obj/item/I, var/mob/user, params)
	if(shovelaway && isshovel(I))
		to_chat(user,"<span class='notice'>You clear away \the [src]</span>")
		playsound(loc, 'sound/items/shovel.ogg', 50, 1)
		qdel(src)
		return 1
//	if(istype(I, /obj/item/ornament))
//		hang_ornament(I, user, params)
//		return 1
	..()

/obj/structure/flora/proc/hang_ornament(var/obj/item/I, var/mob/user, params)
	var/list/params_list = params2list(params)
	if(!istype(I, /obj/item/ornament))
		return
	if(istype(I, /obj/item/ornament/topper))
		for(var/i = 1 to contents.len)
			if(istype(contents[i], /obj/item/ornament/topper))
				to_chat(user, "Having more than one topper on a tree would look silly!")
				return
	if(user.drop_item(I, src))
		if(I.loc == src && params_list.len)
			var/image/O
			if(istype(I, /obj/item/ornament/teardrop))
				O = image('icons/obj/teardrop_ornaments.dmi', src, "[I.icon_state]_small")
			else
				O = image('icons/obj/ball_ornaments.dmi', src, "[I.icon_state]_small")

			var/clamp_x = clicked.Width() / 2
			var/clamp_y = clicked.Height() / 2
			O.pixel_x = clamp(text2num(params_list["icon-x"]) - clamp_x, -clamp_x, clamp_x)+(((((clicked.Width()/32)-1)*16)*PIXEL_MULTIPLIER))
			O.pixel_y = (clamp(text2num(params_list["icon-y"]) - clamp_y, -clamp_y, clamp_y)+((((clicked.Height()/32)-1)*16)*PIXEL_MULTIPLIER))-(5*PIXEL_MULTIPLIER)
			overlays += O
			to_chat(user, "You hang \the [I] on \the [src].")
			return 1

/obj/structure/flora/attack_hand(mob/user)
	if(contents.len)
		var/count = contents.len
		var/obj/item/I = contents[count]
		while(!istype(I, /obj/item/ornament))
			count--
			if(count < 1)
				return
			I = contents[count]
		user.visible_message("<span class='notice'>[user] plucks \the [I] off \the [src].</span>", "You take \the [I] off \the [src].")
		I.forceMove(loc)
		user.put_in_active_hand(I)
		overlays -= overlays[overlays.len]

/obj/structure/flora/pottedplant
	name = "potted plant"
	desc = "Oh, no. Not again."
	icon = 'icons/obj/plants.dmi'
	icon_state = "plant-26"
	layer = FLY_LAYER
	plane = ABOVE_HUMAN_PLANE

/obj/structure/flora/pottedplant/Destroy()
	for(var/I in contents)
		qdel(I)

	return ..()

/obj/structure/flora/pottedplant/attackby(var/obj/item/I, var/mob/user, params)
	if(!I)
		return
	if(I.w_class > W_CLASS_SMALL)
		to_chat(user, "That item is too big.")
		return
	if(contents.len)
		var/filled = FALSE
		for(var/i = 1, i <= contents.len, i++)
			if(!istype(contents[i], /obj/item/ornament))
				filled = TRUE
		if(filled)
			to_chat(user, "There is already something in the pot.")
			playsound(loc, "sound/effects/plant_rustle.ogg", 50, 1, -1)
			return
	if(user.drop_item(I, src))
		user.visible_message("<span class='notice'>[user] stuffs something into the pot.</span>", "You stuff \the [I] into the [src].")
		playsound(loc, "sound/effects/plant_rustle.ogg", 50, 1, -1)

/obj/structure/flora/pottedplant/attack_hand(mob/user)
	if(contents.len)
		var/count = 1
		var/obj/item/I = contents[count]
		while(istype(I, /obj/item/ornament))
			count++
			if(count > contents.len)	//pot is emptied of non-ornament items
				user.visible_message("<span class='notice'>[user] plucks \the [I] off \the [src].</span>", "You take \the [I] off \the [src].")
				playsound(loc, "sound/effects/plant_rustle.ogg", 50, 1, -1)
				I.forceMove(loc)
				user.put_in_active_hand(I)
				overlays -= overlays[overlays.len]
				return
			I = contents[count]
		user.visible_message("<span class='notice'>[user] retrieves something from the pot.</span>", "You retrieve \the [I] from the [src].")
		playsound(loc, "sound/effects/plant_rustle.ogg", 50, 1, -1)
		I.forceMove(loc)
		user.put_in_active_hand(I)
	else
		to_chat(user, "You root around in the roots. There isn't anything in there.")
		playsound(loc, "sound/effects/plant_rustle.ogg", 50, 1, -1)

/obj/structure/flora/pottedplant/attack_paw(mob/user)
	return attack_hand(user)

// /vg/
/obj/structure/flora/pottedplant/random/New()
	..()
	icon_state = "plant-[rand(1,26)]"

/obj/structure/flora/pottedplant/claypot
	name = "clay pot"
	desc = "Plants placed in those stop aging, but cannot be retrieved either."
	icon = 'icons/obj/hydroponics/hydro_tools.dmi'
	icon_state = "claypot"
	anchored = 0
	density = FALSE
	var/plant_name = ""

/obj/structure/flora/pottedplant/claypot/examine(mob/user)
	..()
	if(plant_name)
		to_chat(user, "<span class='info'>You can see [plant_name] planted in it.</span>")

/obj/structure/flora/pottedplant/claypot/attackby(var/obj/item/O,var/mob/user)
	if(O.is_wrench(user))
		playsound(loc, 'sound/items/Ratchet.ogg', 50, 1)
		if(do_after(user, src, 30))
			anchored = !anchored
			user.visible_message(	"<span class='notice'>[user] [anchored ? "wrench" : "unwrench"]es \the [src] [anchored ? "in place" : "from its fixture"].</span>",
									"<span class='notice'>[bicon(src)] You [anchored ? "wrench" : "unwrench"] \the [src] [anchored ? "in place" : "from its fixture"].</span>",
									"<span class='notice'>You hear a ratchet.</span>")
	else if(plant_name && isshovel(O))
		to_chat(user, "<span class='notice'>[bicon(src)] You start removing the [plant_name] from \the [src].</span>")
		if(do_after(user, src, 30))
			playsound(loc, 'sound/items/shovel.ogg', 50, 1)
			user.visible_message(	"<span class='notice'>[user] removes the [plant_name] from \the [src].</span>",
									"<span class='notice'>[bicon(src)] You remove the [plant_name] from \the [src].</span>",
									"<span class='notice'>You hear some digging.</span>")
			for(var/atom/movable/I in contents)
				I.forceMove(loc)
			new /obj/item/claypot(loc)
			qdel(src)

	else if(istype(O,/obj/item/weapon/reagent_containers/food/snacks/grown) || istype(O,/obj/item/weapon/grown))
		to_chat(user, "<span class='warning'>There is already a plant in \the [src]</span>")

	else
		..()


