/spell/aoe_turf/fire_shield
	name = "Fire Shield"
	desc = "Blessing - Grants fire resistance to all those around you and brings up a flaming barrier."
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	user_type = USER_TYPE_PSYKER
	specialization = SSPYROMANCY
	school = "conjuration"
	charge_max = 300
	cooldown_min = 100

	charge_type = Sp_RECHARGE
	invocation_type = SpI_NONE
	hud_state = "fire_barrier"
	override_base = "cult"
	duration = 100
	range = 3
	selection_type = "range"
	warpcharge_cost = 20

/spell/aoe_turf/fire_shield/choose_targets(mob/user = usr)
	return trange(range, get_turf(user)) - trange(range - 1, get_turf(user))

/spell/aoe_turf/fire_shield/cast(list/targets, mob/user)

	var/obj/effect/ring = new /obj/effect/fire_shield(get_turf(user), targets, duration)

	user.lock_atom(ring, /datum/locking_category/fire_shield)

	to_chat(user, "<span class='danger'>You summon a ring of fire around yourself.</span>")

	//WE ALL IN DIS TOGETHER, INCLUDING PEOPLE WHO SHOULDN'T BE
	for(var/mob/living/L in range(2,user))
		if(!L.mutations.Find(M_RESIST_HEAT) || !L.mutations.Find(M_UNBURNABLE))
			to_chat(L, "<span class='info'>You feel completely resistant to fire.</span>")
		L.mutations.Add(M_RESIST_HEAT, M_UNBURNABLE)
		L.update_mutations()

		spawn(duration)
			L.mutations.Remove(M_RESIST_HEAT, M_UNBURNABLE)
			L.update_mutations()
			if(!L.mutations.Find(M_UNBURNABLE))
				to_chat(L, "<span class='info'>You are no longer fully resistant to fire.</span>")

	..()


//Invisible object that keeps all the individual flames together
/obj/effect/fire_shield
	anchored = TRUE
	invisibility = 101

/obj/effect/fire_shield/New(loc, list/locations, duration)
	..()

	var/list/processing_locking_cats = list()

	for(var/turf/T in locations)
		//Create the flames at their intended location
		var/obj/effect/fire_blast/fire_shield/F = new /obj/effect/fire_blast/fire_shield(T, fire_duration = duration)

		var/lock_id = "\ref[F]"
		var/datum/locking_category/fire_shield/locking_cat = add_lock_cat(/datum/locking_category/fire_shield, lock_id)
		//Lock_atom notes their intended location, and moves all of them to the caster's turf
		lock_atom(F, lock_id)

		processing_locking_cats.Add(locking_cat)

	//This subprocess moves all flames to their intended location
	spawn()
		while(processing_locking_cats.len)
			for(var/datum/locking_category/fire_shield/ROF in processing_locking_cats)
				if(ROF.x_offset == ROF.target_x_offset && ROF.y_offset == ROF.target_y_offset)
					processing_locking_cats.Remove(ROF)
					continue
				if(!ROF.locked || !ROF.locked.len || !ROF.owner || !ROF.owner.loc)
					processing_locking_cats.Remove(ROF)
					continue

				ROF.x_offset += sgn(ROF.target_x_offset - ROF.x_offset)
				ROF.y_offset += sgn(ROF.target_y_offset - ROF.y_offset)
				ROF.update_locks()

			sleep(5)

	spawn(duration)
		qdel(src)

/obj/effect/fire_blast/fire_shield
	fire_damage = 15
	spread = 0
	icon = 'icons/effects/fire.dmi'
	icon_state = "1"
	magic_fire = TRUE

/datum/locking_category/fire_shield
	var/target_x_offset
	var/target_y_offset

/datum/locking_category/fire_shield/lock(atom/movable/AM)
	target_x_offset = AM.x - owner.x
	target_y_offset = AM.y - owner.y
	x_offset = 0
	y_offset = 0

	..()