/spell/targeted/spontaneous_combustion
	name = "Spontaneous Combustion"
	desc = "Witchfire(Profileless) - Sets the target ablaze while frying their insides, If they die shortly after they explode."
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	override_base = "cult"
	abbreviation = "HMG"
	user_type = USER_TYPE_PSYKER
	specialization = SSPYROMANCY
	school = "transmutation"
	charge_max = 600
	spell_flags = WAIT_FOR_CLICK
	range = 20
	max_targets = 1
	invocation_type = SpI_NONE

	hud_state = "spont_combust"
	warpcharge_cost = 20

/spell/targeted/spontaneous_combustion/cast(var/list/targets, mob/user)
	..()
	for(var/mob/living/target in targets)
		if(target.stat != DEAD)
			target.adjustFireLoss(50)
			target.fire_stacks += 10
			target.vis_contents += new /obj/effect/overlay/purple_flame(target,12 SECONDS)
			spawn(3 SECONDS)
				if(target.stat == DEAD)
					explosion(get_turf(target), 1, 3, 6, 10)
		else
			to_chat(user, "<span class='sinister'>You cannot cast this on a corpse.</span>")


