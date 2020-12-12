
/obj/item/weapon/psykerstaff
	name = "Psyker Staff"
	desc = "A staff that is important for a great many things to certain people."
	inhand_states = list("left_hand" = 'F_40kshit/icons/inhands/LEFTIES/64x64PsykerStaff.dmi', "right_hand" = 'F_40kshit/icons/inhands/RIGHTIES/64x64PsykerStaff.dmi')
	icon = 'F_40kshit/icons/obj/ig/IGequipment.dmi'
	icon_state = "psykerstaff"
	item_state = "psykerstaff"
	slot_flags = SLOT_BACK
	siemens_coefficient = 1
	force = 35
	throwforce = 5
	throw_speed = 5
	throw_range = 7
	w_class = W_CLASS_MEDIUM
	sharpness = 1.2
	sharpness_flags = CUT_AIRLOCK
	attack_verb = list("attacks", "bludgeons",  "slams")
	actions_types = list(/datum/action/item_action/warhams/basic_swap_stance)

/obj/item/weapon/psykerstaff/New()
	. = ..()

