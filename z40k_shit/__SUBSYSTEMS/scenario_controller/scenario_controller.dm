//Map Scenario Controller, basically keeps track of shit like a datum cause it is one.
//Also handles timing on traps that are tied into its lists.
//I had it on something that was purely a datum, but we were running into issues.
//So here we are with a subsystem now, seeing these globals probably will make people scream.
//But idc bitches

/*
	Future Design Goals
*/
/*
	Add controller Datums, let people assign the max interval possible on them.
	Let them assign traps to numbers on it and auto calculate the tick of stuff.
	EX: They set it to 10. We iterate to 10, so the max length has user input.
	They can make multiple controller datums.
	Its basically like a machine circuit controller that just ticks up.
	Perhaps we can allow multiplication etc.
	We will use this subsystem to keep timing on all of them, and also hold them
	When that day comes at least.

*/
var/datum/subsystem/scenario_controller/SS_Scenario //The subsystem
var/datum/job_quest/global_tracker/quest_master //Datum storage for job_quest shit
var/list/scenario_order_one = list() // A list of objects that fire on one tick
var/list/scenario_order_two = list() //A list of objects that fire on the next they alternate

//var/list/scenario_order_three = list()
var/list/tzeentchpads = list()

//Basically this keeps timing, we dump it onto a datum really.
/datum/subsystem/scenario_controller
	name          = "Scenario Controller"
	init_order    = SS_PRIORITY_SCENARIOS
	display_order = SS_DISPLAY_SCENARIOS
	priority      = SS_PRIORITY_SCENARIOS
	wait          = 2 SECONDS
	flags         = SS_BACKGROUND|SS_FIRE_IN_LOBBY

	var/ticker = 1 //Basically ticks in fire to help keep traps synced to a timing

	/*
		Segment one - Immaterium Dungeon
	*/
	var/active_dungeon = FALSE //is the dungeon currently firing?
	var/mask_is_active = FALSE //Has the mask been picked up?
	var/list/scenario_one_participants = list()
	
 
/datum/subsystem/scenario_controller/New()
	NEW_SS_GLOBAL(SS_Scenario)
	quest_master = new /datum/job_quest/global_tracker()
	
/datum/subsystem/scenario_controller/Initialize()
	..()

/datum/subsystem/scenario_controller/fire(resumed = FALSE)
	ticker++
	switch(ticker)	//for now we have two firing orders
		if(1)
			if(active_dungeon)
				for(var/obj/structure/traps/traps in scenario_order_one)
					traps.turn_my_ass_over()
		if(2)
			if(active_dungeon)
				for(var/obj/structure/traps/traps in scenario_order_two)
					traps.turn_my_ass_over()

	if(scenario_one_participants.len)
		active_dungeon = TRUE
		for(var/mob/living/carbon/human/H in scenario_one_participants)
			if(H.stat == DEAD)
				scenario_one_participants -= H
	else
		active_dungeon = FALSE
		

	if(ticker >= 2)
		ticker = 0
	
/datum/subsystem/scenario_controller/proc/check_pads(mob/user, var/entering)
	var/activated_pads = 0
	for(var/obj/structure/pressure_plate/pad in tzeentchpads)
		if(pad.activated)
			activated_pads++

	if(activated_pads >= 2)
		for(var/obj/structure/pressure_plate/pads in tzeentchpads)
			for(var/mob/living/carbon/human/H in range(0,pads))
				if(H.species.name == "Human")
					if(!H.mind.job_quest)
						H.x = rand(214,218)
						H.y = 179
						H.z = 2
						pads.activated = FALSE
						scenario_one_participants += H

