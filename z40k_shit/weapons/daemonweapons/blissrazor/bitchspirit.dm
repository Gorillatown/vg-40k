//Basically, this is a container for bitches, aka you lmao
/mob/living/simple_animal/hostile/bitchspirit
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

	//Ability handlers
	//Basically this lets us like, not suddenly murder the wielder rapidly.
	var/spirit_charge = 0 //Our spirit charge
	var/spirit_ticker = 0 //Ticker

/mob/living/simple_animal/hostile/bitchspirit/Life() //They need to be able to still see warp things.
	..()
	spirit_ticker++
	if((spirit_ticker >= 20) && (spirit_charge <= 4))
		spirit_charge ++

/mob/living/simple_animal/hostile/bitchspirit/New(loc, ghost)
	..(loc)

/mob/living/simple_animal/hostile/bitchspirit/Stat()
	..()
	if(statpanel("Status"))
		stat("Spirit Energy", spirit_charge)

/mob/living/simple_animal/hostile/bitchspirit/death(var/gibbed = FALSE)
	if(istype(loc, /obj/item/weapon/daemonweapon/blissrazor))
		var/obj/item/weapon/daemonweapon/blissrazor/C = loc
		C.soul_count -= 1
		C.soul_list -= src
	..(gibbed)

/mob/living/simple_animal/hostile/bitchspirit/attack_animal(mob/living/simple_animal/M)
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

