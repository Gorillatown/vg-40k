/*
	IG SHOES AND BOOTS
						*/

/obj/item/clothing/shoes/IG_cadian_boots
	name = "Imperial Flak Boots"
	desc = "Footwear of the Imperial Guard, they look aight"
	icon_state = "flakboots" //Check: Its there
	item_state = "flakboots" //Check: Its fine
	body_parts_covered = LEGS|FEET
	armor = list(melee = 15, bullet = 15, laser = 15,energy = 15, bomb = 15, bio = 0, rad = 0)
	species_restricted = list("Human")

/obj/item/clothing/shoes/IG_wepspec_boots
	name = "Kneepads and boots Combo"
	desc = "Hmmm..."
	icon_state = "cadian_wepspec_boots" //Check: Its there
	item_state = "cadian_wepspec_boots" //Check: Its fine
	body_parts_covered = LEGS|FEET
	armor = list(melee = 20, bullet = 20, laser = 20,energy = 20, bomb = 20, bio = 0, rad = 0)
	species_restricted = list("Human")