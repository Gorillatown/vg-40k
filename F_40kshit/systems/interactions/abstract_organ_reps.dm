/*
	A category of ghetto organs for our system until I get motivated
*/
/datum/interactive_organ
	var/name = "ERROR"
	var/desc = "eek eek ook ook its a parent"
	var/lewd = FALSE
	var/occupied = FALSE //Is it occupied by something else?
	var/broken = FALSE

/datum/interactive_organ/Destroy()
	..()

/datum/interactive_organ/proc/meme_organ_desc(mob/living/L)
	return

//Return TRUE if its obscured, FALSE if it is not
/datum/interactive_organ/proc/check_obscured(mob/living/L)
	return FALSE



/*********************
	Wrestling Parts
**********************/
/*
	Hands
			*/
/datum/interactive_organ/hand
	name = "Hand"

/datum/interactive_organ/hand/meme_organ_desc(mob/living/L)
	. += "A hand"

/*
	Head
			*/
/datum/interactive_organ/head
	name = "Head"

/datum/interactive_organ/head/meme_organ_desc(mob/living/L)
	. += "A Head"

/*
	Mouth
			*/
/datum/interactive_organ/mouth
	name = "Mouth"

/datum/interactive_organ/mouth/meme_organ_desc(mob/living/L)
	. += "A mouth"

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

/datum/interactive_organ/neck/meme_organ_desc(mob/living/L)
	. += "A neck"
	
/*
	Arms
				*/
/datum/interactive_organ/arm
	name = "Arm"

/datum/interactive_organ/arm/meme_organ_desc(mob/living/L)
	. += "An Arm"

/*
	Legs
				*/
/datum/interactive_organ/leg
	name = "Leg"

/datum/interactive_organ/leg/meme_organ_desc(mob/living/L)
	. += "A Leg"

/*
	Feet
			*/
/datum/interactive_organ/foot
	name = "Foot"

/datum/interactive_organ/foot/meme_organ_desc(mob/living/L)
	. += "A Foot"

/*
	Chest
			*/
/datum/interactive_organ/chest
	name = "Chest"

/datum/interactive_organ/chest/meme_organ_desc(mob/living/L)
	. += "A Chest"
/*
	Groin
			*/
/datum/interactive_organ/groin
	name = "Groin"

/datum/interactive_organ/groin/meme_organ_desc(mob/living/L)
	. += "A Groin"



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

