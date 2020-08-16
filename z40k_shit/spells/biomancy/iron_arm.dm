/spell/aoe_turf/iron_arm	//Raaagh
	name = "Iron Arm"
	abbreviation = "IA"
	desc = "Blessing - Grants strength to the caster."
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	override_base = "ork"
	hud_state = "iron_arm"
	user_type = USER_TYPE_PSYKER
	spell_flags = INCLUDEUSER
	specialization = SSBIOMANCY
	charge_type = Sp_RECHARGE
	charge_max = 200
	invocation_type = SpI_NONE
	range = 1
	still_recharging_msg = "<span class='notice'>You ain't ready yet idiot..</span>"
	warpcharge_cost = 20

/spell/aoe_turf/iron_arm/cast(list/targets, mob/living/user)
	set waitfor = 0
	for(var/mob/living/L in targets)
		to_chat(L, "<span class='sinister'>Your arms feel a hell of a lot stronger.</span>")
		L.attribute_strength += 15
		apply_highperf_aura(L,12 SECONDS)
		sleep(12 SECONDS)
		to_chat(L, "<span class='sinister'>Warp energy fading, your strength feels weak.</span>")
		L.attribute_strength -= 15
			
/spell/aoe_turf/iron_arm/choose_targets(var/mob/user = usr)
	return list(user)


/spell/aoe_turf/iron_arm/proc/apply_highperf_aura(mob/living/user,effect_duration)
	user.filters += filter(type="drop_shadow", x=0, y=0, size=5, offset=2, color=rgb(249, 62, 255))
	var/f1 = user.filters[user.filters.len]
	user.filters += filter(type="drop_shadow", x=0, y=0, size=5, offset=2, color=rgb(5, 236, 25))
	var/f3 = user.filters[user.filters.len]
	var/start = user.filters.len
	var/X
	var/Y
	var/rsq
	var/i
	var/f2
	for(i=1, i<=7, ++i)
		// choose a wave with a random direction and a period between 10 and 30 pixels
		do
			X = 60*rand() - 30
			Y = 60*rand() - 30
			rsq = X*X + Y*Y
		while(rsq<100 || rsq>900)   // keep trying if we don't like the numbers
		// keep distortion (size) small, from 0.5 to 3 pixels
		// choose a random phase (offset)
		user.filters += filter(type="wave", x=X, y=Y, size=rand()*2.5+0.5, offset=rand())
	for(i=1, i<=7, ++i)
		// animate phase of each wave from its original phase to phase-1 and then reset;
		// this moves the wave forward in the X,Y direction
		f2 = user.filters[start+i]
		animate(f2, offset=f2:offset, time=0, loop=-1, flags=ANIMATION_PARALLEL)
		animate(offset=f2:offset-1, time=rand()*20+10)
		spawn(effect_duration)
			user.filters -= f2

	sleep(effect_duration)
	user.filters -= f1
	user.filters -= f3
