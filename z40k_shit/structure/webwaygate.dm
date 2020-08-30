var/list/obj/structure/webwaygate/ELDARGATES = list()

/obj/structure/webwaygate/Croneworld
	id = "Crone21775"
	id_target = "base1"

/obj/structure/webwaygate
	name = "Odd Structure"
	desc = "It appears to be a large structure of some sort."
	icon = 'z40k_shit/icons/obj/gateway.dmi'
	icon_state = "off" //The on version is well.... "on"
	anchored = 1
	density = 1
	opacity = 0 //what the fck is wrong with you
	var/id = "base1"
	var/id_target = "Crone21775"
	var/active = 0
	var/reconfigurable = 1
	var/oldID = null

/obj/structure/webwaygate/New()
	..()
	ELDARGATES += src

/obj/structure/webwaygate/Destroy()
	ELDARGATES -= src
	..()

/obj/structure/webwaygate/ex_act()
	return

/obj/structure/webwaygate/attackby(var/obj/item/I, var/mob/user)
	oldID = id_target												//backing up the ID target in case a hacktool is used.
	if(active)
		active = 0
	else if(istype(I, /obj/item/device/soulstone))
		active = 1
	else if(istype(I, /obj/item/device/hacktool))
		if(reconfigurable)
			var/obj/item/device/hacktool/P = I
			id_target = P.injectid
			user.visible_message("<span class='notice'>[user] uses the tool to reconfigure it's destination and activate it.</span>", "<span class='notice'>Destination overridden. You have a limited time to enter it..</span>", "<span class='warning>You can't see shit.</span>")
			active = 1
			qdel(I)
		else
			user.visible_message("<span class='notice'>[user] uses the tool but seems perplexed at it's inner workings.</span>", "<span class='notice'>This one is not reconfigurable.</span>", "<span class='warning>You can't see shit.</span>")
	else
		active = 0
	update_icon()
	sleep(200)
	active = 0
	id_target = oldID	//was a hack tool used? We'll never know.
	update_icon()

/obj/structure/webwaygate/update_icon()
	if(active)
		icon_state = "on"
		return
	else
		icon_state = "off"

/obj/structure/webwaygate/Bumped(atom/user)
	if(active)
		if(!ismob(user))
			//user.loc = src.loc	//Stop at teleporter location
			return

		if(!id_target)
			//user.loc = src.loc	//Stop at teleporter location, there is nowhere to teleport to.
			return

		for(var/obj/structure/webwaygate/EG in ELDARGATES)
			if(EG.id == src.id_target)
				usr.loc = EG.loc	//Teleport to location with correct id.
				return


