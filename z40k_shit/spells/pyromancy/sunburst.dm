/spell/aoe_turf/sunburst
	name = "Sunburst"
	desc = "Witchfire (Nova) - Erupt into a firenova."
	abbreviation = "SBST"
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	override_base = "cult"
	specialization = SSPYROMANCY
	user_type = USER_TYPE_PSYKER

	charge_type = Sp_RECHARGE
	charge_max = 30 SECONDS
	invocation_type = SpI_NONE
	range = 3
	spell_flags = STATALLOWED

	hud_state = "sunburst"
	warpcharge_cost = 20

/spell/aoe_turf/sunburst/choose_targets(var/mob/user = usr)

	var/list/targets = list()

	for(var/mob/living/carbon/C in view(user, 2))
		if(C == user)
			continue
		if(ishuman(C))
			targets += C

	return targets

/spell/aoe_turf/sunburst/cast(var/list/targets, var/mob/user)
	user.vis_contents += new /obj/effect/overlay/sunburst(user,15)
	for(var/mob/living/AUGH in targets)
		to_chat(AUGH, "<span class='danger'><font size='3'>You are engulfed by brilliant warp flames!</font></span>")
		AUGH.soul_blaze_append()
		AUGH.fire_stacks += 10
		AUGH.IgniteMob()
		AUGH.adjustFireLoss(30)


