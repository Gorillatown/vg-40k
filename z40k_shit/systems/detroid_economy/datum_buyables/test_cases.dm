/datum/requisition_buyable
	var/name = "PARENT" //Name for display purposes
	var/req_price = 9999999 //The price of the object
	var/object = null  //The actual object path itself for spawning purposes.

/datum/requisition_buyable/eviscerator
	name = "Eviscerator"
	req_price = 25
	object = /obj/item/weapon/gun/projectile/eviscerator

/datum/requisition_buyable/chain_axe
	name = "Chain Axe"
	req_price = 50
	object = /obj/item/weapon/chainaxe

/datum/requisition_buyable/needler
	name = "Needler"
	req_price = 75
	object = /obj/item/weapon/gun/projectile/needler

/datum/requisition_buyable/lasgun
	name = "M-Galaxy Pattern Lasgun"
	req_price = 420
	object = /obj/item/weapon/gun/energy/lasgun

/datum/requisition_buyable/plasgun
	name = "Plasgun"
	req_price = 600
	object = /obj/item/weapon/gun/ig_plasma_gun