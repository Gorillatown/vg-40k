/*
Notes:
Deffo not my best work, a mix of copy-pasting and shitcode.
*/
/obj/structure/requisition_console
	name = "Requisition Console"
	icon = 'z40k_shit/icons/obj/64xstructures.dmi'
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
	var/list/buyables_list = list() 
	
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
		buyables_list[req_datum_ref.name] = req_datum_ref
	
//we handle the card slot in and out on attackby.
/obj/structure/requisition_console/attackby(obj/item/weapon/W, mob/user)
	..()
	if(istype(W,/obj/item/weapon/card/id))
		var/obj/item/weapon/card/id/id_card = W
		if(user.drop_item(id_card,src)) //If we can drop the card in
			say("Welcome [user.name].") //Greetings message
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
	/*
	To better understand how this shit is working, you need to realize the structures.
	To detail what is contained below, think of 'things in this' as strings.
	Along with that the format is basically. 'button-name', 'little-picture',  {'href_key' : 'passed_info'}
	EX:{{:helper.link('suck dick', 'dick-icon', { 'dick' : 'erect', 'cocks' : '1' })}} in the tmpl
	They click suck dick with a little dic next to it, now we get this motherfuckin data ta work with sent.
	list("src" = "\ref[src]", "dick" = "erect", "cocks" = "1").
	So, we have hrefs from a list, aka href_list. So when you use the keys
	href_list["dick"] you'd get "erect", also href_list["cocks"] would give you "1"
	So we have to convert the strings into the data we need, p much explantory what to do next.
	*/
	
	//Time for a purchase
	if(href_list["purchase"]) //They click the purchase button, we gonna have something in the params to dictate what.
		var/req_on_credstick = contained_card.req_holder.requisition //This is a integer, mostly so we save time.
		var/string = href_list["selection"] //Now we got a string thats keyed to "selection"
		//Pull the proper req_datum out of the list.
		var/datum/requisition_buyable/req_datum_ref = buyables_list[string] //We got the datum now.
		if(req_on_credstick >= req_datum_ref.req_price)
			contained_card.req_holder.requisition -= req_datum_ref.req_price
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
	data["name_of_credholder"] = contained_card.registered_name
	data["shuttle_status"] = nu_req_shuttle.in_transit
	data["requisition"] = contained_card.req_holder.requisition
	data["shuttle_max_capacity"] = nu_req_shuttle.max_capacity

	var/buyable_obj_data[0] //List of shit they can buy
	for(var/datum/requisition_buyable/req_buyable in buyables_list) // we run the loop, to fill it in.
		buyable_obj_data.Add(list(list("name" = req_buyable.name, "price" = req_buyable.req_price))) 
	//Nazty but we basically are sending a beefy ass list over.
	var/shipping_manifest[0] //List of mysterious peoples's shit.
	for(var/strings in nu_req_shuttle.shipping_manifest) //Todo append: {{:data.errorMessage}}
		shipping_manifest.Add(list(list("manifest" = "strings"))) 
	data["req_datums"] = buyable_obj_data
	data["shipping_manifest"] = shipping_manifest

	// update the ui if it exists, returns null if no ui is passed/found
	ui = nanomanager.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		// the ui does not exist, so we'll create a new() one
        // for a list of parameters and their descriptions see the code docs in \code\\modules\nano\nanoui.dm
		ui = new(user, src, ui_key, "requisition_console.tmpl", "Requisition Console", 400, 500)
		// when the ui is first opened this is the data it will use
		ui.set_initial_data(data)
		// open the new ui window
		ui.open()
		// auto update every Master Controller tick
		ui.set_auto_update(1)

/obj/structure/requisition_console/attackby(obj/item/weapon/W, mob/user)
	..()

