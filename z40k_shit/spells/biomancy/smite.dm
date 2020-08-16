/spell/smite
	name = "Smite"
	abbreviation = "LS"
	desc = "(Primaris)Witchfire - Shoot lightning from your fingertips."
	user_type = USER_TYPE_WIZARD
	charge_max = 100
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	override_base = "ork"
	spell_flags = WAIT_FOR_CLICK
	charge_type = Sp_RECHARGE
	invocation_type = SpI_NONE
	hud_state = "smite"

	var/basedamage = 50
	var/bounces = 1
	var/bounce_range = 6
	var/image/chargeoverlay
	var/last_active_sound
	var/multicast = 3
	var/zapzap = 0
	var/lastbumped = null
	warpcharge_cost = 10

/spell/smite/New()
	..()
	chargeoverlay = image("icon" = 'icons/mob/mob.dmi', "icon_state" = "sithlord")

/spell/smite/channel_spell(mob/user = usr, skipcharge = 0, force_remove = 0)
	if(!..()) //We only make it to this point if we succeeded in channeling or are removing channeling
		return 0
	if(user.spell_channeling && !force_remove)
		user.overlays += chargeoverlay
		if(world.time >= last_active_sound + 50)
			playsound(user, 'sound/effects/lightning/chainlightning_activate.ogg', 100, 1, "vary" = 0)
			last_active_sound = world.time
		zapzap = multicast
		//give user overlay
	else
		//remove overlay
		connected_button.name = name
		charge_counter = charge_max
		user.overlays -= chargeoverlay
		if((zapzap != multicast) && (zapzap != 0)) //partial cast
			take_charge(holder, 0)
		zapzap = 0
	return 1

// Listener for /atom/movable/on_moved
/spell/smite/cast(var/list/targets, mob/user)
	var/mob/living/L = targets[1]
	if(istype(L))
		zapzap--
		if(zapzap)
			to_chat(user, "<span class='info'>You can throw lightning [zapzap] more time\s</span>")
			. = 1

		spawn()
			zapmuthafucka(user, L, bounces)

/spell/smite/proc/zapmuthafucka(var/mob/user, var/mob/living/target, var/chained = bounces, var/list/zapped = list(), var/oursound = null)
	var/otarget = target
	src.lastbumped = null
	zapped.Add(target)
	var/turf/T = get_turf(user)
	var/turf/U = get_turf(target)
	var/obj/item/projectile/beam/lightning/spell/L = new /obj/item/projectile/beam/lightning/spell(T)
	if(!oursound)
		oursound = pick(lightning_sound)
	L.our_spell = src
	playsound(user, oursound, 100, 1, "vary" = 0)
	L.tang = adjustAngle(get_angle(U,T))
	L.icon = midicon
	L.icon_state = "[L.tang]"
	L.firer = user
	L.def_zone = LIMB_CHEST
	L.original = target
	L.current = U
	L.starting = U
	L.yo = U.y - T.y
	L.xo = U.x - T.x
	L.process()
	while(!src.lastbumped)
		sleep(world.tick_lag)
	target = lastbumped
	if(!istype(target)) //hit something
		U = get_turf(target)
		var/list/zappanic = list()
		for(var/mob/living/Living in get_turf(target)) //find a mob in the tile
			if(Living == user || Living == holder || (Living in zapped))
				continue
			zappanic |= Living
		if(zappanic.len)
			target = pick(zappanic)
		else
			if(isturf(target))
				target = get_step_towards(target, get_dir(target, user))
	if(istype(target))
		if(!istype(target, /mob/living/simple_animal/hostile/glow_orb))
			target.emp_act(2)
			target.apply_damage((issilicon(target) ? basedamage*0.66 : basedamage), BURN, LIMB_CHEST, "blocked" = 0)
	else if(target)
		var/obj/item/projectile/beam/lightning/spell/B = new /obj/item/projectile/beam/lightning/spell
		B.our_spell = src
		B.damage = basedamage
		target.bullet_act(B)
		qdel(B)
	if(chained)
		//DO IT AGAIN
		var/mob/next_target
		var/currdist = -1
		for(var/mob/living/M in view(target,bounce_range))
			if(M != holder && M != user)
				if(!(M in zapped) && target == otarget)//we are chaining off something going to our original target
					continue
				var/dist = get_dist(M, user)
				if(currdist == -1)
					currdist = dist
					next_target = M
				else if(dist < currdist)
					next_target = M
					currdist = dist
				else

		if(!next_target)
			return //bail out bail out!
		zapmuthafucka("user" = target, "target" = next_target, "chained" = chained-1, "zapped" = zapped, "oursound" = oursound)

