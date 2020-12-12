/*/datum/job/orkwarboss
	title = "Ork Warboss"
	flag = ORKWARBOSS
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	wage_payout = 0
	supervisors = "YA SELF"
	selection_color = "#FFB5B5"
	species_whitelist = list("Ork") //Orks are whitelisted to orks
	access = list()
	landmark_job_override = TRUE
	outfit_datum = /datum/outfit/orkwarboss
	must_be_map_enabled = 1

	relationship_chance = XENO_NO_RELATIONS
*/
/datum/outfit/orkwarboss

	outfit_name = "Ork Warboss"
//	associated_job = /datum/job/orkwarboss
	no_backpack = TRUE
	no_id = TRUE

	items_to_spawn = list(
		"Default" = list(
			slot_w_uniform_str = /obj/item/clothing/under/ig_guard,
		),
		/datum/species/ork/warboss = list( 
			slot_w_uniform_str = /obj/item/clothing/under/warboss_pants,
			slot_shoes_str = /obj/item/clothing/shoes/bossboots,
			slot_gloves_str = /obj/item/clothing/gloves/warboss_armorbracers,
			slot_belt_str = /obj/item/weapon/storage/belt/warboss,
			slot_head_str = /obj/item/clothing/head/warboss/bossarmorhelmet,
			slot_wear_suit_str = /obj/item/clothing/suit/armor/warboss_platearmor,
			slot_back_str = /obj/item/weapon/storage/backpack/brownbackpack,
			slot_r_hand = /obj/item/weapon/boss_choppa
		)
	)

/datum/outfit/orkwarboss/pre_equip(var/mob/living/carbon/human/H)
	H.set_species("Ork Warboss")

/datum/outfit/orkwarboss/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("WAAAAAAAAGH!")

/datum/outfit/orkwarboss/handle_faction(var/mob/living/carbon/human/H)
	var/datum/role/ork_raider/warboss/new_boss = new
	new_boss.AssignToRole(H.mind,TRUE)
	new_boss.mind_storage(H.mind)

/datum/outfit/orkwarboss/handle_special_abilities(var/mob/living/carbon/human/H)
	H.add_spell(new /spell/aoe_turf/warbosswaaagh, "ork_spell_ready", /obj/abstract/screen/movable/spell_master/ork_racial)
