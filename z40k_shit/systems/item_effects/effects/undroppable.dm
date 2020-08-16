/datum/item_artifact/undroppable
	name = "Undroppable Item"
	desc = "Curses the item so that any victim who tries to pick it up will not be able to drop it, as it will be stuck to them."
	charge = 200
	compatible_mobs = list()

/datum/item_artifact/undroppable/item_init(var/obj/item/O)
	O.canremove = FALSE
	..()

/datum/item_artifact/undroppable/neutralize_obj(var/obj/item/O)
	O.canremove = TRUE
	..()
	