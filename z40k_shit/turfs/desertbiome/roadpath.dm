/turf/unsimulated/outside/footpath
	name = "footpath"
	icon = 'z40k_shit/icons/turfs/dirtfootpath.dmi'
	icon_state = "water"
	floragen = FALSE
	footprints = FALSE

/turf/unsimulated/outside/smoothingfootpath
	name = "footpath"
	icon = 'z40k_shit/icons/turfs/dirtfootpath.dmi'
	icon_state = "sandwater7"
	floragen = FALSE 
	footprints = FALSE
	var/isedge

/turf/unsimulated/outside/smoothingfootpath/canSmoothWith() //Works
	var/static/list/smoothables = list(
		/turf/unsimulated/outside/footpath,
	)
	return smoothables

/turf/unsimulated/outside/smoothingfootpath/New(loc)
	..(loc)
	icon = 'z40k_shit/icons/turfs/dirtfootpath.dmi'

	if(ticker && ticker.current_state >= GAME_STATE_PLAYING)
		initialize()

/turf/unsimulated/outside/smoothingfootpath/initialize()

	relativewall()
	relativewall_neighbours()
	
	coastaldiags() //We catch the diagonals

	if(ticker && ticker.current_state >= GAME_STATE_PREGAME)
		coastalcleanse() //We perform a coastal cleanse now that we are here.

/turf/unsimulated/outside/smoothingfootpath/relativewall()
	var/junction = findSmoothingNeighbors()
	icon_state = "sandwater[junction]"

/turf/unsimulated/outside/smoothingfootpath/isSmoothableNeighbor(atom/A)
	if (istype(A, /turf/space))
		return 0

	return ..()

//We only run in the pregame anyways. Who gives a fuck.
/turf/unsimulated/outside/smoothingfootpath/proc/coastalcleanse() 
	var/Deepwatercounter //How many turfs of deep water are around us
	for(var/turf/unsimulated/outside/footpath/NONO in orange(1,src))
		Deepwatercounter++

	if(Deepwatercounter >= 2) //If we see 2 or more deep water turfs around us
		for(var/turf/unsimulated/outside/smoothingfootpath/CHANGE in orange(1,src))
			CHANGE.relativewall() //We only run once anyways, might as well be thorough.
			CHANGE.relativewall_neighbours()
			CHANGE.coastaldiags()

//NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST
/turf/unsimulated/outside/smoothingfootpath/proc/coastaldiags() //lol fuck u
	var/CUNT

	if(icon_state == "sandwater0") //To those who behold this piece of shit.
		var/turf/STUPID_FUCKER = get_step(src, NORTHEAST)
		if(istype(STUPID_FUCKER,/turf/unsimulated/outside/footpath))
			CUNT |= ASS1 //For some reason doing a for loop with the diagonal global was broken.
						//Using the direction bitflags for diagonals kept breaking too.
		var/turf/STUPID_FUCKER1 = get_step(src, NORTHWEST)
		if(istype(STUPID_FUCKER1,/turf/unsimulated/outside/footpath))
			CUNT |= ASS2 //Doing direction checking loops kept failing.

		var/turf/STUPID_FUCKER2 = get_step(src, SOUTHWEST)
		if(istype(STUPID_FUCKER2,/turf/unsimulated/outside/footpath))
			CUNT |= ASS3 //This piece of shit here?

		var/turf/STUPID_FUCKER3 = get_step(src, SOUTHEAST)
		if(istype(STUPID_FUCKER3,/turf/unsimulated/outside/footpath))
			CUNT |= ASS4 //It actually worked, and im tired of fucking with this ok.

		if(CUNT & ASS1)
			icon_state = "sandwaterass1"
		if(CUNT & ASS2)
			icon_state = "sandwaterass2"

		if(CUNT & ASS3)
			icon_state = "sandwaterass3"
		if(CUNT & ASS4)
			icon_state = "sandwaterass4"