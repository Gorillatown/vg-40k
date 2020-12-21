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
	end_result = /obj/item/weapon/gun/projectile/eviscerator

/datum/manufacturing_recipe/stubpistol
	name = "Stubpistol"
	desc_string = "1 Gun Receiver, 1 Gun Barrel"
	requirements = list(/obj/item/manufacturing_parts/gunbarrel = 1,
						/obj/item/manufacturing_parts/receiver = 1)
	end_result = /obj/item/weapon/gun/projectile/stubpistol

/datum/manufacturing_recipe/chainmail
	name = "Chainmail"
	desc_string = "2 Chainsheets, 1 Metal Sheet"
	requirements = list(/obj/item/manufacturing_parts/chainsheet = 2,
						/obj/item/stack/sheet/metal = 1)
	end_result = /obj/item/clothing/under/knight_officer

/datum/manufacturing_recipe/knight_helmet
	name = "Heavy Metal Helmet"
	desc_string = "2 Armor Plates, 1 Metal Sheet"
	requirements = list(/obj/item/manufacturing_parts/armorplate = 2,
						/obj/item/stack/sheet/metal = 1)
	end_result = /obj/item/clothing/head/knight_officer_helmet

/datum/manufacturing_recipe/knight_armor
	name = "Heavy Metal Armor"
	desc_string = "4 Armor Plates, 2 Metal Sheets"
	requirements = list(/obj/item/manufacturing_parts/armorplate = 4,
					/obj/item/stack/sheet/metal = 2)
	end_result = /obj/item/clothing/suit/armor/knight_officer

/datum/manufacturing_recipe/knight_boots
	name = "Heavy Metal Boots"
	desc_string = "2 Armor Plates"
	requirements = list(/obj/item/manufacturing_parts/armorplate = 2)
	end_result = /obj/item/clothing/shoes/knight_officer