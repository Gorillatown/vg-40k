/*
	A category of ghetto organs for our system until I get motivated
*/
/datum/interactive_organ
	var/name = "ERROR" //What is its name?
	var/lewd = FALSE //Is it fucking vulgar?
	var/datum/interactions/parent_datum = null //The parent /datum/interaction
	var/datum/interactive_actions/current_action = null //What current action are we performing?
	var/organ_type = LIMB_MISC //What kind of organ is it for action sorting.
	var/unique_id = null //A unique ID in a string so we can reference the correct organ

	var/broken = FALSE //Is the organ broken?
	
	//Two lists of UIDS so we can check conditions.
	var/list/part_grabbed_by = list() //List of things the part is grabbed by the bottom list is the opposite
	var/acted_on_part_uid = null //the scenario would only let us grab one thing at a time, but lets keep it open

/datum/interactive_organ/New()
	..()
	unique_id = "[rand(1,10000)]"

/datum/interactive_organ/Destroy()
	parent_datum = null
	..()

/datum/interactive_organ/proc/meme_organ_desc(mob/living/L)
	. += "A [name]"

//Return TRUE if its obscured, FALSE if it is not
/datum/interactive_organ/proc/check_obscured(mob/living/L)
	return FALSE



/*********************
	Wrestling Parts - We are going full generic where possible in this iteration.
**********************/
/*
	Mouth
			*/
/datum/interactive_organ/mouth
	name = "Mouth"
	organ_type = TARGET_MOUTH

/datum/interactive_organ/mouth/check_obscured(mob/living/L)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(H.wear_mask)
			return TRUE
	return FALSE

/*
	Neck - for armbars
						*/
/datum/interactive_organ/neck
	name = "Neck"
	organ_type = LIMB_NECK

/**********************
		Lewd Parts
**********************/
//The numbers relating to lengths/depths/widths is in inches.
//Also all of the below makes me laugh, its so fucking stupid.
/*
		Weiners
*/
/datum/interactive_organ/weiner
	name = "Penis"
	lewd = TRUE
	var/length = 2
	var/width = 1

/datum/interactive_organ/weiner/meme_organ_desc(mob/living/L)

	. += "A [name] which appears to be [length] inches long, [width] inches in width."

/datum/interactive_organ/weiner/check_obscured(mob/living/L)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(H.wear_suit || H.w_uniform)
			return TRUE
	return FALSE

/*
	Nuts
*/
/datum/interactive_organ/nuts
	name = "Ballsack"
	lewd = TRUE
	var/amount_of_nuts = 2
	var/circumference = 2 //This is per one nut, instead of both.

/datum/interactive_organ/nuts/meme_organ_desc(mob/living/L)
	var/size_desc = "Pathetic"
	switch(circumference)
		if(1)
			size_desc = "Pathetic"
		if(2)
			size_desc = "Walnut Sized"
		if(3)
			size_desc = "Baseball Sized"
		if(4)
			size_desc = "Shot-Put Sized"
		if(5 to 8)
			size_desc = "Ample Sized"
		if(8)
			size_desc = "Volleyball sized"
	. += "A [name] which holds [amount_of_nuts] [size_desc] sized nuts."

/datum/interactive_organ/nuts/check_obscured(mob/living/L)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(H.wear_suit || H.w_uniform)
			return TRUE
	return FALSE
/*
	Vaginas
*/
/datum/interactive_organ/vagina
	name = "Vagina"
	lewd = TRUE
	var/depth = 8
	var/width = 1
	var/is_wet = FALSE

/datum/interactive_organ/vagina/meme_organ_desc(mob/living/L)
	var/wet_desc = "Dry"
	if(is_wet)
		wet_desc = "Moist"

	. += "A [name] which appears to be [wet_desc]"

/datum/interactive_organ/vagina/check_obscured(mob/living/L)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(H.wear_suit || H.w_uniform)
			return TRUE
	return FALSE
/*
	Singular Boobs
*/
/datum/interactive_organ/boob
	name = "Boob"
	var/nipple_count = 1
	/*
	A - 1
	B - 2
	C - 3
	D - 4
	E - 5
	F - 6
	*/
	var/cup_size = 2

/datum/interactive_organ/boob/meme_organ_desc(mob/living/L)
	var/cup_desc = "Shriveled"
	switch(cup_size)
		if(1)
			cup_desc = "A"
		if(2)
			cup_desc = "B"
		if(3)
			cup_desc = "C"
		if(4)
			cup_desc = "D"
		if(5)
			cup_desc = "E"
		if(6)
			cup_desc = "F"
	. += "A boob which appears to be [cup_desc]-Sized, with [nipple_count] nipples on it."

/datum/interactive_organ/boob/check_obscured(mob/living/L)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(H.wear_suit || H.w_uniform)
			return TRUE
	return FALSE
/*
	Anii
*/
/datum/interactive_organ/anus
	name = "Asshole"
	lewd = TRUE
	var/depth = 5
	var/width = 2

/datum/interactive_organ/anus/meme_organ_desc(mob/living/L)
	. += "An anus"

/datum/interactive_organ/anus/check_obscured(mob/living/L)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(H.wear_suit || H.w_uniform)
			return TRUE
	return FALSE

