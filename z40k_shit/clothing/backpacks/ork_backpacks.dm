/*
	Backpacks
				*/
/obj/item/weapon/storage/backpack/brownbackpack
	name = "Brown Backpack"
	desc = "A brown backpack, maybe one day there will be more to it."
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	icon_state = "orkbackpack"
	item_state = "orkbackpack"
	max_combined_w_class = 200
	
/obj/item/weapon/storage/backpack/brownbackpack/sluggakit/New()
	..()
	new /obj/item/ammo_storage/magazine/sluggamag(src)
	new /obj/item/ammo_storage/magazine/sluggamag(src)
	new /obj/item/ammo_storage/box/piles/sluggabulletpile/max_pile(src)
	new /obj/item/ammo_storage/box/piles/sluggabulletpile/max_pile(src)
	new /obj/item/weapon/grenade/stikkbomb(src)


/obj/item/weapon/storage/backpack/brownbackpack/kommandokit/New()
	..()
	new /obj/item/ammo_storage/box/piles/buckshotpile/max_pile(src)
	new /obj/item/ammo_storage/box/piles/buckshotpile/max_pile(src)
	new /obj/item/ammo_storage/box/piles/buckshotpile/max_pile(src)
	new /obj/item/ammo_storage/magazine/shottamag(src)
	new /obj/item/weapon/grenade/stikkbomb(src)
	new /obj/item/weapon/grenade/stikkbomb(src)

/obj/item/weapon/storage/backpack/brownbackpack/shootakit/New()
	..()
	new /obj/item/ammo_storage/magazine/sluggamag(src)
	new /obj/item/ammo_storage/magazine/sluggamag(src)
	new /obj/item/ammo_storage/magazine/sluggamag(src)
	new /obj/item/ammo_storage/magazine/sluggamag(src)
	new /obj/item/ammo_storage/box/piles/sluggabulletpile/max_pile(src)
	new /obj/item/ammo_storage/box/piles/sluggabulletpile/max_pile(src)

/obj/item/weapon/storage/backpack/brownbackpack/kustomshootabelts/New()
	..()
	new /obj/item/ammo_storage/magazine/kustom_shoota_belt(src)
	new /obj/item/ammo_storage/magazine/kustom_shoota_belt(src)
	new /obj/item/ammo_storage/magazine/kustom_shoota_belt(src)
	new /obj/item/ammo_storage/magazine/kustom_shoota_belt(src)
	new /obj/item/ammo_storage/box/piles/sluggabulletpile/max_pile(src)
	new /obj/item/ammo_storage/box/piles/sluggabulletpile/max_pile(src)

/obj/item/weapon/storage/backpack/brownbackpack/mekpack/New()
	..()
	new /obj/item/ammo_storage/magazine/kustom_shoota_belt(src)
	new /obj/item/weapon/taperoll(src)
	new /obj/item/ammo_storage/magazine/kustom_shoota_belt(src)
	new /obj/item/ammo_storage/magazine/kustom_shoota_belt(src)
	new /obj/item/ammo_storage/box/piles/sluggabulletpile/max_pile(src)
	new /obj/item/ammo_storage/box/piles/sluggabulletpile/max_pile(src)

/*
	Ork Trophy Holder Backpack
*/
/*
/obj/item/weapon/storage/backpack/ork_trophybackpack
	name = "trophy rack"
	desc = "A bag with some poles for skulls upon it."
	inhand_states = list("left_hand" = 'icons/mob/in-hand/left/cultstuff.dmi', "right_hand" = 'icons/mob/in-hand/right/cultstuff.dmi')
	icon_state = "cultpack_0skull"
	item_state = "cultpack"
	var/heads = 0
	var/headone = 0
	var/headtwo = 0

/obj/item/weapon/storage/backpack/ork_trophybackpack/attack_self(var/mob/user)
	..()
	for(var/i = 1 to skulls)
		new/obj/item/weapon/skull(get_turf(src))
	update_icon(user)

/obj/item/weapon/storage/backpack/ork_trophybackpack/equipped(var/mob/user, var/slot, hand_index = 0)
	..()
	update_icon(user)

/obj/item/weapon/storage/backpack/ork_trophybackpack/update_icon(var/mob/living/carbon/human/user)
	if(!istype(user) || !haircolored)
		return
	wear_override = new/icon("icon" = 'icons/mob/head.dmi', "icon_state" = "kitty")
	wear_override.Blend(rgb(user.my_appearance.r_hair, user.my_appearance.g_hair, user.my_appearance.b_hair), ICON_ADD)

	var/icon/earbit = new/icon("icon" = 'icons/mob/head.dmi', "icon_state" = "kittyinner")
	wear_override.Blend(earbit, ICON_OVERLAY)

/obj/item/weapon/storage/backpack/ork_trophybackpack/attackby(var/obj/item/weapon/W, var/mob/user)
	if(istype(W, /obj/item/weapon/skull) && (skulls < 3))
		user.u_equip(W,1)
		qdel(W)
		skulls++
		update_icon(user)
		to_chat(user,"<span class='warning'>You plant \the [W] on \the [src].</span>")
		return
	. = ..()

/obj/item/weapon/storage/backpack/ork_trophybackpack/update_icon(var/mob/living/carbon/user)
	icon_state = "cultpack_[skulls]skull"
	item_state = "cultpack"
	if(istype(user))
		user.update_inv_back()

/obj/item/weapon/storage/backpack/ork_trophybackpack/get_cult_power()
	return 30

/obj/item/weapon/storage/backpack/ork_trophybackpack/cultify()
	return
*/
