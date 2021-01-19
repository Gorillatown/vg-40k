/*
This one isn't so useful considering the regular processing furnace exists.
*/

/obj/machinery/furnace
	name = "Furnace"
	icon = 'F_40kshit/icons/obj/industrial_madness.dmi'
	icon_state = "furnace"
	machine_flags = MULTITOOL_MENU|WRENCHMOVE|FIXED2WORK
	var/frequency = 1367
	var/datum/radio_frequency/radio_connection
	var/datum/materials/ore
	var/list/recipes[0]
	var/failure = FALSE
	var/tamper_protection = FALSE
	density = TRUE
	anchored = TRUE
/* Animated State is
	furnace_on
*/

/obj/machinery/furnace/New()
	..()
	ore = new
	for(var/recipe in typesof(/datum/smelting_recipe) - /datum/smelting_recipe)
		recipes += new recipe()

/obj/machinery/furnace/Destroy()
	..()

/obj/machinery/furnace/initialize()
	..()
	if(frequency)
		set_frequency(frequency)

/obj/machinery/furnace/proc/set_frequency(var/new_frequency)
	radio_controller.remove_object(src, frequency)
	frequency = new_frequency
	radio_connection = radio_controller.add_object(src, frequency, RADIO_CONVEYORS)

/obj/machinery/furnace/receive_signal(datum/signal/signal)
	if(stat & NOPOWER)
		return
	if(!signal || signal.encryption)
		return
	if(id_tag != signal.data["tag"] || !signal.data["command"])
		return
	switch(signal.data["command"])
		if("forward")
			burning_time()
		if("tamper")
			tamper_protection = !tamper_protection

/obj/machinery/furnace/attackby(obj/item/O, mob/living/user)
	if(tamper_protection)
		say("BEEP")
		user.adjustFireLoss(5)
		user.Knockdown(2)
		spark(src, 5)
		return
	else
		..()

/obj/machinery/furnace/proc/burning_time()
	var/turf/in_T = get_step(src, turn(dir,180))
	var/turf/out_T = get_step(src, dir)

	flick("furnace_on",src)
	playsound(src, 'F_40kshit/sounds/misc_effects/furnace.ogg', 50, 1)
	failure = FALSE
	for(var/atom/movable/A in in_T)
		if(A.anchored)
			continue

		if(!istype(A, /obj/item/stack/ore) || !A.materials) // Check if it's an ore
			failure = TRUE
			if(isliving(A))
				var/mob/living/L = A
				L.ghostize()
				new /obj/effect/decal/remains/human(out_T)

		if(!failure)
			ore.addFrom(A.materials, FALSE)
		
		qdel(A)

	if(!failure)
		for(var/datum/smelting_recipe/R in recipes)
			while(R.checkIngredients(src)) //While we have materials for this
				for(var/ore_id in R.ingredients)
					ore.removeAmount(ore_id, R.ingredients[ore_id]) //arg1 = ore name, arg2 = how much per sheet

				drop_stack(R.yieldtype, out_T)
	else
		new /obj/item/stack/ore/slag(out_T)

/obj/machinery/furnace/multitool_menu(var/mob/user,var/obj/item/device/multitool/P)
	//var/obj/item/device/multitool/P = get_multitool(user)
	var/dis_id_tag="-----"
	if(id_tag!=null && id_tag!="")
		dis_id_tag=id_tag
	return {"
	<ul>
		<li><b>Frequency:</b> <a href="?src=\ref[src];set_freq=-1">[format_frequency(frequency)] GHz</a> (<a href="?src=\ref[src];set_freq=1367">Reset</a>)</li>
		<li><b>ID Tag:</b> <a href="?src=\ref[src];set_id=1">[dis_id_tag]</a></li>
	</ul>"}

