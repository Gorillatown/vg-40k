/*
	BASIC ORKS
				*/
//-------------------------------------------------------------------
/datum/species/ork // /ss40k/ heres mr ork, or really their only gender should be male
	name = "Ork"
	icobase = 'icons/mob/human_races/r_ork.dmi'
	deform = 'icons/mob/human_races/r_def_ork.dmi'
	known_languages = list(LANGUAGE_CATBEAST,LANGUAGE_HUMAN)

	primitive = /mob/living/carbon/monkey
	gender = MALE //they are all male, my man.

	eyes = "bald_s"

	flags = NO_PAIN | HYPOTHERMIA_IMMUNE | NO_SCAN | NO_SKIN | NO_BLOOD | IS_WHITELISTED
	anatomy_flags = HAS_LIPS | HAS_SWEAT_GLANDS

	cold_level_1 = -1  // Cold damage level 1 below this point.
	cold_level_2 = -1  // Cold damage level 2 below this point.
	cold_level_3 = -1  // Cold damage level 3 below this point.

	heat_level_1 = 420
	heat_level_2 = 480
	heat_level_3 = 1100

	has_mutant_race = 0

	base_strength = 9
	base_strength_natural_limit = 13
	base_agility = 8
	base_agility_natural_limit = 12
	base_dexterity = 7
	base_dexterity_natural_limit = 11
	base_constitution = 9
	base_constitution_natural_limit = 14
	base_willpower = 5
	base_willpower_natural_limit = 8
	base_sensitivity = 25
	base_sensitivity_natural_limit = 100

	has_organ = list(
		"heart" =    /datum/organ/internal/heart/ork,
		"lungs" =    /datum/organ/internal/lungs,
		"brain" =    /datum/organ/internal/brain,
		"eyes" =     /datum/organ/internal/eyes
	)

	uniform_icons 		= 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
//	fat_uniform_icons   = 'icons/mob/uniform_fat.dmi'
	gloves_icons        = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
//	glasses_icons       = 'icons/mob/eyes.dmi'
//	ears_icons          = 'icons/mob/ears.dmi'
	shoes_icons         = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
	head_icons          = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
	belt_icons          = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
	wear_suit_icons     = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
//	fat_wear_suit_icons = 'icons/mob/suit_fat.dmi'
//	wear_mask_icons     = 'icons/mob/mask.dmi'
	back_icons          = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
//	id_icons            = 'icons/mob/ids.dmi'

/datum/species/ork/get_inventory_offsets()	//This is what you override if you want to give your species unique inventory offsets.
	var/static/list/offsets = list(
		"[slot_back]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_wear_mask]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_handcuffed]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_belt]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_wear_id]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_ears]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_glasses]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_gloves]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_head]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_shoes]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_wear_suit]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_w_uniform]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_s_store]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_legcuffed]"	=	list("pixel_x" = 0, "pixel_y" = 0)
		) //gloves covers inhands and gloves. - JTGSZ
	return offsets

/datum/species/ork/gib(mob/living/carbon/human/H)
	..()
	H.default_gib()
 
/datum/species/ork/makeName()
	return capitalize(pick(ork_first)) + " " + capitalize(pick(ork_last))

/datum/species/ork/makeFirstName(var/gender,var/mob/living/carbon/C=null)
	return capitalize(pick(ork_first))

/datum/species/ork/makeLastName(var/gender,var/mob/living/carbon/C=null)
	return capitalize(pick(ork_last))

//This below segment normally belongs in human.dm
/mob/living/carbon/human/ork/basicork/New(var/new_loc, delay_ready_dna = 0)
	..(new_loc, "Ork")
	my_appearance.h_style = "Bald"
	regenerate_icons()

/*
	GRETCHIN
				*/
