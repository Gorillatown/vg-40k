/datum/species/squats // a v shit iteration of squats
	name = "Squat"
	known_languages = list(LANGUAGE_HUMAN)

	primitive = /mob/living/carbon/monkey
	gender = MALE //they are all male, my man.

	eyes = "eyes_s"

	flags = NO_PAIN | HYPOTHERMIA_IMMUNE | IS_PREF_SELECTABLE
	anatomy_flags = HAS_LIPS | HAS_SWEAT_GLANDS

	cold_level_1 = -1  // Cold damage level 1 below this point.
	cold_level_2 = -1  // Cold damage level 2 below this point.
	cold_level_3 = -1  // Cold damage level 3 below this point.

	heat_level_1 = 420
	heat_level_2 = 480
	heat_level_3 = 1100

	has_mutant_race = 0

	base_strength = 12
	base_strength_natural_limit = 20
	base_agility = 8
	base_agility_natural_limit = 20
	base_dexterity = 8
	base_dexterity_natural_limit = 20
	base_constitution = 12
	base_constitution_natural_limit = 20
	base_willpower = 8
	base_willpower_natural_limit = 20
	base_sensitivity = 300
	base_sensitivity_natural_limit = 1000

/datum/species/squats/handle_post_spawn(var/mob/living/carbon/human/H) //Handles anything not already covered by basic species assignment.
	if(myhuman != H)
		return
	H.transform = H.transform.Scale(1, 0.8)

//This below segment normally belongs in human.dm
/mob/living/carbon/human/squats/New(var/new_loc, delay_ready_dna = 0)
	..(new_loc, "Squat")
	my_appearance.h_style = "Bald"
	regenerate_icons()