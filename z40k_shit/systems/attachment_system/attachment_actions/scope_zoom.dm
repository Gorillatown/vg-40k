
/datum/action/item_action/warhams/attachment/scope_zoom
	name = "Zoom"
	button_icon_state = "zoom"

/datum/action/item_action/warhams/attachment/scope_zoom/Trigger()
	var/obj/item/weapon/gun/S = target
	my_atom.attack_self(owner)
	if(S.currently_zoomed)
		button_icon_state = "zoom"
	else
		button_icon_state = "unzoom"
	UpdateButtonIcon()

/obj/item/weapon/attachment/scope/attack_self(var/mob/user)
	if(!my_atom.currently_zoomed)
		if(user && user.client) 
			usr.regenerate_icons()
			var/client/C = user.client
			C.changeView(C.view + scope_zoom_amount)
			my_atom.currently_zoomed = TRUE
			currently_zoomed = TRUE
	else
		if(user && user.client) 
			user.regenerate_icons()
			var/client/C = user.client
			C.changeView(C.view - scope_zoom_amount)
			my_atom.currently_zoomed = FALSE
			currently_zoomed = TRUE
