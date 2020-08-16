/obj/abstract/screen/viscons/ghostactions
	name = "Ghost Button Parent"
	icon = 'z40k_shit/icons/ghost_actions.dmi'
	del_on_map_removal = FALSE

//Now we can just ..() the checks in
/obj/abstract/screen/viscons/ghostactions/Click(location, control, params)
	if(!usr)
		return 1

	if(!isobserver(usr))
		return 1
	
/*		Toggle Medhud
*/
/obj/abstract/screen/viscons/ghostactions/toggle_medHUD
	name = "Toggle Medic HUD"
	desc = "It also toggles the diagnostic HUD (to see the borgs health)"
	icon_state = "medhud"

/obj/abstract/screen/viscons/ghostactions/toggle_medHUD/Click(location, control, params)
	if(..())
		return 0
	
	var/mob/dead/observer/ghost = usr
	ghost.toggle_medHUD()

/*		reenter corpse
*/
/obj/abstract/screen/viscons/ghostactions/reenter_corpse
	name = "Reenter Corpse"
	desc = "Reenters your corpse"
	icon_state = "reenter_corpse"

/obj/abstract/screen/viscons/ghostactions/reenter_corpse/Click(location, control, params)
	if(..())
		return 0
	
	var/mob/dead/observer/ghost = usr
	ghost.reenter_corpse()

/*		Haunt
*/
/obj/abstract/screen/viscons/ghostactions/haunt
	name = "Haunt"
	desc = "Flavorful following of your target"
	icon_state = "haunt2"

/obj/abstract/screen/viscons/ghostactions/haunt/Click(location, control, params)
	if(..())
		return 0
	
	var/mob/dead/observer/ghost = usr
	ghost.follow()


/*		Toggle Darkness
*/
/obj/abstract/screen/viscons/ghostactions/toggle_darkness
	name = "Toggle Darkness"
	desc = "Toggles Darkness"
	icon_state = "toggle_darkness"

/obj/abstract/screen/viscons/ghostactions/toggle_darkness/Click(location, control, params)
	if(..())
		return 0

	var/mob/dead/observer/ghost = usr
	ghost.toggle_darkness()

/*		Teleport
*/
/obj/abstract/screen/viscons/ghostactions/teleport
	name = "Teleport"
	desc = "Teleports"
	icon_state = "teleport"

/obj/abstract/screen/viscons/ghostactions/teleport/Click(location, control, params)
	if(..())
		return 0

	var/mob/dead/observer/ghost = usr
	ghost.dead_tele()

/*		Hide Sprite
*/
/obj/abstract/screen/viscons/ghostactions/hide_sprite
	name = "Hide Sprite"
	desc = "For Filming shit"
	icon_state = "hidesprite"

/obj/abstract/screen/viscons/ghostactions/hide_sprite/Click(location, control, params)
	if(..())
		return 0

	var/mob/dead/observer/ghost = usr
	ghost.hide_sprite()

/*		Jump to Mob
*/
/obj/abstract/screen/viscons/ghostactions/jump_to
	name = "Jump to Mob"
	desc = "Jumps to a mob in a list"
	icon_state = "jump_to"

/obj/abstract/screen/viscons/ghostactions/jump_to/Click(location, control, params)
	if(..())
		return 0

	var/mob/dead/observer/ghost = usr
	ghost.jumptomob()

/*		Hide Ghosts
*/
/obj/abstract/screen/viscons/ghostactions/hide_ghosts
	name = "Hide Ghosts"
	desc = "Hides all the ghosts"
	icon_state = "hide_ghosts"

/obj/abstract/screen/viscons/ghostactions/hide_ghosts/Click(location, control, params)
	if(..())
		return 0

	var/mob/dead/observer/ghost = usr
	ghost.hide_ghosts()



