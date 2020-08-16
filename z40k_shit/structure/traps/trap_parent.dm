//What were you expecting more? Its a fuckin sorting typepath, 
//and a stopgap for insertion of shit
var/global/list/map_traps = list()

/obj/structure/traps
	name = "Traps"
	var/tied_id = "" //The ID we check for on the button proc to check IDs
	var/always_activate = FALSE //Whether every press activates this. Its for puzzles a fterall
	var/currently_active = FALSE //Whether we are currently lethal, aka active.
	
	/*
		I've decided to keep this seperate from tied_id for now
		Since we are just firing lists in numerical order on the parent.
	*/
	var/scenario_controller_timing = FALSE //Are we tied to the map scenario controller for timing?
	var/scenario_controller_id = 0 //If so what number are we tied to? 

/obj/structure/traps/New()
	..()
	map_traps += src

/obj/structure/traps/Destroy()
	..()
	map_traps -= src

/obj/structure/traps/update_icon()
	return

/*
	The button runs this proc when its hit and the tied_id on the trap 
	is the same as the activate_id on the switch.
*/
/obj/structure/traps/proc/turn_my_ass_over()
	return