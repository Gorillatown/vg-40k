/*
	In this file we have the manned turret
*/
/datum/locking_category/buckle/manned_turret //Locking category

//The projectile that it fires
/obj/item/projectile/bullet/autocannon
	name = "autocannon bullet"
	icon = 'z40k_shit/icons/obj/projectiles.dmi'
	icon_state = "punisher"
	damage = 40
	kill_count = 20

//Our magazine thing
/obj/item/autocannon_drum
	name = "autocannon drum"
	icon = 'z40k_shit/icons/obj/ig/ig_objects.dmi'
	icon_state = "autocannon_ammo"
	var/amount_inside = 20

//Object that represents our controls, afterattack causes the turret to process.
/obj/item/turret_controls //Hand object given to someone when buckled
	name = "turret controls"
	desc = "Basically your hands... on the gun."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "offhand"
	flags = TWOHANDABLE | MUSTTWOHAND
	var/obj/structure/bed/manned_turret/our_turret

//What occurs when a object is dropped.
/obj/item/turret_controls/dropped(mob/user)
	..()
	our_turret.manual_unbuckle(user)


//What occurs when a object is thrown.
/obj/item/turret_controls/throw_impact(atom/hit_atom, mob/user)
	..()
	our_turret.manual_unbuckle(user)


//What occurs when a object is unequipped/stripped
/obj/item/turret_controls/unequipped(mob/user)
	..()
	our_turret.manual_unbuckle(user)

/obj/item/turret_controls/afterattack(atom/A, mob/living/user, flag, params, struggle = 0)
	our_turret.fire_dat_shit(A,user)

//The turret itself
/obj/structure/bed/manned_turret
	name = "PDF Autocannon Variant"
	desc = "Theres many types of autocannon in the universe, but this one is yours."
	icon_state = "autocannon-unloaded"
	icon = 'z40k_shit/icons/obj/64xstructures.dmi'
	layer = BELOW_OBJ_LAYER
	anchored = 1
	density = 1
	sheet_type = /obj/item/stack/sheet/metal
	sheet_amt = 1
	mob_lock_type = /datum/locking_category/buckle/manned_turret
	var/ammo_loaded = 0
	var/obj/item/turret_controls/our_controls
	var/projectile = /obj/item/projectile/bullet/autocannon
	var/obj/item/autocannon_drum/our_drum
	var/next_firetime
	var/fire_delay = 1 SECONDS

/obj/structure/bed/manned_turret/New()
	..()
	if(material_type)
		sheet_type = material_type.sheettype
	our_controls = new /obj/item/turret_controls(src)
	our_controls.our_turret = src
	our_drum = new /obj/item/autocannon_drum(src)
	update_icon()


/obj/structure/bed/manned_turret/Cross(atom/movable/mover, turf/target, height=1.5, air_group = 0)
	if(air_group || (height==0))
		return 1
	if(istype(mover) && mover.checkpass(PASSTABLE)) //NOTE: This includes ALL chairs as well! Vehicles have their own override.
		return 1
	return ..()

/obj/structure/bed/manned_turret/update_icon()
	if(our_drum)
		icon_state = "autocannon-loaded"
	else
		icon_state = "autocannon-unloaded"

/obj/structure/bed/manned_turret/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/bed/manned_turret/attack_hand(mob/user)
	manual_unbuckle(user)

/obj/structure/bed/manned_turret/attack_animal(mob/user)
	manual_unbuckle(user)

/obj/structure/bed/manned_turret/attack_robot(mob/user)
	if(Adjacent(user))
		manual_unbuckle(user)

/obj/structure/bed/manned_turret/MouseDropTo(var/atom/movable/AM, var/mob/user)
	if(ismob(AM))
		buckle_mob(AM, user)
	else
		return ..()

/obj/structure/bed/manned_turret/AltClick(mob/user)
	buckle_mob(user, user)

/obj/structure/bed/manned_turret/manual_unbuckle(var/mob/user)

	if(is_locking(mob_lock_type))
		var/mob/M = get_locked(mob_lock_type)[1]
		var/success = unlock_atom(M)

		M.drop_item(our_controls,src)
		if(M != user)
			if(!success)
				user.delayNextAttack(8)
				M.visible_message("<span class='warning'>[user] struggles in vain trying to pull [M] off \the [src].</span>")
				return FALSE
			M.visible_message(
				"<span class='notice'>[M] was pulled off by [user]!</span>",
				"You were pulled from \the [src] by [user].",
				"You hear metal clanking.")
		else
			if(!success)
				user.delayNextAttack(8)
				M.visible_message("<span class='warning'>[user] struggles in vain trying to pull themselves off \the [src].</span>")
				return FALSE
			M.visible_message(
				"<span class='notice'>[M] pulled \himself off the [src]!</span>",
				"You pull yourself off \the [src].",
				"You hear metal clanking.")
		
		playsound(src, 'sound/misc/buckle_unclick.ogg', 50, 1)
		M.clear_alert(SCREEN_ALARM_BUCKLE)
		return TRUE

