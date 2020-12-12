/*
Notes:
Deffo not my best work, a mix of copy-pasting and shitcode.
*/
/obj/structure/requisition_console
	name = "Requisition Console"
	icon = 'F_40kshit/icons/obj/64xstructures.dmi'
	icon_state = "patrolcomp"
	desc = "This console acknowledges your service to the Mannheim Dynasty, in the form of letting you spend it on material goods."
	density = 1
	anchored = 1
	pixel_x = -12
	pixel_y = -12

	//var/logged_in = FALSE //Did we swipe our credstick.
	var/obj/item/weapon/card/id/contained_card = null //Keep track of the ID inserted.
	
	//The Datums themselves are /datum/requisition_buyable
	//They have three vars atm, basically. Info because they are the contents of the list below.
	//name - this is a string aka name
	//req_price - This is a price aka integer
	//object - This is a path to a object

	//This is an associated list, basically the contents are tagged as [name] = datum.
	//Ex: "Eviscerator" = /datum/requisition_buyable/eviscerator
	//Its done that way cause we dealin wit strings on the href shit, and we gotta find our boys.
	var/list/buyable_obj_list = list() 
	
	//I'm still undecided on whether we tie the purchase to the object on the screen.
	//Or let them hit purchase to move it into the list, so they can have a shopping cart.
	//var/list/current_datums = list() //We jam datums in, and move them out when necessary. Aka purchase holder.

/obj/structure/requisition_console/ex_act(severity)
	return

/obj/structure/requisition_console/New()
	..()
	set_light(3, 3, "#0afd01")

/obj/structure/requisition_console/initialize()
	..()
	fill_buyables_list()

/obj/structure/requisition_console/Destroy()
	..()
 
//This proc fills the buyables list with datums to ref data from.
//TODO: Move it to a global singular iteration.
/obj/structure/requisition_console/proc/fill_buyables_list()
	for(var/req_datum in typesof(/datum/requisition_buyable) - /datum/requisition_buyable)
		var/datum/requisition_buyable/req_datum_ref = new req_datum
		buyable_obj_list += req_datum_ref
	
//we handle the card slot in and out on attackby.
/obj/structure/requisition_console/attackby(obj/item/weapon/W, mob/user)
	..()
	if(istype(W,/obj/item/weapon/card/id))
		var/obj/item/weapon/card/id/id_card = W
		if(user.drop_item(id_card,src)) //If we can drop the card in
			say("*Beep*")
			if(contained_card) //If there is already a contained card
				user.put_in_hands(contained_card) //Put it in our hands
				contained_card = id_card //Change the contained card to ours
			else
				contained_card = id_card //If there isn't a contained card, change the contained card to ours.

//Attacking with open hand opens the nanoui template up.
/obj/structure/requisition_console/attack_hand(mob/user)
	ui_interact(user)

//The Addlink shit in the template calls the topic.
/obj/structure/requisition_console/Topic(href, href_list)
	if(href_list["purchase"]) 
		if(contained_card)
			to_chat(world, "WE HIT")
			var/req_on_credstick = contained_card.req_holder.requisition
			var/datum/requisition_buyable/req_datum_ref
			var/comparison_string = href_list["selection"]
			var/price = text2num(href_list["sel_price"])
			to_chat(world, "[comparison_string]")
			to_chat(world,"[price]")
			for(var/datum/requisition_buyable/req_datum in buyable_obj_list)
				if(req_datum.name == comparison_string)
					req_datum_ref = req_datum
					break
			if(!req_datum_ref)
				say("SOLD OUT")
				return
			if(req_on_credstick >= price)
				contained_card.req_holder.requisition -= price
				buyable_obj_list -= req_datum_ref
				nu_req_shuttle.buy_objects(contained_card,req_datum_ref)
			else
				say("Insufficient Worth") //A denial message, and a return, no goods.
				return
	
	//We gotta be able to handle control of the shuttle too.
	if(href_list["shuttle_time"])
		if(!nu_req_shuttle.in_transit)
			nu_req_shuttle.transit_time()

	//Ez enough, we eject the credstik. Chump, only thing we got is the usr tho.
	if(href_list["eject_credstick"])
		if(contained_card)
			var/mob/living/M = usr
			M.put_in_hands(contained_card)
			contained_card = null
			
//The nano_ui proc, in this we want to prepare data for display on (MY shoddy ass) js interface.
/obj/structure/requisition_console/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = NANOUI_FOCUS)
	var/data[0]
	if(contained_card)
		data["name_of_credholder"] = "[contained_card.registered_name]"
		data["requisition"] = "[contained_card.req_holder.requisition]"
	else
		data["name_of_credholder"] = "Please Insert Identifier"
		data["requisition"] = "NULL"

	data["going_places"] = nu_req_shuttle.off_station
	data["shuttle_status"] = nu_req_shuttle.in_transit
	data["transit_time"] = "[nu_req_shuttle.time_to_departure*2] seconds"
	data["shuttle_max_capacity"] = nu_req_shuttle.max_capacity

	var/buyables_list[0]
	for(var/datum/requisition_buyable/req_buyable in buyable_obj_list)
		buyables_list.Add(list(list("name" = req_buyable.name, "price" = req_buyable.req_price, "quality" = req_buyable.quality))) 
	data["buyables"] = buyables_list
	
	var/shipping_list[0]
	for(var/strings in nu_req_shuttle.shipping_manifest) 
		shipping_list.Add(list(list("manifest" = "[strings]"))) 
	data["shipping"] = shipping_list

	// update the ui if it exists, returns null if no ui is passed/found
	ui = nanomanager.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		// the ui does not exist, so we'll create a new() one
        // for a list of parameters and their descriptions see the code docs in \code\\modules\nano\nanoui.dm
		ui = new(user, src, ui_key, "requisition_console.tmpl", "Requisition Console", 440, 500)
		// when the ui is first opened this is the data it will use
		ui.set_initial_data(data)
		// open the new ui window
		ui.open()
		// auto update every Master Controller tick
		ui.set_auto_update(1)

/obj/structure/requisition_console/attackby(obj/item/weapon/W, mob/user)
	..()

