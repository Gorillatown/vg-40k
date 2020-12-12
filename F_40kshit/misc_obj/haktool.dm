/*
hack tool
*/
/obj/item/device/hacktool
	name = "An Eldar Device"
	desc = "Used for reconfiguring Eldar Gateways."
	icon = 'icons/obj/hacktool.dmi'
	icon_state = "hacktool-g"
	item_state = "pen"
	slot_flags = SLOT_BELT
	w_class = 2 //Increased to 2, because diodes are w_class 2. Conservation of matter.
	origin_tech = "combat=1;magnets=2"
	var/injectid = "Crone21775"
	var/oldname = "Crone21775"

/obj/item/device/hacktool/attack_self(mob/user)
	interact(user)

/obj/item/device/hacktool/interact(mob/user)
	if(!user)
		user << "What the? Who are you?"
		return

	if(!isliving(user) || user.stat || user.restrained() || user.lying)
		user << "Just.... can't.... reach...."
		return

	else
		injectid = input(user,"Enter Gate ID", "Name change",injectid) as text
		user.visible_message("<span class='notice'>[user] reconfigures the Eldar device.</span>", "<span class='notice'>Resetting interface device.</span>", "<span class='warning'>You can't see shit.</span>")