//-------------------------------------------------------------------
/datum/species/ork/gretchin
	name = "Ork Gretchin"
	icobase = 'icons/mob/human_races/r_orkgretchin.dmi'
	deform = 'icons/mob/human_races/r_def_orkgretchin.dmi'
	known_languages = list(LANGUAGE_CATBEAST,LANGUAGE_HUMAN)

	primitive = /mob/living/carbon/monkey
	gender = MALE //they are all male, my man.

	eyes = "bald_s"

	flags = NO_PAIN | HYPOTHERMIA_IMMUNE | NO_SCAN | NO_SKIN | NO_BLOOD
	anatomy_flags = HAS_LIPS | HAS_SWEAT_GLANDS

	cold_level_1 = -1  // Cold damage level 1 below this point.
	cold_level_2 = -1  // Cold damage level 2 below this point.
	cold_level_3 = -1  // Cold damage level 3 below this point.

	heat_level_1 = 420
	heat_level_2 = 480
	heat_level_3 = 1100

	has_mutant_race = 0

	base_strength = 4
	base_strength_natural_limit = 13
	base_agility = 8
	base_agility_natural_limit = 12
	base_dexterity = 8
	base_dexterity_natural_limit = 11
	base_constitution = 5
	base_constitution_natural_limit = 14
	base_willpower = 5
	base_willpower_natural_limit = 8
	base_sensitivity = 25
	base_sensitivity_natural_limit = 100

	has_organ = list(
		"heart" =    /datum/organ/internal/heart/ork,
		"lungs" =    /datum/organ/internal/lungs,
		"brain" =    /datum/organ/internal/brain,
		"eyes" =     /datum/organ/internal/eyes
	)

	uniform_icons 		= 'z40k_shit/icons/mob/orks/orkgearGRETCHINMOB.dmi'
//	fat_uniform_icons   = 'icons/mob/uniform_fat.dmi'
	gloves_icons        = 'z40k_shit/icons/mob/orks/orkgearGRETCHINMOB.dmi'
//	glasses_icons       = 'icons/mob/eyes.dmi'
//	ears_icons          = 'icons/mob/ears.dmi'
	shoes_icons         = 'z40k_shit/icons/mob/orks/orkgearGRETCHINMOB.dmi'
	head_icons          = 'z40k_shit/icons/mob/orks/orkgearGRETCHINMOB.dmi'
	belt_icons          = 'z40k_shit/icons/mob/orks/orkgearGRETCHINMOB.dmi'
	wear_suit_icons     = 'z40k_shit/icons/mob/orks/orkgearGRETCHINMOB.dmi'
//	fat_wear_suit_icons = 'icons/mob/suit_fat.dmi'
//	wear_mask_icons     = 'icons/mob/mask.dmi'
	back_icons          = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
//	id_icons            = 'icons/mob/ids.dmi'

/datum/species/ork/gretchin/get_inventory_offsets()	//This is what you override if you want to give your species unique inventory offsets.
	var/static/list/offsets = list(
		"[slot_back]"		=	list("pixel_x" = 0, "pixel_y" = -6),
		"[slot_wear_mask]"	=	list("pixel_x" = 0, "pixel_y" = -5),
		"[slot_handcuffed]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_belt]"		=	list("pixel_x" = 0, "pixel_y" = -5),
		"[slot_wear_id]"	=	list("pixel_x" = 0, "pixel_y" = -5),
		"[slot_ears]"		=	list("pixel_x" = 0, "pixel_y" = -5),
		"[slot_glasses]"	=	list("pixel_x" = 0, "pixel_y" = -5),
		"[slot_gloves]"		=	list("pixel_x" = 0, "pixel_y" = -4),
		"[slot_head]"		=	list("pixel_x" = 0, "pixel_y" = -5),
		"[slot_shoes]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_wear_suit]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_w_uniform]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_s_store]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_legcuffed]"	=	list("pixel_x" = 0, "pixel_y" = 0)
		) //gloves covers inhands and gloves. - JTGSZ
	return offsets


//This below segment normally belongs in human.dm
/mob/living/carbon/human/ork/gretchin/New(var/new_loc, delay_ready_dna = 0)
	..(new_loc, "Ork Gretchin")
	my_appearance.h_style = "Bald"
	regenerate_icons()

/*
	ORK NOBS
				*/
