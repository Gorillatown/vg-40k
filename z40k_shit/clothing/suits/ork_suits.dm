/*
	Armor and Suits
	*/
/obj/item/clothing/suit/armor/samuraiorkarmor
	name = "Plated Ork Armor"
	desc = "Armor that seems to have more plates than usual, RESEMBLES SOMETHING DOESN'T IT."
	icon_state = "orkarmor1"
	item_state = "orkarmor1"
	armor = list(melee = 50, bullet = 60, laser = 60,energy = 10, bomb = 40, bio = 10, rad = 0)
	siemens_coefficient = 0.8
	body_parts_covered = ARMS|FULL_TORSO
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	species_restricted = list("Ork", "Ork Nob")
	species_fit = list("Ork", "Ork Nob") 
	allowed = list(/obj/item/weapon)

/obj/item/clothing/suit/armor/leatherbikervest
	name = "Leather Biker Vest"
	desc = "A protective leather vest with a stylish skull on the back, looks like it used to be a jacket"
	icon_state = "orkarmor2"
	item_state = "orkarmor2"
	armor = list(melee = 20, bullet = 30, laser = 40,energy = 10, bomb = 40, bio = 10, rad = 0)
	siemens_coefficient = 0.5
	body_parts_covered = FULL_TORSO
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	species_restricted = list("Ork", "Ork Nob")
	species_fit = list("Ork", "Ork Nob") 
	allowed = list(/obj/item/weapon)

/obj/item/clothing/suit/armor/rwallplate
	name = "Plate Ork Armor"
	desc = "Two sets of plating that seem to have came off a wall"
	icon_state = "orkarmor3"
	item_state = "orkarmor3"
	armor = list(melee = 30, bullet = 60, laser = 50,energy = 10, bomb = 40, bio = 10, rad = 0)
	siemens_coefficient = 0.6
	body_parts_covered = FULL_TORSO
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	species_restricted = list("Ork", "Ork Nob")
	species_fit = list("Ork", "Ork Nob") 
	allowed = list(/obj/item/weapon)

/obj/item/clothing/suit/armor/ironplate
	name = "Metal Armor"
	desc = "A crude suit of armor, made for an ork"
	icon_state = "orkarmor4"
	item_state = "orkarmor4"
	armor = list(melee = 30, bullet = 40, laser = 30,energy = 10, bomb = 10, bio = 10, rad = 0)
	siemens_coefficient = 0.6
	body_parts_covered = FULL_TORSO
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	species_restricted = list("Ork", "Ork Nob")
	species_fit = list("Ork", "Ork Nob") 
	allowed = list(/obj/item/weapon)

/*
	Ork Warboss
	*/
/obj/item/clothing/suit/armor/warboss_platearmor
	name = "Large Plate Armor"
	desc = "Plate that should be currently adorning a large ork"
	icon_state = "warboss_armor1"
	icon_state = "warboss_armor1"
	armor = list(melee = 30, bullet = 60, laser = 50,energy = 10, bomb = 40, bio = 10, rad = 0)
	siemens_coefficient = 0.6
	body_parts_covered = FULL_TORSO
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	allowed = list(/obj/item/weapon)
	species_restricted = list("Ork Warboss") 
	species_fit = list("Ork Warboss") 