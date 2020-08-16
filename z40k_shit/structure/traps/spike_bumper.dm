/mob/living/simple_animal/hostile/spike_bumper
	name = "Spiked Bumper"
	desc = "It appears to be a spiked bumper, one that you probably should not by bumped by."
	icon = 'z40k_shit/icons/mob/mobs.dmi'
	icon_state = "spikebumper"
	icon_living = "spikebumper"
	faction = "void"
	icon_dead = null
	wander = FALSE
	speak_emote = list("screeches")
	response_help  = "thinks better of touching"
	response_disarm = "shoves"
	response_harm   = "hits"
	maxHealth = 5000
	health = 5000
	heat_damage_per_tick = 0//amount of damage applied if animal's body temperature is higher than maxbodytemp
	maxbodytemp = 12000
	melee_damage_lower = 10
	melee_damage_upper = 25
	attack_sound = 'z40k_shit/sounds/spike_ring.ogg'
	mob_property_flags = MOB_CONSTRUCT
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	anchored = 1
	a_intent = I_HURT


/mob/living/simple_animal/hostile/spike_bumper/Bumped(atom/thing)
	if(ismob(thing))
		if(isliving(thing))
			var/mob/living/M = thing
			if(M.faction == "void")
				return
			visible_message("<span class='warning'>\The [src] bumps into [M]!</span>")
			playsound(src, 'z40k_shit/sounds/spike_ring.ogg', 100, 1)
			M.adjustBruteLoss(rand(25,55))
			M.Knockdown(12)

//No damagies
/mob/living/simple_animal/hostile/spike_bumper/adjustFireLoss(damage)
	return 0
/mob/living/simple_animal/hostile/spike_bumper/adjustBruteLoss(damage)
	return 0

/mob/living/simple_animal/hostile/spike_bumper/attackby(var/obj/item/O, var/mob/user)
	if(ismob(user))
		if(isliving(user))
			var/mob/living/M = user
			visible_message("<span class='warning'>[user] foolishly hits \The [src]!</span>")
			playsound(src, 'z40k_shit/sounds/spike_ring.ogg', 100, 1)
			M.adjustBruteLoss(rand(25,55))
			M.Knockdown(12)

/mob/living/simple_animal/hostile/spike_bumper/to_bump(atom/Obstacle)
	Bumped(Obstacle)
	..()

/mob/living/simple_animal/hostile/spike_bumper/death(var/gibbed = FALSE)
	..(gibbed)

/mob/living/simple_animal/hostile/spike_bumper/ListTargets()
	return list()
	//return ..() This would make it function normally.