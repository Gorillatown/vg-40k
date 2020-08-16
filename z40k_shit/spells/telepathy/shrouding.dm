/spell/aoe_turf/shrouding
	name = "Shrouding"
	abbreviation = "SHD"
	desc = "Blessing - Shrouds area around caster in darkness"
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	override_base = "cult"
	hud_state = "shrouding"
	user_type = USER_TYPE_PSYKER
	spell_flags = INCLUDEUSER
	specialization = SSTELEPATHY
	charge_type = Sp_RECHARGE
	charge_max = 100
	invocation_type = SpI_NONE
	range = 1
	still_recharging_msg = "<span class='notice'>You ain't ready yet idiot..</span>"
	warpcharge_cost = 20

/spell/aoe_turf/shrouding/cast(list/targets, mob/living/user)
	set waitfor = 0
	var/shroud_modifier = 2+round(user.attribute_sensitivity/100)
	var/list/shrouds = list()
	for(var/turf/T in view(shroud_modifier,user))
		var/obj/effect/blinding_shroud/cock = new(T)
		shrouds += cock

	sleep(20 SECONDS)

	for(var/obj/effect/blinding_shroud/cock in shrouds)
		qdel(cock)
			
/spell/aoe_turf/shrouding/choose_targets(var/mob/user = usr)
	return list(user)

/obj/effect/blinding_shroud
	name = "The current effects of a shroud"
	desc = "WITNESS DARKNESS"
	density = 0
	w_type = NOT_RECYCLABLE
	anchored = 1
	opacity = 1