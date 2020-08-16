
/obj/item/weapon/attachment/scope
	name = "7x scope"
	desc = "A scope made for scoping out shit. This one is a 7x scope cause... Yeah."
	icon_state = "scope"
	item_state = "scope"
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/IGequipment_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/IGequipment_right.dmi')
	force = 10.0
	throwforce = 10.0
	throw_speed = 3
	throw_range = 7
	tied_action = /datum/action/item_action/warhams/attachment/scope_zoom
	scope_zoom_amount = 7
	var/currently_zoomed = FALSE //Mostly a safety var

/obj/item/weapon/attachment/scope/special_detachment(mob/user)
	if(currently_zoomed && my_atom.currently_zoomed)
		user.regenerate_icons()
		var/client/C = user.client
		C.changeView(C.view - scope_zoom_amount)
		my_atom.currently_zoomed = FALSE
		currently_zoomed = FALSE