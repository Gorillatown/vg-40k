/spell/targeted/haemorrage
	name = "Haemorrage"
	desc = "Witchfire(Profileless) - Tests the targets constitution by boiling their blood, If they fail it will spread to another."
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	override_base = "ork"
	abbreviation = "HMG"
	user_type = USER_TYPE_PSYKER
	specialization = SSBIOMANCY
	school = "transmutation"
	charge_max = 600
	spell_flags = WAIT_FOR_CLICK
	range = 20
	max_targets = 1
	invocation_type = SpI_NONE
	cooldown_min = 200 //100 deciseconds reduction per rank
	hud_state = "haemorrhage"
	warpcharge_cost = 120

/spell/targeted/haemorrage/cast(var/list/targets, mob/user)
	for(var/mob/living/target in targets)
		chainkill(targets,user)

/spell/targeted/haemorrage/proc/chainkill(list/targets,mob/user)
	set waitfor = 0
	var/list/our_victims = list()
	var/nazty_loop = TRUE //THIS SHIT IS SICK NASTY
	var/single_check = FALSE //We already pop someone?
	for(var/atom/C in targets)
		our_victims += C
	
	var/ntime = world.time
	while(nazty_loop == TRUE)
		if(world.time >= ntime) //only do this every 2 seconds.
			var/mob/living/C = pick(our_victims)
			if(C.attribute_constitution >= 12)
				if(prob(16))
					C.adjustBruteLoss(15)
					to_chat(C, "<span class='danger'> Your blood is boiling inside of your flesh. </span>")
					C.vis_contents += new /obj/effect/overlay/red_radiating(C,10)
					sleep(3 SECONDS)
					if(single_check)
						C.visible_message("<span class='danger'>\The [C] explodes in a burst of scalding blood!</span>")	
						for(var/mob/living/victim in range(2,C))
							if(victim.stat != DEAD)
								our_victims += victim
						C.gib()
						our_victims -= C
						sleep(1 SECONDS)
						continue
					else if(prob(16))
						C.visible_message("<span class='danger'>\The [C] explodes in a burst of scalding blood!</span>")		
						single_check = TRUE
						for(var/mob/living/victim in range(2,C))
							if(victim.stat != DEAD)
								our_victims += victim
						C.gib()
						our_victims -= C
						sleep(1 SECONDS)
						continue
					else
						nazty_loop = FALSE
						break
				else
					nazty_loop = FALSE
					break
			else
				var/con_percent = abs((C.attribute_constitution*6) - 100)
				if(prob(con_percent))
					C.adjustBruteLoss(15)
					to_chat(C, "<span class='danger'> Your blood is boiling inside of your flesh. </span>")
					C.vis_contents += new /obj/effect/overlay/red_radiating(C,10)
					sleep(3 SECONDS)
					if(single_check)
						C.visible_message("<span class='danger'>\The [C] explodes in a burst of scalding blood!</span>")		
						for(var/mob/living/victim in range(2,C))
							if(victim.stat != DEAD)
								our_victims += victim
						C.gib()
						our_victims -= C
						sleep(1)
						continue
					else if(prob(con_percent))
						C.visible_message("<span class='danger'>\The [C] explodes in a burst of scalding blood!</span>")		
						single_check = TRUE
						for(var/mob/living/victim in range(2,C))
							if(victim.stat != DEAD)
								our_victims += victim
						C.gib()
						our_victims -= C
						sleep(1)
						continue
					else
						nazty_loop = FALSE
						break
				else
					nazty_loop = FALSE
					break
	
		ntime = world.time+20
		sleep(world.tick_lag) //repeat every tick so the loop will end immediately on state change