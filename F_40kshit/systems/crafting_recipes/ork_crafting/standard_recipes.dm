/datum/crafting_recipes/trophy_banner
	title = "Trophy Banner"
	result_type = /obj/structure/orktrophybanner
	skip_qual_boost = TRUE
	time = 5 SECONDS
	build_desc = "5 Metal Sheets, 1 Piece of Uniform Clothing"
	obj_desc = "A banner for ya to stick heads on."
	sheet_types = list(/obj/item/stack/sheet/metal = 5)
	other_objects = list(/obj/item/clothing/under = 1)


/datum/crafting_recipes/flashlight
	title = "Flashlight"
	result_type = /obj/item/device/flashlight
	skip_qual_boost = TRUE
	time = 1 SECONDS
	build_desc = "2 Metal Sheets"
	obj_desc = "A flashlight ya git"
	sheet_types = list(/obj/item/stack/sheet/metal = 2)

/datum/crafting_recipes/ork_clothes
	title = "Ork Clothes"
	result_type = /obj/item/clothing/under/ork_pantsandshirt
	skip_qual_boost = TRUE
	time = 1 SECONDS
	build_desc = "1 Piece of Uniform Clothing"
	obj_desc = "Some clothes ya git"
	other_objects = list(/obj/item/clothing/under = 1)