/obj/item/clothing/shoes/patrolman_boots
	name = "Leather Boots"
	desc = "Look to be standard leather, with dirty wool coming out the top"
	icon = 'z40k_shit/icons/obj/clothing/shoes.dmi'
	icon_state = "patrolman" //Check: Its there
	item_state = "patrolman" //Check: Its fine
	body_parts_covered = LEGS|FEET
	armor = list(melee = 30, bullet = 30, laser = 15,energy = 15, bomb = 25, bio = 30, rad = 30)
	species_restricted = list("Human")