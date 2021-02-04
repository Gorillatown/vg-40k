/datum/crafting_recipes/slugga
	title = "Slugga"
	result_type = /obj/item/weapon/gun/projectile/automatic/slugga
	time = 2 SECONDS
	build_desc = "10 Metal Sheets, 2 metal rods, 4 pieces of cable, 1 welding tool, 1 crowbar"
	obj_desc = "Its basically a handgun"
	sheet_types = list(/obj/item/stack/sheet/metal = 10,
						/obj/item/stack/rods = 2,
						/obj/item/stack/cable_coil = 4)
	other_objects = list(/obj/item/weapon/weldingtool = 1,
						/obj/item/weapon/crowbar = 1)

/datum/crafting_recipes/shotta
	title = "Shotta"
	result_type = /obj/item/weapon/gun/projectile/shotgun/shotta
	time = 2 SECONDS
	build_desc = "20 Metal Sheets, 2 metal rods, 10 pieces of cable, 1 welding tool, 1 crowbar"
	obj_desc = "Unlike the slugga, its a handheld shotgun"
	sheet_types = list(/obj/item/stack/sheet/metal = 20,
						/obj/item/stack/rods = 2,
						/obj/item/stack/cable_coil = 10)
	other_objects = list(/obj/item/weapon/weldingtool = 1,
						/obj/item/weapon/crowbar = 1)

/datum/crafting_recipes/shoota
	title = "Shoota"
	result_type = /obj/item/weapon/gun/projectile/automatic/shoota
	time = 2 SECONDS
	build_desc = "30 Metal Sheets, 12 rods, 30 Standard Metal Floortiles, 20 pieces of cable, 1 welding tool"
	obj_desc = "Its a shoota, it shoots"
	sheet_types = list(/obj/item/stack/sheet/metal = 30,
						/obj/item/stack/rods = 12,
						/obj/item/stack/tile/plasteel = 30,
						/obj/item/stack/cable_coil = 20)
	other_objects = list(/obj/item/weapon/weldingtool = 1)

/datum/crafting_recipes/kustom_shoota
	title = "Kustom Shoota"
	result_type = /obj/item/weapon/gun/projectile/kustomshoota
	time = 2 SECONDS
	build_desc = "30 Metal Sheets, 3 Shootas"
	obj_desc = "A Kustom Shoota allows many guns to be attached to it."
	other_objects = list(/obj/item/weapon/gun/projectile/automatic/shoota = 3)
	sheet_types = list(/obj/item/stack/sheet/metal = 30)

/datum/crafting_recipes/rokkitlauncha
	title = "Rokkitlauncha"
	result_type = /obj/item/weapon/gun/projectile/rocketlauncher/rokkitlauncha
	time = 4 SECONDS
	build_desc = "(2 stacks) of 40 Metal Sheets, 1 Gas Canister"
	obj_desc = "It fire rokkits."
	sheet_types = list(/obj/item/stack/sheet/metal = 40,
						/obj/item/stack/sheet/metal = 40)
	other_objects = list(/obj/machinery/portable_atmospherics/canister = 1)