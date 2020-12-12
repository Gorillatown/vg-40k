/obj/structure/ladder/chaosruin/ground 
	name = "ground"
	id = "slaaneshruin"
	height = 0

/obj/structure/ladder/chaosruin/higher
	name = "higher"
	id = "slaaneshruin"
	height = 1


/*
/obj/structure/ladder/chaosruin/initialize()
	scenario_ladders += src
	update_links()
*/
/*

	for(var/obj/structure/ladder/sokoban/ladder in scenario_ladders)
		//Entrance ladders are connected to previous level's exit ladder
		if(istype(ladder, /obj/structure/ladder/sokoban/entrance))
			ladder.id = "sokoban-[depth]"
			ladder.height = 1
		//Exit ladders are connected to next level's entrance ladder
		else if(istype(ladder, /obj/structure/ladder/sokoban/exit))
			ladder.id = "sokoban-[depth+1]"
			ladder.height = 0*/
