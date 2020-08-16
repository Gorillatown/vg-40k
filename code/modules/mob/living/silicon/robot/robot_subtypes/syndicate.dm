//Syndicate subtype because putting this on new() is fucking retarded.
/mob/living/silicon/robot/syndie
	modtype = "Syndicate"
	icon_state = "robot_old"
	req_access = list()
	cell_type = /obj/item/weapon/cell/hyper
	startup_sound = 'sound/mecha/nominalsyndi.ogg'
	startup_vary = FALSE
	syndicate = TRUE

/mob/living/silicon/robot/syndie/getModules()
	return syndicate_robot_modules

/mob/living/silicon/robot/syndie/GetRobotAccess()
	return get_all_accesses()

/mob/living/silicon/robot/syndie/New()
	..()
	UnlinkSelf()
	laws = new /datum/ai_laws/syndicate_override()

/mob/living/silicon/robot/syndie/setup_PDA()
	return

/mob/living/silicon/robot/syndie/blitz/New()
	..()
	pick_module(SYNDIE_BLITZ_MODULE)
	install_upgrade(src, /obj/item/borg/upgrade/jetpack)

/mob/living/silicon/robot/syndie/crisis/New()
	..()
	pick_module(SYNDIE_CRISIS_MODULE)
	install_upgrade(src, /obj/item/borg/upgrade/vtec)