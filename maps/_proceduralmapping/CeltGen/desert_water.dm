/obj/structure/radial_gen/cellular_automata/waterlake
	name = "water lake"
	ca_wall = /turf/unsimulated/outside/sand
	mapgrid_width = 10 // 10 - THIS SHOULD BE THE TOTAL WIDTH IT CAN GENERATE TO
	mapgrid_height = 10 // 5 - THIS SHOULD BE THE TOTAL HEIGHT IT CAN GENERATE TO
	mapgrid_scale = 5 // 2 - THIS SHOULD BE HOW LIKELY IT IS TO GET TO IT

/obj/structure/radial_gen/cellular_automata/waterlake/makefloor(var/turf/unsimulated/outside/sand/T)
	if(T)
		T.clear_contents(list(type))
		var/obj/waterpatch/WP = new /obj/waterpatch(T,icon_update_later = 1)
		list_of_turfs += WP

/obj/structure/radial_gen/cellular_automata/waterlake/apply_mapgrid_to_turfs(var/turf/bottomleft)
	..()
	for(var/obj/waterpatch/WP in list_of_turfs)
		WP.relativewall()

/obj/waterpatch
	desc = "Some blue shit that might be water."
	icon = 'icons/turf/ice.dmi'
	icon_state = "ice1"
	anchored = 1
	density = 1
	plane = PLATING_PLANE
	var/isedge

/obj/waterpatch/canSmoothWith()
	return list(/obj/waterpatch)

/obj/waterpatch/New(var/icon_update_later = 0)
	var/turf/unsimulated/outside/sand/T = loc
	if(!istype(T))
		qdel(src)
		return
	..()
	if(icon_update_later)
		relativewall()
		relativewall_neighbours()

/obj/waterpatch/relativewall()
	overlays.Cut()
	var/junction = 0
	isedge = 0
	var/edgenum = 0
	var/edgesnum = 0
	for(var/direction in alldirs)
		var/turf/adj_tile = get_step(src, direction)
		var/obj/waterpatch/adj_waterpatch = locate(/obj/waterpatch) in adj_tile
		if(adj_waterpatch)
			junction |= dir_to_smoothingdir(direction)
			if(adj_waterpatch.isedge && direction in cardinal)
				edgenum |= direction
				edgesnum = adj_waterpatch.isedge
	if(junction == SMOOTHING_ALLDIRS) // you win the not-having-to-smooth-lotterys
		icon_state = "ice[rand(1,6)]"
	else
		switch(junction)
			if(SMOOTHING_L_CURVES)
				isedge = junction
				relativewall_neighbours()
		icon_state = "junction[junction]"
	if(edgenum && !isedge)
		icon_state = "edge[edgenum]-[edgesnum]"

/obj/waterpatch/relativewall_neighbours()
	..()
	for(var/direction in diagonal)
		var/turf/adj_tile = get_step(src, direction)
		if(isSmoothableNeighbor(adj_tile))
			adj_tile.relativewall()
		for(var/atom/A in adj_tile)
			if(isSmoothableNeighbor(A))
				A.relativewall()

