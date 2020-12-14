
/obj/item/clothing/under/knight_officer
	name = "Chainmail and Pants"
	desc = "Its basically chainmail, and pants."
	icon = 'F_40kshit/icons/obj/clothing/uniforms.dmi'
	icon_state = "knight_officer" //Check: its there
	item_state = "knight_officer"//Check: Its fine
	_color = "knight_officer"
	has_sensor = 2
	species_restricted = list("Human")
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY 
	armor = list(melee = 10, bullet = 10, laser = 10, energy = 25, bomb = 60, bio = 100, rad = 50)