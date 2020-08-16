
/proc/appendicitis()
	for(var/mob/living/carbon/human/H in living_mob_list)
		var/foundAlready = 0 // don't infect someone that already has the virus
		for(var/datum/disease/D in H.viruses)
			foundAlready = 1
		if(H.stat == 2 || foundAlready)
			continue

		var/datum/disease/D = new /datum/disease/appendicitis
		D.holder = H
		D.affected_mob = H
		H.viruses += D
		break

/proc/viral_outbreak(var/virus = null)
	var/virus_type
	if(!virus)
		virus_type = pick(/datum/disease/dnaspread,/datum/disease/advance/flu,/datum/disease/advance/cold,/datum/disease/brainrot,/datum/disease/magnitis,/datum/disease/pierrot_throat)
	else
		switch(virus)
			if("fake gbs")
				virus_type = /datum/disease/fake_gbs
			if("gbs")
				virus_type = /datum/disease/gbs
			if("magnitis")
				virus_type = /datum/disease/magnitis
			if("rhumba beat")
				virus_type = /datum/disease/rhumba_beat
			if("brain rot")
				virus_type = /datum/disease/brainrot
			if("cold")
				virus_type = /datum/disease/advance/cold
			if("retrovirus")
				virus_type = /datum/disease/dnaspread
			if("flu")
				virus_type = /datum/disease/advance/flu
//			if("t-virus")
//				virus_type = /datum/disease/t_virus
			if("pierrot's throat")
				virus_type = /datum/disease/pierrot_throat
	for(var/mob/living/carbon/human/H in shuffle(living_mob_list))

		var/foundAlready = 0 // don't infect someone that already has the virus
		var/turf/T = get_turf(H)
		if(!T)
			continue
		if(T.z != map.zMainStation)
			continue
		for(var/datum/disease/D in H.viruses)
			foundAlready = 1
		if(H.stat == 2 || foundAlready)
			continue

		if(virus_type == /datum/disease/dnaspread) //Dnaspread needs strain_data set to work.
			if((!H.dna) || (H.sdisabilities & BLIND)) //A blindness disease would be the worst.
				continue
			var/datum/disease/dnaspread/D = new
			D.strain_data["name"] = H.real_name
			D.strain_data["UI"] = H.dna.uni_identity
			D.strain_data["SE"] = H.dna.struc_enzymes
			D.carrier = 1
			D.holder = H
			D.affected_mob = H
			H.viruses += D
			break
		else
			var/datum/disease/D = new virus_type
			D.carrier = 1
			D.holder = H
			D.affected_mob = H
			H.viruses += D
			break
	spawn(rand(1500, 3000)) //Delayed announcements to keep the crew on their toes.
		biohazard_alert()

/proc/alien_infestation(var/spawncount = 1) // -- TLE
	//command_alert("Unidentified lifesigns detected coming aboard [station_name()]. Secure any exterior access, including ducting and ventilation.", "Lifesign Alert")
//	world << sound('sound/AI/aliens.ogg')
	var/list/vents = list()
	var/success = FALSE
	for(var/obj/machinery/atmospherics/unary/vent_pump/temp_vent in atmos_machines)
		if(temp_vent.loc.z == map.zMainStation && !temp_vent.welded && temp_vent.network && temp_vent.canSpawnMice)
			if(temp_vent.network.normal_members.len > 50) // Stops Aliens getting stuck in small networks. See: Security, Virology
				vents += temp_vent

	var/list/mob/dead/observer/candidates = get_active_candidates(ROLE_ALIEN, buffer=ALIEN_SELECT_AFK_BUFFER, poll="HEY KID, YOU WANNA BE AN ALIEN LARVA?")

	if(candidates.len)
		shuffle(candidates)
		if(prob(40))
			spawncount++ //sometimes, have two larvae spawn instead of one
		while((spawncount >= 1) && vents.len && candidates.len)
			var/obj/vent = pick(vents)
			var/mob/dead/observer/candidate = pick(candidates)

			if(istype(candidate) && candidate.client && candidate.key)
				var/mob/living/carbon/alien/larva/new_xeno = new(vent.loc)
				new_xeno.transfer_personality(candidate.client)
				success = TRUE

			candidates -= candidate
			vents -= vent
			spawncount--

		if(success)
			spawn(rand(5000, 6000)) //Delayed announcements to keep the crew on their toes.
				command_alert(/datum/command_alert/xenomorphs)

		return success

