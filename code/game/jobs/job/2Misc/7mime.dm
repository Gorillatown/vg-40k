/datum/job/mime
	title = "Mime"
	flag = MIME
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the inquisitor"
	wage_payout = 15
	selection_color = "#dddddd"
	access = list()
	species_whitelist = list("Human")
	outfit_datum = /datum/outfit/mime
	landmark_job_override = TRUE

	relationship_chance = HUMAN_COMMON

/datum/outfit/mime // ...
	
	outfit_name = "Mime"
	associated_job = /datum/job/mime
	no_id = TRUE

	backpack_types = list(
		BACKPACK_STRING = /obj/item/weapon/storage,
		SATCHEL_NORM_STRING = /obj/item/weapon/storage/backpack/satchel_norm,
		SATCHEL_ALT_STRING = /obj/item/weapon/storage/backpack/satchel,
		MESSENGER_BAG_STRING = /obj/item/weapon/storage/backpack/messenger,
	)

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset,
			slot_w_uniform_str = /obj/item/clothing/under/mime,
			slot_shoes_str = /obj/item/clothing/shoes/mime,
			slot_gloves_str = /obj/item/clothing/gloves/white,
			slot_wear_suit_str = /obj/item/clothing/suit/suspenders,
			slot_head_str = /obj/item/clothing/head/beret,
			slot_wear_mask_str = /obj/item/clothing/mask/gas/mime,
			slot_l_store_str = /obj/item/toy/crayon/mime,
		)
	)

	items_to_collect = list(
		/obj/item/weapon/reagent_containers/food/drinks/bottle/bottleofnothing = GRASP_LEFT_HAND
	)

/datum/outfit/mime/post_equip(var/mob/living/carbon/human/H)
	H.add_spell(new /spell/aoe_turf/conjure/forcewall/mime, "grey_spell_ready")
	H.add_spell(new /spell/targeted/oathbreak/)
	H.mind.miming = MIMING_OUT_OF_CHOICE
	mob_rename_self(H,"mime")
	quest_master.configure_quest(H,HARLEQUIN)
	return 1
	
 
//Mime's break vow spell, couldn't think of anywhere else to put this

/spell/targeted/oathbreak
	name = "Break Oath of Silence"
	desc = "Break your oath of silence."
	school = "mime"
	panel = "Mime"
	charge_max = 10
	spell_flags = INCLUDEUSER
	range = 0
	max_targets = 1

	hud_state = "mime_oath"
	override_base = "const"

/spell/targeted/oathbreak/cast(list/targets)
	for(var/mob/living/carbon/human/M in targets)
		var/response = alert(M, "Are you -sure- you want to break your oath of silence?\n(This removes your ability to create invisible walls and cannot be undone!)","Are you sure you want to break your oath?","Yes","No")
		if(response != "Yes")
			return
		M.mind.miming=0
		for(var/spell/aoe_turf/conjure/forcewall/mime/spell in M.spell_list)
			M.remove_spell(spell)
		for(var/spell/targeted/oathbreak/spell in M.spell_list)
			M.remove_spell(spell)
		message_admins("[M.name] ([M.ckey]) has broken their oath of silence. (<A HREF='?_src_=holder;adminplayerobservejump=\ref[M]'>JMP</a>)")
		to_chat(M, "<span class = 'notice'>An unsettling feeling surrounds you...</span>")
		return