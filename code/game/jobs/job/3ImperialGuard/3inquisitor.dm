//--------------Inquisitor---------------//
/datum/job/inquisitor //This will be inquisitor
	title = "Inquisitor"
	flag = INQUISITOR
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	wage_payout = 65
	supervisors = "the Emperor"
	selection_color = "#E0D68B"
	access = list()
	minimal_player_age = 7
	outfit_datum = /datum/outfit/inquisitor
	species_whitelist = list("Human")
	landmark_job_override = TRUE

	relationship_chance = HUMAN_NO_RELATIONS

//-------------Inquisitor Outfit Datums--------------//
/datum/outfit/inquisitor

	outfit_name = "Inquisitor"
	associated_job = /datum/job/inquisitor
	no_backpack = TRUE

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset,
			slot_w_uniform_str = /obj/item/clothing/under/inquisitor,
			slot_shoes_str = /obj/item/clothing/shoes/jackboots/inquisitor,
			slot_head_str = /obj/item/clothing/head/inqhat,
			slot_gloves_str = /obj/item/clothing/gloves/black,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/inq,
			slot_back_str = /obj/item/weapon/inq_katana,
			slot_r_store_str = /obj/item/weapon/shield/energy
		),
	)

	items_to_collect = list(
	)

	implant_types = list(
		/obj/item/weapon/implant/loyalty/,
	)

	id_type = /obj/item/weapon/card/id/imperial_guard_dogtag

/datum/outfit/inquisitor/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("Frequencies list: <b>Security:</b> [SEC_FREQ]<br/>")

/datum/outfit/inquisitor/handle_faction(var/mob/living/M)
/*	var/datum/role/imperial_guard/inquisitor/inquisitor = new
	inquisitor.AssignToRole(M.mind,TRUE)
	inquisitor.mind_storage(M.mind)*/

/datum/outfit/inquisitor/handle_special_abilities(var/mob/living/carbon/human/H)
	H.attribute_strength = 10
	H.attribute_agility = 12
	H.attribute_dexterity = 13
	return 1