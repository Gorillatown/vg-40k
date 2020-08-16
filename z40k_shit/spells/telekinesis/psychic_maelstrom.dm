/spell/targeted/projectile/psychic_maelstrom
	name = "Psychic Maelstrom"
	desc = "Witchfire - Bring forth a destructive Psychic Maelstrom."
	abbreviation = "PSYM"
	user_type = USER_TYPE_PSYKER
	specialization = SSTELEKINESIS

	proj_type = /obj/item/projectile/spell_projectile/psychic_maelstrom
	school = "evocation"
	projectile_speed = 1
	duration = 20

	var/ex_severe = -1
	var/ex_heavy = 1
	var/ex_light = 2
	var/ex_flash = 5
	var/SHEER_POWER = 2 //SHEEEEEEEEER POWER

	charge_max = 100
	invocation_type = SpI_NONE
	spell_flags = WAIT_FOR_CLICK
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	override_base = "ork"
	hud_state = "psychic_maelstrom"
	cast_prox_range = 2
	warpcharge_cost = 170

/spell/targeted/projectile/psychic_maelstrom/cast(list/targets, mob/living/user = usr)
	SHEER_POWER = SHEER_POWER+round(user.attribute_sensitivity/500)
	if(user.attribute_willpower >= 15)
		ex_severe = 1
		ex_heavy = 2
		ex_light = 4
		ex_flash = 5
	..()

//Basically it runs this when its in range to do shit.
/spell/targeted/projectile/psychic_maelstrom/prox_cast(var/list/targets, var/obj/item/projectile/spell_projectile/spell_holder)
	set waitfor = 0
	spell_holder.visible_message("<span class='danger'>\The [spell_holder] suddenly erupts into a psychic maelstrom!</span>")
	var/turf/ourturf = get_turf(spell_holder)
	var/list/mofugga = list()
	explosion(ourturf, ex_severe, ex_heavy, ex_light, ex_flash)
	
	for(var/turf/T in range(SHEER_POWER,ourturf))
		var/obj/effect/psychic_maelstrom/nigguh = new(T)
		mofugga += nigguh

	sleep(3 SECONDS)
	
	for(var/obj/effect/psychic_maelstrom/muhdik in mofugga)
		qdel(muhdik)

/spell/targeted/projectile/psychic_maelstrom/choose_prox_targets(mob/user = usr, var/atom/movable/spell_holder)
	var/list/targets = ..()
	for(var/mob/living/M in targets)
		if(M.stat == DEAD) //no dead targets
			targets.Remove(M)
	return targets

/spell/targeted/projectile/psychic_maelstrom/is_valid_target(var/atom/target)
	if(!istype(target))
		return 0
	if(target == holder)
		return 0

	return (isturf(target) || isturf(target.loc))

//Our projectile.
/obj/item/projectile/spell_projectile/psychic_maelstrom
	name = "Psychic Maelstrom"
	icon_state = "fireball"
	animate_movement = 2
	linear_movement = 0

/obj/item/projectile/spell_projectile/psychic_maelstrom/to_bump(var/atom/A)
	if(!isliving(A))
		forceMove(get_turf(A))
	return ..()

/obj/effect/psychic_maelstrom
	name = "The current effects of a psychic Maelstrom"
	desc = "What a psyker whom is high powered can do"
	icon = 'z40k_shit/icons/32x32effects.dmi'
	icon_state = "electricity"
	density = 0
	w_type = NOT_RECYCLABLE
	anchored = 1
	opacity = 0

/obj/effect/psychic_maelstrom/to_bump(atom/A)
	ouch_effects(A)

/obj/effect/psychic_maelstrom/Bumped(atom/A)
	ouch_effects(A)

/obj/effect/psychic_maelstrom/Crossed(atom/movable/A)
	ouch_effects(A)

/obj/effect/psychic_maelstrom/proc/ouch_effects(atom/A)
	var/obj/complex_vehicle/CV = A
	if(istype(A,/obj/complex_vehicle))
		CV.health -= 250

	if(iscarbon(A))
		var/mob/living/carbon/C = A
		C.adjustBruteLoss(30)
		C.adjustBrainLoss(20)