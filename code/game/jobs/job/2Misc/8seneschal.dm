//--------------seneschal---------------//
/datum/job/seneschal //This will be seneschal
	title = "Seneschal"
	flag = SENESCHAL
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	wage_payout = 65
	supervisors = "the lord"
	selection_color = "#E0D68B"
	access = list(access_seneschal)
	minimal_player_age = 7
	outfit_datum = /datum/outfit/seneschal
	species_whitelist = list("Human")
	landmark_job_override = TRUE

	relationship_chance = HUMAN_NO_RELATIONS

//-------------seneschal Outfit Datums--------------//
/datum/outfit/seneschal

	outfit_name = "Seneschal"
	associated_job = /datum/job/seneschal
	no_backpack = TRUE

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset,
			slot_w_uniform_str = /obj/item/clothing/under/seneschal,
			slot_shoes_str = /obj/item/clothing/shoes/seneschal_boots,
			slot_head_str = /obj/item/clothing/head/seneschal_hat,
		),
	)

	items_to_collect = list(
	)

	implant_types = list(
		/obj/item/weapon/implant/loyalty/,
	)

	id_type = /obj/item/weapon/card/id/imperial_guard_dogtag

/datum/outfit/seneschal/handle_faction(var/mob/living/M)
/*	var/datum/role/imperial_guard/seneschal/seneschal = new
	seneschal.AssignToRole(M.mind,TRUE)
	seneschal.mind_storage(M.mind)*/

/datum/outfit/seneschal/handle_special_abilities(var/mob/living/carbon/human/H)
	H.attribute_strength = 10
	H.attribute_agility = 10
	H.attribute_dexterity = 10
	return 1