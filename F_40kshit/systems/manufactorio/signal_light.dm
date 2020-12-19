/*
TODO: Signal lights + Menus
*/
/obj/machinery/signal_lights
	name = "Signal Lights"
	icon = 'F_40kshit/icons/obj/industrial_madness.dmi'
	icon_state = "signal_light"
	machine_flags = MULTITOOL_MENU
	var/ticker = 0
	var/tick_counter = 0 //Basically we count when to activate per tick
	var/signal_repeat = FALSE
	var/currently_on = "OFF"
	var/obj/effect/overlay/signal_light_overlay
	var/current_color = "#fbff00"
	var/current_tone = 40000
	var/frequency = 1367
	var/datum/radio_frequency/radio_connection
	var/already_ticked = FALSE
	anchored = TRUE
/* The overlay states for the bulb are basically
	si_overlay_off
	si_overlay_on
*/
 
/obj/machinery/signal_lights/New()
	..()
	if(!id_tag)
		id_tag = "[rand(9999)]"
	set_frequency(frequency)
	signal_light_overlay = new /obj/effect/overlay/signal_light()
	vis_contents += signal_light_overlay
	signal_light_overlay.color = current_color

/obj/machinery/signal_lights/initialize()
	..()

/obj/machinery/signal_lights/Destroy()
	..()

/obj/machinery/signal_lights/proc/set_frequency(var/new_frequency)
	radio_controller.remove_object(src, frequency)
	frequency = new_frequency
	radio_connection = radio_controller.add_object(src, frequency, RADIO_CONVEYORS)

/obj/machinery/signal_lights/process()
	switch(currently_on)
		if("ON")
			if(tick_counter)
				ticker++
				if(ticker >= tick_counter && !already_ticked)
					signal_shit("forward")
					signal_light_overlay.icon_state = "si_overlay_on"
					playsound(loc, 'F_40kshit/sounds/misc_effects/signal_light.wav', 50, 1, frequency = current_tone)
					already_ticked = TRUE
				if(ticker >= tick_counter+1)
					signal_shit("stop")
					signal_light_overlay.icon_state = "si_overlay_off"
					ticker = 0
					already_ticked = FALSE
		if("OFF")
			return

/obj/machinery/signal_lights/proc/signal_shit(var/command)
	if(radio_connection)
		var/datum/signal/signal = new /datum/signal
		signal.source=src
		signal.transmission_method = 1 //radio signal
		signal.data["tag"] = id_tag
		signal.data["timestamp"] = world.time

		signal.data["command"] = command

		radio_connection.post_signal(src, signal, range = CONVEYOR_CONTROL_RANGE)

/obj/machinery/signal_lights/multitool_menu(var/mob/user,var/obj/item/device/multitool/P)
	var/dis_id_tag="-----"
	if(id_tag!=null && id_tag!="")
		dis_id_tag=id_tag 
	return {"
		<ul>
			<li><b>Currently On:</b><a href="?src=\ref[src];turn_on=1">[currently_on]</a></li>
			<li><b>Frequency:</b> <a href="?src=\ref[src];set_freq=-1">[format_frequency(frequency)] GHz</a> (<a href="?src=\ref[src];set_freq=1367">Reset</a>)</li>
			<li><b>ID Tag:</b> <a href="?src=\ref[src];set_id=1">[dis_id_tag]</a></li>
			<li><b>Set Light color:</b> <a href="?src=\ref[src];set_light_color=1"><span style='border:1px solid #161616; background-color: [current_color];'>&nbsp;&nbsp;&nbsp;</span></a></li>
			<li><b>Set Sound Tone:</b> <a href="?src=\ref[src];set_sound_tone=1">[current_tone]</a></li>
			<li><b>Set Tick Ending:</b> <a href="?src=\ref[src];set_tick_ending=1">[tick_counter]</a></li>
		</ul>"}

		
/obj/machinery/signal_lights/multitool_topic(mob/user, list/href_list, obj/O)
	if("set_light_color" in href_list)
		var/new_color = input("Choose a new light color:", "Light Color Menu") as color|null
		if(new_color)
			current_color = new_color
			signal_light_overlay.color = current_color
			return MT_UPDATE
	if("set_sound_tone" in href_list)
		var/new_soundtone = input("Choose a new sound frequency 33000-55000:", "Sound Tone Menu") as null|num
		if(new_soundtone)
			current_tone = clamp(new_soundtone,33000,55000)
			return MT_UPDATE
	if("set_tick_ending" in href_list)
		var/new_tick_ending = input("Choose a new signal time:", "Tick selection menu") as null|num
		if(new_tick_ending)
			tick_counter = new_tick_ending
			return MT_UPDATE
	if("turn_on" in href_list)
		switch(currently_on)
			if("OFF")
				currently_on = "ON"
			if("ON")
				currently_on = "OFF"
		return MT_UPDATE
	return ..()

/obj/effect/overlay/signal_light
	name = "Signal Light"
	icon = 'F_40kshit/icons/obj/industrial_madness.dmi'
	icon_state = "si_overlay_off"
	vis_flags = VIS_INHERIT_ID|VIS_INHERIT_PLANE|VIS_INHERIT_LAYER

