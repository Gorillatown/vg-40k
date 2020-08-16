/obj/structure/nuke_computer_left
	name = "Mysterious Console"
	desc = "For some reason, it has a built in power source, two you don't even know what its for, maybe something will unlock it."
	icon = 'z40k_shit/icons/obj/orbital.dmi'
	icon_state = "left"
	density = 1
	anchored = 1

/obj/structure/nuke_computer_left/ex_act(severity)
	return

/obj/structure/nuke_computer_right
	name = "Mysterious Console"
	desc = "For some reason, it has a built in power source, two you don't even know what its for, maybe something will unlock it."
	icon = 'z40k_shit/icons/obj/orbital.dmi'
	icon_state = "right_closed"
	density = 1
	anchored = 1

/obj/structure/nuke_computer_right/ex_act(severity)
	return

/obj/structure/nuke_computer
	name = "Mysterious Console"
	icon = 'z40k_shit/icons/obj/orbital.dmi'
	icon_state = "ob1"
	desc = "For some reason, it has a built in power source, two you don't even know what its for, maybe something will unlock it."
	density = 1
	anchored = 1
	var/nuke_authorized = FALSE
	var/lord_authorized = FALSE
	var/forced_authorization = FALSE
	var/already_signalled = FALSE
	var/list/used_id_cards = list()
	var/time_left = 600 //This is a value in seconds, deciseconds will be deducted

/obj/structure/nuke_computer/ex_act(severity)
	return

/obj/structure/nuke_computer/New()
	..()

/obj/structure/nuke_computer/initialize()
	quest_master.game_end_objects += src

/obj/structure/nuke_computer/Destroy()
	quest_master.game_end_objects -= src
	..()

/obj/structure/nuke_computer/attack_hand(mob/user)
	lets_a_go(user)

/obj/structure/nuke_computer/attackby(obj/item/weapon/W, mob/user)
	if(istype(W,/obj/item/weapon/card/id))
		var/obj/item/weapon/card/id/id_card = W
		var/end_proc_early = FALSE
		for(var/obj/item/cards in used_id_cards)
			if(cards == id_card)
				used_id_cards -= id_card
				say("Access Revoked")
				end_proc_early = TRUE
		
		if(end_proc_early)
			return
		else
			if(access_lord in id_card.access)
				lord_authorized = TRUE
				used_id_cards += id_card
				say("Access Granted.")
				return
			if(access_knight in id_card.access)
				used_id_cards += id_card
				say("Access Partially Granted.")
				return
		check_authorization()

/obj/structure/nuke_computer/proc/lets_a_go(mob/user)
	check_authorization()
	var/dat
	dat += {"<B> Control Uplink Console</B><BR>
			<HR>
			<B>Currently Authorized:</B> <I><strong>[nuke_authorized ? "<span style=\"color:green\">AUTHORIZED</span>":"<span style=\"color:red\">DENIED</span>"]</strong></I><BR>"}
	if(!nuke_authorized)
		dat += "<BR><BR><I>SUBMIT AUTHORIZATION IDENTIFICATION</I>"
	else
		if(!already_signalled)
			dat += "<BR><I><B>SIGNAL DEATHSTRIKE MISSILE</I></B><BR>"
			dat += "<A href='byond://?src=\ref[src];signalmissile=1'>Hit the Button</A><br>"
		else
			dat += "<BR><B><span style=\"color:red\">MISSILE ENROUTE TO COORDINATES</span></B><BR>"
			dat += "Time before Impact: [time_left] Seconds"

	var/datum/browser/popup = new(user, "nukemenu", "Control Uplink Console")
	popup.set_content(dat)
	popup.open()

/obj/structure/nuke_computer/proc/check_authorization()
	if(lord_authorized)
		nuke_authorized = TRUE
	if(used_id_cards.len >= 3)
		nuke_authorized = TRUE
	if(forced_authorization)
		nuke_authorized = TRUE
	return nuke_authorized

/obj/structure/nuke_computer/proc/the_long_goodbye()
	to_chat(world, "<span class='tzeentch'> <i>You have a eerie feeling like something bad is going to happen in the future.</i></span>")
	processing_objects += src

/obj/structure/nuke_computer/process()
	time_left--
	if(time_left <= 0)
		detonate_the_world()
		processing_objects -= src
		time_left = 600

/obj/structure/nuke_computer/proc/detonate_the_world()
	enter_allowed = 0
	if(ticker)
		ticker.station_explosion_cinematic(0,"planet_nuke")
		ticker.station_was_nuked = 1
		ticker.explosion_in_progress = 0
		SSpersistence_map.setSavingFilth(FALSE)

/obj/structure/nuke_computer/Topic(href, href_list)
	if(usr.stat == DEAD)
		return
	var/mob/living/L = usr
	if(!istype(L))
		return

	if(href_list["signalmissile"])
		if(check_authorization())
			if(!already_signalled)
				say("Authorization Cleared, Sending Coordinates to Missile.")
				already_signalled = TRUE
				sleep(5 SECONDS)
				the_long_goodbye() //We add ourselves to processing objects
			else
				say("Signal Received, Signal Returned")
		else
			say("Authorization Not Cleared")
	lets_a_go(L)