/spell/targeted/projectile/dumbfire/fireball/inferno
	name = "Flame breathe"
	desc = "(Primaris)Witchfire - Shoots out a gout of flames."
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	override_base = "cult"
	user_type = USER_TYPE_PSYKER
	specialization
	abbreviation = "FLMB"

	proj_type = /obj/item/projectile/fire_breath
	invocation_type = SpI_NONE
	school = "evocation"

	spell_flags = WAIT_FOR_CLICK
	spell_aspect_flags = SPELL_FIRE
	range = 20
	projectile_speed = 1
	
	dumbfire = 0
	amt_dam_brute = 0
	amt_dam_fire = 0

	var/pressure = 500 //Basically controls the spread //455 is normal they add 150 to it per level up to 5
	var/temperature = 500 //Controls the damage + heat. normally 488.15, 1643.15 is instant death
	var/fire_duration = 0

	hud_state = "flame_breath"
	warpcharge_cost = 10

/spell/targeted/projectile/dumbfire/fireball/inferno/spawn_projectile(var/location, var/direction)
	return new proj_type(location, direction, P = pressure, T = temperature, F_Dur = fire_duration, m_fire = TRUE)

/spell/targeted/projectile/dumbfire/fireball/inferno/cast(list/targets, mob/user = usr)
	var/mob/living/psyker = user
	pressure  += (psyker.attribute_sensitivity/2)
	temperature += (psyker.attribute_sensitivity/2)
	fire_duration = psyker.attribute_willpower
	
	..()

/spell/targeted/projectile/dumbfire/fireball/inferno/is_valid_target(var/atom/target)
	if(!istype(target))
		return 0
	if(target == holder)
		return 0

	return (isturf(target) || isturf(target.loc))
