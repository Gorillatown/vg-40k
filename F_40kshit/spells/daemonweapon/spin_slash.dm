//////////////////////////////Basic attack
//                          //Can be used by clicking anywhere on the screen for convenience
//        SPIN SLASH        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                          //Attackes EVERY (almost) atoms on your turf, and the one in the direction you're facing.
//////////////////////////////That means unexpected behaviours are likely, for instance you can open doors, harvest meat off dead animals, or break important stuff

/spell/daemonweapon/blade_spin
	name = "Spin Slash"
	desc = "(5 BLOOD) Stop your momentum and cut in front of you."
	hud_state = "soulblade_spin"

	invocation_type = SpI_NONE
	charge_type = Sp_RECHARGE
	charge_max = 15
	range = 0
	spell_flags = null
	insufficient_holder_msg = ""
	still_recharging_msg = ""

	cast_delay = 0

	blood_cost = 5

/spell/daemonweapon/blade_spin/choose_targets(var/mob/user = usr)
	var/obj/item/weapon/daemonweapon/blissrazor/SB = user.loc
	if(!isturf(SB.loc) && !istype(SB.loc,/obj/item/projectile))
		if(ismob(SB.loc))
			var/mob/M = SB.loc
			M.drop_item(SB)
			to_chat(M,"<span class='danger'>\The [SB] suddenly spins out of your grab.</span>")
		else
			return null
	var/turf/T = get_turf(SB)
	var/dir = SB.dir
	if(istype(T,/obj/item/projectile))
		var/obj/item/projectile/P = T
		dir = get_dir(P.starting,P.target)
	var/list/my_targets = list()
	for(var/atom/A in T)
		if(A == SB)
			continue
		if(istype(A,/atom/movable/lighting_overlay))
			continue
		if(ismob(A))
			var/mob/M = A
			if(!M == SB.current_swordbearer)
				my_targets += M
		else
			//BREAK EVERYTHING
			if (!istype(A, /obj/item/weapon/storage))
				my_targets += A
	for(var/atom/A in get_step(T,dir))
		if(istype(A,/atom/movable/lighting_overlay))
			continue
		if(ismob(A))
			var/mob/M = A
			if(!M == SB.current_swordbearer)
				my_targets += M
		else
			//BREAK EVERYTHING
			if(!istype(A, /obj/item/weapon/storage))
				my_targets += A

	return my_targets

/spell/daemonweapon/blade_spin/before_cast(var/list/targets, var/user)
	return targets

/spell/daemonweapon/blade_spin/cast(var/list/targets, var/mob/user)
	..()
	var/obj/item/weapon/daemonweapon/blissrazor/SB = user.loc
	SB.throwing = 0
	if(istype(SB.loc,/obj/item/projectile))
		var/obj/item/projectile/P = SB.loc
		qdel(P)

	flick("blissrazor_spintime",SB)
	for(var/atom/A in targets)
		if(isliving(A))
			SB.attack(A, user)
		else
			A.attackby(SB,user)
			

