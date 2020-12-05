//----------SUIT ARMOR--------------------
/obj/item/clothing/suit/armor/patrolman_suit
	name = "Metal Pauldrons"
	desc = "They protect your shoulders."
	icon = 'z40k_shit/icons/obj/clothing/suits.dmi'
	icon_state = "patrolman" //Check: Its there
	item_state = "patrolman"//Check: Its there
	body_parts_covered = ARMS
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY
	armor = list(melee = 20, bullet = 20, laser = 20,energy = 25, bomb = 20, bio = 20, rad = 0)
	species_restricted = list("Human")
	allowed = list(/obj/item/weapon)

//----------SUIT ARMOR--------------------
/obj/item/clothing/suit/armor/patrolman_swampcape
	name = "Cape"
	desc = "A cape that mostly just is good at protecting one from organic things more than metal."
	icon = 'z40k_shit/icons/obj/clothing/suits.dmi'
	icon_state = "swampcape" //Check: Its there
	item_state = "swampcape" //Check: Its there
	body_parts_covered = ARMS
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY
	armor = list(melee = 5, bullet = 10, laser = 10 ,energy = 10, bomb = 20, bio = 40, rad = 30)
	species_restricted = list("Human")
	allowed = list(/obj/item/weapon)

//----------SUIT ARMOR--------------------
/obj/item/clothing/suit/armor/jg_patrolman_suit
	name = "Heavy Metal Chest and Groin Protection"
	desc = "At some point, the troopers ditched the shoulderpads and opted for protecting the parts they liked."
	icon = 'z40k_shit/icons/obj/clothing/suits.dmi'
	icon_state = "patrolman_jg" //Check: Its there
	item_state = "patrolman_jg"//Check: Its there
	body_parts_covered = UPPER_TORSO
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY
	armor = list(melee = 50, bullet = 50, laser = 70,energy = 25, bomb = 60, bio = 20, rad = 0)
	species_restricted = list("Human")
	allowed = list(/obj/item/weapon)