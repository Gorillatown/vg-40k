/datum/job/celebrity
	title = "Celebrity"
	flag = CELEBRITY
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "yourself, and your court warrant"
	wage_payout = 15
	selection_color = "#dddddd"
	species_whitelist = list("Human")
	outfit_datum = /datum/outfit/celebrity
	landmark_job_override = TRUE

	relationship_chance = HUMAN_COMMON

/datum/outfit/celebrity // Honk
	outfit_name = "Celebrity"
	associated_job = /datum/job/celebrity
	no_backpack = TRUE
	no_id = TRUE

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset,
			slot_w_uniform_str = /obj/item/clothing/under/suit_jacket/red,
			slot_shoes_str = /obj/item/clothing/shoes/jackboots/cowboy,
			slot_wear_suit_str = /obj/item/clothing/suit/celebrity,
			slot_head_str = /obj/item/clothing/head/powdered_wig,
		)
	)

	items_to_collect = list()

/datum/outfit/celebrity/post_equip(var/mob/living/carbon/human/H)
	quest_master.configure_quest(H,SLAANESH_CHAMPION)
	return 1
 