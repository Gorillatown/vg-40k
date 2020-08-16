/mob/living/simple_animal/hostile/retaliate/daemon/lesser
	name = "wight"
	real_name = "wight"
	icon = 'z40k_shit/icons/mob/chaosspawn.dmi'
	icon_state = "ws"
	icon_living = "ws"
	icon_dead = "ws_dead"
	attacktext = "drains life from"
	maxHealth = 40
	health = 40
	melee_damage_lower = 10
	melee_damage_upper = 20
	density = 1

/mob/living/simple_animal/hostile/retaliate/daemon/lesser/Life()
	..()
	for(var/mob/living/M in range(7, src))
		if(M != src && M.stat != DEAD && !(M.faction == "void"))
			enemies.Add(M)
			emote("hisses at \the [M]")
			playsound(src.loc, 'sound/hallucinations/veryfar_noise.ogg', 50, 1)
	if(prob(5)) //Becomes visible for a moment.
		invisibility = 0
		spawn(15)
			invisibility = INVISIBILITY_OBSERVER
			