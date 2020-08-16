/spell/aoe_turf/endurance	//Raaagh
	name = "Endurance"
	abbreviation = "END"
	desc = "Blessing - Makes everyone in range tougher."
	hud_state = "endurance"
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	override_base = "ork"
	user_type = USER_TYPE_PSYKER
	spell_flags = INCLUDEUSER
	specialization = SSBIOMANCY
	charge_type = Sp_RECHARGE
	charge_max = 100
	invocation_type = SpI_NONE
	range = 0
	still_recharging_msg = "<span class='notice'>You ain't ready yet idiot..</span>"
	warpcharge_cost = 120

/spell/aoe_turf/endurance/cast(list/targets, mob/user)

	for(var/mob/living/L in targets)
		to_chat(L, "<span class='sinister'>Warp Energy courses through you, increasing your constitution.</span>")
		L.attribute_constitution += 15
		L.maxHealth += 150
		L.health += 150
		L.vis_contents += new /obj/effect/overlay/weak_blue_circle(L,10)

		spawn(12 SECONDS)
			to_chat(L, "<span class='sinister'>Warp energy fading, your constitution returns to normal.</span>")
			L.maxHealth -= 150
			L.health -= 150
			L.attribute_constitution -= 15
			if(L.stat == DEAD)
				L.visible_message("<span class='bad'> The Warp Energy keeping [L] alive dissipates from their body.</span>")

/spell/aoe_turf/endurance/choose_targets(var/mob/user = usr)
	var/list/targets = list()

	for(var/mob/living/L in view(2, user))
		targets += L

	return targets

