/datum/gamemode/points_of_interest
	name = "Points of Interest"

/datum/gamemode/points_of_interest/Setup()
	return 1

//This will be here for now
//TODO: Make a better system.
/datum/gamemode/points_of_interest/PostSetup()
	..()
	spawn(1 MINUTES)
		var/datum/relationships/fuckyou = new /datum/relationships()
		fuckyou.make_relationships() //bitch