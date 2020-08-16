//obj/abstract/screen/HU

/spell/aoe_turf/ghost_actions//Raaagh
	name = "Ghost Actions"
	desc = "Ghost Actions."
	panel = "Racial Abilities"
	charge_max = 20
	spell_flags = STATALLOWED | GHOSTCAST
	invocation_type = SpI_NONE

	override_base = "basic_button"
	override_icon = 'z40k_shit/icons/ghost_actions.dmi'
	overlay_icon_state = "spell"
	hud_state = "ghost_command"
	var/list/ghost_actions = list()

/spell/aoe_turf/ghost_actions/New()
	..()
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

/spell/aoe_turf/ghost_actions/Destroy()
	..()

/spell/aoe_turf/ghost_actions/cast(var/list/targets, mob/user)
	open_menu(user)

/spell/aoe_turf/ghost_actions/proc/open_menu(var/mob/user)
	if(!user)
		return
	if(!user.client)
		return	
	if(!isobserver(user))
		return
	if("ghostactions_map" in user.client.screen_maps) //alright, the popup this object uses is already IN use, so the window is open. no point in doing any other work here, so we're good. 
		return
	
	user.client.setup_popup("ghostactions",6,2,1,"black")
	user.client.add_objs_to_map(ghost_actions)
