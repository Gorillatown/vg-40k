/datum/job/preacher
	title = "Preacher"
	flag = PREACHER
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "The Ecclesiarchy"
	wage_payout = 25
	selection_color = "#E0D68B"
	access = list()
	var/datum/religion/chap_religion
	landmark_job_override = TRUE
	
	species_whitelist = list("Human")
	outfit_datum = /datum/outfit/preacher

	relationship_chance = HUMAN_SOMEWHAT_RARE

/datum/outfit/preacher

	outfit_name = "Preacher"
	associated_job = /datum/job/preacher
	no_backpack = TRUE

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset,
			slot_w_uniform_str = /obj/item/clothing/under/rank/chaplain,
			slot_shoes_str = /obj/item/clothing/shoes/laceup,
			slot_gloves_str = /obj/item/clothing/gloves/black,
			slot_l_store_str = /obj/item/weapon/nullrod,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/preacherrobe,
			slot_back_str = /obj/item/weapon/gun/projectile/eviscerator,
		)
	)

	implant_types = list(
		/obj/item/weapon/implant/loyalty/,
	)

	id_type = /obj/item/weapon/card/id/imperial_guard_dogtag

/datum/outfit/preacher/post_equip(var/mob/living/carbon/human/H)
	H.add_language("Spooky") //SPOOK
	ChooseReligion(H, FALSE) //Our mob, the second var is if we are a follower of Chaos.

/datum/outfit/preacher/handle_faction(var/mob/living/M)
/*	var/datum/role/imperial_guard/preacher/preacher = new
	preacher.AssignToRole(M.mind,TRUE)
	preacher.mind_storage(M.mind)*/
 
/datum/outfit/preacher/handle_special_abilities(var/mob/living/carbon/human/H)
	H.attribute_strength = 12
	H.attribute_agility = 10
	return 1