/obj/structure/bed/manned_turret/buckle_mob(mob/M, mob/user)
	if(!Adjacent(user) || user.incapacitated() || istype(user, /mob/living/silicon/pai))
		return

	if(!ismob(M) || (M.loc != src.loc)  || M.locked_to)
		return
		
	if(!user.Adjacent(M))
		return

	for(var/mob/living/L in get_locked(mob_lock_type))
		to_chat(user, "<span class='warning'>Somebody else is already on \the [src]!</span>")
		return

	if(!M.put_in_hands(our_controls))
		to_chat(user, "<span class='warning'>You need open hands to do that.</span>")
		return

	if(M == usr)
		M.visible_message(\
			"<span class='notice'>[M.name] mans the [src]!</span>",\
			"You man the [src].",\
			"You hear metal clanking.")
	else
		M.visible_message(\
			"<span class='notice'>[M.name] is forced onto the [src] by [user.name]!</span>",\
			"You are forced to man the [src] by [user.name].",\
			"You hear metal clanking.")

	lock_atom(M, mob_lock_type)
	M.throw_alert(SCREEN_ALARM_BUCKLE, /obj/abstract/screen/alert/object/buckled, new_master = src)

	if(M.pulledby)
		M.pulledby.start_pulling(src)

/obj/structure/bed/manned_turret/unlock_atom(var/atom/movable/AM)
	if(current_glue_state != GLUE_STATE_NONE && ismob(AM))
		return FALSE
	return ..()

/obj/structure/bed/manned_turret/Destroy()
	if(current_glue_state == GLUE_STATE_PERMA && is_locking(mob_lock_type))//Don't de-ass someone if it was temporary glue.
		current_glue_state = GLUE_STATE_NONE
		var/mob/living/carbon/human/locked = get_locked(mob_lock_type)[1]
		if(istype(locked) && locked.remove_butt())
			playsound(src, 'sound/items/poster_ripped.ogg', 100, TRUE)
			visible_message("<span class='danger'>[locked]'s butt is ripped from their body as \the [src] gets dismantled!</span>")
			locked.apply_damage(10, BRUTE, LIMB_GROIN)
			locked.apply_damage(10, BURN, LIMB_GROIN)
			locked.audible_scream()
	..()

/obj/structure/bed/manned_turret/attackby(obj/item/weapon/W, mob/user)
	if(W.is_wrench(user))
		wrench_act(W,user)
	else if(istype(W,/obj/item/autocannon_drum))
		if(our_drum)
			our_drum.forceMove(loc)
			user.drop_item(W,src)
			our_drum = W
			user.visible_message("<span class='notice'>[user.name] sticks a ammo drum onto [src]!</span>")
			update_icon()
		else
			user.drop_item(W,src)
			user.visible_message("<span class='notice'>[user.name] sticks a ammo drum onto [src]!</span>")
			update_icon()
	else
		..()

/obj/structure/bed/manned_turret/wrench_act(obj/item/weapon/W,mob/user)
	W.playtoolsound(src, 50)
	anchored = !anchored

/obj/structure/bed/manned_turret/proc/fire_dat_shit(atom/target,mob/living/user)
	var/dir = get_dir(src,target)
	if(dir == src.dir)
		return 0
	
	if(next_firetime > world.time)
		return 0

	if((our_drum) && (our_drum.amount_inside > 0))
		var/turf/curloc = src.loc
		var/turf/targloc = get_turf(target) //Target location is the turf of the target
		playsound(src, 'z40k_shit/sounds/Autocannon4.ogg', 50, 1, 12)
		var/obj/item/projectile/A = new projectile(curloc)
		A.firer = user
		A.original = target
		A.current = curloc
		A.starting = curloc
		A.yo = targloc.y - curloc.y
		A.xo = targloc.x - curloc.x
		A.OnFired()
		A.process()
		our_drum.amount_inside--
		next_firetime = world.time + fire_delay
	else
		playsound(src, 'sound/weapons/empty.ogg', 50, 1, 12)
		return 0



