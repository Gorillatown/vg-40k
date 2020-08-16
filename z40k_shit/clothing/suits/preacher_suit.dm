/obj/item/clothing/suit/armor/preacherrobe
	name = "preacher robe"
	desc = "An armored coat reinforced with ceramic plates and pauldrons to provide additional protection whilst still offering maximum mobility and flexibility. Issued only to the imperium's finest."
	icon = 'z40k_shit/icons/obj/ig/IGarmorandclothesOBJ.dmi'
	icon_state = "preacher_robe" //Check: Its there
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|MASKHEADHAIR
	heat_conductivity = SPACESUIT_HEAT_CONDUCTIVITY
	armor = list(melee = 65, bullet = 50, laser = 50,energy = 25, bomb = 50, bio = 100, rad = 50)
	var/is_hooded = 0
	var/nohood = 0
	var/obj/item/clothing/head/preacherhood/hood
	actions_types = list(/datum/action/item_action/toggle_hood)
	species_restricted = list("Human")
	allowed = list(/obj/item/weapon)

/obj/item/clothing/suit/armor/preacherrobe/New()
	if(!nohood)
		hood = new(src)
	else
		actions_types = null

	..()

/obj/item/clothing/head/preacherhood
	name = "robe hood"
	desc = "A hood attached to a heavy robe."
	icon = 'z40k_shit/icons/obj/ig/IGarmorandclothesOBJ.dmi'
	icon_state = "phood"
	body_parts_covered = HIDEHEADHAIR
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY
	var/obj/item/clothing/suit/armor/preacherrobe/robe

/obj/item/clothing/head/preacherhood/New(var/obj/item/clothing/suit/armor/preacherrobe/wc)
	..()
	if(istype(wc))
		robe = wc
	else if(!robe)
		qdel(src)

/obj/item/clothing/suit/armor/preacherrobe/proc/togglehood()
	set name = "Toggle Hood"
	set category = "Object"
	set src in usr
	if(usr.incapacitated())
		return
	else
		var/mob/living/carbon/human/user = usr
		if(!istype(user))
			return
		if(user.get_item_by_slot(slot_wear_suit) != src)
			to_chat(user, "You have to put the coat on first.")
			return
		if(!is_hooded && !user.get_item_by_slot(slot_head) && hood.mob_can_equip(user,slot_head))
			to_chat(user, "You put the hood up.")
			hoodup(user)
		else if(user.get_item_by_slot(slot_head) == hood)
			hooddown(user)
			to_chat(user, "You put the hood down.")
		else
			to_chat(user, "You try to put your hood up, but there is something in the way.")
			return
		user.update_inv_wear_suit()

/obj/item/clothing/suit/armor/preacherrobe/attack_self()
	togglehood()

/obj/item/clothing/suit/armor/preacherrobe/proc/hoodup(var/mob/living/carbon/human/user)
	user.equip_to_slot(hood, slot_head)
	icon_state = "[initial(icon_state)]_t"
	is_hooded = HAS_HOOD
	user.update_inv_wear_suit()

/obj/item/clothing/suit/armor/preacherrobe/proc/hooddown(var/mob/living/carbon/human/user,var/unequip = 1)
	icon_state = "[initial(icon_state)]"
	if(unequip)
		user.u_equip(user.head,0)
	is_hooded = NO_HOOD
	user.update_inv_wear_suit()

/obj/item/clothing/suit/armor/preacherrobe/unequipped(var/mob/living/carbon/human/user)
	if(hood && istype(user) && user.get_item_by_slot(slot_head) == hood)
		hooddown(user)

/obj/item/clothing/head/preacherhood/pickup(var/mob/living/carbon/human/user)
	if(robe && istype(robe) && user.get_item_by_slot(slot_wear_suit) == robe)
		robe.hooddown(user,unequip = 0)
		user.drop_from_inventory(src)
		forceMove(robe)
