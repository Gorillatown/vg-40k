/obj/item/clothing/suit/armor/bloodraven_powerarmor
	name = "Bloodraven Powerarmor"
	desc = "Its Space Marine Powerarmor."
	icon = 'F_40kshit/icons/obj/clothing/suits.dmi'
	icon_state = "bloodraven_armor"
	item_state = "bloodraven_armor"
	armor = list(melee = 50, bullet = 60, laser = 60,energy = 10, bomb = 40, bio = 10, rad = 0)
	siemens_coefficient = 0.8
	body_parts_covered = ARMS|FULL_TORSO
	species_restricted = list("Astartes")
	species_fit = list("Astartes") 
	allowed = list(/obj/item/weapon)
