/datum/reagent/stimulant
	name = "Laserbrain Dust"
	id = LASERBRAIN_DUST
	description = "An illegal but nevertheless highly effective drug that grants enhanced speed and stun reduction using a mix of high energy compounds and stimulants. Side effects include confusion, shaking, twitching, et cetera. Also known as hulk dust in some sectors of the imperium."
	reagent_state = REAGENT_STATE_LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220
	var/oldspeed = 0
	data = 0

/datum/reagent/stimulant/reagent_deleted()
	if(..())
		return 1
	if(!holder)
		return
	var/mob/M =  holder.my_atom
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/timedmg = ((data - 60) / 2)
		if(timedmg > 0)
			chemical_ending(H, TRUE)

/datum/reagent/stimulant/on_mob_life(var/mob/living/M)
	if(..())
		return 1
	
	M.Jitter(12)
	M.stuttering += 2
	M.reagents.add_reagent("hyperzine", 0.03) //To pretend it's all okay.
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.inertial_speed = 6
	switch(data)
		if(60 to 99)	//Speed up after a minute
			if(data==60)
				to_chat(M, "<span class='notice'>You feel faster.")
				M.movement_speed_modifier += 0.5
				oldspeed += 0.5
			if(prob(5))
				to_chat(M, "<span class='notice'>[pick("Your leg muscles pulsate", "You feel invigorated", "You feel like running")].")
		if(100 to 114)	//painfully fast
			if(data==100)
				to_chat(M, "<span class='notice'>Your muscles start to feel pretty hot.")
				M.movement_speed_modifier += 0.5
				oldspeed += 0.5
			if(ishuman(M))
				var/mob/living/carbon/human/H = M
				if(prob(10))
					if (M.get_heart())
						to_chat(M, "<span class='notice'>[pick("Your legs are heating up", "You feel your heart racing", "You feel like running as far as you can")]!")
					else
						to_chat(M, "<span class='notice'>[pick("Your legs are heating up", "Your body is aching to move", "You feel like running as far as you can")]!")
				H.adjustFireLoss(0.1)
		if(115 to 120)	//traverse at a velocity exceeding the norm
			M.eye_blurry = max(M.eye_blurry, 16)
			if(data==115)
				to_chat(M, "<span class='alert'>Your muscles are burning up!")
				M.movement_speed_modifier += 1
				oldspeed += 1
			if(ishuman(M))
				var/mob/living/carbon/human/H = M
				if(prob(25))
					if (M.get_heart())
						to_chat(M, "<span class='alert'>[pick("Your legs are burning", "All you feel is your heart racing", "Run! Run through the pain")]!")
					else
						to_chat(M, "<span class='alert'>[pick("Your legs are burning", "You feel like you're on fire", "Run! Run through the heat")]!")
				H.adjustToxLoss(1)
				H.adjustFireLoss(2)
		if(121 to INFINITY)	//funtime is over
			chemical_ending(M)
	data++


/datum/reagent/stimulant/proc/chemical_ending(var/mob/living/M, override_remove = FALSE)
	M.movement_speed_modifier -= oldspeed
	if(!override_remove)
		holder.remove_reagent(src.id) //Clean them out

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!H.faction == "Slaanesh") //We do not feel extremely bad side effects if we are a slaanesh worshippr
			H.Knockdown(12)
			H.Stun(10)
			H.Paralyse(4)
			H.eye_blurry = max(H.eye_blurry, 16)
			H.stuttering = max(H.stuttering, 16)
			H.Dizzy(30)
	else
		M.gib()

	data = 0
	oldspeed = 0

