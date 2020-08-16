//Here is yet another shitty attempt at global outside lighting. Yeah.
var/datum/subsystem/lighthog/SSLighthog
var/global/list/day_and_night_lights = list()

#define TOD_MORNING 	1
#define TOD_SUNRISE 	2
#define TOD_DAYTIME 	3
#define TOD_AFTERNOON 	4
#define TOD_SUNSET 		5
#define TOD_NIGHTTIME 	6

//Basically this keeps timing, we dump it onto a datum really.
/datum/subsystem/lighthog
	name          = "Light CPU Hog"
	init_order    = SS_PRIORITY_LIGHTHOG
	display_order = SS_DISPLAY_LIGHTHOG
	priority      = SS_PRIORITY_LIGHTHOG
	wait          = 8 MINUTES
	flags         = SS_BACKGROUND|SS_FIRE_IN_LOBBY

	var/current_color = "#4d3d66"
	var/timeOfDay = TOD_MORNING
	var/hogpower = 10
	var/hogrange = 1
	var/outside_lights = FALSE

/datum/subsystem/lighthog/New()
	NEW_SS_GLOBAL(SSLighthog)

/datum/subsystem/lighthog/Initialize()
	var/list/timestwopick = list(TOD_MORNING,
								TOD_SUNRISE,
								TOD_DAYTIME,
								TOD_AFTERNOON,
								TOD_SUNSET,
								TOD_NIGHTTIME)
	timeOfDay = pick(timestwopick)
	..()

/datum/subsystem/lighthog/fire(resumed = FALSE)
	switch(timeOfDay)
		if(TOD_MORNING)
			current_color = "#4d6f86"
			timeOfDay = TOD_SUNRISE
			outside_lights = TRUE
		if(TOD_SUNRISE)
			current_color = "#fdc5a0"
			timeOfDay = TOD_DAYTIME
			outside_lights = FALSE
		if(TOD_DAYTIME)
			current_color = "#FFFFFF"
			timeOfDay = TOD_AFTERNOON
			outside_lights = FALSE
		if(TOD_AFTERNOON)
			current_color = "#ffeedf"
			timeOfDay = TOD_SUNSET
			outside_lights = FALSE
		if(TOD_SUNSET)
			current_color = "#75497e"
			timeOfDay = TOD_NIGHTTIME
			outside_lights = TRUE
		if(TOD_NIGHTTIME)
			current_color = "#002235"
			timeOfDay = TOD_MORNING
			outside_lights = TRUE
	
	time2fire()
	
	for(var/obj/machinery/light/day_and_night/our_light in day_and_night_lights)
		our_light.on = outside_lights

/datum/subsystem/lighthog/proc/time2fire()
	for(var/turf/T in block(locate(1, 1, 1), locate(world.maxx, world.maxy, 1)))
		if(IsEven(T.x)) //If we are also even.
			if(IsEven(T.y)) //If we are also even.
				if(istype(T, /turf/unsimulated/outside)) //If we are outside.
					T.set_light(hogrange,hogpower,current_color)
				else //If We aren't we need to make sure we handle the outside segment
					for(var/cdir in cardinal)
						var/turf/TITTIES = get_step(T,cdir)
						if(istype(TITTIES, /turf/unsimulated/outside)) //If we are outside.
							TITTIES.set_light(hogrange,hogpower,current_color) //Set it, starlighto scanno
							break

/*
	for(var/cdir in cardinal)
		var/turf/TITTIES = get_step(T,cdir)
		if(istype(TITTIES, /turf/unsimulated/outside)) //If we are outside.
			TITTIES.set_light(hogrange,hogpower,current_color) //Set it, starlighto scanno

	for(var/curX in 1 to world.maxx)
		for(var/curY in 1 to world.maxy)
			T = locate(curX, curY, 1)
*/
