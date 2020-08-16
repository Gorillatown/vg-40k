/datum/action/item_action/warhams/energy_overcharge
	name = "Overcharge"
	background_icon_state = "bg_overcharge"
	button_icon_state = "overcharge_off"

/datum/action/item_action/warhams/energy_overcharge/Trigger()
	var/obj/item/weapon/S = target
	S.overcharge(owner)
	if(S.overcharged)
		button_icon_state = "overcharge_on"
		UpdateButtonIcon()
	else
		button_icon_state = "overcharge_off"
		UpdateButtonIcon()
