
/obj/item/clothing/suit/armor/valhalla 
	name = "Valhallan Greatcoat"
	desc = "A heavily armored, extremely warm, and waterproof coat that forms the standard armor of the valhallan ice warriors."
	icon_state = "valhalla_suit"//Check: Its there
	item_state = "valhalla_suit"//Check: Its there
	body_parts_covered = FULL_TORSO|LEGS|FEET|ARMS|HANDS
	heat_conductivity = SPACESUIT_HEAT_CONDUCTIVITY //A bit much, but basically the upshot is these protect you from even severe cold.
	armor = list(melee = 70, bullet = 55, laser = 45, energy = 50, bomb = 40, bio = 100, rad = 95)
	species_restricted = list("Human")