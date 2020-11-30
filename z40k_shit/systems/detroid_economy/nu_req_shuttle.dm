var/global/datum/shuttle/nu_req_shuttle/nu_req_shuttle = new(starting_area = /area/shuttle/nu_req_shuttle)

//The Area
/area/shuttle/nu_req_shuttle
	name = "requisition shuttle"
	icon_state = "shuttle3"

//Docking ports
/obj/docking_port/destination/nu_req_shuttle/off_map
	areaname = "off-map loading bay"

/obj/docking_port/destination/nu_req_shuttle/on_map
	areaname = "on-map bay"

//Shuttle datum
/datum/shuttle/nu_req_shuttle
	name = "Supply Delivery"

	var/obj/docking_port/destination/dock_offmap
	var/obj/docking_port/destination/dock_onmap

	pre_flight_delay = 0 
	destroy_everything = 1 
	cooldown = 0
	stable = 1 

	var/in_transit = FALSE 
	var/off_station = TRUE

	var/time_to_departure = 90
	var/list/shipping_manifest = list() //List of objects being shipped. Spawns em all before it heads out.
	var/list/to_ship = list()
	var/max_capacity = 0 //If we are at max capacity

/datum/shuttle/nu_req_shuttle/New()
	..()

/datum/shuttle/nu_req_shuttle/initialize()
	. = ..()
	dock_offmap = add_dock(/obj/docking_port/destination/nu_req_shuttle/off_map)
	dock_onmap = add_dock(/obj/docking_port/destination/nu_req_shuttle/on_map)

/datum/shuttle/nu_req_shuttle/is_special()
	return 1

/datum/shuttle/nu_req_shuttle/proc/transit_time()
	if(in_transit)
		return 0
	if((off_station) && (!max_capacity))
		move_shuttle_objects()

	in_transit = TRUE
	scenario_process += src

/datum/shuttle/nu_req_shuttle/proc/sc_process()
	time_to_departure--
	
	if(time_to_departure <= 0)
		in_transit = FALSE

		if(off_station)
			move_to_dock(dock_onmap)
			time_to_departure = 60
			shipping_manifest.Cut()
			off_station = TRUE
		else
			move_to_dock(dock_offmap)
			remove_shuttle_objects() //Time to delete/process everything
			time_to_departure = 90
			off_station = FALSE

		scenario_process -= src

//This proc basically makes us delete everything in us when we leave the main map ppl r on.
/datum/shuttle/nu_req_shuttle/proc/remove_shuttle_objects()
	var/area/shuttle = linked_area //Mostly to let you know this exists.
	for(var/atom/movable/MA in shuttle)
		if(MA.anchored) //If its anchored, don't bother it aka the fucking lights/glass/grilles/doors
			continue
		else
			qdel(MA) //You could process selling items here, but for now we just want the labor of plebs.
	max_capacity = 0

//This proc basically moves everything on when we are off map and about to go to main map.
/datum/shuttle/nu_req_shuttle/proc/move_shuttle_objects()
	var/area/shuttle = linked_area
	if(!shuttle)
		return

	var/list/clear_turfs = list()
	for(var/turf/T in shuttle)
		if(T.density)
			continue
		var/contcount
		for(var/atom/A in T.contents)
			if(A.density)
				continue
			contcount++
		if(contcount)
			continue
		clear_turfs += T

	for(var/obj/structure/closet/crate/id_secure/deferred_crate in to_ship)
		if(clear_turfs.len)
			var/turf/pickedloc = clear_turfs[rand(1,clear_turfs.len)]
			deferred_crate.loc = pickedloc
			to_ship -= deferred_crate
			clear_turfs -= pickedloc
		else
			max_capacity = 1
			break

//This proc basically loads a crate up with whatever they buy, ofc we will have some params
//Said crate will be locked unless the specific ID is used to open it.
//A personal note is there is a datum on the id, we could move it to be possible on anything tbqh.
//But the first argument is the ID, and the second argument is the req datum of the object bought.
/datum/shuttle/nu_req_shuttle/proc/buy_objects(var/obj/item/weapon/card/id/credstick, var/datum/requisition_buyable/bought_obj)
	var/obj/structure/closet/crate/id_secure/current_crate = new()
	to_ship += current_crate
	current_crate.id_ref = credstick
	current_crate.desc = "This order is registered to a identification of [credstick.registered_name]"
	var/obj/the_obj = bought_obj.object
	if(the_obj)
		the_obj = new (current_crate)
		shipping_manifest += "[the_obj.name] registered to [credstick.registered_name]"
	else
		message_admins("[bought_obj] HAS NO OBJECT PATH")
