/datum/job/rnganimals
	title = "(RNG) Animals"
	flag = RNGANIMALS
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 500
	spawn_positions = 10
	wage_payout = 0
	supervisors = "Up to you?"
	selection_color = "#FFB5B5"
	access = list()
	landmark_job_override = TRUE
	outfit_datum = /datum/outfit/rnganimals

	relationship_chance = XENO_NO_RELATIONS

/datum/outfit/rnganimals

	outfit_name = "RNG Animals"
	associated_job = /datum/job/rnganimals
	no_backpack = TRUE
	no_id = TRUE

	var/list/creatures = list(/mob/living/simple_animal/hostile/giant_spider/spiderling,
							/mob/living/simple_animal/hostile/retaliate/growing_pig,
							/mob/living/simple_animal/borer,
							/mob/living/simple_animal/hostile/lizard,
							/mob/living/simple_animal/cat,
							/mob/living/simple_animal/hostile/wendigo/alpha,
							/mob/living/simple_animal/hostile/wolf,
							/mob/living/simple_animal/hostile/deer)
 
/datum/outfit/rnganimals/post_equip(var/mob/living/carbon/human/H)
	var/numerical_fun = rand(1,10)
	switch(numerical_fun)
		if(1 to 9)
			spawn(5)
				var/simplemob = pick(creatures)

				var/mob/oursimplemob = new simplemob(H.loc)
				H.mind.transfer_to(oursimplemob)

				H.x = 0
				H.y = 0
				H.z = 1
				oursimplemob.see_invisible = SEE_INVISIBLE_OBSERVER_NOLIGHTING
				oursimplemob.see_in_dark_override = 8
				oursimplemob.see_invisible_override = SEE_INVISIBLE_OBSERVER_NOLIGHTING
				spawn(5)
					qdel(H)
		if(10)
			spawn(1 SECONDS)
				H.make_zombie(retain_mind = TRUE)
/*
	var/obj/effect/landmark/start/override_point = null
	var/list/rng_static_spawns = list()
	for(var/obj/effect/landmark/start/S in landmarks_list)
		if(istype(S,/obj/effect/landmark/start/rng_animals))
			rng_static_spawns += S
	override_point = pick(rng_static_spawns)
	if(!override_point)
		message_admins("ERROR - NO VALID OVERRIDE SPAWN. Here's what I've got: [json_encode(landmarks_list)]")
		//Error! We have no targetable spawn!
		return
	target.forceMove(override_point.loc)
*/



