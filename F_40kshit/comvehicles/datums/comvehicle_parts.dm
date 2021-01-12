/datum/comvehicle_parts
	var/obj/my_atom //Holder for what spawned our asses
	
	var/list/plating = list()
	
	var/list/equipment_systems = list() //Container of all the interactive equipment we currently have.
	var/list/action_storage = list() //Container of all the actions we currently have.
	
	var/list/engines = list()
	var/list/fuel_tanks = list()
	
	// Due to obvious reasons, we are only allowing one of these.
	//As multiple transmissions basically means that power is going to each wheel at a seperate ratio etc.
	var/obj/item/comvehicle_parts/transmission/trans = null

	//This is how much total weight we have in parts currently appended for calculations.
	var/total_weight = 0

/datum/comvehicle_parts/New(obj/CV)
	..()
	if(istype(CV))
		my_atom = CV

/datum/comvehicle_parts/Destroy()
	my_atom = null
	..()

/datum/comvehicle_parts/proc/append_plating(var/obj/item/comvehicle_parts/armor_plating/the_plating, var/direction)
	the_plating.loc = src
	the_plating.soak_direction = direction
	plating += the_plating
	total_weight += the_plating.parts_weight

/datum/comvehicle_parts/proc/remove_plating(var/obj/item/comvehicle_parts/armor_plating/the_plating, var/direction)
	the_plating.loc = get_turf(my_atom)
	plating -= the_plating
	total_weight -= the_plating.parts_weight