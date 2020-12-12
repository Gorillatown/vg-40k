/datum/requisition_buyable
	var/name = "PARENT" //Name for display purposes
	var/req_price = 9999999 //The price of the object
	var/object = null  //The actual object path itself for spawning purposes.
	var/quality = 0 //Basically a random value to change things on the object.

/datum/requisition_buyable/New()
	quality = rand(0,10)
	if(quality <= 4)
		req_price -= quality*40
	else if(quality > 5)
		req_price += quality*30

/*
	The fact of the matter is, there are a lot of items with different traits.
	But there are many ways to handle shit.
	So we are going to have a generic ez proc to overwrite on the datum itself.
*/
/datum/requisition_buyable/proc/handle_modifiers(obj/item/E)
	if(istype(E,/obj/item/weapon/gun))
		var/obj/item/weapon/gun/G = E
		if(quality <= 4)
			G.quality_modifier -= quality
		else if(quality > 5)
			G.quality_modifier += quality

	if(quality <= 4)
		E.force -= quality
	else if(quality > 5)
		E.force += quality*2

/datum/requisition_buyable/eviscerator
	name = "Eviscerator"
	req_price = 400
	object = /obj/item/weapon/gun/projectile/eviscerator

/datum/requisition_buyable/chain_axe
	name = "Chain Axe"
	req_price = 250
	object = /obj/item/weapon/chainaxe

/datum/requisition_buyable/needler
	name = "Needler"
	req_price = 1000
	object = /obj/item/weapon/gun/projectile/needler

/datum/requisition_buyable/lasgun
	name = "M-Galaxy Pattern Lasgun"
	req_price = 100
	object = /obj/item/weapon/gun/energy/lasgun

/datum/requisition_buyable/lasgun/handle_modifiers(obj/item/weapon/gun/energy/lasgun/E)
	..()
	if(quality <= 4)
		E.degradation_state -= quality
	else if(quality > 5)
		E.degradation_state += quality
	
/datum/requisition_buyable/plasgun
	name = "Plasgun"
	req_price = 1000
	object = /obj/item/weapon/gun/ig_plasma_gun


/datum/requisition_buyable/plasgun_backpack
	name = "Plasgun Powerpack"
	req_price = 500
	object = /obj/item/weapon/iguard/ig_powerpack

/datum/requisition_buyable/plasgun_backpack/handle_modifiers(obj/item/weapon/iguard/ig_powerpack/E)
	E.max_fuel = quality*100