//-------------------------------------------------------------------
/datum/species/ork/nob
	name = "Ork Nob"
	icobase = 'icons/mob/human_races/r_orknob.dmi'
	deform = 'icons/mob/human_races/r_def_orknob.dmi'
	known_languages = list(LANGUAGE_CATBEAST,LANGUAGE_HUMAN)

	primitive = /mob/living/carbon/monkey
	gender = MALE //they are all male, my man.

	eyes = "bald_s"

	flags = NO_PAIN | HYPOTHERMIA_IMMUNE | NO_SCAN | NO_SKIN
	anatomy_flags = HAS_LIPS | HAS_SWEAT_GLANDS

	cold_level_1 = -1  // Cold damage level 1 below this point.
	cold_level_2 = -1  // Cold damage level 2 below this point.
	cold_level_3 = -1  // Cold damage level 3 below this point.

	heat_level_1 = 420
	heat_level_2 = 480
	heat_level_3 = 1100

	has_mutant_race = 0

	brute_mod = 0.8	// brute multiplier
	burn_mod = 0.8 // burn multiplier
	tox_mod	= 0.8	// toxin multiplier

	base_strength = 11
	base_strength_natural_limit = 16
	base_agility = 9
	base_agility_natural_limit = 13
	base_dexterity = 7
	base_dexterity_natural_limit = 11
	base_constitution = 11
	base_constitution_natural_limit = 17
	base_willpower = 8
	base_willpower_natural_limit = 12
	base_sensitivity = 25
	base_sensitivity_natural_limit = 100


	has_organ = list(
		"heart" =    /datum/organ/internal/heart/ork,
		"lungs" =    /datum/organ/internal/lungs,
		"brain" =    /datum/organ/internal/brain,
		"eyes" =     /datum/organ/internal/eyes
	)

	uniform_icons 		= 'z40k_shit/icons/mob/orks/orkgearNOBMOB.dmi'
//	fat_uniform_icons   = 'icons/mob/uniform_fat.dmi'
	gloves_icons        = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
//	glasses_icons       = 'icons/mob/eyes.dmi'
//	ears_icons          = 'icons/mob/ears.dmi'
	shoes_icons         = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
	head_icons          = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
	belt_icons          = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
	wear_suit_icons     = 'z40k_shit/icons/mob/orks/orkgearNOBMOB.dmi'
//	fat_wear_suit_icons = 'icons/mob/suit_fat.dmi'
//	wear_mask_icons     = 'icons/mob/mask.dmi'
	back_icons          = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
//	id_icons            = 'icons/mob/ids.dmi'

/datum/species/ork/nob/get_inventory_offsets()	//This is what you override if you want to give your species unique inventory offsets.
	var/static/list/offsets = list(
		"[slot_back]"		=	list("pixel_x" = 0, "pixel_y" = 3),
		"[slot_wear_mask]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_handcuffed]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_belt]"		=	list("pixel_x" = 0, "pixel_y" = 2),
		"[slot_wear_id]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_ears]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_glasses]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_gloves]"		=	list("pixel_x" = 0, "pixel_y" = 2),
		"[slot_head]"		=	list("pixel_x" = 0, "pixel_y" = 3),
		"[slot_shoes]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_wear_suit]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_w_uniform]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_s_store]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_legcuffed]"	=	list("pixel_x" = 0, "pixel_y" = 0)
		) //gloves covers inhands and gloves. - JTGSZ
	return offsets


/mob/living/carbon/human/ork/nob/New(var/new_loc, delay_ready_dna = 0)
	..(new_loc, "Ork Nob")
	my_appearance.h_style = "Bald"
	regenerate_icons()

/datum/species/ork/nob/handle_post_spawn(var/mob/living/carbon/human/H)
	if(myhuman != H)
		return
	H.maxHealth += 100
	H.health += 100
	H.update_icon()


/*
	ORK WARBOSS
				*/
