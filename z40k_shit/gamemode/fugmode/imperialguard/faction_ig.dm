
/datum/faction/imperial_guard
	name = "Imperial Guard"
	desc = "Doing their best as humanity to survive as humanity under humanity."
	ID = IMPERIALGUARD
	required_pref = IMPERIALGUARDSMEN
	initial_role = IMPERIALGUARDSMEN
	late_role = IMPERIALGUARDSMEN
	roletype = /datum/role/imperial_guard
	initroletype = /datum/role/imperial_guard
	logo_state = "ig-logo"
	hud_icons = list()

	var/time_left =	(35 MINUTES)/10
	//Are we completed or not
	var/completed = FALSE

	var/results = "Who knows."

	//Do we gots the items
	var/got_items = 0

//The victory Proc
/datum/faction/imperial_guard/check_win()
	if(!completed)
		return 0
	if(ork_total_points > ig_total_points)
		return 0

	if(ig_total_points >= ork_total_points)
		var/intrange = (abs(ig_total_points)-abs(ork_total_points))
		if(intrange >= 2000)
			to_chat(world, {"<FONT size = 5><B>Imperial Guard Major Victory!</B></FONT><br>
			<B>The imperial guard routed the ork raid in this area.</B>"})
			return 1
		else
			to_chat(world, {"<FONT size = 5><B>Imperial Guard Minor Victory!</B></FONT><br>
			<B>The imperial guard brought the ork incursion to a halt, at notable cost.</B>"})
			return 1
	else
		return 0

/datum/faction/imperial_guard/GetScoreboard()
	. = ..()
	if(time_left <= 0)
		. += "<br/> <span class='danger'>The raid has ended.</span>"
	. += "<br/> The imperial guard secured <b>[got_items]</b> items."
	. += "<br/> Total points: <b>[ig_total_points]</b>. <br/>"
	. += results

/datum/faction/imperial_guard/AdminPanelEntry()
	. = ..()
	var/fucktime = round(time_left)
	. += "<br/> Raid time left: [num2text((fucktime/60))] Minutes</b>"

/datum/faction/imperial_guard/OnPostSetup()
	..()

/datum/faction/imperial_guard/process()
	if(completed)
		time_left = 0
		return
	. = ..()
	time_left -= 2
	if((time_left <= 0) && (completed == FALSE))
		completed = TRUE
		for(var/datum/role/R in members)
			to_chat(R.antag.current, "<span class='warning'>The raid is over.</span>")

		var/area/points_area = locate(/area/vault/warhammergen/ig_loot_area)
		for(var/obj/O in points_area)
			if(is_type_in_list(O, mcguffin_items))
				ig_total_points += 2000
				got_items++

		if(ig_total_points >= ork_total_points)
			results = "The imperial guard has beaten the orks."
			for(var/datum/role/R in members)
				if(R.antag.current.client)
					var/client/C = R.antag.current.client
					C.persist.potential += 1
		else
			results = "The imperial guard has been beaten by the orks."
			for(var/datum/role/R in members)
				if(R.antag.current.client)
					var/client/C = R.antag.current.client
					C.persist.potential -= 1
			
/datum/faction/imperial_guard/proc/generate_string()
	var/list/our_stars = list()
	for(var/datum/role/lad in members)
		our_stars += "[lad.antag.key] as [lad.antag.name]"
	return english_list(our_stars)

