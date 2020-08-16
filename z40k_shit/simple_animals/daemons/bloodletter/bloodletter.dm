/mob/living/simple_animal/hostile/retaliate/daemon/bloodletter
	name = "Bloodletter"
	real_name = "Bloodletter"
	icon = 'z40k_shit/icons/mob/daemon.dmi'
	icon_state = "bloodletter"
	icon_living = "bloodletter"
	icon_dead = "daemon_remains"
	maxHealth = 650
	health = 650
	harm_intent_damage = 0
	melee_damage_lower = 100
	melee_damage_upper = 150
	speed = 0
	move_to_delay = 2
	alpha = 240
	attacktext = "mauls"

/mob/living/simple_animal/hostile/retaliate/daemon/bloodletter/attack_animal(mob/living/simple_animal/M) //A real daemon that isn't some lesser warp creature is particularly resistant to shades.
	if(M.melee_damage_upper == 0)
		M.emote("[M.friendly] [src]")
	else
		if(M.attack_sound)
			playsound(loc, M.attack_sound, 50, 1, 1)
		for(var/mob/O in viewers(src, null))
			O.show_message("<span class='warning'>\The [M] [M.attacktext] [src]!</span>", 1)
		var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
		if(istype(M, /mob/living/simple_animal/hostile/manifest_ghost))
			damage /= 4
		adjustBruteLoss(damage)
