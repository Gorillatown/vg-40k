/mob/living/simple_animal/hostile/retaliate/daemon/plaguebearer
	name = "Plaguebearer"
	real_name = "Plaguebearer"
	icon = 'z40k_shit/icons/mob/daemon.dmi'
	icon_state = "plaguebearer"
	icon_living = "plaguebearer"
	icon_dead = "daemon_remains"
	maxHealth = 850
	health = 850
	speed = 1
	move_to_delay = 5
	melee_damage_lower = 50
	melee_damage_upper = 100

/mob/living/simple_animal/hostile/retaliate/daemon/plaguebearer/attack_animal(mob/living/simple_animal/M)
	if(M.melee_damage_upper == 0)
		M.emote("[M.friendly] [src]")
	else
		if(M.attack_sound)
			playsound(loc, M.attack_sound, 50, 1, 1)
		for(var/mob/O in viewers(src, null))
			O.show_message("<span class='warning'> \The [M] [M.attacktext] [src]!</span>", 1)
		var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
		if(istype(M, /mob/living/simple_animal/hostile/manifest_ghost))
			damage /= 4
		adjustBruteLoss(damage)
