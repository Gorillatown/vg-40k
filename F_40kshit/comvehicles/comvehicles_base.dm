/obj/complex_vehicle_system
	name = "Complex Vehicle Chassis"
	desc = "A chassis for a vehicle of some sort."
	icon = 'F_40kshit/icons/complex_vehicle/Leman_Russ_128x128.dmi'
	density = 1 //Dense
	opacity = 0
	anchored = 1
	internal_gravity = 1 // Can move in 0-gravity
	layer = VEHICLE_LAYER
	plane = ABOVE_HUMAN_PLANE
	
/*********************************
Comvehicle Parts - 
	Basically holds all the equipment, and 
	will also store values/calculate stuff for us
	etc.
***********************************/
	var/datum/comvehicle_parts/comvehicle_parts = null
	
/obj/complex_vehicle_system/New()
	..()
	comvehicle_parts = new(src)

/obj/complex_vehicle_system/Destroy()
	qdel(comvehicle_parts)
	comvehicle_parts = null
	..()