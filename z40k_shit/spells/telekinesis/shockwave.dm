/spell/aoe_turf/shockwave
	name = "Shockwave"
	desc = "Witchfire (Nova) - Send out a shockwave."
	abbreviation = "SBST"

	user_type = USER_TYPE_PSYKER
	specialization = SSTELEKINESIS
	charge_type = Sp_RECHARGE
	charge_max = 30 SECONDS
	invocation_type = SpI_NONE
	range = 2
	spell_flags = STATALLOWED
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	override_base = "ork"
	hud_state = "shockwave"
	warpcharge_cost = 20

/spell/aoe_turf/shockwave/choose_targets(var/mob/user = usr)

	var/list/targets = list()

	for(var/mob/living/carbon/C in view(user, 2))
		if(C == user)
			continue
		if(ishuman(C))
			targets += C

	return targets

/spell/aoe_turf/shockwave/cast(var/list/targets, var/mob/user)
	user.vis_contents += new /obj/effect/overlay/shockwave(user,15)
	for(var/mob/living/AUGH in targets)
		to_chat(AUGH, "<span class='danger'><font size='3'>You hit by a psychic shockwave!</font></span>")
		AUGH.adjustBruteLoss(30)
		AUGH.Knockdown(3)
		AUGH.Stun(2)
		var/turf/T = get_distant_turf(get_turf(user), get_dir(user,AUGH), 2)
		AUGH.throw_at(T, rand(3,5), 3)
