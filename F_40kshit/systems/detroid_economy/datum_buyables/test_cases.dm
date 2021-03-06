/* Basically trading some memory off to be lazy,
	We can actually weight the list too.
	Its basically what the requisition system randomly picks from in scenario_controller
*/
var/list/req_obj_reference_list = list(
	/datum/requisition_buyable/eviscerator = 20,
	/datum/requisition_buyable/chain_axe = 40,
	/datum/requisition_buyable/needler = 1,
	/datum/requisition_buyable/lasgun = 60,
	/datum/requisition_buyable/plasgun = 5,
	/datum/requisition_buyable/plasgun_backpack = 5,
	/datum/requisition_buyable/cadian_helmet = 10,
	/datum/requisition_buyable/krieg_helmet = 10,
	/datum/requisition_buyable/valhallan_helmet = 10,
	/datum/requisition_buyable/krieg_greatcoat = 5,
	/datum/requisition_buyable/cadian_flakarmor = 5,
	/datum/requisition_buyable/valhallan_greatcoat = 5,
	/datum/requisition_buyable/cadian_flakboots = 15,
	/datum/requisition_buyable/cadian_gasmask = 10,
	/datum/requisition_buyable/cadian_uniform = 5,
)

/datum/requisition_buyable
	var/name = "PARENT" //Name for display purposes
	var/req_price = 9999999 //The price of the object
	var/object = null  //The actual object path itself for spawning purposes.
	var/quality = 0 //Basically a random value to change things on the object.

/datum/requisition_buyable/New()
	quality = rand(1,10)
	if(quality <= 4)
		var/subtract = round(15/quality)
		subtract = subtract*10
		req_price -= subtract
		if(req_price <= 0)
			req_price = 50
	else if(quality > 5)
		req_price += quality*30


/datum/requisition_buyable/proc/handle_string()
	var/quality_string = ""
	switch(quality)
		if(1 to 4)
			quality_string = "<span class='bad'>Poor</span> [req_price] REQ"
		if(5 to 6)
			quality_string = "<span class='average'>Average</span> [req_price] REQ"
		if(7 to 10)
			quality_string = "<span class='good'>Good</span> [req_price] REQ"
	
	return quality_string

/*
	The fact of the matter is, there are a lot of items with different traits.
	But there are many ways to handle shit.
	So we are going to have a generic ez proc to overwrite on the datum itself.
*/
/datum/requisition_buyable/proc/handle_modifiers(obj/item/E)
	//Guncheck
	if(istype(E,/obj/item/weapon/gun))
		var/obj/item/weapon/gun/G = E
		if(quality <= 4)
			G.quality_modifier -= (15/quality)
		else if(quality > 5)
			G.quality_modifier += quality

	//Armorcheck
	if(istype(E,/obj/item/clothing))
		var/obj/item/clothing/C = E

		if(quality <= 4)
			for(var/A in C.armor)
				C.armor[A] = clamp((C.armor[A]-(15/quality)),0,100)
		else if(quality > 5)
			for(var/A in C.armor)
				C.armor[A] = clamp((C.armor[A]+quality*1.5),0,100)

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

/datum/requisition_buyable/plasgun_backpack
	name = "Plasgun Powerpack"
	req_price = 500
	object = /obj/item/weapon/iguard/ig_powerpack

/datum/requisition_buyable/plasgun_backpack/handle_modifiers(obj/item/weapon/iguard/ig_powerpack/E)
	E.max_fuel = quality*100

