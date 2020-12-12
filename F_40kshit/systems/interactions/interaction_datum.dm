/*
	The return of these fuckers, altho im not gonna like port it, instead ill just code my own
	iteration from memory.
*/
/datum/interactions
	var/title = "You gonna interact boy"
	var/requires_physical_contact = FALSE //Whether we need to be ajacent or ontop of the targetted person.
	var/interaction_msg = "You interact wow"

//Calling parent on this basically handles the setting vars, like whether they need to be adjacent.
/datum/interactions/proc/do_interaction(var/mob/living/user, var/mob/living/target)
	if(physical_contact_check(user,target))
		return

/datum/interactions/proc/physical_contact_check(var/mob/living/user, var/mob/living/target)
	if(requires_physical_contact) //If requires_physical_contact == TRUE
		if(user.Adjacent(target)) //If User is adjacent to target
			return 1 //Return TRUE
		else //They are not
			return 0 //We return false
	else //If we do not require it
		return 1 //We return true

/datum/interactions/high_five
	title = "High Five"
	requires_physical_contact = TRUE
	interaction_msg = ""

