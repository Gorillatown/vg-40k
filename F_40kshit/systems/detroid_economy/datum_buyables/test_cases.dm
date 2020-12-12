/datum/requisition_buyable
	var/name = "PARENT" //Name for display purposes
	var/req_price = 9999999 //The price of the object
	var/object = null  //The actual object path itself for spawning purposes.
	var/quality = 0 //Basically a random value to change things on the object.

/datum/requisition_buyable/New()
	quality = rand(0,10)

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

/datum/requisition_buyable/plasgun
	name = "Plasgun"
	req_price = 1000
	object = /obj/item/weapon/gun/ig_plasma_gun

/datum/requisition_buyable/plasgun_backpack
	name = "Plasgun Powerpack"
	req_price = 500
	object = /obj/item/weapon/iguard/ig_powerpack