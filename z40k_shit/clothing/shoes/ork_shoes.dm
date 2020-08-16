/*
	Shoes
	*/
/obj/item/clothing/shoes/orkboots
	name = "Leather Boots"
	desc = "What more is there to say? These are leather boots, ork sized."
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	icon_state = "orkboots1"
	item_state = "orkboots1"
	siemens_coefficient = 0.6
	body_parts_covered = FEET
	species_restricted = list("Ork", "Ork Nob", "Ork Warboss")
	species_fit = list("Ork", "Ork Nob", "Ork Warboss") 

/*
	warboss shoes
	*/
/obj/item/clothing/shoes/bossboots
	name = "Flashy Spiked Metal Boots"
	desc = "Looks aggressive."
	icon_state = "warboss_shoes"
	item_state = "warboss_shoes"
	siemens_coefficient = 0.6
	body_parts_covered = FEET
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	species_restricted = list("Ork Warboss") 
	species_fit = list("Ork Warboss") 