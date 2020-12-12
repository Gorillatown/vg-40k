/* 
	Gloves
	*/
/obj/item/clothing/gloves/bloodraven_gloves
	name = "Bloodraven Powerarmor Hands" //The name of the object ingame.
	desc = "The Hands on powerarmor." //Description upon examination
	icon = 'F_40kshit/icons/obj/clothing/gloves.dmi'
	icon_state = "bloodraven_gloves" //The state of the object icon when dropped/displayed in slot
	item_state = "bloodraven_gloves" //The state of the mob icon when worn.
	siemens_coefficient = 0.9 //A value of how conductive something is on a scale of 0 to 1
	armor = list(melee = 5, bullet = 5, laser = 5,energy = 0, bomb = 5, bio = 10, rad = 0)
	body_parts_covered = HANDS
	bonus_knockout = 17 //Slight knockout chance increase.
	damage_added = 20 //Add 3 damage to unarmed attacks when worn
	species_restricted = list("Astartes")
	species_fit = list("Astartes")