
/obj/item/clothing/under/knight_officer
	name = "Chainmail and Pants"
	desc = "Its basically chainmail, and pants."
	icon = 'z40k_shit/icons/obj/clothing/uniforms.dmi'
	icon_state = "knight_officer" //Check: its there
	item_state = "knight_officer"//Check: Its fine
	_color = "knight_officer"
	has_sensor = 2
	species_restricted = list("Human")
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY
	armor = list(melee = 50, bullet = 50, laser = 50,energy = 25, bomb = 50, bio = 100, rad = 50)