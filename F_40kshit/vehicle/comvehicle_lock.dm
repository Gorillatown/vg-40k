/datum/locking_category/complex_vehicle


/obj/complex_vehicle/lock_atom(var/atom/movable/AM, var/datum/locking_category/category)
	. = ..()
	if(!.)
		return

	AM.layer = layer + 0.1
	AM.plane = plane

/obj/complex_vehicle/unlock_atom(var/atom/movable/AM, var/datum/locking_category/category)
	. = ..()
	if(!.)
		return

	AM.reset_plane_and_layer()

