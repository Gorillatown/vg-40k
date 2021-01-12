/area/kustom_vehicle
	name = "Kustom Vehicle"
	icon = 'F_40kshit/icons/40kareas.dmi'
	icon_state = "kustom_vehicle"
	var/obj/structure/experimental_custom_vehicle/our_vehicle = null

/obj/effect/overlay/viewport_holder
	name = "Shiiet"
	invisibility = 101

/obj/effect/overlay/fancy_map_reimage
	name = "Fancy Screen Object"
	desc = "Shiiiet"


/*
	Design Draft 1/11/2021

	How it will work, is we will first grab a segment of like another z-level to spawn shit into.
	This will occur in relation to objects around the experimental_custom_vehicle main segment.
	Safe limit will be 10 apart from the next area segment.
	The area will be placed over the turfs, and tied to the vehicle.


*/
/obj/structure/experimental_custom_vehicle
	name = "Experimental Kustom"
	desc = "A vehicle, made out of parts."
	icon = 'F_40kshit/icons/complex_vehicle/kustom_vehicle.dmi'

	var/obj/structure/custom_parts/engine/our_engine = null
	var/obj/structure/custom_parts/fueltank/our_fueltank = null
	
	//These two need to be positioned adequately in relation to each other.
	//Since the images start at the center of the screen.
	var/obj/effect/overlay/viewport_holder/viewport_holder = null
	var/list/map_image_objects = list()
	var/turf/start_position = null
	
	//This keeps track of how far we have built from the bottom relatively.
	var/current_height = 0
	var/current_width = 0

/*
	This is particularly high risk, since right now we are saving memory/effort by using z2
	Which already houses a veritable amount of shit.
*/
/obj/structure/experimental_custom_vehicle/New()
	..()
	
	var/the_x = 2
	var/the_y = 2+(map_allocator.iterations*10)
	if(map_allocator.iterations >= 20)
		the_x = 12
	start_position = locate(the_x,the_y,2)
	map_allocator.iterations++

/*
	Because we are letting people build them segment by segment
	We need to be able to regrab the map overlay
*/
/obj/structure/experimental_custom_vehicle/proc/regrab_vis_contents()
	var/turf/end_position = locate(start_position+current_width, start_position+current_height, 2)
	for(var/turf/T in block(start_position, end_position)) //Its lower left and top right
		var/obj/effect/overlay/fancy_map_reimage/ass = new()
		ass.screen_loc = "CENTER,CENTER"
		ass.vis_contents = list(T)
		map_image_objects += ass
