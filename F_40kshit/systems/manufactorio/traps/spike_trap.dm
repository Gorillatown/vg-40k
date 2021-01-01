/obj/machinery/spike_trap
	name = "Spike Trap"
	icon = 'F_40kshit/icons/obj/trap_madness.dmi'
	icon_state = "spike_off"
	machine_flags = MULTITOOL_MENU|WRENCHMOVE|FIXED2WORK
	var/frequency = 1367
	var/datum/radio_frequency/radio_connection
	var/tamper_protection = FALSE
	density = FALSE
	anchored = FALSE
	var/currently_on = "OFF"
	var/cycle_ticker_on = 0
	var/cycle_ticker_off = 0
	var/cycle_ticker_counter = 0
	
/obj/machinery/spike_trap/New()
	..()

/obj/machinery/spike_trap/Destroy()
	..()

/obj/machinery/spike_trap/initialize()
	..()
	if(frequency)
		set_frequency(frequency)

/obj/machinery/spike_trap/proc/set_frequency(var/new_frequency)
	radio_controller.remove_object(src, frequency)
	frequency = new_frequency
	radio_connection = radio_controller.add_object(src, frequency, RADIO_CONVEYORS)

/obj/machinery/spike_trap/receive_signal(datum/signal/signal)
	if(!signal || signal.encryption)
		return
	if(id_tag != signal.data["tag"] || !signal.data["command"])
		return
	switch(signal.data["command"])
		if("forward")
			spike_time()
		if("tamper")
			tamper_protection = !tamper_protection

/obj/machinery/spike_trap/attackby(obj/item/O, mob/living/user)
	if(tamper_protection)
		say("BEEP")
		user.adjustFireLoss(5)
		user.Knockdown(2)
		spark(src, 5)
		return
	else
		..()

/obj/machinery/spike_trap/Cross(atom/movable/mover, turf/target, height = 1.5, air_group = 0)
	if(!density)
		return 1
	if(air_group || !height) //The mover is an airgroup
		return 1 //We aren't airtight, only exception to PASSGLASS
	if(istype(mover,/obj/item/projectile))
		return 1
	if(ismob(mover))
		var/mob/M = mover
		if(M.flying || M.highflying)
			return 1
	return 0

/obj/machinery/spike_trap/proc/spike_time()
	density = !density
	playsound(src, 'F_40kshit/sounds/spike_ring.ogg', 50, 1)
	if(density)
		icon_state = "spike_on"
		for(var/mob/living/carbon/M in loc)
			M.adjustBruteLoss(20)
			M.Knockdown(5)
			M.visible_message("<span class='danger'>[M.name] gets impaled by \the [src]!</span>", \
							"<span class='danger'>You get impaled by \the [src]!</span>", \
							"You hear a loud ringing.")
	else
		icon_state = "spike_off"

/obj/machinery/spike_trap/Bumped(atom/AM)
	if(istype(AM, /mob/living))
		if(iscarbon(AM))
			var/mob/living/carbon/M = AM
			playsound(src, 'F_40kshit/sounds/spike_ring.ogg', 100, 1)
			M.adjustBruteLoss(8)
			M.Knockdown(3)

/obj/machinery/spike_trap/multitool_menu(var/mob/user,var/obj/item/device/multitool/P)
	var/dis_id_tag="-----"
	if(id_tag!=null && id_tag!="")
		dis_id_tag=id_tag
	return {"
	<ul>
		<li><b>Currently On:</b><a href="?src=\ref[src];turn_on=1">[currently_on]</a></li>
		<li><b>Frequency:</b> <a href="?src=\ref[src];set_freq=-1">[format_frequency(frequency)] GHz</a> (<a href="?src=\ref[src];set_freq=1367">Reset</a>)</li>
		<li><b>ID Tag:</b> <a href="?src=\ref[src];set_id=1">[dis_id_tag]</a></li>
		<li><b>Cycling Ticker On:</b> <a href="?src=\ref[src];cycle_on=1">[cycle_ticker_on]</a></li>
		<li><b>Cycling Ticker Off:</b> <a href="?src=\ref[src];cycle_off=1">[cycle_ticker_off]</a></li>
	</ul>"}

/obj/machinery/spike_trap/process()
	switch(currently_on)
		if("ON")
			if(cycle_ticker_on && cycle_ticker_off)
				cycle_ticker_counter++
				if(cycle_ticker_counter == cycle_ticker_on)
					if(!density)
						spike_time()
				if(cycle_ticker_counter >= cycle_ticker_off)
					if(density)
						spike_time()
						cycle_ticker_counter = 0
		if("OFF")
			return

/obj/machinery/spike_trap/multitool_topic(mob/user, list/href_list, obj/O)
	if("cycle_on" in href_list)
		var/new_cycle_on = input("Choose a tick for spikes to be active (Must be more than Off-time):", "Cycling Ticker") as null|num
		if(new_cycle_on > cycle_ticker_off)
			cycle_ticker_on = new_cycle_on
		else
			cycle_ticker_on = 0
		return MT_UPDATE

	if("cycle_off" in href_list)
		var/new_cycle_off = input("Choose a tick for spikes to be inactive (Must be more than Off-time):", "Cycling Ticker") as null|num
		if(new_cycle_off > cycle_ticker_on)
			cycle_ticker_off = new_cycle_off
		else
			cycle_ticker_on = 0
			cycle_ticker_off = 0
		return MT_UPDATE

	if("turn_on" in href_list)
		switch(currently_on)
			if("OFF")
				currently_on = "ON"
			if("ON")
				currently_on = "OFF"
		return MT_UPDATE
	return ..()