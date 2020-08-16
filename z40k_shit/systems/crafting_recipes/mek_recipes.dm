/datum/crafting_recipes/kustom_shoota
	title = "Kustom Shoota"
	result_type = /obj/item/weapon/gun/projectile/kustomshoota
	time = 3 SECONDS
	build_desc = "30 Metal Sheets, 3 Shootas"
	obj_desc = "A Kustom Shoota allows many guns to be attached to it."
	other_objects = list(/obj/item/weapon/gun/projectile/automatic/shoota = 3)
	sheet_types = list(/obj/item/stack/sheet/metal = 30)

/datum/crafting_recipes/rokkits
	title = "Rokkits"
	result_type = /obj/item/ammo_casing/rocket_rpg/rokkit
	time = 1 SECONDS
	build_desc = "20 Metal Sheets, 4 Metal Rods, 4 Floor Tiles"
	obj_desc = "A rokkit for a rokkitlauncha."
	sheet_types = list(/obj/item/stack/sheet/metal = 20,
						/obj/item/stack/rods = 4,
						/obj/item/stack/tile/plasteel = 4)

/datum/crafting_recipes/scrapbullets
	title = "Pile O' Bullets"
	result_type = /obj/item/ammo_storage/box/piles/sluggabulletpile/max_pile
	time = 1 SECONDS
	build_desc = "10 Metal Sheets, 10 Floor Tiles"
	obj_desc = "Its a pile of general purpose bullets"
	sheet_types = list(/obj/item/stack/sheet/metal = 10,
						/obj/item/stack/tile/plasteel = 10)

/datum/crafting_recipes/buckshot
	title = "Pile O' Buckshot"
	result_type = /obj/item/ammo_storage/box/piles/buckshotpile/max_pile
	time = 1 SECONDS
	build_desc = "10 Metal Sheets, 10 Floor Tiles"
	obj_desc = "Its a pile of buckshot"
	sheet_types = list(/obj/item/stack/sheet/metal = 10,
						/obj/item/stack/tile/plasteel = 10)

/datum/crafting_recipes/stikkbombs
	title = "Stikkbombs"
	result_type = /obj/item/weapon/grenade/stikkbomb
	time = 2 SECONDS
	build_desc = "15 Metal Sheets, 10 Floortiles"
	obj_desc = "Its a bomm on a stikk idiot."
	sheet_types = list(/obj/item/stack/sheet/metal = 15,
						/obj/item/stack/tile/plasteel = 10)

/datum/crafting_recipes/shoota
	title = "Shoota"
	result_type = /obj/item/weapon/gun/projectile/automatic/shoota
	time = 3 SECONDS
	build_desc = "20 Metal Sheets"
	obj_desc = "Its a shoota, it shoots"
	sheet_types = list(/obj/item/stack/sheet/metal = 20)


/datum/crafting_recipes/choppa
	title = "Choppa"
	result_type = /obj/item/weapon/choppa
	time = 2 SECONDS
	build_desc = "20 Metal Sheets"
	obj_desc = "It chopps real good."
	sheet_types = list(/obj/item/stack/sheet/metal = 20)

/datum/crafting_recipes/shield
	title = "Shield"
	result_type = /obj/item/weapon/shield/orkshield
	time = 3 SECONDS
	build_desc = "30 Metal Sheets"
	obj_desc = "Its an orkish shield"
	sheet_types = list(/obj/item/stack/sheet/metal = 30)

/datum/crafting_recipes/slugga
	title = "Slugga"
	result_type = /obj/item/weapon/gun/projectile/automatic/slugga
	time = 3 SECONDS
	build_desc = "20 Metal Sheets"
	obj_desc = "Its basically a handgun"
	sheet_types = list(/obj/item/stack/sheet/metal = 20)

/datum/crafting_recipes/shotta
	title = "Shotta"
	result_type = /obj/item/weapon/gun/projectile/shotgun/shotta
	time = 3 SECONDS
	build_desc = "20 Metal Sheets"
	obj_desc = "Unlike the slugga, its a handheld shotgun"
	sheet_types = list(/obj/item/stack/sheet/metal = 20)

/datum/crafting_recipes/rokkitlauncha
	title = "Rokkitlauncha"
	result_type = /obj/item/weapon/gun/projectile/rocketlauncher/rokkitlauncha
	time = 4 SECONDS
	build_desc = "(2 stacks) of 40 Metal Sheets, 1 Welding Fuel Tank, 1 Canister"
	obj_desc = "It fire rokkits."
	sheet_types = list(/obj/item/stack/sheet/metal = 40,
						/obj/item/stack/sheet/metal = 40)
	other_objects = list(/obj/structure/reagent_dispensers/fueltank = 1,
						/obj/machinery/portable_atmospherics/canister = 1)

/datum/crafting_recipes/ork_jumppack
	title = "Jumppack"
	result_type = /obj/item/ork/jumppack
	time = 5 SECONDS
	build_desc = "40 Metal Sheets, 1 Welding Fuel Tank"
	obj_desc = "It lets you jump into the air"
	sheet_types = list(/obj/item/stack/sheet/metal = 40)
	other_objects = list(/obj/structure/reagent_dispensers/fueltank = 1)

/datum/crafting_recipes/burnapack
	title = "Burnapack"
	result_type = /obj/item/weapon/ork/burnapack
	time = 5 SECONDS
	build_desc = "40 Metal Sheets, 2 Welding Fuel Tanks"
	obj_desc = "It lets you shoot flames"
	sheet_types = list(/obj/item/stack/sheet/metal = 40)
	other_objects = list(/obj/structure/reagent_dispensers/fueltank = 2)

/datum/crafting_recipes/mekanical_shouta
	title = "Mekanical Shouta"
	result_type = /obj/structure/mekanical_shouta
	time = 10 SECONDS
	build_desc = "40 Metal Sheets, 1 Power Cell(Battery)"
	obj_desc = "Lets everyone hear you across the entire battlefield hella loud."
	sheet_types = list(/obj/item/stack/sheet/metal = 40)
	other_objects = list(/obj/item/weapon/cell = 1)

/datum/crafting_recipes/kustom_shoota_belt
	title = "Kustom Shoota Belt"
	result_type = /obj/item/ammo_storage/magazine/kustom_shoota_belt
	time = 10 SECONDS
	build_desc = "20 Metal Sheets, 20 Floor Tiles"
	obj_desc = "Its a belt for a kustom shoota, uses scrap bullets tho"
	sheet_types = list(/obj/item/stack/sheet/metal = 20,
						/obj/item/stack/tile/plasteel = 20)
