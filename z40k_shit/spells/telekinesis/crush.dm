/spell/targeted/crush
	name = "Crush"
	desc = "Witchfire(Profileless) - Attempts to Crush the target."
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	override_base = "ork"
	abbreviation = "HMG"
	user_type = USER_TYPE_PSYKER
	specialization = SSTELEKINESIS
	school = "transmutation"
	charge_max = 70
	spell_flags = WAIT_FOR_CLICK
	range = 20
	max_targets = 1
	invocation_type = SpI_NONE

	hud_state = "crush"
	warpcharge_cost = 20


/spell/targeted/crush/cast(var/list/targets, mob/user)
	set waitfor = 0
	..()
	for(var/mob/living/target in targets)
		target.visible_message("<span class='danger'>[target] is assaulted by crushing psychic force!</span>")
		target.adjustBruteLoss(25)
		sleep(2 SECONDS)
		target.adjustBruteLoss(30)
		if(target.stat == DEAD)
			target.gib()
			target.visible_message("<span class='danger'>\The corpse explodes under the pressure!</span>")
		else
			target.visible_message("<span class='danger'>The crushing psychic force stops!</span>")
			



