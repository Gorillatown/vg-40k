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
			slot_r_store_str = /obj/item/weapon/shield/energy,
			slot_belt_str = /obj/item/weapon/psychic_spellbook,
		),
	)

	items_to_collect = list(
	)

	implant_types = list(
		/obj/item/weapon/implant/loyalty/,
	)

	id_type = /obj/item/weapon/card/id/imperial_guard_dogtag

/datum/outfit/inquisitor/handle_faction(var/mob/living/M)
	var/datum/role/planetary_defense_force/new_trooper = new
	new_trooper.AssignToRole(M.mind,TRUE)
 
/datum/outfit/inquisitor/handle_special_abilities(var/mob/living/carbon/human/H)
	H.attribute_strength += 2
	H.attribute_agility += 4
	H.attribute_dexterity += 5
	H.attribute_willpower = 11
	H.attribute_sensitivity = 500
	H.psyker_points = 2
	return 1