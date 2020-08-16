/* 
	Gloves
	*/
/obj/item/clothing/gloves/clothgloves 
	name = "Ragged Gloves" //The name of the object ingame.
	desc = "A pair of ragged cloth gloves." //Description upon examination
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	icon_state = "orkgloves1" //The state of the object icon when dropped/displayed in slot
	item_state = "orkgloves1" //The state of the mob icon when worn.
	siemens_coefficient = 0.9 //A value of how conductive something is on a scale of 0 to 1
	armor = list(melee = 5, bullet = 5, laser = 5,energy = 0, bomb = 5, bio = 10, rad = 0)
	body_parts_covered = HANDS
	bonus_knockout = 17 //Slight knockout chance increase.
	damage_added = 3 //Add 3 damage to unarmed attacks when worn
	species_restricted = list("Ork", "Ork Nob") //Only orks can wear ork stuff for now at least.
	species_fit = list("Ork", "Ork Nob") //We insure it checks to fit for the species icon.

/* 
	Gloves
	*/
/obj/item/clothing/gloves/warboss_armorbracers
	name = "Armor Bracers" //The name of the object ingame.
	desc = "A pair of metal bracers." //Description upon examination
	icon_state = "warboss_gloves" //The state of the object icon when dropped/displayed in slot
	siemens_coefficient = 0.9 //A value of how conductive something is on a scale of 0 to 1
	armor = list(melee = 5, bullet = 5, laser = 5,energy = 0, bomb = 5, bio = 10, rad = 0)
	body_parts_covered = HANDS
	bonus_knockout = 25 //Slight knockout chance increase.
	damage_added = 10 //Add 3 damage to unarmed attacks when worn
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi' //Object Icon Path, what appears when dropped.
	species_restricted = list("Ork Warboss")  //Only orks can wear ork stuff for now at least.
	species_fit = list("Ork Warboss") //We insure it checks to fit for the species icon.