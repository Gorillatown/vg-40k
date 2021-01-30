
/datum/interactive_actions
	var/name = "ERROR" //Name of the action
	var/requires_grab = FALSE //Does it require the target to be grabbed?
	var/unique_id = null

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
	
	for(var/UID_string in target.part_grabbed_by) //We check to see whether the part is being grabbed by the UID
		if(user.unique_id == UID_string) //This is just for grabs/grab checks, the actual check for how many limbs
			grab_check = TRUE //Is handled in on_use
			break
	
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
/datum/interactive_actions/proc/already_grabbing_check(var/datum/interactive_organ/user, var/datum/interactive_organ/target)
	var/part_already_grabbing = FALSE
	if(user.part_grabbing.len) //If we have anything in the part_grabbing list
		part_already_grabbing = TRUE
	
	if(part_already_grabbing) //If its true we gotta cleanup the UIDs if its not the same part
		var/datum/interactions/target_parent = target.parent_datum //the parent datum of the thing being targeted
		var/part_being_grabbed_uid = null
		var/datum/interactive_organ/other_target_organ = null
		
		var/mob/living/user_mob = user.parent_datum.our_idiot
		var/mob/living/target_mob = target.parent_datum.our_idiot
		
		for(var/unique_id in user.part_grabbing) //Now we find the unique id on the user organ of what its grabn
			part_being_grabbed_uid = unique_id //Store the unique ID on the var

		for(var/datum/interactive_organ/target_organs in target_parent.meme_organ_list)

		//for(var/check_UID in target.part_grabbed_by)
		//	if(user.unique_id == check_UID)
		//		to_chat(user_mob,"<span class='danger'>You were already using your [user.name] on their [target.name]!</span>")
		//		return TRUE

		for(var/datum/interactive_organ/target_organs in target_parent.meme_organ_list) //Iterate thru targets list
			if(target_organs.unique_id == part_being_grabbed_uid) //If the unique ID matches what we were grabbing
				target_organs.part_grabbed_by -= user.unique_id //Remove the ID from the grabbed by on target organ
				user.part_grabbing -= target_organs.unique_id //Remove the target organ's ID from user organ
				other_target_organ = target_organs
		
		user_mob.visible_message("<span class='danger'>[user_mob.name] releases their [user.name] from [target_mob.name]'s [other_target_organ.name].</span>")
		return TRUE
	
	return FALSE


//Return TRUE on a pass aka they manage the on_use, return FALSE on a failure
//Basically we pass the user's organ, and the target's organ to handle variables.
//They all contain a ref to the original mob.
/datum/interactive_actions/proc/on_use(var/datum/interactive_organ/user, var/datum/interactive_organ/target)
	if(already_grabbing_check(user,target)) //Failure because already grabbing.
		return FALSE
	
	return TRUE

