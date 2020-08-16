/datum/gamemode/fugmode
	name = "Battle Points"
	factions_allowed = list(/datum/faction/imperial_guard,
							/datum/faction/ork_raiders) 

//Yeah we handlin relationships here mostly because it will occur after the roundstart shit.
/datum/gamemode/fugmode/PostSetup()
	..()
	var/datum/relationships/fuckyou = new /datum/relationships()
	fuckyou.make_relationships() //bitch