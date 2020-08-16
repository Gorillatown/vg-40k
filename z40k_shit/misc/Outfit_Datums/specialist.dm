// ------------ Sergeant --------------//
/*/datum/job/IG_weapon_specialist
	title = "Weapon Specialist"
	flag = IGWEPSPEC
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 7
	spawn_positions = 5
	wage_payout = 65
	supervisors = "deez nuts"
	selection_color = "#A6EAA9"
	access = list()
	minimal_player_age = 7
	outfit_datum = /datum/outfit/IG_weapon_specialist
	species_whitelist = list("Human")
	landmark_job_override = TRUE

	relationship_chance = HUMAN_COMMON


// ------------ Sergeant Outfit Datum --------------//
*/
/datum/outfit/IG_weapon_specialist

	outfit_name = "IG Weapon Specialist"
//	associated_job = /datum/job/IG_weapon_specialist
	no_backpack = TRUE

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset,
			slot_w_uniform_str = /obj/item/clothing/under/ig_guard,
			slot_head_str = /obj/item/clothing/head/IG_cadian_helmet,
			slot_shoes_str = /obj/item/clothing/shoes/IG_wepspec_boots,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/IG_cadian_armor,
			slot_gloves_str = /obj/item/clothing/gloves/IG_wepspec_gloves,
			slot_s_store_str = /obj/item/weapon/chainsword,
			slot_r_hand = /obj/item/weapon/gun/ig_plasma_gun,
			slot_wear_mask_str = /obj/item/clothing/mask/gas/ig_wepspec_mask,
			slot_back_str = /obj/item/weapon/iguard/ig_powerpack
		),
	)

	implant_types = list(
	)

	id_type = /obj/item/weapon/card/id/imperial_guard_dogtag

/datum/outfit/IG_weapon_specialist/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("Frequencies list: <br/> <b>Security:</b> [SEC_FREQ]<br/>")

/datum/outfit/IG_weapon_specialist/handle_faction(var/mob/living/M)
	var/datum/role/imperial_guard/wepspec/wepspec = new
	wepspec.AssignToRole(M.mind,TRUE)
	wepspec.mind_storage(M.mind)