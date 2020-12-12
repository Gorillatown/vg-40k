/mob/living/simple_animal/hostile/retaliate/warpentity/hulk
	name = "neverborn"
	real_name = "neverborn"
	maxHealth = 300
	health = 300

/mob/living/simple_animal/hostile/retaliate/warpentity/hulk/Life()
	..()
	for(var/mob/living/M in range(7, src))
		if(M != src && M.stat != DEAD && !(M.faction == "void"))
			enemies.Add(M)
			emote("hisses at \the [M]")
			playsound(src.loc, 'sound/hallucinations/veryfar_noise.ogg', 50, 1)
	if(prob(25)) //Becomes visible (and actually damagable) for a moment.
		invisibility = 0
		density = 1
		spawn(25)
			density = 0
			invisibility = INVISIBILITY_OBSERVER
			