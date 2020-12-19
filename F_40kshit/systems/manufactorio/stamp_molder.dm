/*
TODO: Stamp Molder + Menus
*/

/obj/machinery/stamp_molder
	name = "Stamp Molding Machine"
	icon = 'F_40kshit/icons/obj/industrial_madness.dmi'
	icon_state = "stamper"
	machine_flags = MULTITOOL_MENU
	var/frequency = 1367
	var/datum/radio_frequency/radio_connection
	var/datum/manufacturing_recipe/cur_recipe = null
	var/list/contained_objects = list()
	density = TRUE
	anchored = TRUE
/* The Animated state for this is 
	stamper_on
*/

/obj/machinery/stamp_molder/New()
	..()
	if(!id_tag)
		id_tag = "[rand(9999)]"
	set_frequency(frequency)

/obj/machinery/stamp_molder/proc/set_frequency(var/new_frequency)
	radio_controller.remove_object(src, frequency)
	frequency = new_frequency
	radio_connection = radio_controller.add_object(src, frequency, RADIO_CONVEYORS)

/obj/machinery/stamp_molder/Destroy()
	..()

/obj/machinery/stamp_molder/initialize()
	..()

/obj/machinery/stamp_molder/process()
	return

/obj/machinery/stamp_molder/receive_signal(datum/signal/signal)
	if(!signal || signal.encryption)
		return
	if(id_tag != signal.data["tag"] || !signal.data["command"])
		return
	switch(signal.data["command"])
		if("forward")
			stamping_time()

/obj/machinery/stamp_molder/proc/stamping_time()
	var/turf/in_T = get_step(src, turn(dir,180))
	flick("stamper_on",src)
	playsound(src,'sound/machines/compactor.ogg', 30, 1) //Placeholder
	//failure = FALSE
	for(var/atom/movable/A in in_T)
		if(A.anchored)
			continue
		contained_objects += A
		A.forceMove(src)
	if(cur_recipe)
		check_objects()

/obj/machinery/stamp_molder/proc/check_objects()
	var/turf/out_T = get_step(src, dir)
	var/list/recipe_requirements = cur_recipe.requirements.Copy()
	var/failed = FALSE

	for(var/i=1 to recipe_requirements.len)
		failed = TRUE
		var/obj/item/recipe_obj = recipe_requirements[i]
		var/recipe_amount = recipe_requirements[recipe_obj]
	
		if(ispath(recipe_obj,/obj/item/stack))
			for(var/obj/item/I in contained_objects)
				if(istype(I,recipe_obj))
					var/obj/item/stack/STK = I
					if(STK.amount == recipe_amount)
						contained_objects -= I
						qdel(I)
						failed = FALSE
						break
		else
			for(var/ii=1 to recipe_amount)
				failed = TRUE
				for(var/obj/item/I in contained_objects)
					if(istype(I,recipe_obj))
						contained_objects -= I
						qdel(I)
						failed = FALSE
						break
	
	if(contained_objects.len)
		failed = TRUE
	
	if(failed)
		return
	else
		new cur_recipe.end_result(out_T)
					
/obj/machinery/stamp_molder/multitool_menu(var/mob/user,var/obj/item/device/multitool/P)
	var/dis_id_tag="-----"
	if(id_tag!=null && id_tag!="")
		dis_id_tag=id_tag
	var/fixed_string = "NONE"
	if(cur_recipe)
		fixed_string = "[cur_recipe.name]"
	return {"
		<ul>
			<li><b>Frequency:</b> <a href="?src=\ref[src];set_freq=-1">[format_frequency(frequency)] GHz</a> (<a href="?src=\ref[src];set_freq=1367">Reset</a>)</li>
			<li><b>ID Tag:</b> <a href="?src=\ref[src];set_id=1">[dis_id_tag]</a></li>
			<li><b>Current Recipe:</b> <a href="?src=\ref[src];view_recipes=1">[fixed_string]</a></li>
		</ul>"}

/obj/machinery/stamp_molder/multitool_topic(mob/user,list/href_list,obj/O)
	if("view_recipes" in href_list)
		show_menu(usr)
		return MT_UPDATE
	return ..()

/obj/machinery/stamp_molder/Topic(href, href_list)
	if(..())
		return

	var/mob/living/L = usr
	if(!istype(L))
		return

	if(href_list["recipe_select"])
		var/datum/manufacturing_recipe/MR = locate(href_list["picked_recipe"])
		cur_recipe = MR

/obj/machinery/stamp_molder/proc/show_menu(mob/living/user)
	user.set_machine(src)
	var/dat
	dat += {"<head><title> Manufacturing Recipes </title></head>
			<body style="color:#2ae012" bgcolor="#181818"><ul>"}
	dat += "<h3> Manufacturing Recipes: </h3>"
	for(var/datum/manufacturing_recipe/the_recipe in manufacturing_recipes)
		dat += "<a href='?src=\ref[src];recipe_select=1;picked_recipe=\ref[the_recipe]'>[the_recipe.name]</a><br>"
		dat += "Material Cost: [the_recipe.desc_string]"
		dat += "<HR>"
	dat += "</body>"
	user << browse(dat, "window=stamp_molder;size=550x600")
	onclose(user, "stamp_molder")