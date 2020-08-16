
//Giving the spells
/mob/living/simple_animal/hostile/retaliate/daemon/daemonette/player/proc/give_blade_powers()
	if (!istype(loc, /obj/item/weapon/daemonweapon/blissrazor))
		return
	if (client)
		client.CAN_MOVE_DIAGONALLY = 1
		client.screen += list(
			gui_icons.soulblade_bgLEFT,
			gui_icons.soulblade_coverLEFT,
			gui_icons.soulblade_bloodbar,
			healths2,
			)
	//var/obj/item/weapon/daemonweapon/blissrazor/SB = loc
	add_spell(new /spell/daemonweapon/blade_kinesis, "cult_spell_ready", /obj/abstract/screen/movable/spell_master/bloodcult)
	add_spell(new /spell/daemonweapon/blade_spin, "cult_spell_ready", /obj/abstract/screen/movable/spell_master/bloodcult)
	add_spell(new /spell/daemonweapon/blade_mend, "cult_spell_ready", /obj/abstract/screen/movable/spell_master/bloodcult)
	add_spell(new /spell/daemonweapon/blade_boil, "cult_spell_ready", /obj/abstract/screen/movable/spell_master/bloodcult)
	add_spell(new /spell/daemonweapon/blade_possession, "cult_spell_ready", /obj/abstract/screen/movable/spell_master/bloodcult)

	verbs += /mob/living/simple_animal/hostile/retaliate/daemon/daemonette/player/verb/restrict_soul_movement
	verbs += /mob/living/simple_animal/hostile/retaliate/daemon/daemonette/player/verb/restrict_soul_casting
	verbs += /mob/living/simple_animal/hostile/retaliate/daemon/daemonette/player/verb/great_awakening

//Removing the spells, this should always fire when the shade gets removed from the blade, such as when it gets destroyed
/mob/living/simple_animal/hostile/retaliate/daemon/daemonette/player/proc/remove_blade_powers()
	if (client)
		client.CAN_MOVE_DIAGONALLY = 0
		client.screen -= list(
			gui_icons.soulblade_bgLEFT,
			gui_icons.soulblade_coverLEFT,
			gui_icons.soulblade_bloodbar,
			healths2,
			)
	if (hud_used && gui_icons && gui_icons.soulblade_coverLEFT)
		hud_used.mymob.gui_icons.soulblade_coverLEFT.maptext = ""
	for(var/spell/daemonweapon/spell_to_remove in spell_list)
		remove_spell(spell_to_remove)

	verbs -= /mob/living/simple_animal/hostile/retaliate/daemon/daemonette/player/verb/restrict_soul_movement
	verbs -= /mob/living/simple_animal/hostile/retaliate/daemon/daemonette/player/verb/restrict_soul_casting
	verbs -= /mob/living/simple_animal/hostile/retaliate/daemon/daemonette/player/verb/great_awakening

/*
	Im feelin awfully lazy
*/

/mob/living/simple_animal/hostile/retaliate/daemon/daemonette/player/verb/restrict_soul_movement()
	set name = "Restrict Soul Movement"
	set category = "Sword Control"

	if(istype(loc,/obj/item/weapon/daemonweapon/blissrazor))
		var/obj/item/weapon/daemonweapon/blissrazor/SB = loc
		SB.no_soul_piloting = !SB.no_soul_piloting
		to_chat(src, "<span class='notice'>Soul movement of your vessel is now [SB.no_soul_piloting ? "allowed" : "disallowed"].</span>")

/mob/living/simple_animal/hostile/retaliate/daemon/daemonette/player/verb/restrict_soul_casting()
	set name = "Restrict Soul Casting"
	set category = "Sword Control"

	if(istype(loc,/obj/item/weapon/daemonweapon/blissrazor))
		var/obj/item/weapon/daemonweapon/blissrazor/SB = loc
		SB.no_soul_casting = !SB.no_soul_casting
		to_chat(src, "<span class='notice'>Soul casting on whoever wields your vessel is now [SB.no_soul_casting ? "allowed" : "disallowed"].</span>")

/mob/living/simple_animal/hostile/retaliate/daemon/daemonette/player/verb/great_awakening()
	set name = "Great Awakening"
	set category = "Sword Control"

	if(istype(loc,/obj/item/weapon/daemonweapon/blissrazor))
		var/obj/item/weapon/daemonweapon/blissrazor/SB = loc
		if(SB.soul_count >= 15)
			var/mob/living/simple_animal/hostile/retaliate/daemon/possessedsword/niceguy = new(get_turf(SB))
			niceguy.ckey = src.ckey
			SB.forceMove(niceguy)
			for(var/mob/living/simple_animal/hostile/bitchspirit/ouch in SB.soul_list)
				ouch.forceMove(niceguy)



