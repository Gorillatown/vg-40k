/mob/living/simple_animal/hostile/shadow  //A corrupted person to guard daemon weapons.
	name = "Warped Guardsman"
	desc = "A twisted, shadowed, and warp consumed creature that appears to have once been a regular human."
	icon = 'z40k_shit/icons/mob/mobs.dmi'
	icon_state = "shadow"
	icon_living = "shadow"
	icon_dead = "shadow_dead"
	speak_chance = 0
	turns_per_move = 5
	response_help = "passes through"
	response_disarm = "shoves"
	response_harm = "hits"
	speed = 0
	maxHealth = 110
	health = 110

	harm_intent_damage = 10
	melee_damage_lower = 15
	melee_damage_upper = 25
	attacktext = "strikes"
	attack_sound = 'sound/hallucinations/growl1.ogg'

	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0

	stop_automated_movement = 1

	faction = "void"

/mob/living/simple_animal/hostile/shadow/FindTarget()
	. = ..()
	if(.)
		emote("screams at [.]")
		var/sound = pick('sound/hallucinations/i_see_you1.ogg','sound/hallucinations/i_see_you2.ogg','sound/hallucinations/im_here1.ogg','sound/hallucinations/im_here2.ogg')
		playsound(src.loc, sound, 50, 1)

/mob/living/simple_animal/hostile/shadow/AttackingTarget()
	. =..()
	var/mob/living/L = .
	if(istype(L))
		to_chat(L,"<span class='warning'> The [src]'s spectral hands burn!</span>")
		if(prob(20))
			L.apply_effects(0,3)
			L.visible_message("<span class='danger'>\The [src] knocks down \the [L]!</span>")