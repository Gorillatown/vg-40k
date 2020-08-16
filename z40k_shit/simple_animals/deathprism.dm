/mob/living/simple_animal/hostile/deathprism
	name = "Prism"
	desc = "Its an odd floating prism, perhaps you shouldn't touch it."
	icon = 'z40k_shit/icons/mob/mobs.dmi'
	icon_state = "deathprism"
	icon_living = "deathprism"
	faction = "void"
	icon_dead = null
	wander = FALSE
	speak_emote = list("whirrs")
	response_help = "fucks"
	response_disarm = "fucks"
	response_harm = "fucks"
	maxHealth = 5000
	health = 5000
	heat_damage_per_tick = 0	//amount of damage applied if animal's body temperature is higher than maxbodytemp
	maxbodytemp = 12000
	melee_damage_lower = 10
	melee_damage_upper = 25
	attack_sound = "sound/effects/rattling_bones.ogg"
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

/mob/living/simple_animal/hostile/deathprism/Bumped(atom/thing)
	if(ismob(thing))
		if(isliving(thing))
			var/mob/living/M = thing
			if(M.faction == "void")
				return
			visible_message("<span class='warning'>\The [src] disintigrates [thing]!</span>")
			M.dust()

//No damagies
/mob/living/simple_animal/hostile/deathprism/adjustFireLoss(damage)
	return 0
/mob/living/simple_animal/hostile/deathprism/adjustBruteLoss(damage)
	return 0

/mob/living/simple_animal/hostile/deathprism/attackby(var/obj/item/O, var/mob/user)
	if(ismob(user))
		visible_message("<span class='warning'>\The [src] disintigrates [user]!</span>")
		user.dust()

/mob/living/simple_animal/hostile/deathprism/to_bump(atom/Obstacle)
	Bumped(Obstacle)
	..()

/mob/living/simple_animal/hostile/deathprism/death(var/gibbed = FALSE)
	..(gibbed)

/mob/living/simple_animal/hostile/deathprism/ListTargets()
	return list()
	//return ..() This would make it function normally.