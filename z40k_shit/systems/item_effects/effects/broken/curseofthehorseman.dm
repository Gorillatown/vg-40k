/datum/item_artifact/horseman
	name = "The Curse of the Horseman"
	desc = "NEEIGH"
	charge = 250
	compatible_mobs = list(/mob/living/carbon/human)

/datum/item_artifact/horseman/item_act(var/mob/living/carbon/human/M)
	to_chat(M, "<span class='warning'>HOR-SIE HAS RISEN</span>")
	var/obj/item/clothing/mask/horsehead/magichead = new /obj/item/clothing/mask/horsehead
	magichead.canremove = FALSE
	magichead.voicechange = 1	//NEEEEIIGHH
	if(!M.unEquip(M.wear_mask))
		qdel(M.wear_mask)
	M.equip_to_slot_if_possible(magichead, slot_wear_mask, 1, 1)
	..() //Call ..() only when the effect has a neutralize proc and should not be able to act twice on one person.

/datum/item_artifact/horseman/neutralize_mob(var/mob/living/carbon/human/M) //This one needs a neutralize because it is a permanent effect otherwise. Ignite will probably be neutralized in more mundane ways anyway.
	if(!M.unEquip(M.wear_mask))
		qdel(M.wear_mask)
	to_chat(M, "<span class='warning'> You hear the sound of a thousand neighs fading from your head...</span>")
	..()
	