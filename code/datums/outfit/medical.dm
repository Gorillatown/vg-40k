// -- Medical outfits
// -- CMO

/datum/outfit/cmo

	outfit_name = "Chief Medical Officer"
	associated_job = /datum/job/cmo

	backpack_types = list(
		BACKPACK_STRING = /obj/item/weapon/storage/backpack/medic,
		SATCHEL_NORM_STRING = /obj/item/weapon/storage/backpack/satchel_med,
		SATCHEL_ALT_STRING = /obj/item/weapon/storage/backpack/satchel,
		MESSENGER_BAG_STRING = /obj/item/weapon/storage/backpack/messenger/med,
	)

	items_to_spawn = list(
		"Default" = list(
			slot_ears_str = /obj/item/device/radio/headset/heads/cmo,
			slot_w_uniform_str = /obj/item/clothing/under/rank/chief_medical_officer,
			slot_shoes_str = /obj/item/clothing/shoes/brown,
			slot_glasses_str = /obj/item/clothing/glasses/hud/health,
			slot_wear_suit_str = /obj/item/clothing/suit/storage/labcoat/cmo,
			slot_s_store_str = /obj/item/device/flashlight/pen,
		),
		/datum/species/plasmaman = list(
			slot_ears_str = /obj/item/device/radio/headset/heads/cmo,
			slot_w_uniform_str = /obj/item/clothing/under/rank/chief_medical_officer,
			slot_shoes_str = /obj/item/clothing/shoes/brown,
			slot_glasses_str = /obj/item/clothing/glasses/hud/health,
			slot_wear_suit_str = /obj/item/clothing/suit/space/plasmaman/medical/cmo,
			slot_head_str = /obj/item/clothing/head/helmet/space/plasmaman/medical/cmo,
			slot_wear_mask_str =  /obj/item/clothing/mask/breath/,
		),
		/datum/species/vox = list(
			slot_ears_str = /obj/item/device/radio/headset/heads/cmo,
			slot_w_uniform_str = /obj/item/clothing/under/rank/chief_medical_officer,
			slot_shoes_str = /obj/item/clothing/shoes/brown,
			slot_glasses_str = /obj/item/clothing/glasses/hud/health,
			slot_wear_suit_str = /obj/item/clothing/suit/space/vox/civ/medical/cmo,
			slot_head_str = /obj/item/clothing/head/helmet/space/vox/civ/medical/cmo,
			slot_wear_mask_str =  /obj/item/clothing/mask/breath/,
		),
	)

	pda_type = /obj/item/device/pda/heads/cmo
	pda_slot = slot_belt
	id_type = /obj/item/weapon/card/id/cmo

/datum/outfit/cmo/post_equip(var/mob/living/carbon/human/H)
	H.put_in_hands(new /obj/item/weapon/storage/firstaid/regular(get_turf(H)))
	H.mind.store_memory("Frequencies list: <br/><b>Command:</b> [COMM_FREQ] <b>Medical:</b> [MED_FREQ]")



