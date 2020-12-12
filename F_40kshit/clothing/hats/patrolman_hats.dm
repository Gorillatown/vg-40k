//------------HELMETS-----------------
/obj/item/clothing/head/patrolman_hat
	name = "Cloth Head Wrap"
	desc = "Some would say this would have a middle eastern name, but we aren't even on terra right now."
	icon = 'F_40kshit/icons/obj/clothing/hats.dmi'
	icon_state = "patrolman" //Check: Its there
	item_state = "patrolman" //Check: Its there
	armor = list(melee = 10, bullet = 5, laser = 20, energy = 10, bomb = 20, bio = 50, rad = 10)
	body_parts_covered = HIDEHAIR

/obj/item/clothing/head/redbandana
	name = "Red Bandana"
	desc = "A red bandana."
	icon_state = "jg_red_bandana"
	item_state = "jg_red_bandana"
	body_parts_covered = HEAD|EARS|MASKHEADHAIR
	siemens_coefficient = 0.9
	icon = 'F_40kshit/icons/obj/clothing/hats.dmi'
	species_fit = list("Ork", "Ork Nob") 

/obj/item/clothing/head/milcap
	name = "Red Military Cap"
	desc = "A stylish red military cap. Its origins are probably from a corpse of the detroid troopers."
	icon_state = "jg_red_hat"
	item_state = "jg_red_hat"
	body_parts_covered = HEAD|EARS|MASKHEADHAIR
	siemens_coefficient = 0.9
	icon = 'F_40kshit/icons/obj/clothing/hats.dmi'
	species_fit = list("Ork", "Ork Nob")

/obj/item/clothing/head/red_headband
	name = "Red Headband"
	desc = "Some might call this a bandana, but it is most definitely a headband."
	icon_state = "jg_red_headband"
	item_state = "jg_red_headband"
	body_parts_covered = HEAD|EARS
	siemens_coefficient = 0.9
	icon = 'F_40kshit/icons/obj/clothing/hats.dmi'

/obj/item/clothing/head/iron_helmet
	name = "Metal Helmet"
	desc = "One might wonder, whether most Detroid troops had one of these at one point at all."
	icon_state = "jg_iron_helmet"
	item_state = "jg_iron_helmet"
	body_parts_covered = HEAD|EARS|MASKHEADHAIR
	siemens_coefficient = 0.9
	armor = list(melee = 40, bullet = 50, laser = 60, energy = 20, bomb = 30, bio = 50, rad = 10)
	icon = 'F_40kshit/icons/obj/clothing/hats.dmi'