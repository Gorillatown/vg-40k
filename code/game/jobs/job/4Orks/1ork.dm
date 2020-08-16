/datum/job/basicork
	title = "(RNG) Various Orks"
	flag = BASICORK
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 500
	spawn_positions = 10
	wage_payout = 0
	supervisors = "yaself"
	selection_color = "#FFB5B5"
	species_whitelist = list("Ork") //Orks are whitelisted to orks
	access = list()
	landmark_job_override = TRUE
	outfit_datum = /datum/outfit/basicork

	relationship_chance = XENO_NO_RELATIONS

/datum/outfit/basicork

	outfit_name = "Basic Ork"
	associated_job = /datum/job/basicork
	no_backpack = TRUE
	no_id = TRUE
	var/list/ork_uniforms =	list(/obj/item/clothing/under/ork_pantsandshirt,
							/obj/item/clothing/under/ork_pants,
							/obj/item/clothing/under/ork_leatherpantsandshirt
							)
	var/list/ork_hats = list(/obj/item/clothing/head/armorhelmet,
								/obj/item/clothing/head/bucket,
								/obj/item/clothing/head/redbandana,
								/obj/item/clothing/head/milcap
								)
	var/list/ork_suits = list(/obj/item/clothing/suit/armor/samuraiorkarmor,
							/obj/item/clothing/suit/armor/rwallplate,
							/obj/item/clothing/suit/armor/ironplate,
							/obj/item/clothing/suit/armor/leatherbikervest
							)
	var/list/ork_belts = list(/obj/item/weapon/storage/belt/armorbelt,
							/obj/item/weapon/storage/belt/basicbelt
							)
	var/list/ork_shoes = list(/obj/item/clothing/shoes/orkboots
							)

	var/list/ork_mek_hats = list(/obj/item/clothing/head/redbandana,
								/obj/item/clothing/head/milcap)
	

/datum/outfit/basicork/bypass_list_equips(var/mob/living/carbon/human/H)
	var/object = null
	var/numerical_fun = rand(1,11)
	switch(numerical_fun)
		if(1 to 8) //Standard Orks
			object = pick(ork_uniforms)
			H.equip_to_slot_or_del(new object(get_turf(H)), slot_w_uniform)
			object = pick(ork_hats)
			H.equip_to_slot_or_del(new object(get_turf(H)), slot_head)
			object = pick(ork_suits)
			H.equip_to_slot_or_del(new object(get_turf(H)), slot_wear_suit)
			object = pick(ork_belts)
			H.equip_to_slot_or_del(new object(get_turf(H)), slot_belt)
			object = pick(ork_shoes)
			H.equip_to_slot_or_del(new object(get_turf(H)), slot_shoes)
			if(prob(80)) 
				H.put_in_hand(GRASP_RIGHT_HAND, new /obj/item/weapon/choppa(get_turf(H)))
			H.add_spell(new /spell/aoe_turf/mekbuild/standard_ork_build, "ork_spell_ready", /obj/abstract/screen/movable/spell_master/ork_racial)
			spawn(2 SECONDS)
				to_chat(H,"<span class='good'>Ya a ork, ya grow by krumpin gits (to death) n' mountin their heads onta a pole or banner. But dat don't mean ya shouldn't balance that with a social life, ya git. After-all ya need a mek for some good bits.</span>")
		if(9 to 10) //Gretchin
			H.set_species("Ork Gretchin")
			spawn(2 SECONDS)
				to_chat(H,"<span class='bad'>Such is life, you were born a gretchin. You are doomed to suffer until your very last breath.</span>")
		if(11) //Mek
			object = pick(ork_uniforms)
			H.equip_to_slot_or_del(new object(get_turf(H)), slot_w_uniform)
			object = pick(ork_mek_hats)
			H.equip_to_slot_or_del(new object(get_turf(H)), slot_head)
			object = pick(ork_shoes)
			H.equip_to_slot_or_del(new object(get_turf(H)), slot_shoes)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/leatherbikervest(get_turf(H)), slot_wear_suit)
			H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/brownbackpack(get_turf(H)), slot_back)
			H.add_spell(new /spell/aoe_turf/mekbuild, "ork_spell_ready", /obj/abstract/screen/movable/spell_master/ork_racial)
			H.attribute_strength = 12
			spawn(2 SECONDS)
				to_chat(H,"<span class='good'>Lucky you, you are a mek, a 1 in 11 chance. You can still grow like other orks, but you also have the ability to build things, from a menu located on a spell to the top right of your screen.")
	return 1

/datum/outfit/basicork/post_equip(var/mob/living/carbon/human/H)
	H.mind.store_memory("WAAAAAAAAGH!")

/datum/outfit/basicork/handle_special_abilities(var/mob/living/carbon/human/H)
	H.add_spell(new /spell/aoe_turf/waaagh1, "ork_spell_ready", /obj/abstract/screen/movable/spell_master/ork_racial)
//	H.add_spell(new /spell/aoe_turf/ork_mob_builder, "ork_spell_ready", /obj/abstract/screen/movable/spell_master/ork_racial)
