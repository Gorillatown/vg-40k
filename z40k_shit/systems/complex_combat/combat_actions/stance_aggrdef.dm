
//STANCE SWAP - BASIC
/datum/action/item_action/warhams/basic_swap_stance
	name = "Swap Stance"
	background_icon_state = "bg_defensive"
	button_icon_state = "defensive"
	var/defensive_or_not = FALSE

/datum/action/item_action/warhams/basic_swap_stance/Trigger()
	var/obj/item/weapon/S = target
	S.aggr_def_switch_stance(owner)

	if(S.stance == "aggressive")
		background_icon_state = "bg_aggro"
		button_icon_state = "aggressive"
		UpdateButtonIcon()
	else
		background_icon_state = "bg_defensive"
		button_icon_state = "defensive"
		UpdateButtonIcon()


