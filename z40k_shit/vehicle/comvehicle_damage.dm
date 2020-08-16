

/obj/complex_vehicle/to_bump(var/atom/A)
	..()
	var/randomizer = pick('z40k_shit/sounds/wallsmash1.ogg','z40k_shit/sounds/wallsmash2.ogg', 'z40k_shit/sounds/wallsmash3.ogg')
	var/ntime = world.time

	if(istype(A, /turf/simulated/wall) && !istype(A, /turf/simulated/wall/r_wall))
		if(dozer_blade)
			visible_message("<span class = 'warning'>\The [src] collides with the [A], and destroys it with the dozerblade.</span>")
			acceleration -= 100
			if(prob(50))
				A.ex_act(1)
			else
				A.ex_act(2)
			playsound(loc, randomizer, 100, 1)
		else
			if(world.time >= ntime) //only do this every 2 seconds.
				switch(acceleration)
					if(0 to 100) //Max reverse
						if(prob(25))
							A.ex_act(2)
							playsound(loc, randomizer, 100, 1)
						adjust_health(250)
						visible_message("<span class = 'warning'>\The [src] collides with the [A] and takes damage.</span>")
						acceleration = 350
					if(100 to 600) //Mid Reverse
						adjust_health(50)
						visible_message("<span class = 'warning'>\The [src] collides with the [A] and takes damage.</span>")
						acceleration = 350
					if(600 to 700) //Med-High Forward
						adjust_health(100)
						visible_message("<span class = 'warning'>\The [src] collides with the [A] and takes damage.</span>")
						acceleration = 350
					if(700 to 900) //Max Forward
						if(prob(25))
							A.ex_act(2)
							playsound(loc, randomizer, 100, 1)
						adjust_health(250)
						visible_message("<span class = 'warning'>\The [src] collides with the [A] and takes damage.</span>")	
						acceleration = 350
					if(900 to 1000)
						if(prob(90))
							A.ex_act(1)
							playsound(loc, randomizer, 100, 1)
						adjust_health(500)
						visible_message("<span class = 'warning'>\The [src] collides with the [A] at FULL SPEED.</span>")
				ntime = world.time+20
				playsound(loc,'z40k_shit/sounds/crash.ogg',75,1)
			else
				return
	if(istype(A, /turf/simulated/wall/r_wall))
		if(dozer_blade)
			if(prob(50))
				A.ex_act(1)
			else
				A.ex_act(2)
			playsound(loc, randomizer, 100, 1)
			visible_message("<span class = 'warning'>\The [src] collides with the [A], and destroys it with the dozerblade.</span>")
		else
			if(world.time >= ntime) //only do this every 2 seconds.
				switch(acceleration)
					if(0 to 100)
						visible_message("<span class = 'warning'>\The [src] collides with the [A] and takes damage.</span>")
						adjust_health(250)
						acceleration = 350
					if(100 to 700)
						visible_message("<span class = 'warning'>\The [src] collides with the [A] and takes damage.</span>")
						adjust_health(100)
						acceleration = 350
					if(700 to 1000)
						visible_message("<span class = 'warning'>\The [src] collides with the [A] at FULL SPEED.</span>")
						adjust_health(1000)
						acceleration = 350
				ntime = world.time+20
				playsound(loc,'z40k_shit/sounds/crash.ogg',75,1)
			else
				return
	if(istype(A, /obj/structure))
		if(dozer_blade)
			visible_message("<span class = 'warning'>\The [src] collides with the [A], and destroys it with the dozerblade.</span>")
			A.ex_act(1)
		else
			if(prob(10))
				adjust_health(25)
			A.ex_act(1)
			visible_message("<span class = 'warning'>\The [src] collides with the [A]</span>")
			playsound(loc,'z40k_shit/sounds/crash.ogg',75,1)

	if(istype(A, /obj/machinery))
		A.ex_act(1)
		visible_message("<span class = 'warning'>\The [src] collides with the [A]</span>")

	var/mob/living/M = A
	if(istype(A, /mob/living/carbon/human))
		M.Stun(10)
		M.Knockdown(10)
		M.adjustBruteLoss(70)
		visible_message("<span class = 'warning'>\The [src] collides into [A]</span>")
		playsound(loc,'z40k_shit/sounds/squash.ogg',75,1)

/obj/complex_vehicle/bullet_act(var/obj/item/projectile/P)
	if(vehicle_broken_husk)
		return
	if(health <= 0)
		return
	if(P.damage && !P.nodamage)
		if(P.damage >= 41)
			adjust_health(P.damage)
		else
			adjust_health(5)

/obj/complex_vehicle/proc/adjust_health(var/damage)
	if(vehicle_broken_husk)
		return
	var/oldhealth = health
	health = clamp(health-damage,0, maxHealth)
	var/percentage = (health / initial(health)) * 100
	var/mob/pilot = get_pilot()
	if(pilot && oldhealth > health && percentage <= 25 && percentage > 0)
		pilot.playsound_local(pilot, 'sound/effects/engine_alert2.ogg', 50, 0, 0, 0, 0)
	if(pilot && oldhealth > health && !health)
		var/mob/living/L = pilot
		L.playsound_local(L, 'sound/effects/engine_alert1.ogg', 50, 0, 0, 0, 0)
	if((health <= 0) && (!vehicle_broken_husk))
		vehicle_broken_husk = TRUE
		spawn(0)
			var/mob/living/L = get_pilot()
			if(L)
				to_chat(L, "<big><span class='warning'>Critical damage to the vessel detected, core explosion imminent!</span></big>")
			for(var/i = 10, i >= 0; --i)
				if(L)
					to_chat(L, "<span class='warning'>[i]</span>")
				if(i == 0)
					if(has_passengers())
						for(var/mob/living/MUHDICK in get_passengers())
							move_outside(MUHDICK, get_turf(src))
							MUHDICK.throw_at(get_turf(pick(orange(5,src))))
							to_chat(MUHDICK, "<span class='warning'>You are forcefully thrown from \the [src]!</span>")
					var/mob/living/carbon/human/H = get_pilot()
					if(H)
						move_outside(H, get_turf(src))
						H.throw_at(get_turf(pick(orange(5,src))))
						to_chat(H, "<span class='warning'>You are forcefully thrown from \the [src]!</span>")
					explosion(loc, 2, 4, 8)
					break_this_shit()
				sleep(10)

	update_icon()

/obj/complex_vehicle/ex_act(severity)
	if(vehicle_broken_husk)
		return
	switch(severity)
		if(1)
			adjust_health(1000)
		if(2)
			adjust_health(100)
		if(3)
			if(prob(40))
				adjust_health(50)
				