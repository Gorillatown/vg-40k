/datum/manufacturing_recipe/lasgun
	name = "Lasgun"
	desc_string = "2 Lens, 1 Energy Cell, 1 Gun Receiver, 5 Metal"
	requirements = list(/obj/item/stack/sheet/metal = 5,
						/obj/item/weapon/cell/lasgunmag = 1,
						/obj/item/manufacturing_parts/lens = 2,
						/obj/item/manufacturing_parts/receiver = 1)
	end_result = /obj/item/weapon/gun/energy/lasgun

/datum/manufacturing_recipe/chainsword
	name = "Chainsword"
	desc_string = "1 Chainblade, 1 Spring, 1 Lever, 5 Metal"
	requirements = list(/obj/item/stack/sheet/metal = 5,
						/obj/item/manufacturing_parts/spring = 1,
						/obj/item/manufacturing_parts/lever = 1,
						/obj/item/manufacturing_parts/chainblade = 1)
	end_result = /obj/item/weapon/chainsword

/datum/manufacturing_recipe/eviscerator
	name = "Eviscerator"
	desc_string = "2 Chainblade, 2 Piston, 5 Springs, 1 Gun Barrel, 1 Gun Receiver, 1 Lens, 5 Metal Sheets"
	requirements = list(/obj/item/stack/sheet/metal = 5,
						/obj/item/manufacturing_parts/chainblade = 2,
						/obj/item/manufacturing_parts/piston = 2,
						/obj/item/manufacturing_parts/spring = 5,
						/obj/item/manufacturing_parts/gunbarrel = 1,
						/obj/item/manufacturing_parts/receiver = 1,
						/obj/item/manufacturing_parts/lens = 1)

/datum/manufacturing_recipe/stubpistol
	name = "Stubpistol"
	desc_string = "1 Gun Receiver, 1 Gun Barrel"
	requirements = list(/obj/item/manufacturing_parts/gunbarrel = 1,
						/obj/item/manufacturing_parts/receiver = 1)