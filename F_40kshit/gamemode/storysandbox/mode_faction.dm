/*
	TODO: Write scoreboard primary faction here, tie gamemode flow shit into it
*/
/datum/faction/story_sandbox_main
	name = "The Scoreboard"
	desc = "Despite what you think, this is mostly a scoreboard and controller for the roles that go into it."
	ID = POI_MODE_CONTROLLER
	required_pref = PDF
	initial_role = PDF
	late_role = PDF
	roletype = /datum/role/planetary_defense_force
	initroletype = /datum/role/planetary_defense_force 
	logo_state = "ig-logo"
	hud_icons = list()

//	var/results = "Who knows."
	var/time_left =	(60 MINUTES)/10
	//Are we completed or not
	var/completed = FALSE

/datum/faction/story_sandbox_main/OnPostSetup()
	..()

//The victory Proc
/datum/faction/story_sandbox_main/check_win()
//	if(!completed)
//		return 0
	return

/datum/faction/story_sandbox_main/AdminPanelEntry()
	. = ..()
	. += "<br/> Time left: <b>[num2text((time_left /(2*60)))]:[add_zero(num2text(time_left/2 % 60), 2)]</b>"

/datum/faction/story_sandbox_main/process()
	//..() //This calls process on the roles in faction, of which none currently use process. So we comment it out.
	if(completed)
		time_left = 0
	else
		time_left -= 2
		if((time_left <= 0) && (completed == FALSE))
			completed = TRUE
			time_to_end()

/datum/faction/story_sandbox_main/proc/time_to_end()
 //If traveling or docked somewhere other than idle at command, don't call.
	if(emergency_shuttle.location || emergency_shuttle.direction)
		return
	emergency_shuttle.incall()
	captain_announce("Evac En route: Arrival [round(emergency_shuttle.timeleft()/60)] minutes. Justification: Recovery of assets.")

/datum/faction/story_sandbox_main/GetScoreboard()
	//Holder Strings - Score results is the main one returned, anything else is for ordering purposes.
	var/score_results = "" //Total sum stringiu
	var/PDF_results = "" //Mostly so we can do one loop and organize it properly.
	var/ANIMAL_results = "" //Like PDF except for animals

	var/total_times_patrolled = 0
	var/total_life_exterminated = 0
	var/total_orks_exterminated = 0
	var/total_rogue_psykers = 0

	//Leaderboard shit
	var/datum/role/native_animal/biggest_animal = null //Its null until we put someone in as a ref

	score_results += "<span class='danger'>The round has come to a close.</span><br><br>"
	score_results += "<h2> Detroid Mixed Forces Results:</h2>"
	for(var/datum/role/R in members)
		if(istype(R,/datum/role/planetary_defense_force)) //lmao this is so lazy but idc if it crashes at the end of a round.
			var/datum/role/planetary_defense_force/PEEDF = R
			total_times_patrolled += PEEDF.times_patrolled
			total_life_exterminated += PEEDF.exterminated
			total_orks_exterminated += PEEDF.orks_exterminated

		if(istype(R,/datum/role/rogue_psyker))
			total_rogue_psykers++
			//TODO: Chaos Transitions

		if(istype(R,/datum/role/native_animal)) //Time for animals
			var/datum/role/native_animal/NTR = R
			if(!biggest_animal) //No biggest animal
				biggest_animal = NTR //We make guy in first position it
			else if(NTR.total_growth >= biggest_animal.total_growth) //Keep going, if someone has more growth
				biggest_animal = NTR //They are now the biggest animal

	score_results += "Total sentient beings Exterminated: <b>[total_life_exterminated]</b>.<br>"
	score_results += "Total Orks Exterminated: <b>[total_orks_exterminated]</b><br>"
	score_results += "Total Rogue Psykers: <font color='#ff0000'><b>[total_rogue_psykers]</b></font><br>"
	score_results += "Total Rogue Chaos Psykers: <font color='#ff0000'><b>0</b></font><br>"
	var/warcrime_total = clamp((total_life_exterminated-total_orks_exterminated),0,500)
	score_results += "Warcrime total: <font color='#ff0000'><b>[warcrime_total]</b></font><br>"
	score_results += "The total checkpoints checked in: <b>[total_times_patrolled]</b> times.<br><br>"
	score_results += "<b><font size='3'>Notable Members:</b></font><br>"

	for(var/datum/role/R in members)
		if(istype(R,/datum/role/planetary_defense_force))
			var/datum/role/planetary_defense_force/PDEFF = R
			if(PDEFF.times_patrolled > 0)
				var/mob/M = PDEFF.antag.current
				var/icon/flat = getFlatIcon(M, SOUTH, 0, 1)
				end_icons += flat
				var/tempstate = end_icons.len
				PDF_results += "<img src='logo_[tempstate].png' style='position:relative; top:10px;'/>"
				PDF_results += "<b>[PDEFF.antag.key]</b> as <b>[PDEFF.antag.name]</b><br>"
				PDF_results += "<b>Times Patrolled:</b> [PDEFF.times_patrolled]<br>"
				PDF_results += "<b>Orks Exterminated:</b> [PDEFF.orks_exterminated]<br>"
				PDF_results += "<b>Total Beings Exterminated:</b> [PDEFF.exterminated]<br>"
				var/personal_score = round(PDEFF.times_patrolled+PDEFF.orks_exterminated)
				PDF_results += "<b><font size='4'>Total Reward:</font></b> <font color='#07fa0c'>[personal_score]</font> Points gained."
				if(PDEFF.antag.current.client)
					var/client/C = PDEFF.antag.current.client
					var/datum/interactive_persistence/persist = json_persistence["[C.ckey]"]
					persist.change_potential(personal_score)

		//Repurposed from sorting thru animals, mostly so we can sort for scoreboard leaders/ties to leader.
		if(istype(R,/datum/role/native_animal))
			var/datum/role/native_animal/NTR = R
			//We already found the apex predator, time to find ties to it. Its in the list too
			if(NTR.total_growth == biggest_animal.total_growth) //Display anyone who meets the criteria.
				var/mob/M = NTR.antag.current
				var/icon/flat = getFlatIcon(M, SOUTH, 0, 1)
				end_icons += flat
				var/tempstate = end_icons.len
				ANIMAL_results += "<img src='logo_[tempstate].png' style='position:relative; top:10px;'/>"
				ANIMAL_results += "<b>[NTR.antag.key]</b> as <b>[NTR.antag.current.name]</b><br>"
				ANIMAL_results += "<b>Total Growth:</font></b> <font color='#07fa0c'>[NTR.total_growth]</font> total times grown.<br>"
				if(NTR.antag.current.client)
					var/client/C = NTR.antag.current.client
					var/datum/interactive_persistence/persist = json_persistence["[C.ckey]"]
					persist.change_potential(NTR.total_growth)

	score_results += PDF_results //Mostly so we can re-order things and just have one singular loop.
	if(biggest_animal) //If we even got a biggest animal.
		score_results += "<HR>" //<HR> is a line across the page, <UL> is a unordered list.
		score_results += "<h2> Animal Results </h2>"
		score_results += ANIMAL_results //Grr, me an animimal

	return score_results

