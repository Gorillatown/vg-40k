
//Just makes some lakes
/datum/loada_gen/proc/loada_lakes3()
	CreateDeeps()
	CreateShallows()
	
	if(ASS.dd_debug)
		log_startup_progress("LAKE LOADA 3 INITIATED")

//Creates a river
/datum/loada_gen/proc/loada_rivers1()
	CreateRiver()
	
	if(ASS.dd_debug)
		log_startup_progress("RIVER LOADA 1 INITIATED")

//Creates a river that goes to a lake.
/datum/loada_gen/proc/loada_river2lake1()
	CreateRiver2Lake()
	CreateShallows()

	if(ASS.dd_debug)
		log_startup_progress("RIVER 2 LAKE LOADA INITIATED")



