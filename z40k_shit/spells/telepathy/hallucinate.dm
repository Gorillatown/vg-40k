/spell/targeted/hallucination
	name = "Hallucination"
	desc = "Malediction - Makes the target and everyone around it hallucinate."
	abbreviation = "ENF"
	user_type = USER_TYPE_PSYKER
	specialization = SSTELEPATHY
	school = "evocation"
	charge_max = 100
	invocation_type = SpI_NONE
	range = 20
	spell_flags = WAIT_FOR_CLICK
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	override_base = "cult"
	hud_state = "hallucination"
	warpcharge_cost = 120

/spell/targeted/hallucination/cast(var/list/targets, mob/user)
	for(var/atom/target in targets)
		for(var/mob/living/carbon/C in view(3, target))
			if(C == user)
				continue
			C.dizziness = 86
			C.confused = 86 // 2.1 seconds per = 180.6s
			C.stuttering = 86
			var/angle = pick(90, 180, 270)
			var/client/CL = C.client
			if(CL)
				CL.dir = turn(CL.dir, angle)
				spawn(30 SECONDS) //This will confuse someone for a while and end up very annoying
					if(CL)
						CL.dir = turn(CL.dir, -angle)

