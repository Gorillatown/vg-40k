/*
	Basically our perils of the warp table.
											*/

/spell/proc/perils_of_the_warp(mob/living/user) //We only really need the user for this anyways.
	set waitfor = 0
	switch(user.warp_charges)
		if(70 to 100)
			to_chat(user,"<span class='bad'> The warp energy you are tapping into feels like it could slip out of your control.</span>")
		if(101 to INFINITY)
			var/our_prob = user.warp_charges-100
			if(prob(our_prob))
				user.visible_message("<h2><span style=\"color:#f50ce9\"><span style=\"font-family: Impact, Charcoal, sans-serif\">[user] struggles to control their warp energy.</span></span></h2>")
				var/punishment = rand(1,6)
				sleep(2 SECONDS)
				switch(punishment)
					if(1) //Dragged into the warp.
						if(user.attribute_willpower >= 18)
							user.adjustBruteLoss(25)
							to_chat(user,"<span class='good'>Your iron will stops the warp in its tracks</span>")
						else
							if(prob(50))
								user.adjustBruteLoss(50)
								to_chat(user,"<span class='good'>You resist the warp attempting to drag you into itself.</span>")
							else
								user.visible_message("<span class='danger'>Everyone around [user] is dragged into the warp!</span>")
								user.audible_scream()
								sleep(1 SECONDS)
								for(var/mob/living/L in range(2,user))
									L.gib()
					if(2)//Mental Purge
						to_chat(user,"<span class='bad'>You feel as though the ability to tap into a power is lost.</span>")
						var/spell/lostspell = pick(user.spell_list)
						user.remove_spell(lostspell)
						user.adjustBruteLoss(30)
					if(3)//Power Drain
						to_chat(user,"<span class='bad'>Your ability to control the warp wanes as its power increases in you.</span>")
						user.attribute_willpower -= 10
						user.warp_charges += 90
						sleep(3 MINUTES)
						user.attribute_willpower += 10
					if(4)//Psychic Backlash
						to_chat(user,"<span class='bad'> Psychic power backlashes back from your spell into you. </span>")
						user.adjustBruteLoss(70)
					if(5)//Empyric Feedback
						user.visible_message("<span class='sinister'>Violent Warp energy explodes from [user]!</span>")
						user.adjustBruteLoss(50)
						var/turf/ourturf = get_turf(user)
						var/list/mofugga = list()
						explosion(ourturf, -1, 2, 3, 5)
						for(var/turf/T in range(2,ourturf))
							var/obj/effect/psychic_maelstrom/nigguh = new(T)
							mofugga += nigguh
						sleep(8 SECONDS)
						for(var/obj/effect/psychic_maelstrom/muhdik in mofugga)
							qdel(muhdik)
					if(6)//Warp Surge. ITS TIME TO WITNESS A TRUE GOD.
						user.visible_message("<span class='sinister'> [user] has their warp power violently surge!</span>")
						user.attribute_strength += 15
						user.attribute_constitution += 15
						user.attribute_agility += 15
						user.attribute_dexterity += 15
						user.warp_speed = TRUE
						apply_highperf_perils_aura(user,12 SECONDS)
						sleep(12 SECONDS)
						user.attribute_strength -= 15
						user.attribute_constitution -= 15
						user.attribute_agility -= 15
						user.attribute_dexterity -= 15
						user.warp_speed = FALSE

/spell/proc/apply_highperf_perils_aura(mob/living/user,effect_duration)
	user.filters += filter(type="drop_shadow", x=0, y=0, size=7, offset=2, color=rgb(122, 17, 117))
	var/f1 = user.filters[user.filters.len]
	user.filters += filter(type="drop_shadow", x=0, y=0, size=7, offset=2, color=rgb(255, 4, 255))
	var/f3 = user.filters[user.filters.len]
	var/start = user.filters.len
	var/X
	var/Y
	var/rsq
	var/i
	var/f2
	for(i=1, i<=7, ++i)
		// choose a wave with a random direction and a period between 10 and 30 pixels
		do
			X = 60*rand() - 30
			Y = 60*rand() - 30
			rsq = X*X + Y*Y
		while(rsq<100 || rsq>900)   // keep trying if we don't like the numbers
		// keep distortion (size) small, from 0.5 to 3 pixels
		// choose a random phase (offset)
		user.filters += filter(type="wave", x=X, y=Y, size=rand()*2.5+0.5, offset=rand())
	for(i=1, i<=7, ++i)
		// animate phase of each wave from its original phase to phase-1 and then reset;
		// this moves the wave forward in the X,Y direction
		f2 = user.filters[start+i]
		animate(f2, offset=f2:offset, time=0, loop=-1, flags=ANIMATION_PARALLEL)
		animate(offset=f2:offset-1, time=rand()*20+10)
		spawn(effect_duration)
			user.filters -= f1
			user.filters -= f2
			user.filters -= f3
