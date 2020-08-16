
/datum/job/patrolman //This will be converted to the basic guardsman.
	title = "Patrolman"
	flag = PATROLMAN
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 500
	spawn_positions = 50
	wage_payout = 45
	supervisors = "Knight Officers, and your lord."
	selection_color = "#f8cb69"
	access = list()
	minimal_player_age = 7
	outfit_datum = /datum/outfit/patrolman
	species_whitelist = list("Human")
	landmark_job_override = TRUE

	relationship_chance = HUMAN_COMMON


/datum/outfit/patrolman
	outfit_name = "patrolman"
	associated_job = /datum/job/patrolman
	no_backpack = TRUE
	no_id = TRUE

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset,
			slot_w_uniform_str = /obj/item/clothing/under/patrolman_uniform,
			slot_head_str = /obj/item/clothing/head/patrolman_hat,
			slot_shoes_str = /obj/item/clothing/shoes/patrolman_boots,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/patrolman_suit,
			slot_belt_str = /obj/item/weapon/dksword
		),
	)

	items_to_collect = list(
	)

	implant_types = list(
	)

/datum/outfit/patrolman/post_equip(var/mob/living/carbon/human/H)

	