/*
	Parts Datum
*/


/datum/comvehicle_parts
	var/obj/com_vehicle/my_atom //Holder for what spawned our asses
	var/list/equipment_systems = list() //Container of all the equipment we currently have.
	var/list/action_storage = list() //Container of all the actions we currently have.
	var/list/extra_actions = list() //A container of duplicate actions granted to extra users.
	var/total_weight = 0

/datum/comvehicle_parts/Destroy()
	action_clean_up()
	for(var/obj/item/vehicle_parts/equipment in equipment_systems)
		equipment.forceMove(my_atom.loc)
		equipment.throw_at(get_edge_target_turf(my_atom.loc, pick(alldirs)), 7, 30)
	..()

/*
Proc call vars. - Attachment Master
	(1) mob/user - a mob.
	(2) obj/item/device/vehicle_equipment/equipment - the equipment in question
*/
/datum/comvehicle_parts/proc/parts_insertion(mob/user, obj/item/vehicle_parts/equipment)
	equipment_systems += equipment //We add equipment to our equipment list
	equipment.forceMove(my_atom)
	equipment.my_atom = my_atom
	
	if(equipment.tied_action) //If equipment has a tied action.
		var/datum/action/linked_parts_buttons/equipment_action = new equipment.tied_action(my_atom) //new abstract construct spawned into massa obj.
		action_storage += equipment_action

		spawn(1)
			equipment_action.id = equipment.id //The actions ID is now the objects ID, tying them together.

		if(user) //If we have a massa man
			equipment_action.Grant(user) //grant him our equipment_action.

		if(!equipment_action.pilot_only)
			var/theuser
			if(my_atom.occupants.len > 1)
				for(var/i=1 to my_atom.occupants.len)
					if(i==1)
						continue
					theuser = my_atom.occupants[i]
					var/datum/action/fuck = new equipment_action.type(my_atom)
					extra_actions += fuck
					fuck.Grant(theuser)
	
	my_atom.handle_parts_overlays()

//Unlike the insertion, we do not move it to any loc due to the variations that can occur of removal.
/datum/comvehicle_parts/proc/parts_removal(mob/user, obj/item/vehicle_parts/equipment)
	equipment.my_atom = null //you don't got no atom equipment.
	equipment_systems -= equipment //and you leavin our equipment_systems
	
	var/located_equipment = locate(equipment.tied_action) in action_storage
	if(located_equipment)
		action_storage -= located_equipment
		var/datum/action/ARSE = located_equipment
		if(user)
			ARSE.Remove(user) //And I'm removing your ass too.

		if(extra_actions.len) //If extra actions has length
			for(var/i=1 to my_atom.occupants.len) //for var i=1 to len of occupants on master src
				if(i==1) //While we are on 1 we just continue
					continue

				var/extra_action_locate = locate(equipment.tied_action) in extra_actions //We find the tied action in extra actions
				if(extra_action_locate) //If we find it
					var/datum/action/ASS = extra_action_locate //We assigned it to the action var
					extra_actions -= located_equipment //We remove the extra actions of the located equipment
					var/other_users = my_atom.occupants[i] //Other user is in the occupants iteration
					ASS.Remove(other_users) //We remove the action from them too.

	my_atom.handle_parts_overlays()

/datum/comvehicle_parts/proc/action_clean_up()
	for(var/datum/action/linked_parts_buttons/equipment_action in action_storage)
		qdel(equipment_action)

	for(var/datum/action/linked_parts_buttons/equipment_action in extra_actions)
		qdel(equipment_action)

	my_atom.handle_parts_overlays()

