/datum/faction/ork_raiders
	name = "Ork Raiders"
	desc = "Doing as Orks usually do."
	ID = ORKS
	required_pref = ORKRAIDER
	initial_role = ORKRAIDER
	late_role = ORKRAIDER
	roletype = /datum/role/ork_raider
	initroletype = /datum/role/ork_raider
	logo_state = "ork-logo"
	hud_icons = list()

	var/time_left = (35 MINUTES)/10
	//Are we completed or not
	var/completed = FALSE

	var/results = "Who knows."

	//Do we gots the items
	var/got_items = 0

//The victory Proc
/datum/faction/ork_raiders/check_win()
	if(!completed)
		return 0
	if(ork_total_points < ig_total_points)
		return 0
		

	if(ork_total_points > ig_total_points)
		var/intrange = (abs(ork_total_points)-abs(ig_total_points))
		if(intrange >= 2000)
			to_chat(world, {"<FONT size = 5><B>Ork Major Victory!</B></FONT><br>
			<B>The orks pillaged and looted everything along with racking up a high amount of corpses.</B>"})
			return 1
		else
			to_chat(world, {"<FONT size = 5><B>Ork Minor Victory!</B></FONT><br>
			<B>The Orks managed to loot, and kill enough to incur significant losses.</B>"})
			return 1
	else
		return 0

/datum/faction/ork_raiders/GetScoreboard()
	. = ..()
	if (time_left <= 0)
		. += "<br/> <span class='danger'>The raid has ended.</span>"
	. += "<br/> The orks looted <b>[got_items]</b> items."
	. += "<br/> Total points: <b>[ork_total_points]</b>. <br/>"
	. += results

/datum/faction/ork_raiders/AdminPanelEntry()
	. = ..()
	var/fucktime = round(time_left)
	. += "<br/> Raid time left: [num2text((fucktime/60))] Minutes</b>"

/datum/faction/ork_raiders/OnPostSetup()
	..()

/datum/faction/ork_raiders/process()
	if(completed)
		time_left = 0
		return
	. = ..()
	time_left -= 2
	if(time_left <= 0 && completed == FALSE)
		completed = TRUE
		for(var/datum/role/R in members)
			to_chat(R.antag.current, "<span class='warning'>The raid is over.</span>")

		var/area/points_area = locate(/area/vault/warhammergen/ork_loot_area)
		for(var/obj/O in points_area)
			if(is_type_in_list(O, mcguffin_items))
				ork_total_points += 2000
				got_items++

		if(ig_total_points <= ork_total_points)
			results = "WE KRUMPED DA 'UMIES."
			for(var/datum/role/R in members)
				if(R.antag.current.client)
					var/client/C = R.antag.current.client
					C.persist.potential += 1
		else
			results = "THE 'UMIES KRUMPED US."
			for(var/datum/role/R in members)
				if(R.antag.current.client)
					var/client/C = R.antag.current.client
					C.persist.potential -= 1
			
/datum/faction/ork_raiders/proc/generate_string()
	var/list/our_stars = list()
	for(var/datum/role/lad in members)
		our_stars += "[lad.antag.key] as [lad.antag.name]"
	return english_list(our_stars)
