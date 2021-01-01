/obj/effect/overlay/bumper_control_screen
	name = "Mover Control Point"
	icon = 'F_40kshit/icons/obj/trap_madness.dmi'
	icon_state = "bumper_master_screen"
//	plane = LIGHTING_PLANE
//	layer = ABOVE_LIGHTING_LAYER

	vis_flags = VIS_INHERIT_ID|VIS_INHERIT_PLANE

/obj/effect/overlay/bumper_control_arrow
	name = "Mover Control Point"
	icon = 'F_40kshit/icons/obj/trap_madness.dmi'

	icon_state = "bumper_master_arrow"
//	plane = LIGHTING_PLANE
//	layer = SUPERMATTER_WALL_LAYER

	vis_flags = VIS_INHERIT_ID|VIS_INHERIT_PLANE|VIS_INHERIT_DIR

/obj/structure/tracker_object
	name = "ERROR"
	desc = "You should never ever see this ever lmao."
	icon = 'F_40kshit/icons/obj/trap_madness.dmi'
	var/obj/machinery/bumper_control_point/our_controller

/obj/structure/tracker_object/Destroy()
	our_controller = null
	..()

/obj/machinery/bumper_control_point
	name = "Mover Control Point"
	desc = "This thing keeps track of moving a object linked to it."
	icon = 'F_40kshit/icons/obj/trap_madness.dmi'
	icon_state = "bumper_master"
	dir = SOUTH
	density = FALSE
	anchored = TRUE
	var/atom/movable/host
	var/moving = FALSE
	var/step_delay = 1
	var/arrow_color = "#00ff00"
	var/obj/effect/overlay/vis_arrow
	var/screen_color = "#097509"
	var/obj/effect/overlay/vis_screen
	var/obj/structure/tracker_object/track_obj
	var/frequency = 1367
	var/datum/radio_frequency/radio_connection
	var/tamper_protection = FALSE
	machine_flags = MULTITOOL_MENU|WRENCHMOVE|FIXED2WORK


/obj/machinery/bumper_control_point/New()
	..()
	vis_screen = new /obj/effect/overlay/bumper_control_screen()
	vis_screen.color = screen_color
	vis_arrow = new /obj/effect/overlay/bumper_control_arrow()
	vis_arrow.color = arrow_color
	vis_contents += vis_screen
	vis_contents += vis_arrow
	track_obj = new(src)
	track_obj.our_controller = src

/obj/machinery/bumper_control_point/initialize()
	..()
	if(frequency)
		set_frequency(frequency)

/obj/machinery/bumper_control_point/proc/set_frequency(var/new_frequency)
	radio_controller.remove_object(src, frequency)
	frequency = new_frequency
	radio_connection = radio_controller.add_object(src, frequency, RADIO_CONVEYORS)

/obj/machinery/bumper_control_point/Destroy()
	vis_contents.Cut()
	moving = FALSE
	host = null
	qdel(vis_arrow)
	vis_arrow = null
	qdel(vis_screen)
	vis_screen = null
	qdel(track_obj)
	track_obj.our_controller = null
	track_obj = null
	..()

/obj/machinery/bumper_control_point/receive_signal(datum/signal/signal)
	if(!signal || signal.encryption)
		return
	if(id_tag != signal.data["tag"] || !signal.data["command"])
		return
	switch(signal.data["command"])
		if("forward")
			if(!host)
				if(!acquire_host())
					say("No Object Detected")
				else
					moving = TRUE
					move_loop()
			else
				moving = TRUE
				move_loop()
		if("stop")
			vis_contents.Cut()
			moving = FALSE
			track_obj.loc = src
		if("tamper")
			tamper_protection = !tamper_protection

/obj/machinery/bumper_control_point/attackby(obj/item/O, mob/living/user)
	if(tamper_protection)
		say("BEEP")
		user.adjustFireLoss(5)
		user.Knockdown(2)
		spark(src, 5)
		return
	else
		..()

/obj/machinery/bumper_control_point/proc/acquire_host()
	var/turf/T = get_turf(src)
	for(var/atom/movable/AM in T.contents)
		if(!(isrealobject(AM) || isliving(AM)))
			continue
		if(istype(AM, /obj/machinery/bumper_control_point))
			continue
		host = AM
		return TRUE
	return FALSE

/obj/machinery/bumper_control_point/proc/move_loop()
	if(!host)
		return
	vis_contents += vis_screen
	vis_contents += vis_arrow
	
	if(!track_obj)
		track_obj = new(host)
	else
		track_obj.loc = host
	
	while(moving)
		step(host, dir)
		sleep(step_delay)

/obj/machinery/bumper_control_point/multitool_menu(var/mob/user,var/obj/item/device/multitool/P)
	var/controlling_object = "FALSE"
	if(host)
		controlling_object = "TRUE"
	var/dis_id_tag="-----"
	if(id_tag!=null && id_tag!="")
		dis_id_tag=id_tag
	return {"
	<ul>
		<li><b>Currently On:</b> [moving]</li>
		<li><b>Current Speed:</b> [step_delay]</li>
		<li><b>Controlled Object:</b> [controlling_object]</li>
		<li><b>Arrow Color:</b> <a href="?src=\ref[src];set_arrow_color=1"><span style='border:1px solid #161616; background-color: [arrow_color];'>&nbsp;&nbsp;&nbsp;</span></a></li>
		<li><b>Screen Color:</b> <a href="?src=\ref[src];set_screen_color=1"><span style='border:1px solid #161616; background-color: [screen_color];'>&nbsp;&nbsp;&nbsp;</span></a></li>
		<li><b>Unlink Object:</b><a href="?src=\ref[src];unlink_host=1">Unlink</a></li>
		<li><b>Frequency:</b> <a href="?src=\ref[src];set_freq=-1">[format_frequency(frequency)] GHz</a> (<a href="?src=\ref[src];set_freq=1367">Reset</a>)</li>
		<li><b>ID Tag:</b> <a href="?src=\ref[src];set_id=1">[dis_id_tag]</a></li>
		
		<li><b>Initial Direction:</b>
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


/obj/machinery/bumper_control_point/multitool_topic(mob/user, list/href_list, obj/O)
	if("setdir" in href_list)
		dir = text2num(href_list["setdir"])
		return MT_UPDATE
	if("unlink_host" in href_list)
		moving = FALSE
		host = null
		track_obj.loc = src
		return MT_UPDATE
	if("set_arrow_color" in href_list)
		var/new_color = input("Choose a new light color:", "Light Color Menu") as color|null
		if(new_color)
			arrow_color = new_color
			vis_arrow.color = arrow_color
			return MT_UPDATE
	if("set_screen_color" in href_list)
		var/new_color = input("Choose a new light color:", "Light Color Menu") as color|null
		if(new_color)
			screen_color = new_color
			vis_screen.color = screen_color
			return MT_UPDATE
	return ..()