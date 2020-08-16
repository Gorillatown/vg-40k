/mob/living/simple_animal/hostile/manifest_ghost
	name = "spirit"
	real_name = "spirit"
	desc = "The soul of one of the fallen manifested in the warp."
	icon = 'z40k_shit/icons/mob/mobs.dmi'
	icon_state = "ghost"
	icon_living = "ghost"
	icon_dead = "shade_dead"
	speak_emote = list("murmers","wails")
	emote_hear = list("wails","screeches")
	response_help  = "passes through"
	response_disarm = "passes through"
	response_harm   = "passes through"
	attacktext = "sucks life from"
	maxHealth = 80
	health = 80
	harm_intent_damage = 0
	melee_damage_lower = 20
	melee_damage_upper = 50
	speed = -1
	stop_automated_movement = 1
	friendly = "passes through"

/mob/living/simple_animal/hostile/manifest_ghost/Life() //They need to be able to still see warp things.
	..()
	see_invisible = SEE_INVISIBLE_OBSERVER
	verbs.Remove(/mob/living/verb/ghost) //How can a ghost ghost?

/mob/living/simple_animal/hostile/manifest_ghost/Move(NewLoc, direct) //Warp walls block manifest ghosts, even if they are material.
	var/turf/destination = get_step(get_turf(src),direct)
	for(var/obj/effect/warp/W in range(destination, 0))
		if(W.ghost_density)
			dir = direct //Need to do that if we are just returning right here.
			return
	..(NewLoc, direct)

/mob/living/simple_animal/hostile/manifest_ghost/New(loc, ghost)
	..(loc)
	var/mob/dead/observer/O = ghost
	src.icon = O.icon
	src.icon_state = O.icon_state
	src.icon_living = O.icon_state
	src.name = O.name
	src.real_name = O.name
	src.key = O.key

/mob/living/simple_animal/hostile/manifest_ghost/death()
	to_chat(src,"<span class='warning'> Your manifest spirit in the warp is dispelled from this location.</span>")
	enter_warp(src.ghostize(0))
	qdel(src)

/mob/living/simple_animal/hostile/manifest_ghost/attack_animal(mob/living/simple_animal/M)
	if(M.melee_damage_upper == 0)
		M.emote("[M.friendly] [src]")
	else
		if(M.attack_sound)
			playsound(loc, M.attack_sound, 50, 1, 1)
		for(var/mob/O in viewers(src, null))
			O.show_message("<span class='warning'> \The [M] [M.attacktext] [src]!</span>", 1)
		add_logs(M, src, "attacked", admin=0)
		var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
		if(istype(M, /mob/living/simple_animal/hostile/retaliate/daemon)) //Even lesser daemonic beings are well suited to preying on the spirits of dead. The soul of a fallen should not be able to defeat an ebon geist.
			damage *= 5
		adjustBruteLoss(damage)

/proc/enter_warp(var/atom/movable/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/oldalpha = H.alpha
		H.alpha = 0
		H.canmove = 0
		anim(get_turf(H),H,'icons/mob/mob.dmi',,"liquify",,H.dir)
		sleep(14)
		H.alpha = oldalpha
		H.canmove = 1
	var/list/destinations = list()
	for(var/turf/unsimulated/wasteland/T in world)
		destinations.Add(T)
	if(M && M.loc)
		M.loc = pick(destinations)
	else
		if(usr)
			to_chat(usr, "<span class='warning'> Stop breaking shit!</span>")