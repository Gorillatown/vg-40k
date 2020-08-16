/obj/item/clothing/suit/armor/harlequin
	name = "Harlequin Coat"
	desc = "The ornamented battle dress of a harlequin."
	icon = 'z40k_shit/icons/obj/clothing/suits.dmi'
	icon_state = "harlequin"
	item_state = "harlequin"
	blood_overlay_type = "armor"
	body_parts_covered = ARMS|LEGS|FULL_TORSO
	armor = list(melee = 65, bullet = 60, laser = 60, energy = 100, bomb = 65, bio = 100, rad = 100)
	var/speed_modifier = 3
	allowed = list(/obj/item/weapon)

/obj/item/clothing/suit/armor/harlequin/equipped(mob/living/carbon/human/H, equipped_slot)
	..()
	if(istype(H) && H.get_item_by_slot(slot_shoes) == src && equipped_slot != null && equipped_slot == slot_shoes)
		if(H.mind.assigned_role == "Mime")
			H.movement_speed_modifier *= speed_modifier

/obj/item/clothing/suit/armor/harlequin/unequipped(mob/living/carbon/human/H, var/from_slot = null)
	..()
	if(from_slot == slot_shoes && istype(H))
		if(H.mind.assigned_role == "Mime")
			H.movement_speed_modifier /= speed_modifier