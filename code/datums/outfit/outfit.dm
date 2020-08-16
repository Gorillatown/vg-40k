 
/*
 * Outfit datums
 * For equipping characters with special provisions for race and so on
 *

	VARS :
	- items_to_spawn: items to spawn, arranged if needed by race.
	  "Default" is the list of items for humans.
	- use_pref_bag: if we use the backpack he has in prefs, or if we give him a standard backpack.
	- no_backpack: If we don't give them a backpack + survival gear.
	- no_id: If we don't give them a ID
	- equip_survival_gear: if we give him the basic survival gear.
	- items_to_collect: items to put in the backbag
		The associative key is for when to put it if we have no backbag.
		Use GRASP_LEFT_HAND and GRASP_RIGHT_HAND if it goes to the hands, but slot_x_str if it goes to a slot on the person.
	- implant_types: the implants we give to the mob.
	- special_snowflakes: for the edge cases where you need a manual proc.
	- pda_slot/pda_type/id_type: for the ID and PDA of the mob.
	- give_disabilities_equipment: if we give equipment for disabilities or not.

	PROCS :
	-- "Static" procs
		- equip(var/mob/living/carbon/human/H): tries to equip everything on the list to the relevant slots. This is the "master proc".
		- equip_backbag(var/mob/living/carbon/human/H): equip the backbag with the correct pref, and tries to put items in it if possible.
		- give_disabilities_equipment(var/mob/living/carbon/human/H): give the correct equipement for the disabilities the mob has, in the correct slots.

	-- Procs you can override
		- pre_equip(var/mob/living/carbon/human/H): altering the mob or the list of items before the mob is dressed.
		- post_equip(var/mob/living/carbon/human/H): after the mob is fully dressed.
		- spawn_id(var/mob/living/carbon/human/H, rank): give an ID to the mob. Overriden by striketeams.
		- species_final_equip(var/mob/living/carbon/human/H): give internals/a tank to species as needed.

		- special_equip(var/title, var/slot, var/mob/living/carbon/human/H): for the more exotic item slots.
*/

/datum/outfit/
	var/outfit_name = "Abstract outfit datum"

	var/associated_job = null

	var/list/items_to_spawn = list(
		"Default" = list(),
	)

	var/list/backpack_types = list(
		BACKPACK_STRING = null,
		SATCHEL_NORM_STRING = null,
		SATCHEL_ALT_STRING = null,
		MESSENGER_BAG_STRING = null,
	)

	var/use_pref_bag = TRUE
	var/no_backpack = FALSE
	var/no_id = FALSE
	var/give_disabilities_equipment = TRUE
	var/gender_gear = FALSE
	
	var/list/equip_survival_gear = list()

	var/list/items_to_collect = list()
	var/list/alt_title_items_to_collect = list()

	var/list/implant_types = list()

	var/pda_slot 
	var/pda_type = null
	var/id_type = null

	var/list/special_snowflakes = list()

/datum/outfit/New()
	return

/datum/outfit/proc/pre_equip(var/mob/living/carbon/human/H)
	return

/datum/outfit/proc/bypass_list_equips(var/mob/living/carbon/human/H)
	return 0

/datum/outfit/proc/pre_equip_disabilities(var/mob/living/carbon/human/H, var/list/items_to_equip)
	if(H.client.IsByondMember())
		to_chat(H, "Thank you for supporting BYOND!")
		items_to_collect[/obj/item/weapon/storage/box/byond] = GRASP_LEFT_HAND

	if(!give_disabilities_equipment)
		return
	if(H.disabilities & ASTHMA)
		items_to_collect[/obj/item/device/inhaler] = "Survival Box"
	if(!items_to_equip[slot_glasses_str] && (H.disabilities & NEARSIGHTED))
		items_to_equip[slot_glasses_str] = /obj/item/clothing/glasses/regular

