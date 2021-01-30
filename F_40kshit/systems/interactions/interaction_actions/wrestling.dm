/*
	Basically many actions need to start with a grab
*/
/datum/interactive_actions/grab
	name = "Grab"
	parts_can_use = list(LIMB_LEFT_HAND, 
						LIMB_RIGHT_HAND, 
						LIMB_LEFT_LEG,
						LIMB_RIGHT_LEG,
						LIMB_LEFT_ARM,
						LIMB_RIGHT_ARM,
						TARGET_MOUTH)
	
	target_anything = TRUE
	repeat_action = FALSE

/datum/interactive_actions/grab/on_use(datum/interactive_organ/user, datum/interactive_organ/target)
	if(..())
		var/mob/living/user_mob = user.parent_datum.our_idiot
		var/mob/living/target_mob = target.parent_datum.our_idiot
		user.acted_on_part_uid = target.unique_id
		target.part_grabbed_by += user.unique_id
		user_mob.visible_message("<span class='danger'>[user_mob.name] grabs [target_mob.name]'s [target.name] with their [user.name].</span>")

/*
	Starts with a grab, only can be used on a neck
*/
/datum/interactive_actions/choke_hold
	name = "Chokehold"
	requires_grab = TRUE
	parts_can_use = list(LIMB_LEFT_ARM,LIMB_RIGHT_ARM,
						LIMB_LEFT_LEG, LIMB_RIGHT_LEG)
	
	parts_can_target = list(LIMB_NECK)
	repeat_action = TRUE

/datum/interactive_actions/choke_hold/on_use(datum/interactive_organ/user, datum/interactive_organ/target)
	if(..())
		var/mob/living/user_mob = user.parent_datum.our_idiot
		var/mob/living/target_mob = target.parent_datum.our_idiot
		var/check_count = 0
		var/list/names = list()
		for(var/string_uids in target.part_grabbed_by)
			for(var/datum/interactive_organ/checks in user_mob.interactions.meme_organ_list)
				if(checks.acted_on_part_uid == string_uids)
					check_count++
					names += "[checks.name]"
		
		if(check_count == 2)
			var/msg = "<span class='danger'>[user_mob.name] gets [target_mob.name] into a chokehold with their "
			for(var/strings in names)
				msg += "[strings]"
				names -= strings
				if(names.len > 1)
					msg += " and "
			msg += "</span>"
			user_mob.visible_message("[msg]")

/*
	Starts with a grab, can only be used on legs and arms
*/
/datum/interactive_actions/joint_lock
	name = "Joint Lock"
	requires_grab = TRUE
	parts_can_use = list(LIMB_LEFT_ARM,LIMB_RIGHT_ARM,
						LIMB_LEFT_LEG, LIMB_RIGHT_LEG)
	
	target_anything = TRUE
	repeat_action = TRUE

/datum/interactive_actions/joint_lock/on_use(datum/interactive_organ/user, datum/interactive_organ/target)
	if(..())
		var/mob/living/user_mob = user.parent_datum.our_idiot
		var/mob/living/target_mob = target.parent_datum.our_idiot
		var/check_count = 0
		var/list/names = list()
		for(var/string_uids in target.part_grabbed_by)
			for(var/datum/interactive_organ/checks in user.parent_datum.meme_organ_list)
				if(checks.acted_on_part_uid == string_uids)
					check_count++
					names += "[checks.name]"
		
		if(check_count == 2)
			var/msg = "<span class='danger'>[user_mob.name] gets [target_mob.name] into a Joint Lock with their "
			for(var/strings in names)
				msg += "[strings]"
				names -= strings
				if(names.len > 1)
					msg += " and "
				msg += "</span>"
			
			user_mob.visible_message("[msg]")
/*
	Starts with a grab can only be used by mouth
*/
/datum/interactive_actions/shake
	name = "Shake"
	requires_grab = TRUE
	parts_can_use = list(TARGET_MOUTH)
	
	target_anything = TRUE
	repeat_action = TRUE

/datum/interactive_actions/shake/on_use(datum/interactive_organ/user, datum/interactive_organ/target)
	if(..())
		var/mob/living/user_mob = user.parent_datum.our_idiot
		var/mob/living/target_mob = target.parent_datum.our_idiot

		user_mob.visible_message("<span class='danger'>[user_mob.name] bites down onto [target_mob.name]'s [target.name] and shakes.</span>")
/*
	Can only be used by a hand - basically tries to tear/gouge a limb off
*/
/datum/interactive_actions/pinch
	name = "Pinch"
	parts_can_use = list(LIMB_LEFT_HAND, 
						LIMB_RIGHT_HAND)
	
	target_anything = TRUE
	repeat_action = TRUE

/datum/interactive_actions/pinch/on_use(datum/interactive_organ/user, datum/interactive_organ/target)
	if(..())
		var/mob/living/user_mob = user.parent_datum.our_idiot
		var/mob/living/target_mob = target.parent_datum.our_idiot
		if(target.organ_type == LIMB_HEAD)
			user_mob.visible_message("<span class='danger'>[user_mob.name] digs their fingers into [target_mob]'s eyes.</span>")
		else
			user_mob.visible_message("<span class='danger'>[user_mob.name] pinches into [target_mob]'s [target.name] with their [user.name].</span>")
/*
	Can only be used by a hand - Basically removes objects from targeted area
*/
/datum/interactive_actions/disarm
	name = "Disarm"
	parts_can_use = list(LIMB_LEFT_HAND, 
						LIMB_RIGHT_HAND)
	
	target_anything = TRUE
	repeat_action = TRUE

/datum/interactive_actions/disarm/on_use(datum/interactive_organ/user, datum/interactive_organ/target)
	if(..())
		var/mob/living/user_mob = user.parent_datum.our_idiot
		var/mob/living/target_mob = target.parent_datum.our_idiot
		user_mob.visible_message("<span class='danger'>[user_mob.name] attempts to pull something off of [target_mob]'s [target.name].</span>")
