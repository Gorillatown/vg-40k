/*
	Basically many actions need to start with a grab
*/
/datum/interactive_actions/grab
	name = "Grab"

/datum/interactive_actions/grab/check_can_use(datum/interactive_organ/user)
	if(\
	(istype(user,/datum/interactive_organ/hand)) || \
	(istype(user,/datum/interactive_organ/mouth)) || \
	(istype(user,/datum/interactive_organ/arm)) || \
	(istype(user,/datum/interactive_organ/leg)))
		return TRUE


/datum/interactive_actions/on_use(datum/interactive_organ/user, datum/interactive_organ/target)
	return


/*
	Starts with a grab, only can be used on a neck
*/
/datum/interactive_actions/choke_hold
	name = "Chokehold"

/datum/interactive_actions/choke_hold/check_can_use(datum/interactive_organ/user)
	if(istype(user,/datum/interactive_organ/arm) || istype(user,/datum/interactive_organ/leg))
		return TRUE



/*
	Starts with a grab, can only be used on legs and arms
*/
/datum/interactive_actions/joint_lock
	name = "Joint Lock"

/datum/interactive_actions/joint_lock/check_can_use(datum/interactive_organ/user)
	if(istype(user,/datum/interactive_organ/arm) || istype(user,/datum/interactive_organ/leg))
		return TRUE

/*
	Starts with a grab can only be used by mouth
*/
/datum/interactive_actions/bite_onto
	name = "Bite Onto"

/datum/interactive_actions/bite_onto/check_can_use(datum/interactive_organ/user)
	if(istype(user,/datum/interactive_organ/mouth))
		return TRUE

/*
	Can only be used by a hand - basically tries to tear/gouge a limb off
*/
/datum/interactive_actions/pinch
	name = "Pinch"

/datum/interactive_actions/pinch/check_can_use(datum/interactive_organ/user)
	if(istype(user,/datum/interactive_organ/hand))
		return TRUE

/*
	Can only be used by a hand - Basically removes objects from targeted area
*/
/datum/interactive_actions/disarm
	name = "Disarm"

/datum/interactive_actions/disarm/check_can_use(datum/interactive_organ/user)
	if(istype(user,/datum/interactive_organ/hand))
		return TRUE