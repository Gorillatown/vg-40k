/datum/job/doctor
	title = "Medical Doctor"
	flag = DOCTOR
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 5
	spawn_positions = 3
	wage_payout = 65
	supervisors = "the lord"
	selection_color = "#ffeef0"
	access = list()
	alt_titles = list("Emergency Physician", "Nurse", "Surgeon")
	outfit_datum = /datum/outfit/doctor
	species_blacklist = list("Ork")
	relationship_chance = HUMAN_COMMON
	landmark_job_override = TRUE


/datum/outfit/doctor
	outfit_name = "Medical Doctor"
	associated_job = /datum/job/doctor
	no_id = TRUE

	backpack_types = list(
		BACKPACK_STRING = /obj/item/weapon/storage/backpack/medic,
		SATCHEL_NORM_STRING = /obj/item/weapon/storage/backpack/satchel_med,
		SATCHEL_ALT_STRING = /obj/item/weapon/storage/backpack/satchel,
		MESSENGER_BAG_STRING = /obj/item/weapon/storage/backpack/messenger/med,
	)

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset/headset_med,
			slot_w_uniform_str = list(
				"Emergency Physician" = /obj/item/clothing/under/rank/medical,
				"Surgeon" =  /obj/item/clothing/under/rank/medical/blue,
				"Medical Doctor" = /obj/item/clothing/under/rank/medical,
			),
			slot_shoes_str = /obj/item/clothing/shoes/white,
			slot_glasses_str = /obj/item/clothing/glasses/hud/health,
			slot_wear_suit_str = list(
				"Emergency Physician" = /obj/item/clothing/suit/storage/fr_jacket,
				"Surgeon" =  /obj/item/clothing/suit/storage/labcoat,
				"Medical Doctor" =  /obj/item/clothing/suit/storage/labcoat,
			),
			slot_head_str = list(
				"Surgeron" = /obj/item/clothing/head/surgery/blue,
			),
			slot_s_store_str = /obj/item/device/flashlight/pen,
		),
		/datum/species/plasmaman = list(
			slot_ears_str = /obj/item/device/radio/headset/headset_med,
			slot_w_uniform_str = list(
				"Emergency Physician" = /obj/item/clothing/under/rank/medical,
				"Surgeon" =  /obj/item/clothing/under/rank/medical/blue,
				"Medical Doctor" = /obj/item/clothing/under/rank/medical,
			),
			slot_shoes_str = /obj/item/clothing/shoes/white,
			slot_glasses_str = /obj/item/clothing/glasses/hud/health,
			slot_wear_suit_str = /obj/item/clothing/suit/space/plasmaman/medical,
			slot_head_str = /obj/item/clothing/head/helmet/space/plasmaman/medical,
			slot_wear_mask_str =  /obj/item/clothing/mask/breath/,
		),
		/datum/species/vox = list(
			slot_ears_str = /obj/item/device/radio/headset/headset_med,
			slot_w_uniform_str = list(
				"Emergency Physician" = /obj/item/clothing/under/rank/medical,
				"Surgeon" =  /obj/item/clothing/under/rank/medical/blue,
				"Medical Doctor" = /obj/item/clothing/under/rank/medical,
			),
			slot_shoes_str = /obj/item/clothing/shoes/white,
			slot_glasses_str = /obj/item/clothing/glasses/hud/health,
			slot_wear_suit_str = /obj/item/clothing/suit/space/vox/civ/medical,
			slot_head_str = /obj/item/clothing/head/helmet/space/vox/civ/medical,
			slot_wear_mask_str =  /obj/item/clothing/mask/breath/,
		),
	)

	special_snowflakes = list(
		"Default" = list(
			"Nurse" = list(slot_w_uniform_str, slot_head_str),
		),
	)

// This right here is the proof that the female gender should be removed from the codebase. Fucking snowflakes
/datum/outfit/doctor/special_equip(var/title, var/slot, var/mob/living/carbon/human/H)
	switch (title)
		if ("Nurse")
			switch (slot)
				if (slot_w_uniform_str)
					if(H.gender == FEMALE)
						if(prob(50))
							H.equip_or_collect(new /obj/item/clothing/under/rank/nursesuit(H), slot_w_uniform)
						else
							H.equip_or_collect(new /obj/item/clothing/under/rank/nurse(H), slot_w_uniform)
					else
						H.equip_or_collect(new /obj/item/clothing/under/rank/medical/purple(H), slot_w_uniform)
				if (slot_head_str)
					if (H.gender == FEMALE)
						H.equip_or_collect(new /obj/item/clothing/head/nursehat(H), slot_head)

/datum/outfit/doctor/post_equip(var/mob/living/carbon/human/H)
	H.put_in_hands(new /obj/item/weapon/storage/firstaid/regular(get_turf(H)))
	H.mind.store_memory("Frequencies list: <br/><b>Medical:</b> [MED_FREQ]")

/datum/job/doctor/priority_reward_equip(var/mob/living/carbon/human/H)
	. = ..()
	H.equip_or_collect(new /obj/item/weapon/storage/belt/medical(H.back), slot_in_backpack)