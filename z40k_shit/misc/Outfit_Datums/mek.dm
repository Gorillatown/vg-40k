/*/datum/job/basicmek
	title = "Mek"
	flag = BASICMEK
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	wage_payout = 0
	supervisors = "da boss"
	selection_color = "#FFB5B5"
	species_whitelist = list("Ork") //Orks are whitelisted to orks
	access = list()
	landmark_job_override = TRUE
	alt_titles = list("Mek")
	outfit_datum = /datum/outfit/basicmek

	relationship_chance = XENO_NO_RELATIONS
*/
/datum/outfit/basicmek

	outfit_name = "Basic Mek"
//	associated_job = /datum/job/basicmek
	no_backpack = TRUE
	no_id = TRUE

	items_to_spawn = list(
		"Default" = list(
			slot_w_uniform_str = list(
				"Mek" = /obj/item/clothing/under/color/grey,

			),
				slot_shoes_str = /obj/item/clothing/shoes/black,
		),
		/datum/species/ork = list( 
			slot_w_uniform_str = list(
				"Mek" = list(/obj/item/clothing/under/ork_pants,
								/obj/item/clothing/under/ork_pantsandshirt,
								/obj/item/clothing/under/ork_leatherpantsandshirt)
			),
			slot_head_str = list(
				"Mek" = list(/obj/item/clothing/head/redbandana,
								/obj/item/clothing/head/milcap)
			),
			slot_wear_suit_str = list(
				"Mek" = list(/obj/item/clothing/suit/armor/leatherbikervest)
			),
			slot_belt_str = list(
				"Mek" = list(/obj/item/weapon/storage/belt/basicbelt/stikkbombs)
			),
			slot_shoes_str = /obj/item/clothing/shoes/orkboots,
			slot_back_str = /obj/item/weapon/storage/backpack/brownbackpack/mekpack,
			slot_r_hand = list(
				"Mek" = list(/obj/item/weapon/gun/projectile/kustomshoota)
			),
		)
	)

/datum/outfit/basicmek/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("WAAAAAAAAGH!")

/datum/outfit/basicmek/handle_faction(var/mob/living/carbon/human/H)
	var/datum/role/ork_raider/new_boss = new
	new_boss.AssignToRole(H.mind,TRUE)
	new_boss.mind_storage(H.mind)

/datum/outfit/basicmek/handle_special_abilities(var/mob/living/carbon/human/H)
	H.add_spell(new /spell/aoe_turf/waaagh1, "ork_spell_ready", /obj/abstract/screen/movable/spell_master/ork_racial)
	H.add_spell(new /spell/aoe_turf/mekbuild, "ork_spell_ready", /obj/abstract/screen/movable/spell_master/ork_racial)
	H.attribute_strength = 12