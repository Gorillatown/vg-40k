/*
TODO: Signal lights + Menus
*/
/obj/machinery/signal_lights
	name = "Signal Lights"
	icon = 'F_40kshit/icons/obj/industrial_madness.dmi'
	icon_state = "signal_light"
/* The overlay states for the bulb are basically
	si_overlay_off
	si_overlay_on
*/

/obj/machinery/signal_lights/New()
	..()

/obj/machinery/signal_lights/Destroy()
	..()

/obj/machinery/signal_lights/initialize()
	..()

/obj/machinery/signal_lights/process()
	return

/obj/machinery/signal_lights/Topic(href, href_list)
	return