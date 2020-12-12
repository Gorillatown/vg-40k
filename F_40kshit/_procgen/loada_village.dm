/*
	Basically this proc generates a small town out of tempaltes in a block.

*/
//Basically we want to be far away from spawn 2 or whatever the ork spawn is.
//So we will be on the side the IG are on, but we will be opposite from the y the ork base is.
/datum/loada_gen/proc/loada_village()
	var/amount_of_buildings = 5 //The amount of buildings we will pick.
	var/town_spread = 38 //The total amount of coordinates we have for use.

	//var/center_x = round(world.maxx/2) //EX: 200/2 = 100
	//var/center_y = round(world.maxy/2) //Exact center of a whole map.

	//Well now we need to calculate our placement block
	//Right now S2 is always going to be higher, and S1 is always going to be lower.
	//So we want to use the X of s1, and the Y of s2 since we don't want to be on the same line as orks

	var/block_x1 = 0 //Basically our bottom left corner coordinates.
	var/block_y1 = 0 //Equal on line with spawn 1, and 2.
	var/block_x2 = 0 //These will be the top right coordinates
	var/block_y2 = 0
	var/list/valid_turf_block = list() //Our list
	
	var/safelimit_x = (world.maxx-town_spread)
	var/safelimit_y = (world.maxy-town_spread)-100
	
	block_x1 = rand(1,safelimit_x)
	block_y1 = rand((s1_y1_coord+50),safelimit_y)

	block_x2 = block_x1 + town_spread
	block_y2 = block_y1 + town_spread

	//Center with changes to it picks which side to draw from
	//var/center_x = round(block_x2/2) //EX: 200/2 = 100
	//var/center_y = round(block_y2/2) //Exact center of a whole map.
	//var/exact_center = locate(center_x,center_y,1)

	//We spawn the first roadnode in the exact center of our block
	//var/obj/road_node/the_sun = new(exact_center)
	//road_nodes += the_sun //Then we add it to the list, the road pather is ran after this proc anyways.

	for(var/turf/T in block(locate(block_x1,block_y1,1), locate(block_x2,block_y2,1)))
		valid_turf_block += T
		//We add the turfs in the block to a list.

	if(ASS.dd_debug)
		log_startup_progress("------VILLAGE BLOCK COORDS---------------")
		log_startup_progress("Block_x1:[block_x1],Block_y1:[block_y1]")
		log_startup_progress("Block_x2:[block_x2],Block_y2:[block_y2]")
		log_startup_progress("VALID_TURF_BLOCK:[valid_turf_block.len]")
		log_startup_progress("Worldmaxx:[world.maxx],Worldmaxy:[world.maxy]")

	//So whats next? Well, we need to pick our templates.
	//Well now that we have our square, I need to pick out our templates.
	//We have 100 turfs to work with.
	//The key point is we need to make sure not to overwrite a previously placed building.
	//So we probably need to grab some dimensions, and we need a list of buildings that can appear.
	var/list/placed_structures = list()
	for(var/i=1 to amount_of_buildings) //We iterate var integer times atm.
		var/itme_shitcode = pick(village_templates)
		village_templates -= itme_shitcode
		var/datum/map_element/cur_sel = new itme_shitcode
		var/list/big_brain = valid_turf_block.Copy() //We got a copy of the valid turfs.

		if(i>1) //Now the real fun begins since we have hopefully loaded the first template.
			var/list/template_dimensions = cur_sel.get_dimensions()
			var/templ_x = template_dimensions[1]
			var/templ_y = template_dimensions[2]
	
			for(var/datum/map_element/isolator in placed_structures)
				var/turf/T = isolator.location //Bottom left of already placed structure
				var/turf/T2 = locate(T.x+isolator.width, T.y+isolator.height,T.z) //Top right.
				
				//We now draw a bigger box, mostly to stop overwriting old placements.
				var/turf/B1 = locate(T.x-templ_x+1,T.y-templ_y+1,T.z)
				var/turf/B2 = locate(T2.x+templ_x+1,T2.y+templ_y+1,T.z)
	
				big_brain.Remove(block(B1,B2)) //Now we remove all the invalid area from our list
	
			//We are back on the mainline again, heres some protection so we don't fuck ourselves.
			var/turf/P1
			if(big_brain.len)
				P1 = pick(big_brain) //Pick from our newly changed list.
			else
				break
		
			var/turf/P2 = locate(P1.x+templ_x,P1.y+templ_y,P1.z) //We now get the top right corner
			valid_turf_block.Remove(block(P1,P2)) //Remove it from the original big list

			placed_structures += cur_sel
			cur_sel.load(P1.x,P1.y,P1.z) // And we load the template.
			CHECK_TICK

			if(ASS.dd_debug)
				log_startup_progress("-------------VILLAGE TEMP [i]---------------")
				log_startup_progress("Coordinates:X:[P1.x],Y:[P1.y]")

		else
			//Now we need to load our first template in.
			var/turf/P1 = pick(valid_turf_block) //We pick a turf from the block list.
			var/list/template_dimensions = cur_sel.get_dimensions() //We get the dimensions returned to us in a list form.
			var/templ_x = template_dimensions[1] //List num 1 is X, we do this cause its not in the world yet.
			var/templ_y = template_dimensions[2] //List Num 2 is Y
			var/turf/P2 = locate(P1.x+templ_x,P1.y+templ_y,P1.z) //We have the bottom left and top right now.

			valid_turf_block.Remove(block(P1, P2))//These are no longer valid to spawn into.
	
			placed_structures += cur_sel
			CHECK_TICK
			//Now we can actually load the template.
			cur_sel.load(P1.x,P1.y,P1.z)

			if(ASS.dd_debug)
				log_startup_progress("-------------VILLAGE TEMP [i]---------------")
				log_startup_progress("Coordinates:X:[P1.x],Y:[P1.y]")

