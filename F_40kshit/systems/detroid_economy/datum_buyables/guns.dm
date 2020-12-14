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