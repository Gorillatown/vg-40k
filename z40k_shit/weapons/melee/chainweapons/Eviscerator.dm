
/*
 * Eviscerator
 */
/obj/item/projectile/fire_breath/eviscerator //The fire projectile we will use, cap it to 4 turfs.
	fire_blast_type = /obj/effect/fire_blast/no_spread
	fire_sound = null
	max_range = 4

/obj/item/weapon/gun/projectile/eviscerator
	name = "Eviscerator"
	desc = "A oversized chainsword. This one has a exterminator attached to it too."
	slot_flags = SLOT_BACK
	icon = 'z40k_shit/icons/obj/ig/IGequipment.dmi'
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/64x64eviscerator.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/64x64eviscerator.dmi')
	icon_state = "eviscerator_off" 
	item_state = "eviscerator_off"
	throwforce = 35
	force = 50
	armor_penetration = 100
	throw_speed = 5
	throw_range = 10
	sharpness = 50
	sharpness_flags = SHARP_TIP | SHARP_BLADE | CHOPWOOD | CUT_WALL | CUT_AIRLOCK //it's a really sharp blade m'kay
	w_class = W_CLASS_LARGE
	flags = TWOHANDABLE | MUSTTWOHAND
	hitsound = 'z40k_shit/sounds/chainsword_evishit.ogg'
	fire_sound = null
	var/revvin_on = FALSE //Are we currently on?
	var/idle_loop = 0 //Our holder for process() ticks and the idle sound firing
	var/max_fuel = 500 //The max amount of fuel this can hold
	var/start_fueled = TRUE // Do we start fueled
	var/firstrev = TRUE //To handle the first rev noise and not allow spam of it.
	fire_sound = null
	ejectshell = 0
	caliber = null
	ammo_type = null
	fire_sound = null
	conventional_firearm = 0
	silenced = 1
	recoil = 0
	actions_types = list(/datum/action/item_action/warhams/begin_sawing,
						/datum/action/item_action/warhams/basic_swap_stance)

/obj/item/weapon/gun/projectile/eviscerator/interpret_powerwords(mob/living/target, mob/living/user, def_zone, var/originator = null)
	..()
	var/mob/living/carbon/human/H = user
	var/mob/living/carbon/human/T = target
	switch(H.word_combo_chain)
		if("hurthurthurthurthurt")
			user.visible_message("<span class='danger'>[H] swings and cleaves everything in front of them!")
			H.stat_increase(ATTR_STRENGTH,25)
			var/turf/starter = get_step(user,user.dir)
			var/turf/sideone = get_step(starter,turn(user.dir,90))
			var/turf/sidetwo = get_step(starter,turn(user.dir,-90))
			for(var/turf/RAAAGH in list(starter, sideone, sidetwo))
				for(var/mob/living/MENS in RAAAGH)
					H.health += 10
					MENS.attackby(src,user)
			H.word_combo_chain = ""
			H.update_powerwords_hud(clear = TRUE)
		if("sawhurtchargehurt")
			user.visible_message("<span class='danger'>[H] continues their frenzy of violence!")
			H.stat_increase(ATTR_SENSITIVITY,25)
			T.attackby(src,user)
			H.health += 25
			H.word_combo_chain = ""
			H.update_powerwords_hud(clear = TRUE)

/obj/item/weapon/gun/projectile/eviscerator/New() //We need to get our own process loop started for sounds
	..()
	processing_objects.Add(src)
	create_reagents(max_fuel)
	if(start_fueled)
		reagents.add_reagent(FUEL, max_fuel)

/obj/item/weapon/gun/projectile/eviscerator/Destroy()
	processing_objects.Remove(src)
	..()

/obj/item/weapon/gun/projectile/eviscerator/process()
	if(revvin_on)
		idle_loop++
	if(idle_loop >= 1)
		idle_loop = 0
		playsound(src,'z40k_shit/sounds/Chainsword_Idle.ogg',50)
		if(!firstrev)
			firstrev = TRUE

/obj/item/weapon/gun/projectile/eviscerator/examine(mob/user)
	..()
	to_chat(user, "<span class='info'> Has [max_fuel] unit\s of fuel remaining.</span>")

/obj/item/weapon/gun/projectile/eviscerator/IsShield()
	return 1

/obj/item/weapon/gun/projectile/eviscerator/attack_self(var/mob/user) //If we click this, we ignite it.
	if(revvin_on)
		revvin_on = FALSE
		update_icon()
	else
		revvin_on = TRUE
		update_icon()
		if(firstrev)
			firstrev = FALSE
			playsound(src,'z40k_shit/sounds/Chainsword_Idle.ogg',50)

/obj/item/weapon/gun/projectile/eviscerator/unequipped(mob/user)
	if(revvin_on)
		revvin_on = FALSE
		update_icon()
	..()

/obj/item/weapon/gun/projectile/eviscerator/dropped(mob/user)
	if(revvin_on)
		revvin_on = FALSE
		update_icon()
	..()

/obj/item/weapon/gun/projectile/eviscerator/proc/get_fuel()
	return reagents.get_reagent_amount(FUEL)

/obj/item/weapon/gun/projectile/eviscerator/afterattack(atom/target, mob/user, flag)
	if (istype(target, /obj/structure/reagent_dispensers/fueltank) && get_dist(src,target) <= 1 && !src.revvin_on)
		if(target.reagents.trans_to(src, max_fuel))
			to_chat(user, "<span class='notice'>Exterminator refueled.</span>")
			playsound(src, 'sound/effects/refill.ogg', 50, 1, -6)
		else if(!target.reagents)
			to_chat(user, "<span class='notice'>\The [target] is empty.</span>")
		else
			to_chat(user, "<span class='notice'>\The [src] is already full.</span>")
		return
	else if (istype(target, /obj/structure/reagent_dispensers/fueltank) && get_dist(src,target) <= 1 && src.revvin_on)
		message_admins("[key_name_admin(user)] triggered a fueltank explosion.")
		log_game("[key_name(user)] triggered a fueltank explosion.")
		to_chat(user, "<span class='warning'>That was stupid of you.</span>")
		var/obj/structure/reagent_dispensers/fueltank/tank = target
		tank.explode()
		return
	if(!revvin_on)
		return
	if(!prefire_check(user, 1))
		return

	var/obj/item/projectile/fire_breath/eviscerator/B = new(null)
	in_chamber = B
	if(get_fuel() <= 0) 
		user.visible_message("<span class='danger'>\The [src] hisses.</span>")
		to_chat(user, "<span class='warning'>It sounds like the tank is empty.</span>")
		qdel(B)
		in_chamber = null
		return
	if(Fire(target,user))
		user.visible_message("<span class='danger'>[user] shoots a jet of gas from \his [src.name]!</span>","<span class='danger'>You shoot a jet of gas from your [src.name]!</span>")
		reagents.remove_reagent(FUEL, 50)
		playsound(user, 'sound/weapons/flamethrower.ogg', 50, 1)

/obj/item/weapon/gun/projectile/eviscerator/update_icon()
	var/mob/living/carbon/human/H = loc
	if(istype(loc,/mob/living/carbon/human))
		if(revvin_on)
			icon_state = "eviscerator_on"
			item_state = "eviscerator_on"
			H.update_inv_hands()
		else
			icon_state = "eviscerator_off"
			item_state = "eviscerator_off"
			H.update_inv_hands()
