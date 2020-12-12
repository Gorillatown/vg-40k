/*
Just like Pdfenseforce.dm, I've decided to consolidate all the scoreboards into a single one.
*/
/datum/faction/native_animal_faction
	name = "Native Animals"
	desc = "Its a faction of Native Animals, who aren't a faction but are animals."
	ID = NATIVEANIMALS
	required_pref = NATIVEANIMAL
	initial_role = NATIVEANIMAL
	late_role = NATIVEANIMAL
	roletype = /datum/role/native_animal
	initroletype = /datum/role/native_animal
	logo_state = "monkey-logo"
	hud_icons = list()

	var/results = "Who knows."

//The victory Proc
/datum/faction/native_animal_faction/check_win()
	return

/datum/faction/native_animal_faction/GetScoreboard()
	var/score_results = ""
	var/datum/role/native_animal/biggest_animal = null //Its null until we put someone in as a ref
	var/list/scoreboard_boys = list() //A list of roles

	//First we sort through the list
	for(var/datum/role/native_animal/NTR in members) //Go thru membas
		if(!biggest_animal) //No biggest animal
			biggest_animal = NTR //We make guy in first position it
		else if(NTR.total_growth >= biggest_animal.total_growth) //Keep going, if someone has more growth
			biggest_animal = NTR //They are now the biggest animal

	if(biggest_animal) //We actually have a animal player who is the biggest

//		scoreboard_boys += biggest_animal //We add the big boy to the list
	
		for(var/datum/role/native_animal/NTR in members) //We go through the list again
			if(NTR.total_growth == biggest_animal.total_growth) //find ties, we tie with the big boy and he gets added too
				scoreboard_boys += NTR //So we add anyone who is tied to a list

		for(var/datum/role/native_animal/NTR in scoreboard_boys)
			var/mob/M = NTR.antag.current
			var/icon/flat = getFlatIcon(M, SOUTH, 0, 1)
			end_icons += flat
			var/tempstate = end_icons.len
			score_results += "<img src='logo_[tempstate].png' style='position:relative; top:10px;'/>"
			score_results += "<b>[NTR.antag.key]</b> as <b>[NTR.antag.name]</b><br>"
			score_results += "<b>Total Growth:</font></b> <font color='#07fa0c'>[NTR.total_growth]</font> total times grown.<br>"
			if(NTR.antag.current.client)
				var/client/C = NTR.antag.current.client
				C.persist.potential += NTR.total_growth

	return score_results

/datum/faction/native_animal_faction/OnPostSetup()
	..()

/datum/faction/native_animal_faction/process()
	..()
		
