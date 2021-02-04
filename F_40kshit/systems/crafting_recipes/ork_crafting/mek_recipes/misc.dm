/datum/crafting_recipes/stikkbombs
	title = "Stikkbombs"
	result_type = /obj/item/weapon/grenade/stikkbomb
	time = 1 SECONDS
	skip_qual_boost = TRUE
	build_desc = "8 Metal Sheets, 8 Standard Metal Floortiles"
	obj_desc = "Its a bomm on a stikk idiot."
	sheet_types = list(/obj/item/stack/sheet/metal = 8,
						/obj/item/stack/tile/plasteel = 8)

/datum/crafting_recipes/choppa
	title = "Choppa"
	result_type = /obj/item/weapon/choppa
	time = 2 SECONDS
	build_desc = "5 Metal Sheets"
	obj_desc = "It chopps real good."
	sheet_types = list(/obj/item/stack/sheet/metal = 5)

/datum/crafting_recipes/shield
	title = "Shield"
	result_type = /obj/item/weapon/shield/orkshield
	time = 2 SECONDS
	build_desc = "10 Metal Sheets"
	obj_desc = "Its an orkish shield"
	sheet_types = list(/obj/item/stack/sheet/metal = 10)

/datum/crafting_recipes/ork_jumppack
	title = "Jumppack"
	result_type = /obj/item/ork/jumppack
	time = 5 SECONDS
	skip_qual_boost = TRUE
	build_desc = "40 Metal Sheets, 1 Welding Fuel Tank"
	obj_desc = "It lets you jump into the air"
	sheet_types = list(/obj/item/stack/sheet/metal = 40)
	other_objects = list(/obj/structure/reagent_dispensers/fueltank = 1)

/datum/crafting_recipes/burnapack
	title = "Burnapack"
	result_type = /obj/item/weapon/ork/burnapack
	time = 2 SECONDS
	build_desc = "20 Metal Sheets, 1 Welding Fuel Tanks"
	obj_desc = "It lets you shoot flames"
	sheet_types = list(/obj/item/stack/sheet/metal = 20)
	other_objects = list(/obj/structure/reagent_dispensers/fueltank = 1)

/datum/crafting_recipes/mekanical_shouta
	title = "Mekanical Shouta"
	result_type = /obj/structure/mekanical_shouta
	time = 5 SECONDS
	skip_qual_boost = TRUE
	build_desc = "20 Metal Sheets, 1 Power Cell(Battery)"
	obj_desc = "Lets everyone hear you across the entire battlefield hella loud."
	sheet_types = list(/obj/item/stack/sheet/metal = 30)
	other_objects = list(/obj/item/weapon/cell = 1)

/datum/crafting_recipes/duct_tape
	title = "Tape Roll"
	result_type = /obj/item/weapon/taperoll
	time = 2 SECONDS
	skip_qual_boost = TRUE
	build_desc = "1 Metal Sheets"
	obj_desc = "A tool for if ya have a kustom ya git."
	sheet_types = list(/obj/item/stack/sheet/metal = 1)

/datum/crafting_recipes/tankhammer
	title = "Tankhammer"
	result_type = /obj/item/weapon/tankhammer
	time = 2 SECONDS
	skip_qual_boost = TRUE
	build_desc = "4 Rods, 1 Rocket"
	obj_desc = "A rocket on a hammer, for old-fashioned orks who don't want to deal with a launcher failing."
	sheet_types = list(/obj/item/stack/rods = 4)
	other_objects = list(/obj/item/ammo_casing/rocket_rpg/d_rocket = 1)
