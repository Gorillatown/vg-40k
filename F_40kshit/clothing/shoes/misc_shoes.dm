
/*
	Shoes
	*/
/obj/item/clothing/shoes/hospitaller_shoes
	name = "Armored Boots"
	desc = "Armored boots, that are probably bolted on."
	icon_state = "hospitaller_boots"
	item_state = "hospitaller_boots"
	siemens_coefficient = 0.6
	body_parts_covered = FEET
	canremove = FALSE
	species_restricted = list("Human") //Only humans can wear IG stuff for now at least.

/obj/item/clothing/shoes/enginseer_boots
	name = "Metal Feet(?)"
	desc = "Oddly enough, you are pretty sure these are boots. But perhaps they are also the feet. Who exactly knows"
	icon = 'F_40kshit/icons/obj/clothing/shoes.dmi'
	icon_state = "mech_boots"
	species_restricted = list("Human")
	canremove = 0

/obj/item/clothing/shoes/seneschal_boots
	name = "Seneschal Boots"
	desc = "Fancy Boots, for a fancy man"
	icon = 'F_40kshit/icons/obj/clothing/shoes.dmi'
	icon_state = "seneschal_boots"
	species_restricted = list("Human")

/obj/item/clothing/shoes/swat/harlequin
	name = "harlequin boots"
	desc = "A pair of shoes that have been artfully reinforced with metal. Not bad, considering the simplicity of their construction."
	icon = 'F_40kshit/icons/obj/clothing/shoes.dmi'
	icon_state = "harlequin"
	item_state = "harlequin"
