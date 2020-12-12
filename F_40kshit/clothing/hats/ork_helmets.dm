/*
	Hats & Helmets
	*/

/obj/item/clothing/head/armorhelmet
	name = "Horned Armored Helmet"
	desc = "A helmet with horns"
	icon_state = "orkhelmet1"
	item_state = "orkhelmet1"
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 10, bomb = 40, bio = 10, rad = 0)
	body_parts_covered = FULL_HEAD|HIDEHEADHAIR
	siemens_coefficient = 1
	icon = 'F_40kshit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	species_restricted = list("Ork", "Ork Nob")
	species_fit = list("Ork", "Ork Nob") 

/obj/item/clothing/head/bucket
	name = "Metal Bucket Helmet"
	desc = "A metal bucket, conveniently sized for a orks head."
	icon_state = "orkhelmet2"
	item_state = "orkhelmet2"
	armor = list(melee = 40, bullet = 20, laser = 20,energy = 10, bomb = 25, bio = 10, rad = 0)
	body_parts_covered = HEAD|EARS|MASKHEADHAIR
	siemens_coefficient = 0.8
	icon = 'F_40kshit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	species_restricted = list("Ork", "Ork Nob")
	species_fit = list("Ork", "Ork Nob") 

/*
	warboss helmet
	*/
/obj/item/clothing/head/warboss/bossarmorhelmet
	name = "Horned Armored Helmet"
	desc = "A large helmet with horns and a metal faceplate"
	icon_state = "warboss_helmet"
	item_state = "warboss_helmet"
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 10, bomb = 40, bio = 10, rad = 0)
	body_parts_covered = FULL_HEAD|HIDEHEADHAIR
	siemens_coefficient = 1
	icon = 'F_40kshit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	species_restricted = list("Ork Warboss") 
	species_fit = list("Ork Warboss") 