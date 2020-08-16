/turf/unsimulated/outside/smoothingcoastline
	name = "coastline"
	icon = 'z40k_shit/icons/turfs/coastal2.dmi'
	icon_state = "sandwater7"
	floragen = FALSE 
	var/isedge
	footprints = FALSE

/turf/unsimulated/outside/smoothingcoastline/canSmoothWith() //Works
	var/static/list/smoothables = list(
		/turf/unsimulated/outside/water/shallow,
	)
	return smoothables

/turf/unsimulated/outside/smoothingcoastline/New(loc)
	..(loc)

	if(ticker && ticker.current_state >= GAME_STATE_PLAYING)
		initialize()

/turf/unsimulated/outside/smoothingcoastline/initialize()

	relativewall()
	relativewall_neighbours()
	
	coastaldiags() //We catch the diagonals

	if(ticker && ticker.current_state >= GAME_STATE_PREGAME)
		coastalcleanse() //We perform a coastal cleanse now that we are here.

/turf/unsimulated/outside/smoothingcoastline/relativewall()
	var/junction = findSmoothingNeighbors()
	icon_state = "sandwater[junction]"

/turf/unsimulated/outside/smoothingcoastline/isSmoothableNeighbor(atom/A)
	if (istype(A, /turf/space))
		return 0

	return ..()

//We only run in the pregame anyways. Who gives a fuck.
/turf/unsimulated/outside/smoothingcoastline/proc/coastalcleanse() 
	switch(icon_state) //Having that it was either this or a giant scan.
		if("sandwater7")	//I opted for this, we just do it once anyways.
			src.ChangeTurf(/turf/unsimulated/outside/water/shallow)
		if("sandwater11")
			src.ChangeTurf(/turf/unsimulated/outside/water/shallow)
		if("sandwater13")
			src.ChangeTurf(/turf/unsimulated/outside/water/shallow)
		if("sandwater14")
			src.ChangeTurf(/turf/unsimulated/outside/water/shallow)
		if("sandwater12")
			src.ChangeTurf(/turf/unsimulated/outside/water/shallow)
		if("sandwater3")
			src.ChangeTurf(/turf/unsimulated/outside/water/shallow)

	//var/Coastalneighbors //How many coastalneighbors we have next to us.
	var/Deepwatercounter //How many turfs of deep water are around us
	for(var/turf/unsimulated/outside/water/deep/NONO in orange(1,src))
		Deepwatercounter++

	//for(var/turf/unsimulated/outside/smoothingcoastline/CHANGE in orange(1,src))
		//Coastalneighbors++

		//CHANGE.relativewall()
		//CHANGE.relativewall_neighbours()
		//CHANGE.coastaldiags()

	if(Deepwatercounter >= 2) //If we see 2 or more deep water turfs around us.
		src.ChangeTurf(/turf/unsimulated/outside/water/shallow) //And we do not have 2 or more coastal neighbors around us.
	
		for(var/turf/unsimulated/outside/smoothingcoastline/CHANGE in orange(1,src))
			CHANGE.relativewall() //We only run once anyways, might as well be thorough.
			CHANGE.relativewall_neighbours()
			CHANGE.coastaldiags()


#define ASS1 1
#define ASS2 2 
#define ASS3 4 
#define ASS4 8 
//NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST
/turf/unsimulated/outside/smoothingcoastline/proc/coastaldiags() //lol fuck u
	var/CUNT

	if(icon_state == "sandwater0") //To those who behold this piece of shit.
		var/turf/STUPID_FUCKER = get_step(src, NORTHEAST)
		if(istype(STUPID_FUCKER,/turf/unsimulated/outside/water/shallow))
			CUNT |= ASS1 //For some reason doing a for loop with the diagonal global was broken.
						//Using the direction bitflags for diagonals kept breaking too.
		var/turf/STUPID_FUCKER1 = get_step(src, NORTHWEST)
		if(istype(STUPID_FUCKER1,/turf/unsimulated/outside/water/shallow))
			CUNT |= ASS2 //Doing direction checking loops kept failing.

		var/turf/STUPID_FUCKER2 = get_step(src, SOUTHWEST)
		if(istype(STUPID_FUCKER2,/turf/unsimulated/outside/water/shallow))
			CUNT |= ASS3 //This piece of shit here?

		var/turf/STUPID_FUCKER3 = get_step(src, SOUTHEAST)
		if(istype(STUPID_FUCKER3,/turf/unsimulated/outside/water/shallow))
			CUNT |= ASS4 //It actually worked, and im tired of fucking with this ok.

		if(CUNT & ASS1)
			icon_state = "sandwaterass1"
		if(CUNT & ASS2)
			icon_state = "sandwaterass2"

		if(CUNT & ASS3)
			icon_state = "sandwaterass3"
		if(CUNT & ASS4)
			icon_state = "sandwaterass4"


