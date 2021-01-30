
/datum/interactive_actions
	var/name = "ERROR" //Name of the action
	var/requires_grab = FALSE //Does it require the target to be grabbed?
	var/multi_part_action = FALSE //Can the action handle one part 
	var/unique_id = null
	var/repeat_action = FALSE

	var/list/parts_can_use  //list of parts that can use the action
	var/target_anything = FALSE //If it can target anything
	var/list/parts_can_target //List of parts the action can target

/datum/interactive_actions/New()
	..()

//Return TRUE on a yes, return FALSE on a no
//Basically we pass the datum attempting to use the action to it.
/datum/interactive_actions/proc/check_can_use(var/datum/interactive_organ/user, var/datum/interactive_organ/target)
	var/parts_check = FALSE
	var/target_check = FALSE
	var/grab_check = TRUE
	
	if(requires_grab)
		grab_check = FALSE
	
	for(var/parts_string in parts_can_use) //We check whether the user organ type is able to use the action
		if(user.organ_type == parts_string)
			parts_check = TRUE
			break
	
	if(user.acted_on_part_uid == target.unique_id)
		grab_check = TRUE //Is handled in on_use
	
	if(target_anything && parts_check && grab_check) //We can target any part, return TRUE here
		return TRUE
	

	for(var/parts_string_a in parts_can_target) //We check whether the action can target the part
		if(target.organ_type == parts_string_a)
			target_check = TRUE
			break
	
	if(parts_check && target_check && grab_check) //All checks passed return TRUE
		return TRUE


//returns TRUE if already grabbing, false if it is not.
//Mostly this is ref cleanup in the scenario we are doing something with a part and select another part
/datum/interactive_actions/proc/condition_checks(var/datum/interactive_organ/user, var/datum/interactive_organ/target)
	if(user.acted_on_part_uid) //IF TARGET IS NOT THE SAME AS THE ID WE ARE GRABBING WE RELEASE
		var/datum/interactions/target_parent = target.parent_datum //the parent datum of the thing being targeted
		
		if(user.acted_on_part_uid != target.unique_id)
			for(var/datum/interactive_organ/target_organs in target_parent.meme_organ_list)
				if(target_organs.unique_id == user.acted_on_part_uid)
					target_organs.part_grabbed_by -= user.acted_on_part_uid
					user.acted_on_part_uid = null
					var/mob/living/user_mob = user.parent_datum.our_idiot
					var/mob/living/target_mob = target.parent_datum.our_idiot
					user_mob.visible_message("<span class='danger'>[user_mob.name] releases their [user.name] from [target_mob.name]'s [target_organs.name].</span>")
					return FALSE
		else
			if(!repeat_action)
				return FALSE
	
	return TRUE


//Return TRUE on a pass aka they manage the on_use, return FALSE on a failure
//Basically we pass the user's organ, and the target's organ to handle variables.
//They all contain a ref to the original mob.
/datum/interactive_actions/proc/on_use(var/datum/interactive_organ/user, var/datum/interactive_organ/target)
	if(!condition_checks(user,target)) //Failure because already grabbing.
		return FALSE
	return TRUE
