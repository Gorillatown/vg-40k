//CONTAINS: Evidence bags

/obj/item/weapon/storage/evidencebag
	name = "evidence bag"
	desc = "An empty evidence bag."
	icon = 'icons/obj/storage/storage.dmi'
	icon_state = "evidenceobj"
	item_state = ""
	use_to_pickup = TRUE
	allow_quick_empty = TRUE
	collection_mode = FALSE
	w_class = W_CLASS_TINY
	fits_max_w_class = W_CLASS_MEDIUM
	storage_slots = 1

/obj/item/weapon/storage/evidencebag/update_icon()
	var/obj/item/I = locate() in contents
	if(I)
		var/xx = I.pixel_x	//save the offset of the item
		var/yy = I.pixel_y
		I.pixel_x = 0		//then remove it so it'll stay within the evidence bag
		I.pixel_y = 0
		var/image/img = image("icon"=I, "layer"=FLOAT_LAYER)	//take a snapshot. (necessary to stop the underlays appearing under our inventory-HUD slots ~Carn
		img.plane = FLOAT_PLANE
		I.pixel_x = xx		//and then return it
		I.pixel_y = yy
		overlays += img
		overlays += image(icon = icon, icon_state = "evidence")	//should look nicer for transparent stuff. not really that important, but hey.

		desc = "An evidence bag containing [I]. [I.desc]"
		w_class = I.w_class
	else
		desc = initial(desc)
		w_class = initial(w_class)
		overlays.Cut()

/obj/item/weapon/storage/box/evidence
	name = "evidence bag box"
	desc = "A box containing evidence bags."
	icon_state = "evidencebox"

/obj/item/weapon/storage/box/evidence/New()
	new /obj/item/weapon/storage/evidencebag(src)
	new /obj/item/weapon/storage/evidencebag(src)
	new /obj/item/weapon/storage/evidencebag(src)
	new /obj/item/weapon/storage/evidencebag(src)
	new /obj/item/weapon/storage/evidencebag(src)
	new /obj/item/weapon/storage/evidencebag(src)
	..()
	return
