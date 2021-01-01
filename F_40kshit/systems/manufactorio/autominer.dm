/obj/machinery/machine_miner
	name = "Drilling Machine"
	icon = 'F_40kshit/icons/obj/industrial_madness.dmi'
	icon_state = "autominer"
	machine_flags = MULTITOOL_MENU|WRENCHMOVE|FIXED2WORK
	var/frequency = 1367
	var/datum/radio_frequency/radio_connection
	var/tamper_protection = FALSE
	density = TRUE
	anchored = TRUE
/* Animated State is
	autominer_on
*/

/obj/machinery/machine_miner/New()
	..()

/obj/machinery/machine_miner/Destroy()
	..()

/obj/machinery/machine_miner/initialize()
	..()
	if(frequency)
		set_frequency(frequency)

/obj/machinery/machine_miner/proc/set_frequency(var/new_frequency)
	radio_controller.remove_object(src, frequency)
	frequency = new_frequency
	radio_connection = radio_controller.add_object(src, frequency, RADIO_CONVEYORS)

/obj/machinery/machine_miner/receive_signal(datum/signal/signal)
	if(stat & NOPOWER)
		return
	if(!signal || signal.encryption)
		return
	if(id_tag != signal.data["tag"] || !signal.data["command"])
		return
	switch(signal.data["command"])
		if("forward")
			mining_time()
		if("tamper")
			tamper_protection = !tamper_protection

/obj/machinery/machine_miner/attackby(obj/item/O, mob/living/user)
	if(tamper_protection)
		say("BEEP")
		user.adjustFireLoss(5)
		user.Knockdown(2)
		spark(src, 5)
		return
	else
		..()

/obj/machinery/machine_miner/proc/mining_time()
	var/turf/out_T = get_step(src, dir)
	flick("autominer_on", src)
	new /obj/item/stack/ore/iron(out_T)

/obj/machinery/machine_miner/multitool_menu(var/mob/user,var/obj/item/device/multitool/P)
	//var/obj/item/device/multitool/P = get_multitool(user)
	var/dis_id_tag="-----"
	if(id_tag!=null && id_tag!="")
		dis_id_tag=id_tag
	return {"
	<ul>
		<li><b>Frequency:</b> <a href="?src=\ref[src];set_freq=-1">[format_frequency(frequency)] GHz</a> (<a href="?src=\ref[src];set_freq=1367">Reset</a>)</li>
		<li><b>ID Tag:</b> <a href="?src=\ref[src];set_id=1">[dis_id_tag]</a></li>
	</ul>"}

