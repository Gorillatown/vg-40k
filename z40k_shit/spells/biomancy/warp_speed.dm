/spell/aoe_turf/warp_speed	//Raaagh
	name = "Warp Speed"
	abbreviation = "WSPD"
	desc = "Blessing - Makes you move faster."
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	override_base = "ork"
	hud_state = "warp_speed"
	user_type = USER_TYPE_PSYKER
	spell_flags = INCLUDEUSER
	specialization = SSBIOMANCY
	charge_type = Sp_RECHARGE
	charge_max = 10
	invocation_type = SpI_NONE
	range = 1
	still_recharging_msg = "<span class='notice'>You ain't ready yet idiot..</span>"
	warpcharge_cost = 20

/spell/aoe_turf/warp_speed/cast(list/targets, mob/user)
	for(var/mob/living/L in targets)
		to_chat(L, "<span class='sinister'>Warp Energy courses through you, allowing you to move inhumanly fast.</span>")
		L.attribute_agility += 15
		L.movement_speed_modifier += 1.0
		L.warp_speed = TRUE
		spawn(12 SECONDS)
			to_chat(L, "<span class='sinister'>Warp energy fading, your speed returns to normal.</span>")
			L.warp_speed = FALSE
			L.attribute_agility -= 15
			L.movement_speed_modifier -= 1.0
			
/spell/aoe_turf/warp_speed/choose_targets(var/mob/user = usr)
	return list(user)
