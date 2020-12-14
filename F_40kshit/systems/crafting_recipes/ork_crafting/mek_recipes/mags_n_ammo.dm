/datum/crafting_recipes/ork_slugga_mag
	title = "Ork Slugga Mag"
	result_type = /obj/item/ammo_storage/magazine/sluggamag
	time = 5 SECONDS
	build_desc = "15 Metal Sheets, 12 Standard Metal Floortiles"
	obj_desc = "A mag for a slugga, ya make the bullets too"
	sheet_types = list(/obj/item/stack/sheet/metal = 15,
						/obj/item/stack/tile/plasteel = 12)

/datum/crafting_recipes/ork_shotta_mag
	title = "Ork Shotta Mag"
	result_type = /obj/item/ammo_storage/magazine/shottamag
	time = 5 SECONDS
	build_desc = "15 Metal Sheets, 12 Standard Metal Floortiles"
	obj_desc = "Mag for ya shotta, ya make the shells too"
	sheet_types = list(/obj/item/stack/sheet/metal = 15,
						/obj/item/stack/tile/plasteel = 12)

/datum/crafting_recipes/kustom_shoota_belt
	title = "Kustom Shoota Ammo Belt"
	result_type = /obj/item/ammo_storage/magazine/kustom_shoota_belt
	time = 10 SECONDS
	build_desc = "15 Metal Sheets, 12 Standard Metal Floortiles"
	obj_desc = "Its a belt for a kustom shoota, uses scrap bullets tho"
	sheet_types = list(/obj/item/stack/sheet/metal = 15,
						/obj/item/stack/tile/plasteel = 12)

/datum/crafting_recipes/rokkits
	title = "Rokkits"
	result_type = /obj/item/ammo_casing/rocket_rpg/rokkit
	time = 1 SECONDS
	build_desc = "20 Metal Sheets, 4 Metal Rods, 4 Standard Metal Floortiles"
	obj_desc = "A rokkit for a rokkitlauncha."
	sheet_types = list(/obj/item/stack/sheet/metal = 20,
						/obj/item/stack/rods = 4,
						/obj/item/stack/tile/plasteel = 4)

/datum/crafting_recipes/scrapbullets
	title = "Pile O' Bullets"
	result_type = /obj/item/ammo_storage/box/piles/sluggabulletpile/max_pile
	time = 1 SECONDS
	build_desc = "5 Metal Sheets, 4 Standard Metal Floortiles"
	obj_desc = "Its a pile of general purpose bullets"
	sheet_types = list(/obj/item/stack/sheet/metal = 5,
						/obj/item/stack/tile/plasteel = 4)

/datum/crafting_recipes/buckshot
	title = "Pile O' Buckshot"
	result_type = /obj/item/ammo_storage/box/piles/buckshotpile/max_pile
	time = 1 SECONDS
	build_desc = "5 Metal Sheets, 4 Standard Metal Floortiles"
	obj_desc = "Its a pile of buckshot"
	sheet_types = list(/obj/item/stack/sheet/metal = 5,
						/obj/item/stack/tile/plasteel = 4)