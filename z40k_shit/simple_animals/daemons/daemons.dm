
/mob/living/simple_animal/hostile/retaliate/daemon
	name = "spirit"
	real_name = "spirit"
	desc = "A malevolent presence."
	icon = 'z40k_shit/icons/mob/mobs.dmi'
	icon_state = "void_demon"
	icon_living = "void_demon"
	icon_dead = "daemon_remains"
	layer = 4
	blinded = 0
	anchored = 1	//  don't get pushed around
	density = 0
	//invisibility = INVISIBILITY_OBSERVER //This is what makes it a proper spirit.
	see_invisible = SEE_INVISIBLE_OBSERVER //Daemons can see into the immaterial world, I should think.
	maxHealth = 500
	health = 500
	speak_emote = list("hisses")
	emote_hear = list("wails","screeches")
	response_help  = "thinks better of touching"
	response_disarm = "shoves"
	response_harm   = "hits"
	harm_intent_damage = 5
	melee_damage_lower = 50
	melee_damage_upper = 150
	attacktext = "flogs"
	attack_sound = 'sound/hallucinations/growl1.ogg'
	speed = 0
	stop_automated_movement = 1
	status_flags = 0
	environment_smash_flags = 0
	min_oxy = 5
	max_oxy = 0
	min_tox = 0
	max_tox = 1
	min_co2 = 0
	max_co2 = 5
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	maxbodytemp = 450 //A good fire would hurt one, but not something small.
	heat_damage_per_tick = 15	//amount of damage applied if animal's body temperature is higher than maxbodytemp
	cold_damage_per_tick = 10	//same as heat_damage_per_tick, only if the bodytemperature it's lower than minbodytemp
	unsuitable_atoms_damage = 10

	faction = "void"

/mob/living/simple_animal/hostile/retaliate/daemon/examine(mob/user)
	..()
	if(!client)
		to_chat(user, "<span class='warning'>The expression upon its face doesn't appear to have much intelligence showing.</span>")

/mob/living/simple_animal/hostile/retaliate/daemon/Life()
	..()
	daemon_checks()

/mob/living/simple_animal/hostile/retaliate/daemon/proc/daemon_checks()
	return

/mob/living/simple_animal/hostile/retaliate/daemon/Move(NewLoc, direct) //Daemons are blocked by psychic walls too.
	var/turf/destination = get_step(get_turf(src),direct)
	for(var/obj/effect/warp/W in range(destination, 0)) //Ghost walls. For no particular reason. -Drake
		if(W.ghost_density)
			return
	..(NewLoc, direct)

