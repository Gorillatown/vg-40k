/*/Can_enlarge determines whether we clamp by edgelimit or it just extends the map.
//Border_range determines additional distance from edges on all sides 

//Variables as of 1/8/2020

------Moving them in relation to the borders this amount of tiles.---

border_range_x = 0 	//EX: 20 means we will move 20 turfs away for better or worse
border_range_y = 0 	//EX: -20 Means we will move 20 turfs closer, but not into the boundary.

-----We move them this amount of distance in relation to each other
spawn_distance = 0 	//EX: -20/20 Means 20 closer or further. 

---This being true means template 2 can overwrite template 1------
spawn_overwrite = TRUE

----These basically let you set a boundary box/rectangle that the spawns can occur in---
spawn_max_x = 0 	//Is world.maxx by default - Furthest Right we go
spawn_max_y = 0 	//Is world.maxy by default - Furthest North we go
spawn_min_x = 0 	//Is 1 by default - Furthest left we go
spawn_min_y = 0 	//Is 1 by default - Furthest south we go

-----------------Spawn Templates-------------
Basically the load order, and what actually spawns in for the templates.
spawn_template_1 = /datum/map_element/vault/bases/test_ig_spawn
spawn_template_2 = /datum/map_element/vault/bases/test_ork_spawn

-----String entries for preset spawn alignments------
|-"horizontals" - Basically are opposing north and south|
|-"verticals" - Basically opposing east and west|
|-"random" - Random for better or worse|

	spawn_alignment = "horizontals"

-----Toggles startup coordinate debugging-----
	dd_debug = TRUE
*/
/datum/loada_gen/proc/loada_spawns()
	var/datum/map_element/ME //Map Element 1
	var/datum/map_element/MEOP //Map Element 2
	
	/*
	var/s1_z1_coord = 1 //Z level will always be 1
	var/s1_x1_coord = 0 //Holder for calculated x - horizontal
	var/s1_y1_coord = 0 //Holder for calculated y - vertical

	var/s2_z2_coord = 1 //Placement of the opposing template
	var/s2_x2_coord = 0 //X 1
	var/s2_y2_coord = 0 //Y 1
	*/

	//Center with changes to it picks which side to draw from
	var/center_x = round(world.maxx/2) //EX: 200/2 = 100
	var/center_y = round(world.maxy/2) //Exact center of a whole map.
	var/exact_center = locate(center_x,center_y,1)

	//Primary Placement coordinates for the origin position on the map.
	var/primary_x1 = 1 //the main X value sent through
	var/primary_y1 = 1 //the main Y value sent through
	
	var/primary_x2 = 1 //The opposing template placement
	var/primary_y2 = 1 //The opposing template placement

	new /obj/effect/landmark/observer(exact_center) //Observer landmark appears at exact center
	new /obj/effect/landmark/latejoin(exact_center) //Latejoins appear in the center too
	new /obj/effect/landmark/newplayerstart(exact_center) //Might as well try putting the start in the center too

	ME = new ASS.spawn_template_1 //This needs unhardcoded later anyways
	
	MEOP = new ASS.spawn_template_2 //The opposing map element
	
	var/list/template_dimensions = ME.get_dimensions() //Gets dimensions of template, assigns them to vars
	var/template_x1 = template_dimensions[1] //Max horizontal Dimension of the template we have
	var/template_y1 = template_dimensions[2] //Max vertical Dimension
	
	var/list/template_dimensions1 = MEOP.get_dimensions() //Secondary Template dimensions.
	var/template_x2 = template_dimensions1[1]
	var/template_y2 = template_dimensions1[2]
	
	//We start counting from the bottom left, so the maximum number is our boundary and min is static at 1
	var/edgelimit_max_x1 = (world.maxx - template_x1) - ASS.border_range_x //How far we are from right
	var/edgelimit_max_y1 = (world.maxy - template_y1) - ASS.border_range_y //How far we are from north
	var/edgelimit_min_x1 = 1 + ASS.border_range_x //How far we are from left side
	var/edgelimit_min_y1 = 1 + ASS.border_range_y //How far we are from bottom

	var/edgelimit_max_x2 = (world.maxx - template_x2) - ASS.border_range_x //How far we are from right
	var/edgelimit_max_y2 = (world.maxy - template_y2) - ASS.border_range_y //How far we are from north

	if(ASS.spawn_min_x > 0) //If Spawn_max_x is greater than 0 we no longer use def center_x
		center_x = ASS.spawn_min_x + (ASS.spawn_min_x/2) //EX: 100 to 200 is our coordinates
		edgelimit_min_x1 = ASS.spawn_min_x + ASS.border_range_x //Our edgelimit is now
	if(ASS.spawn_min_y > 0) //If spawn_max_y is greater than 0 we no longer use def center_y
		center_y = ASS.spawn_min_y + (ASS.spawn_min_y/2) //EX: 100 + (100/2) = 150. Center of 100 to 200
		edgelimit_min_y1 = ASS.spawn_min_y + ASS.border_range_x
	if(ASS.spawn_max_x > 0)
		edgelimit_max_x1 = (ASS.spawn_max_x - template_x1) - ASS.border_range_x
		edgelimit_max_x2 = (ASS.spawn_max_x - template_x1) - ASS.border_range_x
	if(ASS.spawn_max_y > 0)
		edgelimit_max_y1 = (ASS.spawn_max_x - template_x1) - ASS.border_range_y
		edgelimit_max_y2 = (ASS.spawn_max_x - template_x1) - ASS.border_range_y

	//Spawn Alignments
	if(ASS.spawn_alignment)
		switch(ASS.spawn_alignment)
			if("horizontals")
				primary_x1 = rand(1, world.maxx) //We are between 1 and world max on horizontal
				primary_y1 = rand(1, round(world.maxy/4)) //We are somewhere in 1/4th of the world max vertical

			if("verticals")
				primary_x1 = rand(1, round(world.maxx/4)) //Somewhere in 1/4th of world max horizontal
				primary_y1 = rand(1,world.maxy) //We are between 1 and world max on vertical
				
			if("random")
				primary_x1 = rand(1, world.maxx)
				primary_y1 = rand(1, world.maxy)
							
				primary_x2 = rand(1,world.maxx)
				primary_y2 = rand(1,world.maxy)

	//Symmetrical Mirror Placement + Distance between both var Adjustment.
	var/h1 = primary_x1 - world.maxx
	var/h2 = primary_y1 - world.maxy
	
	if(primary_x1 > center_x) //If Primary X1 is further to right than center
		primary_x1 = primary_x1 - ASS.spawn_distance //169 = 169 - 20 = 149 in comparison to 51
		primary_x2 = (world.maxx - primary_x1) + ASS.spawn_distance//EX: 200 - 169 = 31 + 20 = 51
	else //If Primary X1 is closer to left than center
		primary_x1 = primary_x1 + ASS.spawn_distance
		primary_x2 = (primary_x2 - h1) - ASS.spawn_distance //X2 = 0 - -160 = 160 - 20
	if(primary_y1 > center_y) //If Primary Y1 is further north than center
		primary_y1 = primary_y1 - ASS.spawn_distance
		primary_y2 = (world.maxy - primary_y1) + ASS.spawn_distance
	else //If Primary Y1 is further south than center
		primary_y1 = primary_y1 + ASS.spawn_distance
		primary_y2 = (primary_y2 - h2) - ASS.spawn_distance

	 //If we don't want the templates to overwrite each other.
	 //Our edgelimit is 169 + 20 since we are spawning to the right thusly... 189.
	var/edgelimit_min_x2 = primary_x1 + template_x1 //EX: 169 + 20 = 189
	var/edgelimit_min_y2 =  primary_y1 + template_y1 //EX: 50 + 20 = 70
	
		//These only occur if spawn_overwrite = FALSE
	if((edgelimit_min_x2 + template_x2) > world.maxx) //If our min goes over world maximum x with template tho
		edgelimit_min_x2 = primary_x1 - template_x2 //EX: (190 + 20) = 210 > 200. Then MX2 = 190 - 20 = 170
	if((edgelimit_min_y2 + template_y2) > world.maxy) //That means we end up to the left of the other template.
		edgelimit_min_y2 = primary_x1 - template_y2 //In this scenario I think.

	//Since we start at the bottom left corner
	if(!ASS.can_enlarge) //Can enlarge is false, so template deletes if it can't fit
		s1_x1_coord = clamp(primary_x1, edgelimit_min_x1, edgelimit_max_x1) //x coord is rng clamped between 1 and edgelimit x
		s1_y1_coord = clamp(primary_y1, edgelimit_min_y1, edgelimit_max_y1)
		ME.load(s1_x1_coord, s1_y1_coord, s1_z1_coord)
		CHECK_TICK

		if(ASS.spawn_overwrite) //If we can overwrite
			s2_x2_coord = clamp(primary_x2, edgelimit_min_x1, edgelimit_max_x2)
			s2_y2_coord = clamp(primary_y2, edgelimit_min_y1, edgelimit_max_y2)

			CHECK_TICK
			MEOP.load(s2_x2_coord, s2_y2_coord, s2_z2_coord)
		else //if spawn_overwrite = FALSE
			if(edgelimit_min_x2 > edgelimit_max_x2) //If we end up greater than the max
				s2_x2_coord = clamp(primary_x2, edgelimit_max_x2, edgelimit_min_x2) //Then we start from the max and clamp to min
			if(edgelimit_min_y2 > edgelimit_max_y2)
				s2_y2_coord = clamp(primary_y2, edgelimit_max_y2, edgelimit_min_y2)
			MEOP.load(s2_x2_coord, s2_y2_coord, s2_z2_coord)
		
	if(ASS.dd_debug)
		log_startup_progress("-------------TEMPLATE 1---------------")
		log_startup_progress("[ME] spawned at coordinates X:[s1_x1_coord], Y:[s1_y1_coord], Z:[s1_z1_coord]")
		log_startup_progress("Edgelimit Max X:[edgelimit_max_x1], Edgelimit Max Y:[edgelimit_max_y1].")
		log_startup_progress("Edgelimit Min X:[edgelimit_min_x1], Edgelimit Min Y:[edgelimit_min_y1].")
		log_startup_progress("Template X1: [template_x1], Template Y1: [template_y1]")
		log_startup_progress("Primary X1: [primary_x1], Primary Y1: [primary_y1]")
		
		log_startup_progress("-------------NEUTRAL VARS---------------")
		log_startup_progress("World Max X:[world.maxx], World Max Y:[world.maxy]")
		log_startup_progress("World Center X:[center_x], World Center Y:[center_y]")
		log_startup_progress("Spawn Alignment: [ASS.spawn_alignment], Spawn Distance: [ASS.spawn_distance]")
		log_startup_progress("Spawn Overwrite: [ASS.spawn_overwrite]")

		log_startup_progress("-------------CALCULATED VARS---------------")
		log_startup_progress("Holder 1: [h1], Holder 2: [h2]")

		log_startup_progress("-------------TEMPLATE 2---------------")
		log_startup_progress("[MEOP] spawned at coordinates X:[s2_x2_coord], Y:[s2_y2_coord], Z:[s2_z2_coord]")
		log_startup_progress("Edgelimit Max X2:[edgelimit_max_x2], Edgelimit Max Y2:[edgelimit_max_y2]")
		log_startup_progress("Edgelimit Min X2:[edgelimit_min_x2], Edgelimit Min Y2:[edgelimit_min_y2]")
		log_startup_progress("Template X2: [template_x2], Template Y2: [template_y2]")
		log_startup_progress("Primary X2: [primary_x2], Primary Y2:[primary_y2]")