/proc/high_radiation_event()

/* // Haha, this is way too laggy. I'll keep the prison break though.
	for(var/obj/machinery/light/L in world)
		if(L.z != map.zMainStation)
			continue
		L.flicker(50)

	sleep(100)
*/
	for(var/mob/living/carbon/human/H in living_mob_list)
		var/turf/T = get_turf(H)
		if(!T)
			continue
		if(T.z != map.zMainStation)
			continue
		if(istype(H,/mob/living/carbon/human))
			H.apply_radiation((rand(15,75)),RAD_EXTERNAL)
			if (prob(5))
				H.apply_radiation((rand(90,150)),RAD_EXTERNAL)
			if (prob(25))
				if (prob(75))
					randmutb(H)
					domutcheck(H,null,MUTCHK_FORCED)
				else
					randmutg(H)
					domutcheck(H,null,MUTCHK_FORCED)
	for(var/mob/living/carbon/monkey/M in living_mob_list)
		var/turf/T = get_turf(M)
		if(!T)
			continue
		if(T.z != map.zMainStation)
			continue
		M.apply_radiation((rand(15,75)),RAD_EXTERNAL)
	sleep(100)
	command_alert(/datum/command_alert/radiation)


//Changing this to affect the main station. Blame Urist. --Pete
/proc/prison_break() // -- Callagan




	var/list/area/theareas = list()
	for(var/area/A in areas)
		if(istype(A, /area/security/prison) || istype(A, /area/security/brig))
			theareas += A

	if(theareas && theareas.len > 0)

		for(var/area/A in theareas)
			for(var/obj/machinery/light/L in A)
				L.flicker(10)

		sleep(100)

		for(var/area/A in theareas)
			for (var/obj/machinery/power/apc/temp_apc in A)
				temp_apc.overload_lighting()

			for (var/obj/structure/closet/secure_closet/brig/temp_closet in A)
				temp_closet.locked = 0
				temp_closet.icon_state = temp_closet.icon_closed

			for (var/obj/machinery/door/airlock/security/temp_airlock in A)
				spawn(0) temp_airlock.prison_open()

			for (var/obj/machinery/door/airlock/glass_security/temp_glassairlock in A)
				spawn(0) temp_glassairlock.prison_open()

			for (var/obj/machinery/door_timer/temp_timer in A)
				temp_timer.releasetime = 1

		sleep(150)
		command_alert(/datum/command_alert/graytide)
	else
		world.log << "ERROR: Could not initate grey-tide. Unable find prison or brig area."

/proc/carp_migration() // -- Darem
	for(var/obj/effect/landmark/C in landmarks_list)
		if(C.name == "carpspawn")
			new /mob/living/simple_animal/hostile/carp(C.loc)
	//sleep(100)
	spawn(rand(300, 600)) //Delayed announcements to keep the crew on their toes.
		command_alert(/datum/command_alert/carp)

/proc/lightsout(isEvent = 0, lightsoutAmount = 1,lightsoutRange = 25) //leave lightsoutAmount as 0 to break ALL lights
	if(isEvent)
		command_alert(/datum/command_alert/electrical_storm)

	if(lightsoutAmount)
		var/list/epicentreList = list()

		for(var/i=1,i<=lightsoutAmount,i++)
			var/list/possibleEpicentres = list()
			for(var/obj/effect/landmark/newEpicentre in landmarks_list)
				if(newEpicentre.name == "lightsout" && !(newEpicentre in epicentreList))
					possibleEpicentres += newEpicentre
			if(possibleEpicentres.len)
				epicentreList += pick(possibleEpicentres)
			else
				break

		if(!epicentreList.len)
			return

		for(var/obj/effect/landmark/epicentre in epicentreList)
			for(var/obj/machinery/power/apc/apc in range(epicentre,lightsoutRange))
				apc.overload_lighting()

	else
		for(var/obj/machinery/power/apc/apc in power_machines)
			apc.overload_lighting()

	return
