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

	var/list/creatures = list(
							/mob/living/simple_animal/hostile/retaliate/growing_pig,
							/mob/living/simple_animal/borer,
							/mob/living/simple_animal/hostile/growing_lizard,
							/mob/living/simple_animal/hostile/growing_cat,
							/mob/living/simple_animal/hostile/retaliate/growing_wolf,
							/mob/living/simple_animal/hostile/growing_deer)

	var/list/rare_creatures = list(
							/mob/living/simple_animal/hostile/wendigo/alpha,
	)
 
/datum/outfit/rnganimals/post_equip(var/mob/living/carbon/human/H)
	var/numerical_fun = rand(1,11)
	switch(numerical_fun)
		if(1 to 10)
			spawn(5)
				var/simplemob
				if(prob(95))
					simplemob = pick(creatures)
				else
					simplemob = pick(rare_creatures)
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
					to_chat(oursimplemob,"<span class='good'>You are one of the many native animals of the Detroid System, you can speak and find yourself capable of concise thought.</span>")
		if(11)
			spawn(1 SECONDS)
				H.make_zombie(retain_mind = TRUE)
		