/datum/outfit/proc/equip(var/mob/living/carbon/human/H)
	if(!H || !H.mind)
		return
	
	pre_equip(H)
	var/species = H.species.type //Species is the species type of the human we have inputted in.
	var/list/L = items_to_spawn[species] //the list of L is the items to spawn + species key
	if(!L) // Couldn't find the particular species
		species = "Default"
		L = items_to_spawn["Default"]
	pre_equip_disabilities(H, L)

	if(!bypass_list_equips(H)) //If the proc returns a 0 we function as normal, if its a 1 we bypass the below.
		for(var/slot in L) //For var/slot in items to spawn Species Key
			var/list/snowflake_items = special_snowflakes[species]

			if(snowflake_items && (slot in snowflake_items[H.mind.role_alt_title])) // ex: special_snowflakes["Vox"]["Emergency responder"].
				special_equip(H.mind.role_alt_title, slot, 	H)
				continue
		
			var/obj_type = L[slot] //Obj type is species tied key list and then the slot key
			if(islist(obj_type)) // Special objects for alt-titles, if the obj type is another list.
				var/list/L2 = obj_type
				obj_type = L2[H.mind.role_alt_title]
				if(islist(obj_type))
					if(gender_gear) //This would mean that you would use gender as the key for the lists.
						var/list/L3 = obj_type
						obj_type = L3[H.gender]
						if(islist(obj_type)) //rng select on list in list in list in list
							obj_type = pick(obj_type)
					else //same deal except we now aren't tied to a gender key in
						obj_type = pick(obj_type)

			if(!obj_type)
				continue
			slot = text2num(slot)
			if(slot == 19)
				H.put_in_hand(GRASP_LEFT_HAND, new obj_type(get_turf(H)))
			else if(slot == 20)
				H.put_in_hand(GRASP_RIGHT_HAND, new obj_type(get_turf(H)))
			else
				H.equip_to_slot_or_del(new obj_type(get_turf(H)), slot, TRUE)
	
	if(!no_backpack)
		equip_backbag(H, species)

	for(var/imp_type in implant_types)
		var/obj/item/weapon/implant/I = new imp_type(H)
		I.imp_in = H
		I.implanted = 1
		var/datum/organ/external/affected = H.get_organ(LIMB_HEAD) // By default, all implants go to the head.
		affected.implants += I
		I.part = affected

	species_final_equip(H)
	spawn_id(H)
	post_equip(H) // Accessories, IDs, etc.
	give_disabilities_equipment(H)
	H.update_icons()
	//Handle faction shit here
	spawn(1 SECONDS)
		handle_faction(H)
		handle_special_abilities(H)

/datum/outfit/proc/equip_backbag(var/mob/living/carbon/human/H, var/species)
	// -- Backbag
	var/obj/item/chosen_backpack = null
	if(use_pref_bag)
		var/backbag_string = num2text(H.backbag)
		chosen_backpack = backpack_types[backbag_string]
	else
		chosen_backpack = backpack_types[BACKPACK_STRING]

	// -- The (wo)man has a backpack, let's put stuff in them
	var/special_items = alt_title_items_to_collect[H.mind.role_alt_title]
	if(chosen_backpack)
		H.equip_to_slot_or_del(new chosen_backpack(H), slot_back, 1)
		for(var/item_type in items_to_collect)
			H.equip_or_collect(new item_type(H.back), slot_in_backpack)
		if(equip_survival_gear.len)
			if (ispath(equip_survival_gear[species]))
				H.equip_or_collect(new equip_survival_gear(H.back), slot_in_backpack)
		else
			H.equip_or_collect(new H.species.survival_gear(H.back), slot_in_backpack)

		// Special alt-title items
		if(special_items)
			for(var/item_type in special_items)
				H.equip_or_collect(new item_type(H.back), slot_in_backpack)

	// -- No backbag, let's improvise
	
	else
		var/obj/item/weapon/storage/box/survival/pack
		if(equip_survival_gear.len)
			if(ispath(equip_survival_gear[species]))
				pack = new equip_survival_gear(H)
				H.put_in_hand(GRASP_RIGHT_HAND, pack)
		else
			pack = new H.species.survival_gear(H)
			H.put_in_hand(GRASP_RIGHT_HAND, pack)
		for(var/item in items_to_collect)
			if(items_to_collect[item] == "Surival Box" && pack)
				new item(pack)
			else
				if(!isnum(items_to_collect[item])) // Not a number : it's a slot
					var/item_slot = text2num(items_to_collect[item])
					if(item_slot)
						H.equip_or_collect(new item(get_turf(H)), item_slot)
					else
						new item(get_turf(H))
				else
					var/hand_slot = items_to_collect[item]
					if(hand_slot) // ie, if it's an actual number
						H.put_in_hand(hand_slot, new item)

				// Special alt-title items
		if(special_items)
			for(var/item_type in special_items)
				H.equip_or_collect(new item_type(H.back), slot_in_backpack)

