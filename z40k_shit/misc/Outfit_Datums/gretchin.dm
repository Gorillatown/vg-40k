/*/datum/job/gretchin
	title = "Gretchin"
	flag = ORKGRETCHIN
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	wage_payout = 0
	supervisors = "NOT YA SELF IF YOU KNOW WOTS GOOD FOR YA"
	selection_color = "#FFB5B5"
	species_whitelist = list("Ork") //Orks are whitelisted to orks
	access = list()
	landmark_job_override = TRUE
	outfit_datum = /datum/outfit/orkgretchin
	must_be_map_enabled = 0

	relationship_chance = XENO_NO_RELATIONS
*/
/datum/outfit/orkgretchin

	outfit_name = "Gretchin"
//	associated_job = /datum/job/gretchin
	no_backpack = TRUE
	no_id = TRUE

	items_to_spawn = list(
		"Default" = list(
			slot_w_uniform_str = /obj/item/clothing/under/ig_guard,
		),
		/datum/species/ork/gretchin = list()
	)

/datum/outfit/orkgretchin/pre_equip(var/mob/living/carbon/human/H)
	H.set_species("Ork Gretchin")

/datum/outfit/orkgretchin/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("WAAAAAAAAGH!")

/datum/outfit/orkgretchin/handle_faction(var/mob/living/carbon/human/H)
	var/datum/role/ork_raider/warboss/new_boss = new
	new_boss.AssignToRole(H.mind,TRUE)
	new_boss.mind_storage(H.mind)

