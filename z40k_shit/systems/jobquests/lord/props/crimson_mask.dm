/obj/item/clothing/mask/gas/artifact
	name = "Crimson Mask"
	desc = "The eerie countenance glows with a reddish light, humming with power..."
	icon = 'z40k_shit/icons/obj/clothing/masks.dmi'
	icon_state = "artifact_noeffect" //When its just artifact we get the full lightshow
	item_state = "artifact_noeffect"
	var/weartime = 0
	var/worn = 0
	var/speed_modifier = 1
	var/first_pickup = FALSE

/obj/item/clothing/mask/gas/artifact/New()
	..()
	processing_objects.Add(src)

/obj/item/clothing/mask/gas/artifact/process()
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		if(H.wear_mask == src) //the mob is wearing this mask
			if(H.mind)
				weartime += 1
			if(weartime >= 40)
				if(prob(75))
					to_chat(H, "<span class='warning'> You sense that wearing the mask for much longer would be a bad idea.</span>")
			if(weartime >= 60)
				if(!istype(H.mind.job_quest,/datum/job_quest/tzeentch_plot_one))
					H.visible_message("<span class='warning'> [H]'s body is consumed in a flash of deep red light!</span>")
					H.dust()
			H.heal_organ_damage(8, 8)
			H.adjustOxyLoss(-12)
			H.adjustToxLoss(-8)
			H.AdjustStunned(-10)
			H.AdjustKnockdown(-10)
			H.AdjustParalysis(-10)
			H.drowsyness = 0
			H.eye_blurry = 0
			H.dodging = TRUE
			if(H.handcuffed)
				H.drop_from_inventory(H.handcuffed)
			if(H.legcuffed)
				H.drop_from_inventory(H.legcuffed)
	else
		if(weartime > 0) 
			weartime --


/obj/item/clothing/mask/gas/artifact/equipped(mob/living/carbon/human/H, equipped_slot)
	..()
	if(istype(H) && H.get_item_by_slot(slot_wear_mask) == src && equipped_slot != null && equipped_slot == slot_wear_mask)
		icon_state = "artifact"
		item_state = "artifact"
		H.movement_speed_modifier += speed_modifier
		H.visible_message("<span class='warning'> <b>[H] puts on the [src]!</b></span>")
		to_chat(H, "<span class='warning'> You feel a rush of power!</span>")
		if(istype(H.mind.job_quest,/datum/job_quest/tzeentch_plot_one))
			H.add_spell(new /spell/targeted/devastate, "ork_spell_ready")

/obj/item/clothing/mask/gas/artifact/unequipped(mob/living/carbon/human/H, var/from_slot = null)
	..()
	if(from_slot == slot_wear_mask && istype(H))
		icon_state = "artifact_noeffect"
		item_state = "artifact_noeffect"
		H.movement_speed_modifier -= speed_modifier
		H.visible_message("<span class='warning'> [H] takes off the [src]!</span>")
		H.Knockdown(weartime/5)
		H.Stun(weartime/5)
		H.dodging = FALSE
		for(var/spell/targeted/devastate/spell in H.spell_list)
			H.remove_spell(spell)

/obj/item/clothing/mask/gas/artifact/pickup(var/mob/user)
	if(first_pickup && quest_master.tzeentch_champion)
		SS_Scenario.mask_is_active = TRUE
		var/mob/living/carbon/human/H = quest_master.tzeentch_champion
		to_chat(H, "<span class='tzeentch'> A certain object has entered your realm, fueled by the many sacrifices you have offered. Perhaps you should investigate this. </span>")