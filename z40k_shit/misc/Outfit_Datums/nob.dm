/*/datum/job/orknob
	title = "Ork Nob"
	flag = ORKNOB
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 5
	spawn_positions = 3
	wage_payout = 0
	supervisors = "da boss"
	selection_color = "#FFB5B5"
	species_whitelist = list("Ork") //Orks are whitelisted to orks
	access = list()
	landmark_job_override = TRUE
	alt_titles = list("Ork Nob")
	outfit_datum = /datum/outfit/orknob

	relationship_chance = XENO_NO_RELATIONS
	must_be_map_enabled = 1
*/
/datum/outfit/orknob

	outfit_name = "Ork Nob"
//	associated_job = /datum/job/orknob
	no_backpack = TRUE
	no_id = TRUE

	items_to_spawn = list(
		"Default" = list(
			slot_w_uniform_str = list(
				"Ork Nob" = /obj/item/clothing/under/color/grey,

			),
				slot_shoes_str = /obj/item/clothing/shoes/black,
		),
		/datum/species/ork/nob = list( 
			slot_w_uniform_str = list(
				"Ork Nob" = list(/obj/item/clothing/under/ork_pants,
								/obj/item/clothing/under/ork_pantsandshirt,
								/obj/item/clothing/under/ork_leatherpantsandshirt)
			),
			slot_head_str = list(
				"Ork Nob" = list(/obj/item/clothing/head/armorhelmet,
								/obj/item/clothing/head/redbandana,
								/obj/item/clothing/head/milcap)
			),
			slot_wear_suit_str = list(
				"Ork Nob" = list(/obj/item/clothing/suit/armor/samuraiorkarmor,
								/obj/item/clothing/suit/armor/rwallplate,
								/obj/item/clothing/suit/armor/ironplate,
								/obj/item/clothing/suit/armor/leatherbikervest)
			),
			slot_belt_str = list(
				"Ork Nob" = list(/obj/item/weapon/storage/belt/basicbelt/stikkbombs)
			),
			slot_shoes_str = /obj/item/clothing/shoes/orkboots,
			slot_back_str = /obj/item/weapon/storage/backpack/brownbackpack/kustomshootabelts,
			slot_r_hand = list(
				"Ork Nob" = list(/obj/item/weapon/gun/projectile/kustomshoota)
			),
		)
	)

/datum/outfit/orknob/pre_equip(var/mob/living/carbon/human/H)
	H.set_species("Ork Nob")

/datum/outfit/orknob/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("WAAAAAAAAGH!")

/datum/outfit/orknob/handle_faction(var/mob/living/carbon/human/H)
	var/datum/role/ork_raider/nob/new_nob = new
	new_nob.AssignToRole(H.mind,TRUE)
	new_nob.mind_storage(H.mind)

/datum/outfit/orknob/handle_special_abilities(var/mob/living/carbon/human/H)
	H.add_spell(new /spell/aoe_turf/waaagh1, "ork_spell_ready", /obj/abstract/screen/movable/spell_master/ork_racial)