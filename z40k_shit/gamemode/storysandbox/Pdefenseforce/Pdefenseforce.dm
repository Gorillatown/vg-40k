/datum/faction/planetary_defense_force
	name = "Planetary Defense Force"
	desc = "Unlike the imperial guard, these people generally do not do their very best."
	ID = PLANETARYDEFFORCE
	required_pref = PDF
	initial_role = PDF
	late_role = PDF
	roletype = /datum/role/planetary_defense_force
	initroletype = /datum/role/planetary_defense_force
	logo_state = "ig-logo"
	hud_icons = list()

	var/results = "Who knows."

//The victory Proc
/datum/faction/planetary_defense_force/check_win()
	return

/datum/faction/planetary_defense_force/GetScoreboard()
	var/score_results = ""
	var/total_times_patrolled = 0
	var/total_life_exterminated = 0

	score_results += "<br/> <span class='danger'>The round has come to a close.</span>"
	for(var/datum/role/R in members)
		if(istype(R,/datum/role/planetary_defense_force))
			total_times_patrolled += R:times_patrolled
			total_life_exterminated += R:exterminated

	score_results += "<br/> Total living beings Exterminated: <b>[total_life_exterminated]</b>. <br/>"
	score_results += "<br/> The total checkpoints checked in: <b>[total_times_patrolled]</b> times."
	score_results += "<b>Notable Members:</b><br>"
	for(var/datum/role/R in members)
		if(istype(R,/datum/role/planetary_defense_force))
			var/datum/role/planetary_defense_force/PDEFF = R
			if(PDEFF.times_patrolled > 0)
				var/mob/M = PDEFF.antag.current
				var/icon/flat = getFlatIcon(M, SOUTH, 0, 1)
				end_icons += flat
				var/tempstate = end_icons.len
				score_results += "<img src='logo_[tempstate].png' style='position:relative; top:10px;'/>"
				score_results += "<b>[PDEFF.antag.key]</b> was <b>[PDEFF.antag.name]</b><br>"
				score_results += "<b>Times Patrolled:</b>[PDEFF.times_patrolled]<br>"
				score_results += "<b>Exterminated:</b>[PDEFF.exterminated]<br>"
				var/personal_score = round(PDEFF.times_patrolled+PDEFF.exterminated)
				score_results += "<b>Total Reward: [personal_score] Points gained.</b>"
				if(PDEFF.antag.current.client)
					var/client/C = PDEFF.antag.current.client
					C.persist.potential += personal_score

	return score_results

/datum/faction/planetary_defense_force/OnPostSetup()
	..()

/datum/faction/planetary_defense_force/process()
	..()
		
/datum/faction/planetary_defense_force/proc/generate_string()
	var/list/our_stars = list()
	for(var/datum/role/lad in members)
		our_stars += "[lad.antag.key] as [lad.antag.name]"
	return english_list(our_stars)