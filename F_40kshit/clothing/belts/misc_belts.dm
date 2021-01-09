//--------------BELT----------------
/obj/item/weapon/storage/belt/hospitaller_belt
	name = "Cloth Armor Addition"
	desc = "Its basically cloth that makes your armor look kind of stylish."
	icon = 'F_40kshit/icons/obj/ig/IGarmorandclothesOBJ.dmi'
	icon_state = "hospitaller_belt"
	item_state = "hospitaller_belt"
	max_combined_w_class = 200
	fits_max_w_class = 5
	body_parts_covered = LOWER_TORSO|LEGS
	armor = list(melee = 30, bullet = 20, laser = 40,energy = 10, bomb = 10, bio = 10, rad = 0)
	w_class = W_CLASS_LARGE
	storage_slots = 7
	can_only_hold = list("/obj/item/weapon/gun/projectile/automatic/boltpistol",
					"/obj/item/weapon/chainsword",
					"/obj/item/weapon/powersword",
					"/obj/item/weapon/"
					)
	canremove = FALSE

/*
	IMPERIAL GUARD BELTS
						*/

/obj/item/weapon/storage/belt/basicbelt
	name = "Basic Belt"
	desc = "A standard issue belt."
	icon_state = "imperialbelt" //Check: Its there
	item_state = "imperialbelt" //Check: Its there
	w_class = W_CLASS_LARGE
	storage_slots = 14
	max_combined_w_class = 20
	fits_ignoring_w_class = list(
		"/obj/item/device/lightreplacer"
		)
	can_only_hold = list(
		"/obj/item/weapon/crowbar",
		"/obj/item/weapon/screwdriver",
		"/obj/item/weapon/weldingtool",
		"/obj/item/weapon/solder",
		"/obj/item/weapon/wirecutters",
		"/obj/item/weapon/wrench",
		"/obj/item/device/multitool",
		"/obj/item/device/flashlight",
		"/obj/item/stack/cable_coil",
		"/obj/item/device/t_scanner",
		"/obj/item/device/analyzer",
		"/obj/item/taperoll/engineering",
		"/obj/item/taperoll/syndie/engineering",
		"/obj/item/taperoll/atmos",
		"/obj/item/taperoll/syndie/atmos",
		"/obj/item/weapon/extinguisher",
		"/obj/item/stack/rcd_ammo",
		"/obj/item/weapon/reagent_containers/glass/fuelcan",
		"/obj/item/device/lightreplacer",
		"/obj/item/device/device_analyser",
		"/obj/item/device/silicate_sprayer",
		"/obj/item/device/geiger_counter"
		)

//mech belt
/obj/item/weapon/storage/belt/enginseer_belt
	name = "Flashy belt"
	desc = "A belt that can hold things, with a bit of rice to it in the form of a dirty red cloth."
	icon = 'F_40kshit/icons/obj/clothing/belts.dmi'
	icon_state = "mech_belt" //Check: Its there
	item_state = "mech_belt" //Check: Its there
	w_class = W_CLASS_LARGE
	storage_slots = 14
	max_combined_w_class = 200
	fits_ignoring_w_class = list(
		"/obj/item/device/lightreplacer"
		)
	can_only_hold = list(
		"/obj/item/weapon/crowbar",
		"/obj/item/weapon/screwdriver",
		"/obj/item/weapon/weldingtool",
		"/obj/item/weapon/solder",
		"/obj/item/weapon/wirecutters",
		"/obj/item/weapon/wrench",
		"/obj/item/device/multitool",
		"/obj/item/device/flashlight",
		"/obj/item/stack/cable_coil",
		"/obj/item/device/t_scanner",
		"/obj/item/device/analyzer",
		"/obj/item/taperoll/engineering",
		"/obj/item/taperoll/syndie/engineering",
		"/obj/item/taperoll/atmos",
		"/obj/item/taperoll/syndie/atmos",
		"/obj/item/weapon/extinguisher",
		"/obj/item/stack/rcd_ammo",
		"/obj/item/weapon/reagent_containers/glass/fuelcan",
		"/obj/item/device/lightreplacer",
		"/obj/item/device/device_analyser",
		"/obj/item/device/silicate_sprayer",
		"/obj/item/device/geiger_counter"
		)

	canremove = 0