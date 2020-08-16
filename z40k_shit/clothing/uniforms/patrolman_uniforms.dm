/obj/item/clothing/under/patrolman_uniform
	name = "Dusty Robe"
	desc = "Good for those whom reside in a desert."
	icon = 'z40k_shit/icons/obj/clothing/uniforms.dmi'
	icon_state = "patrolman" //Check: its there
	item_state = "patrolman"//Check: Its fine
	_color = "patrolman"
	has_sensor = 2
	species_restricted = list("Human")
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY
	armor = list(melee = 20, bullet = 10, laser = 30,energy = 25, bomb = 20, bio = 25, rad = 50)