/datum/outfit/proc/species_final_equip(var/mob/living/carbon/human/H)
	if(H.species)
		H.species.final_equip(H)

/datum/outfit/proc/spawn_id(var/mob/living/carbon/human/H, rank)
	if(!associated_job)
		CRASH("Outfit [outfit_name] has no associated job, and the proc to spawn the ID is not overriden.")
	var/datum/job/concrete_job = new associated_job

	if(!no_id)
		var/obj/item/weapon/card/id/C
		C = new id_type(H)
		C.access = concrete_job.get_access()
		C.registered_name = H.real_name
		C.rank = rank
		C.assignment = H.mind.role_alt_title
		C.name = "[C.registered_name]'s ID Card ([C.assignment])" 
		H.equip_or_collect(C, slot_wear_id) 
		if(pda_type)
			var/obj/item/device/pda/pda = new pda_type(get_turf(H))
			pda.owner = H.real_name
			pda.ownjob = C.assignment
			pda.name = "PDA-[H.real_name] ([pda.ownjob])"
			H.equip_or_collect(pda, pda_slot)
		if(H.mind && H.mind.initial_account) //40K REVISIT - This just silences the runtime.
			C.associated_account_number = H.mind.initial_account.account_number

/datum/outfit/proc/post_equip(var/mob/living/carbon/human/H)
	return // Empty

/datum/outfit/proc/special_equip(var/title, var/slot, var/mob/living/carbon/human/H)
	return

/datum/outfit/proc/handle_faction(var/mob/living/carbon/human/H)
	return 1

/datum/outfit/proc/handle_special_abilities(var/mob/living/carbon/human/H)
	return 1

/datum/outfit/proc/give_disabilities_equipment(var/mob/living/carbon/human/H)
	if (!give_disabilities_equipment)
		return
	
	//If a character can't stand because of missing limbs, equip them with a wheelchair
	if(!H.check_stand_ability())
		var/obj/structure/bed/chair/vehicle/wheelchair/W = new(H.loc)
		W.buckle_mob(H,H)

	if (H.glasses)
		var/obj/item/clothing/glasses/G = H.glasses
		G.prescription = 1

	return 1

// Strike teams have 2 particularities : a leader, and several specialised roles.
// Give the concrete (instancied) outfit datum the right "specialisation" after the player made his choice.
// Then, call "equip_special_items(player)" to give him the items associated.

/datum/outfit/striketeam/
	give_disabilities_equipment = FALSE
	var/is_leader = FALSE

	var/list/specs = list()

	var/chosen_spec = null

	var/assignment_leader = "Striketeam Leader"
	var/assignment_member = "Striketeam Member"

	var/id_type_leader = null

/datum/outfit/striketeam/spawn_id(var/mob/living/carbon/human/H, rank)
	var/obj/item/weapon/card/id/W
	if(is_leader)
		W = new id_type_leader(get_turf(H))
		W.assignment = assignment_leader
	else
		W = new id_type(get_turf(H))
		W.assignment = assignment_member
	W.name = "[H.real_name]'s ID Card"
	W.registered_name = H.real_name
	W.UpdateName()
	W.SetOwnerInfo(H)
	H.equip_to_slot_or_drop(W, slot_wear_id)
	return W

/datum/outfit/striketeam/proc/equip_special_items(var/mob/living/carbon/human/H)
	if (!chosen_spec)
		return

	if (!(chosen_spec in specs))
		CRASH("Trying to give [chosen_spec] to [H], but cannot find this spec in [src.type].")

	var/list/to_equip = specs[chosen_spec]

	for (var/slot_str in to_equip)
		var/equipment = to_equip[slot_str]

		switch (slot_str)
			if (ACCESSORY_ITEM) // It's an accesory. We put it in their hands if possible.
				H.put_in_hands(new equipment(H))

			else // It's a concrete item.
				var/slot = text2num(slot_str) // slots stored are STRINGS.

				if (islist(equipment)) // List of things to equip
					for (var/item in equipment)
						for (var/i = 1 to equipment[item]) // Give them this much of that item
							var/concrete_item = new item(H)
							if (!H.equip_to_slot_or_drop(concrete_item, slot)) // Can't put them in the designate slot ? Put it in their hands.
								H.put_in_hands(concrete_item)
				else
					var/concrete_item = new equipment(H)
					if (!H.equip_to_slot_or_drop(concrete_item, slot))
						H.put_in_hands(concrete_item)
