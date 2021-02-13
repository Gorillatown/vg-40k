/obj/item/weapon/tankhammer
	name = "Tankhammer"
	desc = "Its a hammer, If you replaced the hammer end with a rocket"
	inhand_states = list("left_hand" = 'F_40kshit/icons/inhands/LEFTIES/64x64Special_melee_left.dmi', "right_hand" = 'F_40kshit/icons/inhands/RIGHTIES/64x64Special_melee_right.dmi')
	icon = 'F_40kshit/icons/obj/32x64_misc_objs.dmi'
	icon_state = "tankhammer"
	item_state = "tankhammer"
	hitsound = 'F_40kshit/sounds/big_choppa.ogg'
	flags = TWOHANDABLE | MUSTTWOHAND
	siemens_coefficient = 1
	force = 30
	armor_penetration = 50
	throwforce = 50
	throw_speed = 5
	throw_range = 7
	w_class = W_CLASS_LARGE
	attack_verb = list("attacks", "smashes",  "bludgeons", "tenderizes", "whams", "bops", "slamdunks")
	actions_types = list(/datum/action/item_action/warhams/basic_swap_stance)

/obj/item/weapon/tankhammer/prepickup(mob/living/user)
	to_chat(user,"<span class='bad'>You realize that you probably aren't going to be in good shape if you hit anything with this.</span>")

/obj/item/weapon/tankhammer/afterattack(atom/target, mob/living/user, proximity_flag, click_parameters)
	..()
	user.visible_message("<span class='danger'>[user] lands a tankhammer hit into \the [target]!</span>", "<span class='danger'>As your tankhammer hits [target] you see a bright flash of glorious light!</span>")
	explosion(target.loc, 1, 1, 3, 8)
	user.adjustBruteLoss(30)
	explosion(user.loc, 1, 1, 3, 8)
	qdel(src)