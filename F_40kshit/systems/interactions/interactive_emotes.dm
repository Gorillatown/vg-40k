/*
	Basically if these are the datum type that stores data for the actual emote conditions
*/


/datum/interaction_emotes
	var/title = "List of interaction emotes"

/datum/interaction_emotes/proc/check_conditions(mob/user, mob/target)
	return

/datum/interaction_emotes/highfive
	title = "High five"