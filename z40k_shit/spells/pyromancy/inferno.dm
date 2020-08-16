/spell/targeted/projectile/dumbfire/inferno
	name = "Inferno"
	abbreviation = "INF"
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	override_base = "cult"
	desc = "Witchfire - Fires a flaming projectile."
	user_type = USER_TYPE_PSYKER
	specialization = SSPYROMANCY

	proj_type = /obj/item/projectile/spell_projectile/inferno

	school = "evocation"
	charge_max = 100
	invocation_type = SpI_NONE
	range = 20

	spell_flags = 0
	spell_aspect_flags = SPELL_FIRE
	duration = 20
	projectile_speed = 1

	amt_dam_brute = 20
	amt_dam_fire = 25
	spell_flags = WAIT_FOR_CLICK
	dumbfire = 0

	var/ex_severe = -1
	var/ex_heavy = 1
	var/ex_light = 2
	var/ex_flash = 5

	hud_state = "inferno"
	warpcharge_cost = 120

/spell/targeted/projectile/dumbfire/fireball/inferno/prox_cast(var/list/targets, spell_holder)
	for(var/mob/living/M in targets)
		apply_spell_damage(M)
		M.soul_blaze_append()
		
	explosion(get_turf(spell_holder), ex_severe, ex_heavy, ex_light, ex_flash)
	return targets

/spell/targeted/projectile/dumbfire/fireball/inferno/choose_prox_targets(mob/user = usr, var/atom/movable/spell_holder)
	var/list/targets = ..()
	for(var/mob/living/M in targets)
		if(M.lying)
			targets -= M
	return targets

/spell/targeted/projectile/dumbfire/fireball/inferno/is_valid_target(var/atom/target)
	if(!istype(target))
		return 0
	if(target == holder)
		return 0

	return (isturf(target) || isturf(target.loc))

//PROJECTILE
/obj/item/projectile/spell_projectile/inferno
	name = "fireball"
	icon_state = "fireball"
	animate_movement = 2
	linear_movement = 0

/obj/item/projectile/spell_projectile/inferno/to_bump(var/atom/A)
	if(!isliving(A))
		forceMove(get_turf(A))
	return ..()
