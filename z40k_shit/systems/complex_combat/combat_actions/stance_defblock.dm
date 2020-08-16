//STANCE SWAP - BASIC
/datum/action/item_action/warhams/heavydef_swap_stance
	name = "Swap Stance"
	background_icon_state = "bg_block"
	button_icon_state = "blocking"

/datum/action/item_action/warhams/heavydef_swap_stance/Trigger()
	var/obj/item/weapon/S = target
	S.defl_bloc_switch_stance(owner)

	if(S.stance == "deflective")
		background_icon_state = "bg_deflect"
		button_icon_state = "deflect"
		UpdateButtonIcon()
	else
		background_icon_state = "bg_block"
		button_icon_state = "blocking"
		UpdateButtonIcon()


		