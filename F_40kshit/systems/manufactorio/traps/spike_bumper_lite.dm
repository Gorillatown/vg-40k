/mob/living/simple_animal/hostile/spike_bumper_lite
	name = "Spiked Bumper"
	desc = "It appears to be a spiked bumper, one that you probably should not by bumped by."
	icon = 'F_40kshit/icons/mob/mobs.dmi'
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
	attack_sound = 'F_40kshit/sounds/spike_ring.ogg'
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


/mob/living/simple_animal/hostile/spike_bumper_lite/Bumped(atom/thing)
	if(ismob(thing))
		if(isliving(thing))
			var/mob/living/M = thing
			visible_message("<span class='warning'>\The [src] bumps into [M]!</span>")
			playsound(src, 'F_40kshit/sounds/spike_ring.ogg', 100, 1)
			M.adjustBruteLoss(rand(5,15))
			M.Knockdown(12)

//No damagies
/mob/living/simple_animal/hostile/spike_bumper_lite/adjustFireLoss(damage)
	return 0

/mob/living/simple_animal/hostile/spike_bumper_lite/adjustBruteLoss(damage)
	return 0

/mob/living/simple_animal/hostile/spike_bumper_lite/attackby(var/obj/item/O, var/mob/user)
	if(istype(O,/obj/item/weapon/wrench))
		O.playtoolsound(src, 50)
		if(do_mob(user, src, 60))
			if(anchored)
				visible_message("<span class='warning'>[user] unanchors \The [src]!</span>")
			else
				visible_message("<span class='warning'>[user] anchors \The [src]!</span>")
			anchored = !anchored
	else
		if(ismob(user))
			if(isliving(user))
				var/mob/living/M = user
				visible_message("<span class='warning'>[user] foolishly hits \The [src]!</span>")
				playsound(src, 'F_40kshit/sounds/spike_ring.ogg', 100, 1)
				M.adjustBruteLoss(rand(5,15))
				M.Knockdown(12)

/mob/living/simple_animal/hostile/spike_bumper_lite/to_bump(atom/Obstacle)
	Bumped(Obstacle)
	..()

/mob/living/simple_animal/hostile/spike_bumper_lite/death(var/gibbed = FALSE)
	..(gibbed)

/mob/living/simple_animal/hostile/spike_bumper_lite/ListTargets()
	return list()
	//return ..() This would make it function normally.