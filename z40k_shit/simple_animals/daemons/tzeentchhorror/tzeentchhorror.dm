/mob/living/simple_animal/hostile/retaliate/daemon/tzeenchhorror
	name = "Horror of Tzeench"
	real_name = "Horror of Tzeench"
	speed = -1
	move_to_delay = 1
	harm_intent_damage = 0
	speak_chance = 5
	speak_emote = list("giggles", "laughs", "chuckles")
	attacktext = "curses"
	alpha = 150
	var/horror_color = "#FF0088"

/mob/living/simple_animal/hostile/retaliate/daemon/tzeenchhorror/attack_animal(mob/living/simple_animal/M)
	if(M.melee_damage_upper == 0)
		M.emote("[M.friendly] [src]")
	else
		if(M.attack_sound)
			playsound(loc, M.attack_sound, 50, 1, 1)
		for(var/mob/O in viewers(src, null))
			O.show_message("<span class='warning'> \The [M] [M.attacktext] [src]!</span>", 1)
		add_logs(M, src, "attacked", admin=0)
		var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
		if(istype(M, /mob/living/simple_animal/hostile/manifest_ghost))
			damage /= 4
		adjustBruteLoss(damage)

/mob/living/simple_animal/hostile/retaliate/daemon/tzeenchhorror/Life()
	..()
	if(src.stat == DEAD) 
		return
	if(src.horror_color == "FF0088" && src.stance == HOSTILE_STANCE_ATTACK)
		for(var/mob/living/carbon/C in range(src, 1))
			if(C in src.enemies)
				C.fire_stacks += 1
				C.IgniteMob()
	if(prob(25))
		for(var/mob/living/target in range(5, get_turf(src)))
			src.icon = target.icon
			src.icon_state = target.icon_state
			src.overlays = target.overlays
			src.color = horror_color
//			src.GlichAnimation(changecolor = 0)

/mob/living/simple_animal/hostile/retaliate/daemon/tzeenchhorror/blue
	speed = 2
	move_to_delay = 4
	horror_color = "0000FF"
	speak_emote = list("scowls")
	maxHealth = 150
	health = 150
	melee_damage_lower = 20
	melee_damage_upper = 40
	attacktext = "chokes"

/atom/proc/GlichAnimation(speed = 10, loops = 1, changecolor = 1) //An animation for decayed cameleoline to make things get pretty screwy.
	var/matrix/m30 = matrix(transform)
	m30.Turn(30)
	var/matrix/m90 = matrix(transform)
	m90.Turn(90)
	var/matrix/m120 = matrix(transform)
	m120.Turn(120)
	var/matrix/mn30 = matrix(transform)
	mn30.Turn(330)
	var/matrix/mn90 = matrix(transform)
	mn90.Turn(270)
	var/matrix/mn120 = matrix(transform)
	mn120.Turn(240)
	speed /= 3
	for(var/loop = 1, loop<=loops, loop++)
		sleep(5)
		src.pixel_y = rand(-20,20)
		src.pixel_x = rand(-20,20)
		if(changecolor) src.color = pick("#C73232","#5998FF","#2A9C3B","#CFB52B","#AE4CCD","#FFFFFF","#333333")
		var/selection = rand(1,6)
		switch(selection)
			if(1)
				animate(src, transform = m30, time = speed)
			if(2)
				animate(src, transform = m90, time = speed)
			if(3)
				animate(src, transform = m120, time = speed)
			if(4)
				animate(src, transform = mn30, time = speed)
			if(5)
				animate(src, transform = mn90, time = speed)
			if(6)
				animate(src, transform = mn120, time = speed)
	src.pixel_y = 0
	src.pixel_x = 0
	animate(src, transform = initial(src.transform), time = speed) //set us back in the regular orientation
	spawn(5)
		src.color = initial(src.color)
		