//Our own special form of crate. Mostly because we need some that are ID specific this time.
/obj/structure/closet/crate/id_secure
	name = "ID secured Crate"
	desc = "Registered to the person who requisitioned a smaller item."
	icon = 'F_40kshit/icons/obj/crates.dmi'
	icon_state = "greencrate_closed"
	icon_opened = "greencrate_open"
	icon_closed = "greencrate_closed"
	locked = TRUE
	var/obj/item/weapon/card/id/id_ref = null //We need this exact ID

/obj/structure/closet/crate/id_secure/New()
	..()

/obj/structure/closet/crate/id_secure/initialize()
	..()

/obj/structure/closet/crate/id_secure/Destroy()
	id_ref = null
	..()

/obj/structure/closet/crate/id_secure/attackby(obj/item/weapon/W, mob/user)
	if(istype(W, /obj/item/weapon/card) && !opened && !broken)
		if(toggle_reader(W))
			if(locked)
				to_chat(user, "<span class='notice'>You unlock [src].</span>")
				locked = FALSE
				say("*click click*")
			else
				to_chat(user, "<span class='notice'>You lock [src].</span>")
				locked = TRUE
		else
			to_chat(user, "<span class='notice'>Access Denied.</span>")
	return ..()

/obj/structure/closet/crate/id_secure/proc/toggle_reader(obj/item/weapon/card/id/passed_id)
	if(passed_id == id_ref)
		return TRUE
	else
		return FALSE

/obj/structure/closet/crate/id_secure/attack_hand(mob/user)
	if(locked)
		return 0
	else
		..()

/obj/structure/closet/crate/id_secure/open()
	if(locked)
		return 0
	else
		..()

