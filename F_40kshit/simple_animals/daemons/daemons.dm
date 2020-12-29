
/mob/living/simple_animal/hostile/retaliate/daemon
	name = "spirit"
	real_name = "spirit"
	desc = "A malevolent presence."
	icon = 'F_40kshit/icons/mob/mobs.dmi'
	icon_state = "void_demon"
	icon_living = "void_demon"
	icon_dead = "daemon_remains"
	layer = 4
	blinded = 0
	anchored = 1	//  don't get pushed around
	density = 1
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
	speed = 1
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
	var/mob/living/carbon/human/possessed = null //If we have possessed a human. We need to hold a REF anyways
	var/mob/living/captive_holder = null //Basically safety so we don't eject someone out of the server
	var/next_possess_mechanics = null
	faction = "void"

/mob/living/simple_animal/hostile/retaliate/daemon/New()
	..()
	verbs -= /mob/living/simple_animal/hostile/retaliate/daemon/proc/assert_control

/mob/living/simple_animal/hostile/retaliate/daemon/examine(mob/user)
	..()
	if(!client)
		to_chat(user, "<span class='warning'>The expression upon its face doesn't appear to have much intelligence showing.</span>")

/mob/living/simple_animal/hostile/retaliate/daemon/Destroy()
	possessed = null //Make sure to remove it
	if(captive_holder.client && captive_holder.mind)
		captive_holder.ghostize()
	qdel(captive_holder)
	captive_holder = null
	..()

/mob/living/simple_animal/hostile/retaliate/daemon/Life()
	..()

	daemon_checks()

/mob/living/simple_animal/hostile/retaliate/daemon/proc/handle_possession(var/possessing_or_leaving = 1) //TODO: Handle possession and unpossession
	if(possessed)
		if(!captive_holder)
			captive_holder = new(src)
			verbs += /mob/living/simple_animal/hostile/retaliate/daemon/proc/assert_control
		
		if(possessing_or_leaving)
			if(possessed.mind)
				possessed.mind.transfer_to(captive_holder)
			mind.transfer_to(possessed)
		
		else
			possessed.mind.transfer_to(src)
			if(captive_holder.mind)
				captive_holder.mind.transfer_to(possessed)

/mob/living/simple_animal/hostile/retaliate/daemon/proc/assert_control()
	set name = "Assert Control"
	set desc = "Asset Control over the host."
	set category = "Daemon"
	
	if(!possessed)
		to_chat(src, "<span class='info'>You aren't possessing anything.</span>")
		return
	
	if(world.time > next_possess_mechanics)
		next_possess_mechanics = world.time+5 MINUTES
		handle_possession(TRUE)
		to_chat(src, "<span class='info'>You assert control over the host momentarily</span>")
		spawn(2 MINUTES)
			handle_possession(FALSE)


/mob/living/simple_animal/hostile/retaliate/daemon/proc/daemon_checks()
	return
