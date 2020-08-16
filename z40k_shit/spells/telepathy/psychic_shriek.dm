/spell/aoe_turf/psychic_shriek
	name = "Psychic Shriek"
	desc = "Witchfire (Profileless) - Emits a psychic Shriek in range."
	abbreviation = "PSK"

	school = "evocation"
	user_type = USER_TYPE_PSYKER

	charge_type = Sp_RECHARGE
	charge_max = 2 MINUTES
	invocation_type = SpI_NONE
	range = 4
	spell_flags = STATALLOWED
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	override_base = "cult"
	hud_state = "psychic_shriek"
	warpcharge_cost = 20

/spell/aoe_turf/psychic_shriek/cast_check(var/skipcharge = 0, var/mob/user = usr)
	. = ..()
	if (!.) // No need to go further.
		return FALSE

/spell/aoe_turf/psychic_shriek/choose_targets(var/mob/user = usr)
	var/list/targets = list()
	for(var/mob/living/carbon/C in range(user, 4))
		if(C == user)
			continue
		if(ishuman(C))
			targets += C

	if(!targets.len)
		to_chat(user, "<span class='warning'>There are no targets.</span>")
		return FALSE

	return targets

/spell/aoe_turf/psychic_shriek/cast(var/list/targets, var/mob/user)
	for(var/T in targets)
		var/mob/living/carbon/C = T
		to_chat(C, "<span class='danger'><font size='3'>Your mind perceives a piercing shriek and your senses dull!</font></span>")
		C.Knockdown(8)
		C.ear_deaf = 20
		C.stuttering = 20
		C.Stun(8)
		C.Jitter(150)
		C.adjustBruteLoss(25)
		if(C.client)
			C << 'sound/effects/creepyshriek.ogg'
	for(var/obj/structure/window/W in view(4))
		W.shatter()
