/*
Notes:
Deffo not my best work, a mix of copy-pasting and shitcode.
*/
var/obj/machinery/requisition_console/req_con
/obj/machinery/requisition_console
	name = "Requisition Console"
	icon = 'F_40kshit/icons/obj/64x64machines.dmi'
	icon_state = "req_base"
	desc = "This console acknowledges your service to the Mannheim Dynasty, in the form of letting you spend it on material goods."
	machine_flags = WRENCHMOVE|FIXED2WORK 
	density = TRUE
	anchored = TRUE
	bound_width = 64
	plane = ABOVE_HUMAN_PLANE
	layer = WINDOOR_LAYER
	var/current_cargo_req_held = 0 //Amount of sales Req we currently got.

	//var/logged_in = FALSE //Did we swipe our credstick.
	var/obj/item/weapon/card/id/contained_card = null //Keep track of the ID inserted.
	
	//The Datums themselves are /datum/requisition_buyable
	//They have three vars atm, basically. Info because they are the contents of the list below.
	//name - this is a string aka name
	//req_price - This is a price aka integer
	//object - This is a path to a object

	//I'm still undecided on whether we tie the purchase to the object on the screen.
	//Or let them hit purchase to move it into the list, so they can have a shopping cart.
	//var/list/current_datums = list() //We jam datums in, and move them out when necessary. Aka purchase holder.

/obj/machinery/requisition_console/ex_act(severity)
	return

/obj/machinery/requisition_console/New()
	..()
	set_light(3, 6, "#FDFDFD")
	req_con = src

/obj/machinery/requisition_console/initialize()
	..()

/obj/machinery/requisition_console/Destroy()
	req_con = null
	qdel(contained_card)
	contained_card = null
	..()
 
/obj/machinery/requisition_console/update_icon()
	if(stat & (NOPOWER))
		vis_contents.Cut()
	else
		vis_contents += new /obj/effect/overlay/viscons/detroid_req_overlay

/obj/effect/overlay/viscons/detroid_req_overlay
	name = "Detroid Req Light"
	desc = "Ayep"
	icon = 'F_40kshit/icons/obj/64x64machines.dmi'
	icon_state = "req_on"
	vis_flags = VIS_INHERIT_ID
	plane = LIGHTING_PLANE
	layer = ABOVE_LIGHTING_LAYER

/obj/machinery/requisition_console/power_change()
	..()
	update_icon()

//we handle the card slot in and out on attackby.
/obj/machinery/requisition_console/attackby(obj/item/weapon/W, mob/user)
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
/obj/machinery/requisition_console/attack_hand(mob/user)
	ui_interact(user)

//The Addlink shit in the template calls the topic.
/obj/machinery/requisition_console/Topic(href, href_list)
	if(href_list["purchase"]) 
		if(contained_card)
			var/req_on_credstick = contained_card.req_holder.requisition
			var/datum/requisition_buyable/req_datum_ref
			var/comparison_string = href_list["selection"]
			var/price = text2num(href_list["sel_price"])
			for(var/datum/requisition_buyable/req_datum in requisition_buyable_obj_list)
				if(req_datum.name == comparison_string)
					req_datum_ref = req_datum
					break
			if(!req_datum_ref)
				say("SOLD OUT")
				return
			if(req_on_credstick >= price)
				contained_card.req_holder.requisition -= price
				requisition_buyable_obj_list -= req_datum_ref
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

	if(href_list["withdraw_cargo_req"])
		if(contained_card)
			contained_card.req_holder.requisition += current_cargo_req_held
			current_cargo_req_held = 0
		
//The nano_ui proc, in this we want to prepare data for display on (MY shoddy ass) js interface.
/obj/machinery/requisition_console/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = NANOUI_FOCUS)
	var/data[0]
	if(contained_card)
		data["name_of_credholder"] = "[contained_card.registered_name]"
		data["requisition"] = "[contained_card.req_holder.requisition]"
	else
		data["name_of_credholder"] = "Please Insert Identifier"
		data["requisition"] = "NULL"
	data["req_from_sales"] = "[current_cargo_req_held]"

	data["going_places"] = nu_req_shuttle.off_station
	data["shuttle_status"] = nu_req_shuttle.in_transit
	data["transit_time"] = "[nu_req_shuttle.time_to_departure*2] seconds"
	data["shuttle_max_capacity"] = nu_req_shuttle.max_capacity
 
	var/buyables_list[0]
	for(var/datum/requisition_buyable/req_buyable in requisition_buyable_obj_list)
		var/dumb_string = req_buyable.handle_string()
		buyables_list.Add(list(list("name" = req_buyable.name, "price" = req_buyable.req_price, "quality" = dumb_string))) 
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
		ui = new(user, src, ui_key, "requisition_console.tmpl", "Requisition Console", 450, 500)
		// when the ui is first opened this is the data it will use
		ui.set_initial_data(data)
		// open the new ui window
		ui.open()
