/datum/job/peasant
	title = "Peasant"
	flag = PEASANT
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 2
	spawn_positions = -1
	supervisors = "absolutely everyone if you know whats good for you" 
	wage_payout = 10
	selection_color = "#dddddd"
	access = list()	
	alt_titles = list()
	species_blacklist = list("Ork")
	no_random_roll = 1 //Don't become assistant randomly

	outfit_datum = /datum/outfit/peasant

	relationship_chance = HUMAN_COMMON
	landmark_job_override = TRUE

/datum/outfit/peasant

	outfit_name = "Peasant"
	associated_job = /datum/job/peasant
	no_backpack = TRUE
	no_id = TRUE

	items_to_spawn = list(
		"Default" = list(
			slot_w_uniform_str = /obj/item/clothing/under/squatter_outfit,
			slot_head_str = /obj/item/clothing/head/squatter_hat,
			slot_shoes_str = /obj/item/clothing/shoes/black,
		),
		// Same as above, plus some
		/datum/species/plasmaman/ = list(
			slot_w_uniform_str = /obj/item/clothing/under/color/grey,
			slot_shoes_str = /obj/item/clothing/shoes/black,
			slot_wear_suit_str = /obj/item/clothing/suit/space/plasmaman/assistant,
			slot_wear_mask_str =  /obj/item/clothing/mask/breath/,
			slot_head_str = /obj/item/clothing/head/helmet/space/plasmaman/assistant,
		),
		/datum/species/vox/ = list(
			slot_w_uniform_str = /obj/item/clothing/under/color/grey,
			slot_shoes_str = /obj/item/clothing/shoes/black,
			slot_wear_suit_str = /obj/item/clothing/suit/space/vox/civ,
			slot_wear_mask_str =  /obj/item/clothing/mask/breath/,
			slot_head_str = /obj/item/clothing/head/helmet/space/vox/civ,
		),
	)

/datum/outfit/assistant/post_equip(var/mob/living/carbon/human/H)


