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
var/list/patrol_checkpoints = list() //A list of patrol checkpoints on the map.
var/list/requisition_buyable_obj_list = list()

//These are basically point totals
var/ig_total_points = 0
var/ork_total_points = 0

//One must ask, is it worthwhile having lists? Probably not until theres more than one faction.

var/list/tzeentchpads = list() //The dumb teleportation pads
var/list/scenario_process = list() //basically it calls everything in this list every call on the loop.

//Basically this keeps timing, we dump it onto a datum really.
/datum/subsystem/scenario_controller
	name          = "Scenario Controller"
	init_order    = SS_PRIORITY_SCENARIOS
	display_order = SS_DISPLAY_SCENARIOS
	priority      = SS_PRIORITY_SCENARIOS
	wait          = 2 SECONDS
	flags         = SS_BACKGROUND|SS_FIRE_IN_LOBBY

	var/ticker = 1 //Basically ticks in fire to help keep traps synced to a timing
	var/next_req_refill_time = 0 //Basically world_time + minutes

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

	if(active_dungeon)
		switch(ticker)	//for now we have two firing orders
			if(1)
				for(var/obj/structure/traps/traps in scenario_order_one)
					traps.turn_my_ass_over()
			if(2)
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

	if(world.time > next_req_refill_time)
		fill_req_list()
		next_req_refill_time = world.time + 10 MINUTES
	/*
	Forewarning: we are turning safety checks off for scenario_process.
	You may ask why? Its because its handling a lot of datums that aren't on the same path.
	For now its handling one shuttle datum, and all the roguelike passives.
	We are even putting it at the end, so it doesn't cancel other shit with a runtime.
	*/
	for(var/NO_BAD_THINGS in scenario_process)
		NO_BAD_THINGS:sc_process()
		
//This exists mostly to move people into the dungeon properly/make sure its not on If nobody is in it
//To save on CPU.
/datum/subsystem/scenario_controller/proc/check_pads(mob/user, var/entering)
	var/activated_pads = 0
	for(var/obj/structure/pressure_plate/pad in tzeentchpads)
		if(pad.activated)
			activated_pads++

	if(activated_pads >= 2)
		for(var/obj/structure/pressure_plate/pads in tzeentchpads)
			for(var/mob/living/carbon/human/H in range(0,pads))
				var/datum/role/job_quest/tzeentch_one/TZZTCH = H.mind.GetRole(TZEENTCH_CHAMPION)
				if(!TZZTCH)
					for(var/obj/effect/step_trigger/id_teleporter/end/END in id_teleporters)
						if(END.destination_id == "dungeon_one_start")
							H.loc = END.loc
					pads.activated = FALSE
					scenario_one_participants += H

/datum/subsystem/scenario_controller/proc/fill_req_list()
	for(var/datum/requisition_buyable/CUR_OBJ in requisition_buyable_obj_list)
		requisition_buyable_obj_list -= CUR_OBJ
		qdel(CUR_OBJ)
		
	for(var/i=0 to req_obj_reference_list.len)
		var/picked_datum = pickweight(req_obj_reference_list)
		var/datum/requisition_buyable/REQ_OBJ = new picked_datum
		requisition_buyable_obj_list += REQ_OBJ
