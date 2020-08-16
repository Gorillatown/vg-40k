//----------SUIT ARMOR--------------------
/obj/item/clothing/suit/armor/shocktrooper 
	name = "Flak Armor"
	desc = "Specialized Cadian Shock Trooper armor. This looks expensive. Too bad there aren't more."
	icon = 'z40k_shit/icons/obj/ig/IGarmorandclothesOBJ.dmi'
	icon_state = "storm" //Check: Its there
	item_state = "storm"//Check: Its there
	body_parts_covered = FULL_TORSO|ARMS
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY
	armor = list(melee = 65, bullet = 50, laser = 50,energy = 25, bomb = 50, bio = 100, rad = 50)
	species_restricted = list("Human")

/obj/item/clothing/suit/armor/IG_cadian_armor
	name = "Flak Armor"
	desc = "Standard issue armor given to Guardsmen of the Imperial Guard. Protects against some damage."
	icon = 'z40k_shit/icons/obj/ig/IGarmorandclothesOBJ.dmi'
	icon_state = "cadia_flak_armor" //Check: Its there
	item_state = "cadia_flak_armor" //Check: Its there
	body_parts_covered = FULL_TORSO
	armor = list(melee = 25, bullet = 35, laser = 35,energy = 10, bomb = 25, bio = 0, rad = 0)
	allowed = list(/obj/item/weapon/gun/energy/lasgun)
	species_restricted = list("Human")

/obj/item/clothing/suit/armor/IG_cadian_medic_armor
	name = "Flak Armor"
	desc = "Standard issue armor given to Guardsmen Medics of the Imperial Guard. Lighter than the normal variant."
	icon = 'z40k_shit/icons/obj/ig/IGarmorandclothesOBJ.dmi'
	icon_state = "cadia_flak_armor_medic" //Check: Its there
	item_state = "cadia_flak_armor_medic"//Check: Its there
	body_parts_covered = FULL_TORSO
	armor = list(melee = 25, bullet = 35, laser = 25,energy = 10, bomb = 15, bio = 25, rad = 0) //In case of... Nurgle?
	allowed = list(/obj/item/weapon/gun/energy/lasgun)
	species_restricted = list("Human")

/obj/item/clothing/head/stormtrooper
	name = "Flak Armor"
	desc = "Standard gear for a Cadian Shock Trooper."
	icon = 'z40k_shit/icons/obj/ig/IGarmorandclothesOBJ.dmi'
	icon_state = "stormh" //Check: its there
	item_state = "stormh" //Check: Its there
	armor = list(melee = 50, bullet = 30, laser = 50,energy = 10, bomb = 25, bio = 0, rad = 0)
	body_parts_covered = HEAD|EARS|EYES
	species_restricted = list("Human")


//------GENERAL COAT
/obj/item/clothing/suit/armor/commanderarmor 
	name = "General Reinforced Coat"
	desc = "A long coat draped over standard issue flak armor. Despite common thoughts, even this general doesn't step too far from being in uniform."
	icon_state = "commanderarmor" //Check: Its there
	item_state = "commanderarmor"//Check: Its there
	body_parts_covered = UPPER_TORSO
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY
	allowed = list(/obj/item/weapon/gun/projectile/automatic/boltpistol,
				/obj/item/weapon/chainsword,
				/obj/item/weapon/powersword
				)
	armor = list(melee = 65, bullet = 50, laser = 50,energy = 25, bomb = 50, bio = 100, rad = 50)
	species_restricted = list("Human") //Only humans can wear IG stuff for now at least.