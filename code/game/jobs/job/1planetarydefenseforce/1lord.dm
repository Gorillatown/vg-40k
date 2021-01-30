
/datum/job/lord
	title = "Lord"
	flag = LORD
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "yourself, and maybe the imperium"
	selection_color = "#f8cb69"
	req_admin_notify = 1
	access = list(access_lord,access_seneschal,access_checkpoints,access_armory,access_garage) //See get_access()
	minimal_player_age = 30
	wage_payout = 100
	landmark_job_override = TRUE

	species_whitelist = list("Human")
	outfit_datum = /datum/outfit/lord

	relationship_chance = HUMAN_SUPER_RARE

/datum/outfit/lord

	outfit_name = "Lord"
	associated_job = /datum/job/lord
	no_backpack = TRUE

	items_to_spawn = list( 
		"Default" = list(
			slot_head_str = /obj/item/clothing/head/lord_hat,
			slot_ears_str = /obj/item/device/radio/headset,
			slot_w_uniform_str = /obj/item/clothing/under/lord_uniform,
			slot_shoes_str = /obj/item/clothing/shoes/lord_boots,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/lord_suit,
			slot_belt_str = /obj/item/weapon/dksword,
			slot_s_store_str = /obj/item/weapon/gun/projectile/automatic/boltpistol,
			slot_l_store_str = /obj/item/weapon/gun/projectile/needler,
			slot_back_str = /obj/item/weapon/storage/backpack/brownbackpack
		)
	)
	 
	implant_types = list(
		/obj/item/weapon/implant/loyalty/,
	)

	id_type = /obj/item/weapon/card/id/imperial_guard_dogtag

/datum/outfit/lord/post_equip(var/mob/living/carbon/human/H)
	var/changed_name
	if(H.gender == MALE)
		changed_name = "Lord" + " " + "[H.first_name]" + " " + "Mannheim"
		H.real_name = changed_name
	else
		changed_name = "Lady" + " " + "[H.first_name]" + " " + "Mannheim"
		H.real_name = changed_name
	H.check_dna(H)

	if(H.wear_id)
		var/obj/item/weapon/card/id/id = H.wear_id
		id.name = "[H.real_name]'s ID Card"
		id.registered_name = H.real_name
	quest_master.configure_quest(H,TZEENTCH_CHAMPION)
	to_chat(world, "<b>[H.real_name] is the Lord of these lands!</b>")

/datum/outfit/lord/handle_special_abilities(var/mob/living/carbon/human/H)
	H.attribute_strength += 3 //8 + 3 = 11
	H.attribute_agility += 1
	H.attribute_dexterity += 1
	return 1

/datum/outfit/lord/handle_faction(var/mob/living/M)
	var/datum/role/planetary_defense_force/new_trooper = new
	new_trooper.AssignToRole(M.mind,TRUE)
