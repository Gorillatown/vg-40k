/obj/abstract/loot_spawners/test_spawner
	amount_to_pick = 1
	chance_of_artifact = 100
	loot_table = list(
		/obj/item/weapon/crowbar = 1,
		/obj/item/weapon/weldingtool = 1,
		/obj/item/weapon/wirecutters = 1,
		/obj/item/weapon/screwdriver = 1,
		/obj/item/weapon/wrench = 1,
	)

/obj/abstract/loot_spawners/tool_spawner
	amount_to_pick = 4
	chance_of_artifact = 5
	prob_of_skipped_items = 25
	loot_table = list(
		/obj/item/weapon/crowbar = 1,
		/obj/item/weapon/weldingtool = 1,
		/obj/item/weapon/wirecutters = 1,
		/obj/item/weapon/screwdriver = 1,
		/obj/item/weapon/wrench = 1,
		/obj/item/weapon/wrench/socket = 1,
		/obj/item/device/multitool = 1,
		/obj/item/weapon/solder = 1
	)

/obj/abstract/loot_spawners/instrument_spawner
	amount_to_pick = 2
	chance_of_artifact = 10
	prob_of_skipped_items = 25
	loot_table = list(/obj/item/device/instrument/violin = 1,
					/obj/item/device/instrument/guitar = 2,
					/obj/item/device/instrument/glockenspiel = 1,
					/obj/item/device/instrument/accordion = 1,
					/obj/item/device/instrument/saxophone = 1,
					/obj/item/device/instrument/trombone = 1,
					/obj/item/device/instrument/recorder = 1,
					/obj/item/device/instrument/harmonica = 1,
					/obj/item/device/instrument/bikehorn = 1,
					/obj/item/device/instrument/drum = 1
					)

/obj/abstract/loot_spawners/surgery_tools
	amount_to_pick = 1
	chance_of_artifact = 10
	loot_table = list(
					/obj/item/weapon/cautery = 1,
					/obj/item/weapon/surgicaldrill = 1,
					/obj/item/clothing/mask/breath/medical = 1,
					/obj/item/weapon/tank/anesthetic = 1,
					/obj/item/weapon/FixOVein = 1,
					/obj/item/weapon/hemostat = 1,
					/obj/item/weapon/scalpel = 1,
					/obj/item/weapon/bonegel = 1,
					/obj/item/weapon/retractor = 1,
					/obj/item/weapon/bonesetter = 1,
					/obj/item/weapon/circular_saw = 1
					)

/obj/abstract/loot_spawners/random_materials
	amount_to_pick = 1
	chance_of_artifact = 10
	loot_table = list(/obj/item/stack/sheet/metal/bigstack = 1,
						/obj/item/stack/sheet/glass/glass/bigstack = 1,
						/obj/item/stack/sheet/wood/bigstack = 5

	)

/obj/abstract/loot_spawners/random_set_one
	amount_to_pick = 2
	chance_of_artifact = 5
	loot_table = list(/obj/item/weapon/bikehorn = 1,
					/obj/item/weapon/coin/gold = 1,
					/obj/item/weapon/shard = 1,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/absinthe = 1,
					/obj/item/weapon/switchtool/swiss_army_knife = 1,
					/obj/item/clothing/head/kitty = 1,
					/obj/item/clothing/head/rabbitears = 1,
					/obj/item/clothing/head/bandana = 1,
					/obj/item/clothing/head/helmet/gladiator = 1,
					/obj/item/clothing/gloves/knuckles = 1,
					/obj/item/weapon/reagent_containers/food/snacks/hoboburger = 1,
					/obj/item/weapon/shield/IGshield = 1,
					/obj/item/weapon/dksword = 1,
					/obj/item/weapon/chainsword = 1)


/obj/abstract/loot_spawners/ork_mat_stack
	amount_to_pick = 2
	chance_of_artifact = 0
	loot_table = list(
					/obj/item/stack/sheet/metal/bigstack = 1,
					/obj/item/stack/sheet/metal/bigstack = 1,
					/obj/item/stack/cable_coil/random = 1,
					/obj/item/weapon/weldingtool = 1,
					/obj/item/weapon/crowbar = 1
					)
