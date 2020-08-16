//So, i'm going to try a vis_contents pooling system right here.
//We will explore the different forms of it, and see how it goes.
/datum/visconpooler
	
/datum/visconpooler/New()
	load_barricades()
//	load_ghostbodies()
//	load_ghostbuttons()

/datum/visconpooler/proc/load_barricades()
	barricadepool[1] = new /obj/effect/overlay/viscons/aegisline/north
	barricadepool[2] = new /obj/effect/overlay/viscons/aegisline/south
	barricadepool[3] = new /obj/effect/overlay/viscons/aegisline/east_one
	barricadepool[4] = new /obj/effect/overlay/viscons/aegisline/east_two
	barricadepool[5] = new /obj/effect/overlay/viscons/aegisline/west_one
	barricadepool[6] = new /obj/effect/overlay/viscons/aegisline/west_two

/*/datum/visconpooler/proc/load_ghostbodies()
	var/p_width = 1
	var/p_height = 1
	
	for(var/bodytype in typesof(/obj/effect/overlay/viscons/ghostbody) - /obj/effect/overlay/viscons/ghostbody)
		var/obj/effect/overlay/viscons/ghostbody/curbod = new bodytype
		var/obj/abstract/screen/viscons/ghostbodies/gbutton = new
		if(curbod.colorable)
			gbutton.colorable = TRUE
		gbutton.given_body = "[curbod.icon_state]"
		gbutton.potential_req = curbod.potential_req
		gbutton.del_on_map_removal = FALSE
		gbutton.assigned_map = "ghostbodies_map"
		gbutton.vis_contents += curbod
		gbutton.screen_info = list(p_width,p_height)
		ghostbody_buttons.Add(gbutton)

		p_height++
		if(p_height > 6)
			p_height = 1
			p_width++

/datum/visconpooler/proc/load_ghostbuttons()
	var/p_width = 1
	var/p_height = 1
	
	for(var/ourbutton in typesof(/obj/abstract/screen/viscons/ghostactions) - /obj/abstract/screen/viscons/ghostactions)
		var/obj/abstract/screen/viscons/ghostactions/thebutton = new ourbutton
		thebutton.del_on_map_removal = FALSE
		thebutton.assigned_map = "ghostactions_map"
		thebutton.screen_info = list(p_width,p_height)
		ghost_actions.Add(thebutton)
	
		p_width++
		if(p_width > 6)
			p_width = 1
			p_height++
*/
	