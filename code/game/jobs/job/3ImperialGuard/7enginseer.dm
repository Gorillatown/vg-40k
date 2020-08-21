//------------enginseer---------------//
/datum/job/enginseer 
	title = "Enginseer"
	flag = ENGINSEER
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "yourself"
	selection_color = "#E0D68B"
	req_admin_notify = 1
	wage_payout = 80
	access = list(access_enginseer,access_lord,access_checkpoints) 
	minimal_player_age = 30
	landmark_job_override = TRUE

	species_whitelist = list("Human")

	outfit_datum = /datum/outfit/enginseer

	relationship_chance = HUMAN_NO_RELATIONS

//-------------enginseer Outfit Datum--------------//
/datum/outfit/enginseer 

	outfit_name = "enginseer"
	associated_job = /datum/job/enginseer
	no_backpack = TRUE

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset,
			slot_w_uniform_str = /obj/item/clothing/under/enginseer_uniform,
			slot_head_str = /obj/item/clothing/head/enginseer_hood,
			slot_shoes_str = /obj/item/clothing/shoes/enginseer_boots,
			slot_back_str = /obj/item/enginseer_powerpack,
			slot_belt_str = /obj/item/weapon/storage/belt/enginseer_belt,
			slot_wear_mask_str = /obj/item/clothing/mask/gas/enginseer_mask
		),
	)

	implant_types = list(
		/obj/item/weapon/implant/loyalty/,
	)

	id_type = /obj/item/weapon/card/id/imperial_guard_dogtag

/datum/outfit/enginseer/post_equip(var/mob/living/carbon/human/H)
	

/datum/outfit/enginseer/handle_faction(var/mob/living/M)
	/*var/datum/role/imperial_guard/enginseer/enginseer = new
	enginseer.AssignToRole(M.mind,TRUE)
	enginseer.mind_storage(M.mind)*/

/datum/outfit/enginseer/handle_special_abilities(var/mob/living/carbon/human/H)
	H.attribute_strength = 12
	H.attribute_agility = 12
	H.attribute_dexterity = 13
	return 1