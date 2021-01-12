/datum/map_allocator
	var/iterations = 0 //We allocate 20 turfs per iteration

/datum/map_allocator/proc/allocate_region()
	iterations++