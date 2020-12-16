/*
TODO: Datums + Requirements
*/

/datum/manufacturing_recipe
	var/name = "Manufacturing Recipe"
	var/list/requirements = list() //List of requirements
	var/obj/item/end_result = null //End item

/datum/manufacturing_recipe/gear
	name = "Gear"
	requirements = list(/obj/item/stack/sheet/metal = 5)
	end_result = /obj/item/manufacturing_parts/gear