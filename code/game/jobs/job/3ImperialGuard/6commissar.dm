//------------Commissar---------------//
/datum/job/commissar 
	title = "Commissar"
	flag = COMMISSAR
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Regiment General"
	selection_color = "#E0D68B"
	req_admin_notify = 1
	wage_payout = 80
	access = list() 
	minimal_player_age = 30
	landmark_job_override = TRUE

	species_whitelist = list("Human")

	outfit_datum = /datum/outfit/commissar

	relationship_chance = HUMAN_NO_RELATIONS

//-------------Commissar Outfit Datum--------------//
/datum/outfit/commissar 

	outfit_name = "Commissar"
	associated_job = /datum/job/commissar
	no_backpack = TRUE

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset,
			slot_w_uniform_str = /obj/item/clothing/under/commissar,
			slot_head_str = /obj/item/clothing/head/commissarcap,
			slot_shoes_str = /obj/item/clothing/shoes/jackboots/inquisitor,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/comissarcoat,
			slot_s_store_str = /obj/item/weapon/gun/projectile/automatic/boltpistol,
			slot_l_hand = /obj/item/weapon/chainsword
		),
	)

	implant_types = list(
		/obj/item/weapon/implant/loyalty/,
	)

	id_type = /obj/item/weapon/card/id/imperial_guard_dogtag

/datum/outfit/commissar/post_equip(var/mob/living/carbon/human/H)
	

/datum/outfit/commissar/handle_faction(var/mob/living/M)
	var/datum/role/imperial_guard/commissar/commissar = new
	commissar.AssignToRole(M.mind,TRUE)
	commissar.mind_storage(M.mind)

/datum/outfit/commissar/handle_special_abilities(var/mob/living/carbon/human/H)
	H.attribute_strength = 9
	H.attribute_agility = 9
	H.attribute_dexterity = 9
	return 1