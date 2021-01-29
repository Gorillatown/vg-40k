
/datum/interactive_actions
	var/name = "ERROR" //Name of the action
	//var/parts_can_use = list() //list of parts that can use the action

//Return TRUE on a yes, return FALSE on a no
//Basically we pass the datum attempting to use the action to it.
/datum/interactive_actions/proc/check_can_use(var/datum/interactive_organ/user)
	return FALSE

//Return TRUE on a pass, return FALSE on a no
//Basically we pass the user's organ, and the target's organ to handle variables.
//They all contain a ref to the original mob.
/datum/interactive_actions/proc/on_use(var/datum/interactive_organ/user, var/datum/interactive_organ/target)
	return FALSE

