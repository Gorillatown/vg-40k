/datum/item_artifact/shield
	name = "Shield Item"
	desc = "Blesses an item to repell projectiles."
	charge = 200
	compatible_mobs = list()

/datum/item_artifact/shield/item_init(var/obj/item/O)
	O.shield_item = 1
	..()
/datum/item_artifact/shield/neutralize_obj(var/obj/item/O)
	O.shield_item = 0
	..()
