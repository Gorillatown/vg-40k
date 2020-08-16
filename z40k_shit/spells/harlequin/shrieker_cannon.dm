/spell/targeted/projectile/shrieker_cannon
	name = "Shrieker Cannon"
	desc = "Fire a shrieker cannon and then appear somewhere else."
	override_base = "cult" //The area behind tied into the panel we are attached to
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	abbreviation = "SCNON"
	school = "mime"
	panel = "Mime"
	proj_type = /obj/item/projectile/spell_projectile/shrieker_cannon
	projectile_speed = 1
	duration = 20

	charge_max = 500
	invocation_type = SpI_NONE
	spell_flags = WAIT_FOR_CLICK
//	hud_state = "life_leech"
	cast_prox_range = 1

/spell/targeted/projectile/shrieker_cannon/cast(list/targets, mob/living/user = usr)
	..()
	if(user.gender == MALE)
		var/mimelaugh = pick('z40k_shit/sounds/mimelaugh1.ogg','z40k_shit/sounds/mimelaugh2.ogg')
		playsound(user.loc, mimelaugh, 75, 0)
	else
		var/mimelaugh = pick('z40k_shit/sounds/mimelaughf1.ogg','z40k_shit/sounds/mimelaughf2.ogg')
		playsound(user.loc, mimelaugh, 75, 0)
	user.visible_message("<span class='warning'> [user] fires the Shrieker Cannon!</span>", "<span class='warning'> You fire the Shrieker Cannon.</span>")
	var/turf/T = user.loc
	if(!isturf(user) || !isturf(T))
		return
	spawn(10)
		user.alpha = 0
		var/list/posturfs = circlerangeturfs(get_turf(user),4)
		var/turf/destturf = safepick(posturfs)
		user.loc = destturf
		var/area/destarea = get_area(destturf)
		destarea.Entered(user)
		var/datum/effect/effect/system/smoke_spread/smoke = new /datum/effect/effect/system/smoke_spread()
		smoke.set_up(10, 0, user.loc)
		smoke.time_to_live = 10 SECONDS //unusually short smoke
		smoke.start()
		animate(user, alpha = 255, time = 5)

//Basically it runs this when its in range to do shit.
/spell/targeted/projectile/shrieker_cannon/prox_cast(var/list/targets, var/obj/item/projectile/spell_projectile/spell_holder)
	spell_holder.visible_message("<span class='danger'>\The [spell_holder] pops with a flash!</span>")
//	var/mob/living/owner = spell_holder.shot_from
	for(var/mob/living/M in targets)
		M.reagents.add_reagent(DESTROYER_VENOM, 15)

/spell/targeted/projectile/shrieker_cannon/choose_prox_targets(mob/user = usr, var/atom/movable/spell_holder)
	var/list/targets = ..()
	return targets

/spell/targeted/projectile/shrieker_cannon/is_valid_target(var/atom/target)
	if(!istype(target))
		return 0
	if(target == holder)
		return 0

	return (isturf(target) || isturf(target.loc))

//Our projectile.
/obj/item/projectile/spell_projectile/shrieker_cannon
	name = "Shrieker Cannon"
	icon = 'z40k_shit/icons/obj/projectiles.dmi'
	icon_state = "shuriken"
	animate_movement = 2
	linear_movement = 0

/obj/item/projectile/spell_projectile/shrieker_cannon/to_bump(var/atom/A)
	if(!isliving(A))
		forceMove(get_turf(A))
	return ..()

