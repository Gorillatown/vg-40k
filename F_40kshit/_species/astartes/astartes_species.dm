/*
	ASTARTES
				*/
//-------------------------------------------------------------------
/datum/species/astartes // /ss40k/ heres the space marines, bretty good overall
	name = "Astartes"
	icobase = 'icons/mob/human_races/r_astartes.dmi'
	deform = 'icons/mob/human_races/r_def_astartes.dmi'
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

	base_strength = 14
	base_strength_natural_limit = 20
	base_agility = 12
	base_agility_natural_limit = 20
	base_dexterity = 14
	base_dexterity_natural_limit = 20
	base_constitution = 15
	base_constitution_natural_limit = 20
	base_willpower = 14
	base_willpower_natural_limit = 20
	base_sensitivity = 300
	base_sensitivity_natural_limit = 800

	has_organ = list(
		"heart" =    /datum/organ/internal/heart,
		"lungs" =    /datum/organ/internal/lungs,
		"brain" =    /datum/organ/internal/brain,
		"eyes" =     /datum/organ/internal/eyes
	)

	uniform_icons 		= 'F_40kshit/icons/mob/species_clothing/astartes/uniform.dmi'
//	fat_uniform_icons   = 'icons/mob/uniform_fat.dmi'
	gloves_icons        = 'F_40kshit/icons/mob/species_clothing/astartes/gloves.dmi'
//	glasses_icons       = 'icons/mob/eyes.dmi'
//	ears_icons          = 'icons/mob/ears.dmi'
	shoes_icons         = 'F_40kshit/icons/mob/species_clothing/astartes/boots.dmi'
	head_icons          = 'F_40kshit/icons/mob/species_clothing/astartes/head.dmi'
	belt_icons          = 'F_40kshit/icons/mob/species_clothing/astartes/belts.dmi'
	wear_suit_icons     = 'F_40kshit/icons/mob/species_clothing/astartes/suits.dmi'
//	fat_wear_suit_icons = 'icons/mob/suit_fat.dmi'
//	wear_mask_icons     = 'icons/mob/mask.dmi'
	back_icons          = 'F_40kshit/icons/mob/species_clothing/astartes/backs.dmi'
//	id_icons            = 'icons/mob/ids.dmi'

/datum/species/astartes/get_inventory_offsets()	//This is what you override if you want to give your species unique inventory offsets.
	var/static/list/offsets = list(
		"[slot_back]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_wear_mask]"	=	list("pixel_x" = 0, "pixel_y" = 3),
		"[slot_handcuffed]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_belt]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_wear_id]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_ears]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_glasses]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_gloves]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_head]"		=	list("pixel_x" = 0, "pixel_y" = 3),
		"[slot_shoes]"		=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_wear_suit]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_w_uniform]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_s_store]"	=	list("pixel_x" = 0, "pixel_y" = 0),
		"[slot_legcuffed]"	=	list("pixel_x" = 0, "pixel_y" = 0)
		) //gloves covers inhands and gloves. - JTGSZ
	return offsets

/datum/species/astartes/gib(mob/living/carbon/human/H)
	..()
	H.default_gib()
 
//This below segment normally belongs in human.dm
/mob/living/carbon/human/astartes/New(var/new_loc, delay_ready_dna = 0)
	..(new_loc, "Astartes")
	my_appearance.h_style = "Bald"
	regenerate_icons()
