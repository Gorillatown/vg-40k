/datum/job/basicork
	title = "Slugga Boy"
	flag = BASICORK
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 500
	spawn_positions = 10
	wage_payout = 0
	supervisors = "da boss"
	selection_color = "#FFB5B5"
	species_whitelist = list("Ork") //Orks are whitelisted to orks
	access = list()
	landmark_job_override = TRUE
	alt_titles = list("Slugga Boy", "Shoota Boy", "Kommando", "Burna Boy", "Storm Boy")
	outfit_datum = /datum/outfit/basicork

	relationship_chance = XENO_NO_RELATIONS

/datum/outfit/basicork

	outfit_name = "Basic Ork"
	associated_job = /datum/job/basicork
	no_backpack = TRUE
	no_id = TRUE

	items_to_spawn = list(
		"Default" = list(
			slot_w_uniform_str = list(
				"Slugga Boy" = /obj/item/clothing/under/color/grey,
				"Shoota Boy" =  /obj/item/clothing/under/color/grey,
				"Kommando" = /obj/item/clothing/under/color/grey,
				"Burna Boy" = /obj/item/clothing/under/color/grey,
				"Storm Boy" = /obj/item/clothing/under/color/grey,
			),
				slot_shoes_str = /obj/item/clothing/shoes/black,
		),
		/datum/species/ork = list( 
			slot_w_uniform_str = list(
				"Slugga Boy" =	list(/obj/item/clothing/under/ork/pantsandshirt,
									/obj/item/clothing/under/ork/pants,
									/obj/item/clothing/under/ork/leatherpantsandshirt),
				"Shoota Boy" = list(/obj/item/clothing/under/ork/pants,
									/obj/item/clothing/under/ork/pantsandshirt),
				"Kommando" = list(/obj/item/clothing/under/ork/pants,
									/obj/item/clothing/under/ork/pantsandshirt),
				"Burna Boy" = /obj/item/clothing/under/ork/pants,
				"Storm Boy" = list(/obj/item/clothing/under/ork/pants,
									/obj/item/clothing/under/ork/pantsandshirt),
			),
			slot_head_str = list(
				"Slugga Boy" = list(/obj/item/clothing/head/ork/armorhelmet,
									/obj/item/clothing/head/ork/bucket),
				"Shoota Boy" = list(/obj/item/clothing/head/ork/armorhelmet,
									/obj/item/clothing/head/ork/milcap),
				"Kommando" = list(/obj/item/clothing/head/ork/redbandana,
									/obj/item/clothing/head/ork/milcap),
				"Burna Boy" = list(/obj/item/clothing/head/ork/redbandana,
									/obj/item/clothing/head/ork/milcap),
				"Storm Boy" = list(/obj/item/clothing/head/ork/armorhelmet,
									/obj/item/clothing/head/ork/redbandana)
			),
			slot_wear_suit_str = list(
				"Slugga Boy" = list(/obj/item/clothing/suit/armor/ork/samuraiorkarmor,
									/obj/item/clothing/suit/armor/ork/rwallplate,
									/obj/item/clothing/suit/armor/ork/ironplate),
				"Shoota Boy" = list(/obj/item/clothing/suit/armor/ork/rwallplate,
									/obj/item/clothing/suit/armor/ork/leatherbikervest),
				"Kommando" = list(/obj/item/clothing/suit/armor/ork/leatherbikervest),
				"Burna Boy" = list(/obj/item/clothing/suit/armor/ork/leatherbikervest,
									/obj/item/clothing/suit/armor/ork/rwallplate),
				"Storm Boy" = list(/obj/item/clothing/suit/armor/ork/samuraiorkarmor,
									/obj/item/clothing/suit/armor/ork/rwallplate,
									/obj/item/clothing/suit/armor/ork/leatherbikervest)
			),
			slot_shoes_str = /obj/item/clothing/shoes/ork/orkboots,
			slot_belt_str = list(
				"Slugga Boy" = list(/obj/item/weapon/storage/belt/ork/armorbelt,
									/obj/item/weapon/storage/belt/ork/basicbelt,
									/obj/item/weapon/storage/belt/ork/basicbelt/stikkbombs),
				"Shoota Boy" = list(/obj/item/weapon/storage/belt/ork/basicbelt),
				"Kommando" = list(/obj/item/weapon/storage/belt/ork/basicbelt/stikkbombs),
				"Burna Boy" = list(/obj/item/weapon/storage/belt/ork/armorbelt),
				"Storm Boy" = list(/obj/item/weapon/storage/belt/ork/basicbelt)
			),
			slot_back_str = list(
				"Slugga Boy" = /obj/item/weapon/storage/backpack/ork/brownbackpack/sluggakit,
				"Shoota Boy" = /obj/item/weapon/storage/backpack/ork/brownbackpack/shootakit,
				"Kommando"	= /obj/item/weapon/storage/backpack/ork/brownbackpack/kommandokit,
				"Burna Boy"	= /obj/item/weapon/ork/burnapack,
				"Storm Boy"	= /obj/item/ork/jumppack, 
			),
			slot_r_hand = list(
				"Slugga Boy" = list(/obj/item/weapon/gun/projectile/automatic/slugga,
									/obj/item/weapon/choppa,
									/obj/item/weapon/shield/orkshield),
				"Shoota Boy" = /obj/item/weapon/gun/projectile/automatic/shoota,
				"Kommando" = /obj/item/weapon/gun/projectile/shotgun/shotta,
				"Storm Boy" = /obj/item/weapon/choppa
			),
			slot_l_hand = list(
				"Slugga Boy" = list(/obj/item/weapon/choppa,
									/obj/item/weapon/shield/orkshield,
									/obj/item/weapon/gun/projectile/automatic/slugga),
				"Kommando" = /obj/item/weapon/choppa
			)
		)
	)

 
/datum/outfit/basicork/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("WAAAAAAAAGH!")

/datum/outfit/basicork/handle_faction(var/mob/living/carbon/human/H)
	var/datum/role/ork_raider/new_boy = new
	new_boy.AssignToRole(H.mind,TRUE)
	new_boy.mind_storage(H.mind)

/datum/outfit/basicork/handle_special_abilities(var/mob/living/carbon/human/H)
	H.add_spell(new /spell/aoe_turf/waaagh1, "ork_spell_ready", /obj/abstract/screen/movable/spell_master/ork_racial)
