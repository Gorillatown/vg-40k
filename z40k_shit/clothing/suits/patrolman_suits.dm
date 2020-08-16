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