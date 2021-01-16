/*
	Vehicle Parts Parent

Procs
	New() - Called on new, currently handles giving it a random number as a ID.
	Destroy() - Clears references
	action() - Called on Click Action Handler in a loop, the part performs its action

*/
/obj/item/vehicle_parts
	name = "equipment"
	icon = 'F_40kshit/icons/complex_vehicle/vehicle_equipment.dmi'
	var/datum/action/linked_parts_buttons/tied_action //The action button tied to the object
	var/obj/my_atom //Basically the object we are attached to.
	var/id			//The ID we share with our action button if we have one.
	var/parts_weight = 0 //Basically this is basically how much a part weighs.
	var/systems_online = FALSE //Is the system currently toggled to be online?
	var/obj/effect/overlay/vis_con_overlay = null //A attached overlay

//Our ID is tied to the action button ID. Theoretically theres a 1 in 10000 chance for a magic button.
/obj/item/vehicle_parts/New()
	..()
	id = rand(1, 10000)

/obj/item/vehicle_parts/Destroy()
	my_atom = null
	..()

//Basically when you click with the switch toggled on, it performs this proc.
/obj/item/vehicle_parts/proc/action(atom/target)
	return 0