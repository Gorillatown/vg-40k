/obj/road_node
	name = "Road Node"
	desc = "The roadest of nodes"
	icon = 'z40k_shit/icons/abstract_markers.dmi'
	icon_state = "road_node"
	alpha = 255
	invisibility = 101
	mouse_opacity = 0

/obj/road_node/New()
	..()
	road_nodes += src

/obj/road_node_stepper
	name = "Road Nodeliner"
	desc = "He a bad boy"
	density = 1

//For now we will just path from a center to everything else.
//Road_node is spawned in the center and appended to this list in like the village loada atm.
//So the sun will always be number 1, and its trails are afterwards.

//A list for road_nodes
var/list/road_nodes = list()

/datum/loada_gen/proc/loada_roadsystem()
	if(road_nodes.len)
		if(ASS.dd_debug)
			log_startup_progress("Roadnodes: [road_nodes.len]")

		if(road_nodes.len)
			for(var/obj/road_node/move_bitch in road_nodes) //First we need to move our boys off the fuckin doors.
				var/tries = 0
				for(var/d in cardinal) //We check the cardinal directions.
					tries++
					var/turf/T = get_step(move_bitch, d)
					if(istype(T,/turf/unsimulated/outside/sand)) //If its outside
						move_bitch.loc = T //We relocate our boy there
						break //And break
					if(tries >= cardinal.len) //If our tries is greater than or equal to 4
						road_nodes -= move_bitch //We remove the current node from road_nodes
						qdel(move_bitch) //We delete it
						break //And then just break the inner loop

			var/obj/road_node/numba_won = road_nodes[1]
			var/obj/road_node_stepper/big_steppy = new(numba_won.loc)
			road_nodes -= numba_won
			qdel(numba_won)
			var/pathing = TRUE
			var/sanity = 0
			while(pathing)
				if((road_nodes.len) && (200 > sanity))
					var/obj/road_node/current_target = road_nodes[1]
					if(get_dist(big_steppy,current_target) > world.view*2)
						var/turf/T = get_step(big_steppy,get_dir(big_steppy,current_target))
						if(T && T.density)
							step_rand(big_steppy)
						else if(dense_obj_chek(T))
							step_rand(big_steppy)
						else
							step_towards(big_steppy,current_target)
					else
						var/turf/T = get_step(big_steppy,get_dir(big_steppy,current_target))
						if(T && T.density)
							step_to(big_steppy,current_target)
						else if(dense_obj_chek(T))
							step_to(big_steppy,current_target)
						else
							step_towards(big_steppy,current_target)
					var/turf/T1 = get_turf(big_steppy)
					T1.ChangeTurf(/turf/unsimulated/outside/footpath)
					if(big_steppy.loc == current_target.loc)
						road_nodes -= current_target
						qdel(current_target)
						sanity = 0
						if(ASS.dd_debug)
							log_startup_progress("Ding we hit a path change at. X:[big_steppy.x], Y:[big_steppy.y]")
					sanity++
				else
					pathing = FALSE
					break
				sleep(world.tick_lag) //repeat every tick so the loop will end immediately on state change


	else
		warning("Roadnodes appear to be fucked up. Contact jtgsz#6921.")

/datum/loada_gen/proc/dense_obj_chek(var/turf/T)
	var/obstruction = FALSE
	for(var/atom/A in T)
		if(A.density)
			obstruction = TRUE
			break
	if(obstruction)
		return 1
	//TODO: 5/2/2020 - Roadnode system.
	//For now I'll just place the nodes tho.