//-------------------------------------------------------------------
/datum/species/ork/warboss
	name = "Ork Warboss"
	icobase = 'icons/mob/human_races/r_orkboss.dmi'
	deform = 'icons/mob/human_races/r_def_orkboss.dmi'
	known_languages = list(LANGUAGE_CATBEAST,LANGUAGE_HUMAN)

	primitive = /mob/living/carbon/monkey
	gender = MALE //they are all male, my man.

	eyes = "bald_s"

	flags = NO_PAIN | HYPOTHERMIA_IMMUNE | NO_SCAN | NO_SKIN
	anatomy_flags = HAS_LIPS | HAS_SWEAT_GLANDS

	cold_level_1 = -1  // Cold damage level 1 below this point.
	cold_level_2 = -1  // Cold damage level 2 below this point.
	cold_level_3 = -1  // Cold damage level 3 below this point.

	heat_level_1 = 420
	heat_level_2 = 480
	heat_level_3 = 1100

	has_mutant_race = 0

	brute_mod = 0.5	// brute multiplier
	burn_mod = 0.5 // burn multiplier
	tox_mod	= 0.5	// toxin multiplier

	base_strength = 13
	base_strength_natural_limit = 20
	base_agility = 9
	base_agility_natural_limit = 14
	base_dexterity = 9
	base_dexterity_natural_limit = 14
	base_constitution = 13
	base_constitution_natural_limit = 20
	base_willpower = 11
	base_willpower_natural_limit = 16
	base_sensitivity = 25
	base_sensitivity_natural_limit = 100

	has_organ = list(
		"heart" =    /datum/organ/internal/heart/ork,
		"lungs" =    /datum/organ/internal/lungs,
		"brain" =    /datum/organ/internal/brain,
		"eyes" =     /datum/organ/internal/eyes
	)

	uniform_icons 		= 'z40k_shit/icons/mob/orks/orkgearWARBOSSMOB.dmi'
//	fat_uniform_icons   = 'icons/mob/uniform_fat.dmi'
	gloves_icons        = 'z40k_shit/icons/mob/orks/orkgearWARBOSSMOB.dmi'
//	glasses_icons       = 'icons/mob/eyes.dmi'
//	ears_icons          = 'icons/mob/ears.dmi'
	shoes_icons         = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
	head_icons          = 'z40k_shit/icons/mob/orks/orkgearWARBOSSMOB.dmi'
	belt_icons          = 'z40k_shit/icons/mob/orks/orkgearWARBOSSMOB.dmi'
	wear_suit_icons     = 'z40k_shit/icons/mob/orks/orkgearWARBOSSMOB.dmi'
//	fat_wear_suit_icons = 'icons/mob/suit_fat.dmi'
//	wear_mask_icons     = 'icons/mob/mask.dmi'
	back_icons          = 'z40k_shit/icons/mob/orks/orkgearMOB.dmi'
//	id_icons            = 'icons/mob/ids.dmi'

/datum/species/ork/warboss/get_inventory_offsets()	//This is what you override if you want to give your species unique inventory offsets.
	var/static/list/offsets = list(
		"[slot_back]"		=	list("pixel_x" = 0, "pixel_y" = 5),
		"[slot_wear_mask]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_handcuffed]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_belt]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_wear_id]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_ears]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_glasses]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_gloves]"		=	list("pixel_x" = 0, "pixel_y" = 2),
		"[slot_head]"		=	list("pixel_x" = 0, "pixel_y" = 5),
		"[slot_shoes]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_wear_suit]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_w_uniform]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_s_store]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_legcuffed]"	=	list("pixel_x" = 0, "pixel_y" = 0)
		) //gloves covers inhands and gloves. - JTGSZ
	return offsets

/mob/living/carbon/human/ork/warboss/New(var/new_loc, delay_ready_dna = 0)
	..(new_loc, "Ork Warboss")
	my_appearance.h_style = "Bald"
	regenerate_icons()

/datum/species/ork/warboss/handle_post_spawn(var/mob/living/carbon/human/H)
	if(myhuman != H)
		return
	H.maxHealth += 200
	H.health += 200
	H.update_icon()
