/spell/targeted/objuration_mechanicum
	name = "Objuration Mechanicum"
	desc = "Malediction - Causes guns to malfunction and perform poorly in an area."
	abbreviation = "OBM"
	user_type = USER_TYPE_PSYKER
	specialization = SSTELEKINESIS
	school = "evocation"
	charge_max = 250
	invocation_type = SpI_NONE
	range = 20
	spell_flags = WAIT_FOR_CLICK
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	override_base = "ork"
	hud_state = "objmech"
	warpcharge_cost = 20

/spell/targeted/objuration_mechanicum/cast(var/list/targets, mob/user)
	set waitfor = 0
	for(var/atom/target in targets)
		for(var/mob/living/carbon/C in view(3, target))
			C.objuration_mechanicum = TRUE
			C.vis_contents += new /obj/effect/overlay/red_downwards_lines(C,4)
			sleep(3 SECONDS)
			C.objuration_mechanicum = FALSE