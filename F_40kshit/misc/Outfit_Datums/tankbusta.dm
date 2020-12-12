/*/datum/job/orktankbusta
	title = "Ork Tankbusta"
	flag = ORKTANKBUSTA
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	wage_payout = 0
	supervisors = "da boss"
	selection_color = "#FFB5B5"
	species_whitelist = list("Ork") //Orks are whitelisted to orks
	access = list()
	landmark_job_override = TRUE
	alt_titles = list("Ork Tankbusta")
	outfit_datum = /datum/outfit/orktankbusta

	relationship_chance = XENO_NO_RELATIONS
*/
/datum/outfit/orktankbusta

	outfit_name = "Ork Tankbusta"
//	associated_job = /datum/job/orktankbusta
	no_backpack = TRUE
	no_id = TRUE

	items_to_spawn = list(
		"Default" = list(
			slot_w_uniform_str = /obj/item/clothing/under/ig_guard,
		),
		/datum/species/ork = list(
			slot_w_uniform_str = list(
				"Ork Tankbusta" = list(/obj/item/clothing/under/ork_pantsandshirt,
									/obj/item/clothing/under/ork_pants,
									/obj/item/clothing/under/ork_leatherpantsandshirt)
			),
			slot_shoes_str = list(
				"Ork Tankbusta" = list(/obj/item/clothing/shoes/orkboots)
			),
			slot_gloves_str = list(
				"Ork Tankbusta" = list(/obj/item/clothing/gloves/clothgloves)
			),
			slot_belt_str = list(
				"Ork Tankbusta" = list(/obj/item/weapon/storage/belt/armorbelt/rokkitbelt,
										/obj/item/weapon/storage/belt/basicbelt/rokkitbelt)
			),
			slot_head_str = list(
				"Ork Tankbusta" = list(/obj/item/clothing/head/armorhelmet,
									/obj/item/clothing/head/bucket,
									/obj/item/clothing/head/redbandana,
									/obj/item/clothing/head/milcap)
			),
			slot_wear_suit_str = list(
				"Ork Tankbusta" = list(/obj/item/clothing/suit/armor/samuraiorkarmor,
									/obj/item/clothing/suit/armor/rwallplate,
									/obj/item/clothing/suit/armor/ironplate,
									/obj/item/clothing/suit/armor/leatherbikervest)
			),
			slot_back_str = list(
				"Ork Tankbusta" = list(/obj/item/weapon/gun/projectile/rocketlauncher/rokkitlauncha)
			)
		)
	)


/datum/outfit/orktankbusta/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("WAAAAAAAAGH!")

/datum/outfit/orktankbusta/handle_faction(var/mob/living/carbon/human/H)
	var/datum/role/ork_raider/new_busta = new
	new_busta.AssignToRole(H.mind,TRUE)
	new_busta.mind_storage(H.mind)

/datum/outfit/orktankbusta/handle_special_abilities(var/mob/living/carbon/human/H)
	H.add_spell(new /spell/aoe_turf/waaagh1, "ork_spell_ready", /obj/abstract/screen/movable/spell_master/ork_racial)
