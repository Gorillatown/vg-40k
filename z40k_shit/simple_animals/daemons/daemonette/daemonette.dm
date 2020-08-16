/mob/living/simple_animal/hostile/retaliate/daemon/daemonette
	name = "Daemonette"
	real_name = "Daemonette"
	icon = 'z40k_shit/icons/mob/daemon.dmi'
	icon_state = "daemonette"
	icon_living = "daemonette"
	icon_dead = "daemon_remains"
	harm_intent_damage = 0

/mob/living/simple_animal/hostile/retaliate/daemon/daemonette/attack_animal(mob/living/simple_animal/M)
	if(M.melee_damage_upper == 0)
		M.emote("[M.friendly] [src]")
	else
		if(M.attack_sound)
			playsound(loc, M.attack_sound, 50, 1, 1)
		for(var/mob/O in viewers(src, null))
			O.show_message("<span class='warning'>\The [M] [M.attacktext] [src]!</span>", 1)
		add_logs(M, src, "attacked", admin=0)
		var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
		if(istype(M, /mob/living/simple_animal/hostile/manifest_ghost))
			damage /= 4
		adjustBruteLoss(damage)