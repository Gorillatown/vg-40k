//I'm leaving this unticked simply because I'm not using it over badplotter, but it compiles and works.
//1/13/2020 - JTGSZ

//You need to set these to filepaths otherwise it won't work, atm it selects from the blank.
#define VOR_REGION_ICON 'icons/turf/gentest.dmi'
#define VOR_BORDER_ICON 'icons/turf/gentest.dmi'
#define VOR_WATER_ICON 'icons/turf/gentest.dmi'


/datum/voronoi_diagrams

	var/vorResX
	var/vorResY
	var/vorSkipProb

	var/vorRegionCount
	var/vorMinimumDistance

	var/list/vorRegions = list()
	var/list/vorCardinalDirs = list(1, 2, 4, 8)
	var/list/vorAllDirs = list(1, 2, 4, 8, 5, 6, 10, 9)
	var/list/vorAdjacentRegions = list()


/area/vorRegion
		//each region starts as a seed and will later expand until it can't expand further.
		var/list/expandable = list()


/area/vorRegion/proc/SetIcon(I)
	for(var/turf/T in contents)
		T.icon = I



/datum/voronoi_diagrams/proc/vorSetGridResolution(resX, resY)
		//set the spacing between grid points.
		vorResX = resX
		vorResY = resY


/datum/voronoi_diagrams/proc/vorSetSkipProbability(skipProb)
		//set the chance that any given grid point will not have a region seed.
		vorSkipProb = skipProb


/datum/voronoi_diagrams/proc/vorSetMinimumDistance(myDist)
		vorMinimumDistance = myDist


/datum/voronoi_diagrams/proc/vorSetRegionCount(myCount)
		vorRegionCount = myCount


/datum/voronoi_diagrams/proc/vorBuildLand()
	//place random region seeds all over the map at a minimum distance from each other.
	var/curx
	var/cury

	for(var/i in 1 to vorRegionCount)
		while(1)
			curx = rand(1, world.maxx)
			cury = rand(1, world.maxy)

			var/turf/T = locate(curx, cury, 1)

			var/bad = 0
			for(var/turf/neighbor in oview(T, vorMinimumDistance - 1))
				if(istype(neighbor.loc, /area/vorRegion))
					bad = 1
					break

			if(!bad)
				vorCreateRegion(T)
				break


/datum/voronoi_diagrams/proc/vorBuildGrid()
	//place region seeds in a grid, with the option to skip some grid points.
	var/curx
	var/cury

	for(curx = round(vorResX / 2); curx <= world.maxx; curx += vorResX)
		for(cury = round(vorResY / 2); cury <= world.maxy; cury += vorResY)
			var/turf/T = locate(curx, cury, 1)

			if(!prob(vorSkipProb))
				vorCreateRegion(T)


/datum/voronoi_diagrams/proc/vorCreateRegion(turf/T)
	var/area/vorRegion/A = new()
	A.contents += T
	vorRegions += A
	T.icon = VOR_REGION_ICON //fixme


/datum/voronoi_diagrams/proc/vorExpandRegions()
	//grow all regions at an equal rate. Most of the code is here not strictly necessary for growing the
	//regions, but it helps grow them fast by tracking which regions and turfs can be ignored.
	var/expanded = 1
	var/iExpanded
	var/list/growable = vorRegions.Copy()


	for(var/area/vorRegion/R in growable)
		R.expandable = R.contents.Copy()


	while(expanded)
		expanded = 0

		for(var/area/vorRegion/R in growable)
			iExpanded = 0
			var/list/newExpandable = list()

			for(var/turf/T in R.expandable)
				var/turfExpanded = 0

				for(var/turf/neighbor in vorGetNeighbors(T, vorAllDirs))
					if(!istype(neighbor.loc, /area/vorRegion))
						expanded = 1
						iExpanded = 1
						turfExpanded = 1

						R.contents += neighbor
						newExpandable += neighbor
						neighbor.icon = VOR_REGION_ICON

				//to speed up processing, we track which turfs are still potentially able to expand.
				if(!turfExpanded) R.expandable -= T

			if(!iExpanded) growable -= R
			else R.expandable += newExpandable


/datum/voronoi_diagrams/proc/vorOutlineRegions(drawOutline)
	//calculates which regions are adjacent and, if drawOutline is 1, draws borders.
	for(var/area/vorRegion/R in world)
		vorAdjacentRegions[R] = list()

	for(var/turf/T in world)
		for(var/turf/neighbor in vorGetNeighbors(T, vorAllDirs))
			if(neighbor.loc != T.loc)
				if(drawOutline) T.icon = VOR_BORDER_ICON
				if(!(neighbor.loc in vorAdjacentRegions[T.loc]))
					vorAdjacentRegions[T.loc] += neighbor.loc


/datum/voronoi_diagrams/proc/vorGetNeighbors(turf/T, dirlist)
	var/list/L = list()
	for(var/curDir in dirlist)
		var/turf/neighbor = get_step(T, curDir)
		if(neighbor) L += neighbor

	return L


/datum/voronoi_diagrams/proc/vorCreateLake(maxsize)
	//randomly walk through regions and turn them into water.
	//Note that this is not a very intelligent proc -- it is possible that the random walk
	//will retrace some of its steps (revisit regions already converted to water)
	//and create a map with less water than expected.
	var/list/allRegions = list()

	for(var/area/vorRegion/R in world)
		allRegions += R

	var/area/vorRegion/R = pick(allRegions)
	R.SetIcon(VOR_WATER_ICON)

	for(var/i in 2 to maxsize)
		R = pick(vorAdjacentRegions[R])
		R.SetIcon(VOR_WATER_ICON)
