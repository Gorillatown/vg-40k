
//We ready a piercing Blow, which will armor penetrate to some degree on the weapon you do it with.
//Can be used in conjunction with stances.
/datum/action/item_action/warhams/piercing_blow
	name = "Piercing Blow"
	background_icon_state = "bg_pierce"
	button_icon_state = "pierce"

/datum/action/item_action/warhams/piercing_blow/Trigger()
	var/obj/item/weapon/S = target
	S.piercing_blow(owner)
