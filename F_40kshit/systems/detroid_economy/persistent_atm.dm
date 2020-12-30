/obj/machinery/detroid_teller
	name = "Mannheim Dynasty ATM Machine"
	icon = 'F_40kshit/icons/obj/64x64machines.dmi'
	icon_state = "atm_base"
	machine_flags = WRENCHMOVE|FIXED2WORK 
	density = TRUE
	anchored = TRUE
	plane = ABOVE_HUMAN_PLANE
	layer = WINDOOR_LAYER
	var/obj/item/weapon/card/id/contained_card = null //Keep track of the ID inserted.
	var/contained_nuyen = 0
	var/time_cooldown = 0

/obj/machinery/detroid_teller/New()
	..()
	set_light(3, 6, "#FDFDFD")
	update_icon()

//we handle the card slot in and out on attackby.
/obj/machinery/detroid_teller/attackby(obj/item/weapon/W, mob/user)
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
	if(istype(W,/obj/item/weapon/nuyen))
		var/obj/item/weapon/nuyen/NY = W
		if(user.drop_item(NY,src))
			say("*Clink*")
			say("[NY.amount] Deposited into Machine.")
			contained_nuyen += NY.amount

/obj/machinery/detroid_teller/power_change()
	..()
	update_icon()

/obj/machinery/detroid_teller/update_icon()
	if(stat & (NOPOWER))
		vis_contents.Cut()
	else
		vis_contents += new /obj/effect/overlay/viscons/detroid_teller_overlay

/obj/effect/overlay/viscons/detroid_teller_overlay
	name = "Detroid Teller Light"
	desc = "Ayep"
	icon = 'F_40kshit/icons/obj/64x64machines.dmi'
	icon_state = "atm_on"
	plane = LIGHTING_PLANE
	layer = ABOVE_LIGHTING_LAYER
	vis_flags = VIS_INHERIT_ID

/obj/machinery/detroid_teller/attack_hand(mob/user)
	show_menu(user)

/obj/machinery/detroid_teller/proc/show_menu(mob/living/user)
	var/datum/interactive_persistence/persist = json_persistence["[user.ckey]"]
	user.set_machine(src)
	var/dat
	dat += {"<head><title> Mannheim Dynasty ATM </title></head>
			<body style="color:#2ae012" bgcolor="#181818"><ul>"}
	dat += "<h3> Mannheim Dynasty ATM </h3>"
	if(!contained_card)
		dat += "Please Insert Identification to use the automatic teller machine.."
	else
		dat += "Welcome <b>[contained_card.registered_name]</b><br>"
		dat += "You currently have <b>[contained_card.req_holder.requisition] REQUISITION</b> on your identification.<br>"
		dat += "In your sector record you currently have <b>[persist.money_saved] DETROID NUYEN</b>.<br>"
		dat += "There is currently <b>[contained_nuyen] DETROID NUYEN</b> in the Machine.<br>"
		dat += "The current conversion rate is <b>3 Requisition to 1 Detroid Nuyen.</b>"
		dat += "<hr>"
		dat += "Please Select your Option.<br><br>"
		
		dat += "<b>Conversion Options</b><br>"
		dat += "<a href='?src=\ref[src];nuyen_to_req=1'>Convert Detroid Nuyen to Requisition</a><br>" //NY 2 REQ
		dat += "<a href='?src=\ref[src];req_to_nuyen=1'>Convert Requisition to Detroid Nuyen</a><br>" // REQ 2 NY
		
		dat += "<br><b>Detroid Nuyen Options</b><br>"
		dat += "<a href='?src=\ref[src];withdraw_sector=1'>Withdraw Detroid Nuyen from Sector Record</a><br>" //PERSIST 2 MACHINE
		dat += "<a href='?src=\ref[src];deposit_sector=1'>Deposit Detroid Nuyen in Sector Record</a><br>" //MACHINE 2 PERSIST
		dat += "<a href='?src=\ref[src];withdraw_phys_machine=1'>Withdraw Detroid Nuyen from Machine as Currency Token</a><br>" //MACHINE 2 OBJ
		
		dat += "<br><br><b><a href='?src=\ref[src];log_out=1'>LOG OUT</a></b>"


	dat += "</body>"
	
	user << browse(dat, "window=mannheim_atm;size=550x600")
	onclose(user, "mannheim_atm")

/obj/machinery/detroid_teller/Topic(href, href_list)
	if(..())
		return

	var/mob/living/L = usr
	if(!istype(L))
		return
	if(world.time < time_cooldown)
		return
	
	var/datum/interactive_persistence/persist = json_persistence["[L.ckey]"]
	
	if(href_list["log_out"])
		L.put_in_hands(contained_card)
		contained_card = null
	
	if(href_list["nuyen_to_req"])
		if(contained_nuyen > 0)
			var/nuyen_to_req = input(usr, "How much Nuyen to convert to Requisition?", "Nuyen to Requisition", contained_nuyen) as null|num
			contained_card.req_holder.requisition += clamp(round(nuyen_to_req*3),0,contained_nuyen)
			contained_nuyen -= clamp(round(nuyen_to_req),0,contained_nuyen)
	
	if(href_list["req_to_nuyen"])
		if(contained_card.req_holder.requisition > 0)
			var/req_to_nuyen = input(usr, "How much Requisition to convert to Nuyen?", "Requisition to Nuyen", contained_card.req_holder.requisition) as null|num
			contained_nuyen += clamp(round(req_to_nuyen/3),0,contained_card.req_holder.requisition)
			contained_card.req_holder.requisition -= clamp(round(req_to_nuyen),0,contained_card.req_holder.requisition)
	
	if(href_list["withdraw_sector"])
		if(persist.money_saved > 0)
			var/withdraw_sector = input(usr, "How much to withdraw from your Sector Record?", "Sector Record Withdrawal", persist.money_saved) as null|num
			contained_nuyen += clamp(round(withdraw_sector),0,persist.money_saved)
			persist.money_saved -= clamp(round(withdraw_sector),0,persist.money_saved)
	
	if(href_list["deposit_sector"])
		if(contained_nuyen > 0)
			var/deposit_sector = input(usr, "How much to deposit into your Sector Record?", "Sector Record Deposit", contained_nuyen) as null|num
			persist.money_saved += clamp(round(deposit_sector),0,contained_nuyen)
			contained_nuyen -= clamp(round(deposit_sector),0,contained_nuyen)
	
	if(href_list["withdraw_phys_machine"])
		if(contained_nuyen > 0)
			var/deposit_sector = input(usr, "How much physical currency to withdraw from the machine?", "Physical Currency Withdrawal", contained_nuyen) as null|num
			if(deposit_sector > 0)
				var/obj/item/weapon/nuyen/our_nuyen = new(loc,deposit_sector)
				our_nuyen.amount += clamp(round(deposit_sector),0,contained_nuyen)
				contained_nuyen -= clamp(round(deposit_sector),0,contained_nuyen)
				L.put_in_hands(our_nuyen)
	
	time_cooldown = world.time+2 SECONDS
	attack_hand(L)