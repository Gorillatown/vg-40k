/*
TODO: Datums + Requirements
*/
/*
var/list/manufacturing_recipes = list(
									/datum/manufacturing_recipe/gear,
									/datum/manufacturing_recipe/lens,
									/datum/manufacturing_recipe/fuel_tank,
									/datum/manufacturing_recipe/energy_cell,
									/datum/manufacturing_recipe/blade,
									/datum/manufacturing_recipe/gun_receiver,
									/datum/manufacturing_recipe/spring,
									/datum/manufacturing_recipe/lever,
									/datum/manufacturing_recipe/piston,
									/datum/manufacturing_recipe/gun_barrel,
									/datum/manufacturing_recipe/chain_blade,
									/datum/manufacturing_recipe/lasgun,
									/datum/manufacturing_recipe/chainsword,
									/datum/manufacturing_recipe/eviscerator,
									/datum/manufacturing_recipe/stubpistol)
*/

/datum/manufacturing_recipe
	var/name = "Manufacturing Recipe"
	var/desc_string = "ERROR"
	var/list/requirements = list() //List of requirements
	var/obj/item/end_result = null //End item

/datum/manufacturing_recipe/gear
	name = "Gear"
	desc_string = "1 Metal Sheet"
	requirements = list(/obj/item/stack/sheet/metal = 1)
	end_result = /obj/item/manufacturing_parts/gear

/datum/manufacturing_recipe/lens
	name = "Lens"
	desc_string = "1 Glass Sheet"
	requirements = list(/obj/item/stack/sheet/glass = 1)
	end_result = /obj/item/manufacturing_parts/lens

/datum/manufacturing_recipe/fuel_tank
	name = "Fuel Tank"
	desc_string = "2 Metal Sheets"
	requirements = list(/obj/item/stack/sheet/metal = 2)
	end_result = /obj/item/manufacturing_parts/fueltank

/datum/manufacturing_recipe/energy_cell
	name = "Energy Cell"
	desc_string = "1 Metal Sheet, 1 Uranium Sheet"
	requirements = list(/obj/item/stack/sheet/metal = 1,
						/obj/item/stack/sheet/mineral/uranium = 1)
	end_result = /obj/item/weapon/cell/lasgunmag

/datum/manufacturing_recipe/blade
	name = "Blade"
	desc_string = "1 Metal Sheet"
	requirements = list(/obj/item/stack/sheet/metal = 1)
	end_result = /obj/item/manufacturing_parts/blade

/datum/manufacturing_recipe/gun_receiver
	name = "Gun Receiver"
	desc_string = "1 Spring, 1 Lever, 1 Piston"
	requirements = list(/obj/item/manufacturing_parts/spring = 1,
						/obj/item/manufacturing_parts/lever = 1,
						/obj/item/manufacturing_parts/piston = 1)
	end_result = /obj/item/manufacturing_parts/receiver

/datum/manufacturing_recipe/spring
	name = "Spring"
	desc_string = "1 Metal Sheet"
	requirements = list(/obj/item/stack/sheet/metal = 1)
	end_result = /obj/item/manufacturing_parts/spring

/datum/manufacturing_recipe/lever
	name = "Lever"
	desc_string = "1 Metal Sheet"
	requirements = list(/obj/item/stack/sheet/metal = 1)
	end_result = /obj/item/manufacturing_parts/lever

/datum/manufacturing_recipe/piston
	name = "Piston"
	desc_string = "1 Metal Sheet"
	requirements = list(/obj/item/stack/sheet/metal = 1)
	end_result = /obj/item/manufacturing_parts/piston

/datum/manufacturing_recipe/gun_barrel
	name = "Gun Barrel"
	desc_string = "2 Metal Sheets"
	requirements = list(/obj/item/stack/sheet/metal = 2)
	end_result = /obj/item/manufacturing_parts/gunbarrel

/datum/manufacturing_recipe/chain_blade
	name = "Chain Blade"
	desc_string = "2 Metal Sheets, 5 Blades"
	requirements = list(/obj/item/stack/sheet/metal = 2,
						/obj/item/manufacturing_parts/blade = 5)
	end_result = /obj/item/manufacturing_parts/chainblade
