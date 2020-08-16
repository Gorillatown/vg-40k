/*
	Basically a counter teleporter.
	We ref the map_scenario_controller
*/
/obj/effect/step_trigger/teleporter/counter
	teleport_x = 0	// teleportation coordinates (if one is null, then no teleport!)
	teleport_y = 0
	teleport_z = 0

/obj/effect/step_trigger/teleporter/Trigger(var/atom/movable/A)
	if(teleport_x && teleport_y && teleport_z)
		A.x = teleport_x
		A.y = teleport_y
		A.z = teleport_z
