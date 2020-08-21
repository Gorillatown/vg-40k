/datum/job/bartender
	title = "Bartender"
	flag = BARTENDER
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the lord"
	wage_payout = 20
	selection_color = "#dddddd"
	access = list()
	species_blacklist = list("Ork")
	outfit_datum = /datum/outfit/bartender

	relationship_chance = HUMAN_COMMON
	landmark_job_override = TRUE

/datum/outfit/bartender
	outfit_name = "Bartender"
	associated_job = /datum/job/bartender
	no_id = TRUE

	backpack_types = list(
		BACKPACK_STRING = /obj/item/weapon/storage/backpack,
		SATCHEL_NORM_STRING = /obj/item/weapon/storage/backpack/satchel_norm,
		SATCHEL_ALT_STRING = /obj/item/weapon/storage/backpack/satchel,
		MESSENGER_BAG_STRING = /obj/item/weapon/storage/backpack/messenger,
	)
	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset/headset_service,
			slot_w_uniform_str = /obj/item/clothing/under/rank/bartender,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/vest,
			slot_shoes_str = /obj/item/clothing/shoes/black,
		),
		/datum/species/plasmaman/ = list(
			slot_ears_str = /obj/item/device/radio/headset,
			slot_w_uniform_str = /obj/item/clothing/under/rank/bartender,
			slot_shoes_str = /obj/item/clothing/shoes/black,
			slot_wear_suit_str = /obj/item/clothing/suit/space/plasmaman/service,
			slot_wear_mask_str =  /obj/item/clothing/mask/breath/,
			slot_head_str = /obj/item/clothing/head/helmet/space/plasmaman/service,
		),
		/datum/species/vox/ = list(
			slot_ears_str = /obj/item/device/radio/headset,
			slot_w_uniform_str = /obj/item/clothing/under/rank/bartender,
			slot_shoes_str = /obj/item/clothing/shoes/black,
			slot_wear_suit_str = /obj/item/clothing/suit/space/vox/civ/bartender,
			slot_wear_mask_str =  /obj/item/clothing/mask/breath/vox,
			slot_head_str = /obj/item/clothing/head/helmet/space/vox/civ/bartender,
		),
	)

	items_to_collect = list(
		/obj/item/ammo_casing/shotgun/beanbag = "Survival Box",
		/obj/item/ammo_casing/shotgun/beanbag = "Survival Box",
		/obj/item/ammo_casing/shotgun/beanbag = "Survival Box",
		/obj/item/ammo_casing/shotgun/beanbag = "Survival Box",
		/obj/item/weapon/reagent_containers/food/drinks/shaker = slot_l_store_str,
	)

/datum/outfit/bartender/post_equip(var/mob/living/carbon/human/H)
	H.put_in_hands(new /obj/item/weapon/storage/bag/plasticbag(H))
	H.dna.SetSEState(SOBERBLOCK,1)
	H.mutations += M_SOBER
	H.check_mutations = 1
	H.mind.store_memory("Frequencies list: <br/> <b>Service:</b> [SER_FREQ]<br/>")

/datum/job/bartender/priority_reward_equip(var/mob/living/carbon/human/H)
	. = ..()
	H.equip_or_collect(new /obj/item/weapon/circuitboard/chem_dispenser/soda_dispenser(H.back), slot_in_backpack)
	H.equip_or_collect(new /obj/item/weapon/circuitboard/chem_dispenser/booze_dispenser(H.back), slot_in_backpack)
