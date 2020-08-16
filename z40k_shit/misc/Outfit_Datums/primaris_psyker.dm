/*
/datum/job/primarispsyker
	title = "Primaris Psyker"
	flag = PRIMARISPSYKER 
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	wage_payout = 65
	supervisors = "the Emperor"
	selection_color = "#E0D68B"
	access = list()
	minimal_player_age = 7
	outfit_datum = /datum/outfit/primarispsyker
	species_whitelist = list("Human")
	landmark_job_override = TRUE

	relationship_chance = HUMAN_NO_RELATIONS
*/

/datum/outfit/primarispsyker

	outfit_name = "Primaris Psyker"
//	associated_job = /datum/job/primarispsyker
	no_backpack = TRUE

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset,
			slot_w_uniform_str = /obj/item/clothing/under/rank/chaplain,
			slot_shoes_str = /obj/item/clothing/shoes/jackboots/inquisitor,
			slot_head_str = /obj/item/clothing/head/primarispsykertop,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/primarispsykerrobe,
			slot_back_str = /obj/item/weapon/psykerstaff,
			slot_belt_str = /obj/item/weapon/psychic_spellbook,
		)
	)

	id_type = /obj/item/weapon/card/id/imperial_guard_dogtag

/datum/outfit/primarispsyker/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("Fuck you")

/datum/outfit/primarispsyker/handle_faction(var/mob/living/M)
	var/datum/role/imperial_guard/psyker/psyker = new
	psyker.AssignToRole(M.mind,TRUE)
	psyker.mind_storage(M.mind)

/datum/outfit/primarispsyker/handle_special_abilities(var/mob/living/carbon/human/H)
	H.attribute_willpower = 11
	H.attribute_sensitivity = 500
	H.psyker_points = 8
	return 1
