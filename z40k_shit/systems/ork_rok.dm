var/global/datum/shuttle/ork_rok/ork_rok = new(starting_area = /area/shuttle/ork_rok/start)

/datum/shuttle/ork_rok
	name = "ork rok"
	can_link_to_computer = LINK_FREE
	cooldown = TRADE_SHUTTLE_COOLDOWN
	transit_delay = 5 MINUTES //Once somebody sends the shuttle, it waits for 3 seconds before leaving. Transit delay is reduced to compensate for that
	pre_flight_delay = 30
	cooldown = 200
	stable = 0 //Don't stun everyone and don't throw anything when moving
	can_rotate = 1 //Sleepers, body scanners and multi-tile airlocks aren't rotated properly
	destroy_everything = 0 //The cargo shuttle should never be cancelled because of something in the way

/datum/shuttle/ork_rok/initialize()
	.=..()
	add_dock(/obj/docking_port/destination/ork_rok/starting_zone)
	add_dock(/obj/docking_port/destination/ork_rok/landing_zone)
	set_transit_dock(/obj/docking_port/destination/ork_rok/transit)

/obj/machinery/computer/shuttle_control/ork_rok
	icon_state = "syndishuttle"
	light_color = LIGHT_COLOR_RED
	machine_flags = EMAGGABLE //No screwtoggle because this computer can't be built

/obj/machinery/computer/shuttle_control/ork_rok/New() //Main shuttle_control code is in code/game/machinery/computer/shuttle_computer.dm
	link_to(ork_rok)
	.=..()

//code/game/objects/structures/docking_port.dm

/obj/docking_port/destination/ork_rok/landing_zone
	areaname = "landing zone"

/obj/docking_port/destination/ork_rok/transit
	areaname = "planetfall (ork rok)"

/obj/docking_port/destination/ork_rok/starting_zone
	areaname = "starting zone"
	require_admin_permission = 1
 
 //------Shuttles or some shit--------//
/area/shuttle/ork_rok/start
	name = "starting zone"
	icon = 'z40k_shit/icons/40kareas.dmi'
	icon_state = "ork_rok"


