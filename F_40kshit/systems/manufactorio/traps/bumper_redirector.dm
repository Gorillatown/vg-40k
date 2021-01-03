/*
	Redirector
*/
/obj/machinery/bumper_redirector
	name = "Redirector"
	icon = 'F_40kshit/icons/obj/trap_madness.dmi'
	icon_state = "trap_director"
	var/obj/machinery/bumper_control/our_control
	var/frequency = 1367
	var/datum/radio_frequency/radio_connection
	var/tamper_protection = FALSE
	var/currently_on = FALSE
	machine_flags = MULTITOOL_MENU|WRENCHMOVE|FIXED2WORK

/obj/machinery/bumper_redirector/initialize()
	..()
	if(frequency)
		set_frequency(frequency)

/obj/machinery/bumper_redirector/proc/set_frequency(var/new_frequency)
	radio_controller.remove_object(src, frequency)
	frequency = new_frequency
	radio_connection = radio_controller.add_object(src, frequency, RADIO_CONVEYORS)

/obj/machinery/bumper_redirector/receive_signal(datum/signal/signal)
	if(!signal || signal.encryption)
		return
	if(id_tag != signal.data["tag"] || !signal.data["command"])
		return
	switch(signal.data["command"])
		if("forward")
			currently_on = TRUE
		if("stop")
			currently_on = FALSE
		if("tamper")
			tamper_protection = !tamper_protection

/obj/machinery/bumper_redirector/attackby(obj/item/O, mob/living/user)
	if(tamper_protection)
		say("BEEP")
		user.adjustFireLoss(5)
		user.Knockdown(2)
		spark(src, 5)
		return
	else
		..()

/obj/machinery/bumper_redirector/multitool_menu(var/mob/user,var/obj/item/device/multitool/P)
	var/currently_connected = "FALSE"
	if(currently_on)
		currently_connected = "TRUE"
	var/dis_id_tag="-----"
	if(id_tag!=null && id_tag!="")
		dis_id_tag=id_tag
	return {"
	<ul>
		<li><b>Currently On:</b> [currently_connected] </li>
		<li><b>Frequency:</b> <a href="?src=\ref[src];set_freq=-1">[format_frequency(frequency)] GHz</a> (<a href="?src=\ref[src];set_freq=1367">Reset</a>)</li>
		<li><b>ID Tag:</b> <a href="?src=\ref[src];set_id=1">[dis_id_tag]</a></li>
		<li><b>Direction:</b>
			<a href="?src=\ref[src];setdir=[NORTH]" title="North">["&uarr;"]</a>
			<a href="?src=\ref[src];setdir=[EAST]" title="East">["&rarr;"]</a>
			<a href="?src=\ref[src];setdir=[SOUTH]" title="South">["&darr;"]</a>
			<a href="?src=\ref[src];setdir=[WEST]" title="West">["&larr;"]</a>
			<a href="?src=\ref[src];setdir=[NORTHEAST]" title="Northeast">["&#8599;"]</a>
			<a href="?src=\ref[src];setdir=[NORTHWEST]" title="Northwest">["&#8600;"]</a>
			<a href="?src=\ref[src];setdir=[SOUTHEAST]" title="Southeast">["&#8598;"]</a>
			<a href="?src=\ref[src];setdir=[SOUTHWEST]" title="Southwest">["&#8601;"]</a>
		</li>
	</ul>"} 

/obj/machinery/bumper_redirector/multitool_topic(mob/user, list/href_list, obj/O)
	if("setdir" in href_list)
		dir = text2num(href_list["setdir"])
		return MT_UPDATE
	return ..()

/obj/machinery/bumper_redirector/Crossed(atom/movable/AM)
	if(currently_on)
		for(var/obj/structure/tracker_object/T in AM.contents)
			T.our_controller.dir = dir