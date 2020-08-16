
/datum/job/knight_officer 
	title = "Knight Officer"
	flag = KNIGHTOFFICER
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	supervisors = "the lord of these lands"
	selection_color = "#f8cb69"
	req_admin_notify = 1
	wage_payout = 80
	access = list(access_knight,access_enginseer,access_seneschal) 
	minimal_player_age = 30
	landmark_job_override = TRUE

	species_whitelist = list("Human")

	outfit_datum = /datum/outfit/knight_officer

	relationship_chance = HUMAN_NO_RELATIONS

/datum/outfit/knight_officer

	outfit_name = "Knight Officer"
	associated_job = /datum/job/knight_officer 
	no_backpack = TRUE

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset,
			slot_w_uniform_str = /obj/item/clothing/under/knight_officer,
			slot_head_str = /obj/item/clothing/head/knight_officer_helmet,
			slot_shoes_str = /obj/item/clothing/shoes/knight_officer,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/knight_officer,
			slot_r_hand = /obj/item/weapon/chainaxe
		),
	)

	implant_types = list(
		/obj/item/weapon/implant/loyalty/,
	)

	id_type = /obj/item/weapon/card/id/imperial_guard_dogtag

/datum/outfit/knight_officer/post_equip(var/mob/living/carbon/human/H)
	var/changed_name
	if(H.gender == MALE)
		changed_name = "Sir" + " " + "[H.real_name]"
		H.real_name = changed_name
	else
		changed_name = "Dame" + " " + "[H.real_name]"
		H.real_name = changed_name
	H.check_dna(H)

	if(H.wear_id)
		var/obj/item/weapon/card/id/id = H.wear_id
		id.name = "[H.real_name]'s ID Card"
		id.registered_name = H.real_name
	

/datum/outfit/knight_officer/handle_special_abilities(var/mob/living/carbon/human/H)
	H.attribute_strength = 10
	H.attribute_agility = 10
	H.attribute_dexterity = 10
	return 1