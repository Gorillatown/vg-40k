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

/datum/interactive_actions/grab/on_use(datum/interactive_organ/user, datum/interactive_organ/target)
	if(..())
		var/mob/living/user_mob = user.parent_datum.our_idiot
		var/mob/living/target_mob = target.parent_datum.our_idiot
		user.part_grabbing += target.unique_id
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

/datum/interactive_actions/choke_hold/on_use(datum/interactive_organ/user, datum/interactive_organ/target)

/*
	Starts with a grab, can only be used on legs and arms
*/
/datum/interactive_actions/joint_lock
	name = "Joint Lock"
	requires_grab = TRUE
	parts_can_use = list(LIMB_LEFT_ARM,LIMB_RIGHT_ARM,
						LIMB_LEFT_LEG, LIMB_RIGHT_LEG)
	
	target_anything = TRUE

/datum/interactive_actions/joint_lock/on_use(datum/interactive_organ/user, datum/interactive_organ/target)
/*
	Starts with a grab can only be used by mouth
*/
/datum/interactive_actions/shake
	name = "Shake"
	requires_grab = TRUE
	parts_can_use = list(TARGET_MOUTH)
	
	target_anything = TRUE

/datum/interactive_actions/shake/on_use(datum/interactive_organ/user, datum/interactive_organ/target)
/*
	Can only be used by a hand - basically tries to tear/gouge a limb off
*/
/datum/interactive_actions/pinch
	name = "Pinch"
	parts_can_use = list(LIMB_LEFT_HAND, 
						LIMB_RIGHT_HAND)
	
	target_anything = TRUE

/datum/interactive_actions/pinch/on_use(datum/interactive_organ/user, datum/interactive_organ/target)
/*
	Can only be used by a hand - Basically removes objects from targeted area
*/
/datum/interactive_actions/disarm
	name = "Disarm"
	parts_can_use = list(LIMB_LEFT_HAND, 
						LIMB_RIGHT_HAND)
	
	target_anything = TRUE

/datum/interactive_actions/disarm/on_use(datum/interactive_organ/user, datum/interactive_organ/target)