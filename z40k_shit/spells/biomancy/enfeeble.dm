/spell/targeted/enfeeble
	name = "Enfeeble"
	desc = "Malediction - Weakens the target and everyone around it."
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	override_base = "ork"
	abbreviation = "ENF"
	user_type = USER_TYPE_PSYKER
	specialization = SSBIOMANCY
	school = "evocation"
	charge_max = 100
	invocation_type = SpI_NONE
	range = 20
	spell_flags = WAIT_FOR_CLICK
	hud_state = "enfeeble"
	warpcharge_cost = 20

/spell/targeted/enfeeble/cast(var/list/targets, mob/user)
	for(var/atom/target in targets)
		for(var/mob/living/carbon/C in view(3, target))
			C.movement_speed_modifier -= 0.5
			C.attribute_strength -= 10
			C.attribute_constitution -= 10
			C.adjustBruteLoss(50-C.attribute_willpower)
			C.vis_contents += new /obj/effect/overlay/weak_red_circle(C,5)
			C.vis_contents += new /obj/effect/overlay/red_downwards_lines(C,4)

			spawn(3 SECONDS)
				C.adjustBruteLoss(-30)
				C.attribute_strength += 10
				C.attribute_constitution += 10
				C.movement_speed_modifier += 0.5
