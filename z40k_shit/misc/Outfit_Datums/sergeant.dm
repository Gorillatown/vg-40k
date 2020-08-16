// ------------ Sergeant --------------//
/*/datum/job/IG_trooper_sergeant
	title = "Sergeant"
	flag = IGSERGEANT
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 5
	spawn_positions = 3
	wage_payout = 65
	supervisors = "the head of security"
	selection_color = "#A6EAA9"
	access = list()
	minimal_player_age = 7
	outfit_datum = /datum/outfit/IG_trooper_sergeant
	species_whitelist = list("Human")
	landmark_job_override = TRUE

	relationship_chance = HUMAN_COMMON


// ------------ Sergeant Outfit Datum --------------//
*/
/datum/outfit/IG_trooper_sergeant

	outfit_name = "Sergeant"
//	associated_job = /datum/job/IG_trooper_sergeant

	backpack_types = list(
		BACKPACK_STRING = /obj/item/weapon/storage/backpack/trooperbag,
		SATCHEL_NORM_STRING = /obj/item/weapon/storage/backpack/trooperbag,
		SATCHEL_ALT_STRING = /obj/item/weapon/storage/backpack/trooperbag,
		MESSENGER_BAG_STRING = /obj/item/weapon/storage/backpack/trooperbag,
	)

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset,
			slot_w_uniform_str = /obj/item/clothing/under/ig_guard,
			slot_shoes_str = /obj/item/clothing/shoes/IG_cadian_boots,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/IG_cadian_armor,
			slot_s_store_str = /obj/item/weapon/gun/energy/lasgun,
			slot_r_hand = /obj/item/weapon/chainsword,
		),
	)

	implant_types = list(
	)

	id_type = /obj/item/weapon/card/id/imperial_guard_dogtag

/datum/outfit/IG_trooper_sergeant/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("Frequencies list: <br/> <b>Security:</b> [SEC_FREQ]<br/>")

/datum/outfit/IG_trooper_sergeant/handle_faction(var/mob/living/M)
	var/datum/role/imperial_guard/sergeant/new_trooper = new
	new_trooper.AssignToRole(M.mind,TRUE)
	new_trooper.mind_storage(M.mind)

/datum/outfit/IG_trooper_sergeant/handle_special_abilities(var/mob/living/carbon/human/H)
	H.attribute_strength = 9
	H.attribute_agility = 10
	H.attribute_dexterity = 10
	return 1
