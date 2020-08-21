/datum/job/janitor
	title = "Janitor"
	flag = JANITOR
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the lord"
	wage_payout = 20
	selection_color = "#dddddd"
	access = list()
	species_blacklist = list("Ork")
	outfit_datum = /datum/outfit/janitor
	landmark_job_override = TRUE

	relationship_chance = HUMAN_COMMON

/datum/outfit/janitor
	outfit_name = "Janitor"
	associated_job = /datum/job/janitor
	no_id = TRUE

	backpack_types = list(
		BACKPACK_STRING = /obj/item/weapon/storage,
		SATCHEL_NORM_STRING = /obj/item/weapon/storage/backpack/satchel_norm,
		SATCHEL_ALT_STRING = /obj/item/weapon/storage/backpack/satchel,
		MESSENGER_BAG_STRING = /obj/item/weapon/storage/backpack/messenger,
	)

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset,
			slot_w_uniform_str = /obj/item/clothing/under/rank/janitor,
			slot_shoes_str = /obj/item/clothing/shoes/black,
		),
		/datum/species/plasmaman/ = list(
			slot_ears_str = /obj/item/device/radio/headset,
			slot_w_uniform_str = /obj/item/clothing/under/rank/janitor,
			slot_shoes_str = /obj/item/clothing/shoes/black,
			slot_wear_suit_str = /obj/item/clothing/suit/space/plasmaman/janitor,
			slot_head_str = /obj/item/clothing/head/helmet/space/plasmaman/janitor,
			slot_wear_mask_str = /obj/item/clothing/mask/breath,
		),
		/datum/species/vox/ = list(
			slot_ears_str = /obj/item/device/radio/headset,
			slot_w_uniform_str = /obj/item/clothing/under/rank/janitor,
			slot_shoes_str = /obj/item/clothing/shoes/black,
			slot_wear_suit_str = /obj/item/clothing/suit/space/vox/civ/janitor,
			slot_head_str = /obj/item/clothing/head/helmet/space/vox/civ/janitor,
			slot_wear_mask_str = /obj/item/clothing/mask/breath/vox,
		),
	)

/datum/outfit/janitor/post_equip(var/mob/living/carbon/human/H)
	H.add_language(LANGUAGE_MOUSE)
	to_chat(H, "<span class = 'notice'>Decades of roaming maintenance tunnels and interacting with its denizens have granted you the ability to understand the speech of mice and rats.</span>")
	return 1

/datum/job/janitor/priority_reward_equip(var/mob/living/carbon/human/H)
	. = ..()
	H.equip_or_collect(new /obj/item/weapon/grenade/chem_grenade/cleaner(H.back), slot_in_backpack)
	H.equip_or_collect(new /obj/item/weapon/reagent_containers/spray/cleaner(H.back), slot_in_backpack)