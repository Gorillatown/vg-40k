/spell/targeted/dominate
	name = "Dominate"
	desc = "Malediction - Dominates everyone around the targeted area until one fights off your will."
	abbreviation = "DOM"
	user_type = USER_TYPE_PSYKER
	specialization = SSTELEPATHY
	school = "evocation"
	charge_max = 100
	invocation_type = SpI_NONE
	range = 20
	spell_flags = WAIT_FOR_CLICK
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	override_base = "cult"
	hud_state = "dominate"
	warpcharge_cost = 20

/spell/targeted/dominate/cast(var/list/targets, mob/user)
	var/list/our_victims = list()
	var/nazty_loop = TRUE //THIS SHIT IS SICK NASTY
	for(var/atom/target in targets)
		for(var/mob/living/carbon/C in view(3, target))
			to_chat(C, "<span class='sinister'>A alien force pervades your mind, attempting to crush your will to fight.</span>")
			if(C == user)
				continue
			our_victims += C
	
	var/ntime = world.time
	while(nazty_loop == TRUE)
		if(world.time >= ntime) //only do this every 2 seconds.
			for(var/mob/living/carbon/C in our_victims)
				if(prob(5))
					nazty_loop = FALSE
				else
					to_chat(C, "<span class='sinister'>Visions and whispers of your defeat continue to flood into you.</span>")
					C.Silent(10)
					C.Knockdown(15)
					C.Stun(15)
					C.audible_scream()
			ntime = world.time+20
		sleep(world.tick_lag) //repeat every tick so the loop will end immediately on state change

