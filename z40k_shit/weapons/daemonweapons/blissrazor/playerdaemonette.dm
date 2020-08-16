/mob/living/simple_animal/hostile/retaliate/daemon/daemonette/player
	name = "Daemonette"
	real_name = "Daemonette"
	icon = 'z40k_shit/icons/mob/daemon.dmi'
	icon_state = "daemonette"
	icon_living = "daemonette"
	icon_dead = "daemon_remains"
	harm_intent_damage = 0
	maxHealth = 20000
	health = 20000
	melee_damage_lower = 50
	melee_damage_upper = 150
	stop_automated_movement = TRUE

//As odd as it sounds, I'm basically gonna make someone releasing a daemonette from the sword a awful idea.
//Well unless you really want a 20k health daemonette walking around.
/*
	Welcome to a mix of copy pasted shitcode, we can hand the daemonette the hud in the weapon
*/

/mob/living/simple_animal/hostile/retaliate/daemon/daemonette/player/Login()
	..()
	hud_used.shade_hud()
	if (istype(loc, /obj/item/weapon/daemonweapon/blissrazor))
		client.CAN_MOVE_DIAGONALLY = 1
		client.screen += list(
			gui_icons.soulblade_bgLEFT,
			gui_icons.soulblade_coverLEFT,
			gui_icons.soulblade_bloodbar,
			)

/mob/living/simple_animal/hostile/retaliate/daemon/daemonette/player/Life()
	if(timestopped)
		return FALSE //under effects of time magick
	..()
	regular_hud_updates()
	if(isDead())
		for(var/i=0;i<3;i++)
			new /obj/item/weapon/ectoplasm (src.loc)
		visible_message("<span class='warning'> [src] lets out a contented sigh as their form unwinds.</span>")
		ghostize()
		qdel(src)
		return

	if(istype(loc,/obj/item/weapon/daemonweapon/blissrazor))
		var/obj/item/weapon/daemonweapon/blissrazor/SB = loc
		if(istype(SB.loc,/mob/living))
			if(SB.blood < SB.maxblood)
				SB.blood++
		else if(SB.blood < SB.maxregenblood)
			SB.blood++

/mob/living/simple_animal/hostile/retaliate/daemon/daemonette/player/regular_hud_updates()
	update_pull_icon() //why is this here?

	if(istype(loc, /obj/item/weapon/daemonweapon/blissrazor) && hud_used && gui_icons && gui_icons.soulblade_bloodbar)
		var/obj/item/weapon/daemonweapon/blissrazor/SB = loc
/*		if(healths2)
			switch(SB.health)
				if(-INFINITY to 18)
					healths2.icon_state = "blade_reallynotok"
				if(18 to 36)
					healths2.icon_state = "blade_notok"
				if(36 to INFINITY)
					healths2.icon_state = "blade_ok"*/
		var/matrix/M = matrix()
		M.Scale(1,SB.blood/SB.maxblood)
		var/total_offset = (60 + (100*(SB.blood/SB.maxblood))) * PIXEL_MULTIPLIER
		hud_used.mymob.gui_icons.soulblade_bloodbar.transform = M
		hud_used.mymob.gui_icons.soulblade_bloodbar.screen_loc = "WEST,CENTER-[8-round(total_offset/WORLD_ICON_SIZE)]:[total_offset%WORLD_ICON_SIZE]"
		hud_used.mymob.gui_icons.soulblade_coverLEFT.maptext = "[SB.blood]"


/mob/living/simple_animal/hostile/retaliate/daemon/daemonette/ClickOn(var/atom/A, var/params)
	if (istype(loc, /obj/item/weapon/daemonweapon/blissrazor))
		var/obj/item/weapon/daemonweapon/blissrazor/SB = loc
		SB.dir = get_dir(get_turf(SB), A)
		var/spell/soulblade/blade_spin/BS = locate() in spell_list
		if(BS)
			BS.perform(src)
			return
	..()


/mob/living/simple_animal/hostile/retaliate/daemon/daemonette/player/attack_animal(mob/living/simple_animal/M)
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

/mob/living/simple_animal/hostile/retaliate/daemon/daemonette/player/attempt_suicide(forced = FALSE, suicide_set = TRUE)
	if(!forced)
		var/confirm = alert("Are you sure you want to go to sleep?.", "Confirm Suicide", "Yes", "No")

		if(!confirm == "Yes")
			return

		if(stat != CONSCIOUS)
			to_chat(src, "<span class='warning'>You can't perform the sealing ritual in this state!</span>")
			return

		log_attack("<span class='danger'>[key_name(src)] has sealed itself via the suicide verb.</span>")

	if(suicide_set)
		suiciding = TRUE

	visible_message("<span class='danger'>[src] shudders violently for a moment, then becomes motionless, its aura fading. </span>")
	death()

/mob/living/simple_animal/hostile/retaliate/daemon/daemonette/player/death(var/gibbed = FALSE)
	if(istype(loc, /obj/item/weapon/daemonweapon/blissrazor))
		var/obj/item/weapon/daemonweapon/blissrazor/C = loc
		C.daemon_inside = FALSE
		C.update_icon()
	..(gibbed)
