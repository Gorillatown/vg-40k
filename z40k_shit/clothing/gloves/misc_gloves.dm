/* 
	Gloves
	*/
/obj/item/clothing/gloves/hospitaller_gloves
	name = "Hospitaller Tool" //The name of the object ingame.
	desc = "Armored Gloves with basically some tools built into them for medical help." //Description upon examination
	icon = 'z40k_shit/icons/obj/ig/IGarmorandclothesOBJ.dmi'
	icon_state = "hospitaller_gloves" //The state of the object icon when dropped/displayed in slot
	item_state = "hospitaller_gloves" //The state of the mob icon when worn.
	siemens_coefficient = 0.9 //A value of how conductive something is on a scale of 0 to 1
	armor = list(melee = 5, bullet = 5, laser = 5,energy = 0, bomb = 5, bio = 10, rad = 0)
	body_parts_covered = HANDS
	bonus_knockout = 17 //Slight knockout chance increase.
	damage_added = 8
	canremove = FALSE
	species_restricted = list("Human") //Only humans can wear IG stuff for now at least.
