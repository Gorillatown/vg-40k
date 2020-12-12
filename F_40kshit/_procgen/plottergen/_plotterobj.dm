/*

     NW(9)  N(1) NE(5)
		\	|   /
W(8)---- *****  ---- E(4)
		/	|	\
   SE(6)  S(2)  SW(10)

*/


/*
	BAD PLOTTER
				*/

//Basically handles chunk generation
/obj/helper/badplotter/ //This is basically an object that moves around and does stuff on its own.
	name = "badplotter"
	desc = "he plottin somein real bad"
	density = 0
	var/list/cardinalDirs = list(1, 2, 4, 8)

/obj/helper/badplotter/proc/roam()
	var/newDir = pick(cardinalDirs)
	var/turf/T = get_step(src, newDir)
	if(T)
		loc = T

		if(istype(T, /turf)) //Nowe get all of them
			T = new /turf/unsimulated/outside/water/deep(T) 
			T = new /area/warhammer/water(T)
			return 1
/*
	BAD LINER
				*/

//Basically good for doing lines
/obj/helper/badliner
	name = "badliner"
	density = 0
	var/ballcurvature = FALSE //Are we curving?
	var/curveticker = 0 //how many ticks are we curving?
	var/balls2shaft = FALSE //If we are currently holding our curved direction?
	var/HUR_DUR //this where we currently headin, east if there be a fuckup

/*

     NW(9)  N(1) NE(5)
		\	|   /
W(8)---- *****  ---- E(4)
		/	|	\
   SW(6)  S(2)  SE(10)

*/															//Deviant is deviation.
/obj/helper/badliner/proc/roam2node(var/node, var/deviant) //Node is the node it roams to
	var/turf/BALLS = get_turf(src)//THIS PROC SUCKS BALLS - where we at.
	var/turf/NODEGOAL = get_turf(node) //where we wanna be
	//var/turf/NODEGOALDIR = get_dir(BALLS, NODEGOAL) //This is the direction to get where we wanna be

	//After having fucked with just doing this by coordinates, now im trying directions.
	//Basically it was becoming very hard to read doing riverbends.
	//Yeah now we resemble lavariver shit more, this still needs redone at some point tho to be gradual.


	if(ballcurvature) //CURVING SEGMENT 1 DIAGONAL FROM LINE
		if(prob(20))
			ballcurvature = FALSE
			HUR_DUR = get_dir(BALLS, NODEGOAL)
	else if(prob(20))
		ballcurvature = 1
		if(prob(50))
			HUR_DUR = turn(HUR_DUR, 45) //we go to a diagonal
		else
			HUR_DUR = turn(HUR_DUR, -45) //either direction
	else
		HUR_DUR = get_dir(HUR_DUR, NODEGOAL)

	step(src, HUR_DUR)

	//We step to the current direction
	//step(src, HUR_DUR) //This replaces us just setting our location to BALLS
	
	for(var/turf/T in orange(1,src))
		if(!istype(T, /turf/unsimulated/outside/water/deep)) //No density check, WE CUTTIN THRU
			T.ChangeTurf(/turf/unsimulated/outside/water/deep)
			T.set_area(/area/warhammer/water)

/*
	NODE LINER
				*/

//Basically a node helper for badliner
/obj/helper/nodeliner
	name = "nodeliner"
	desc = "he a badboy"
	density = 0

