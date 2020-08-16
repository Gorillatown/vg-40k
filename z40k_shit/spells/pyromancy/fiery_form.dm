/spell/aoe_turf/fiery_form	//Raaagh
	name = "Fiery Form"
	abbreviation = "FIF"
	desc = "Blessing - Adds Soul Blaze to melee attacks, increases CON."
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	override_base = "cult"
	hud_state = "fiery_form"
	user_type = USER_TYPE_PSYKER
	spell_flags = INCLUDEUSER
	specialization = SSPYROMANCY
	charge_type = Sp_RECHARGE
	charge_max = 100
	invocation_type = SpI_NONE
	range = 1
	still_recharging_msg = "<span class='notice'>You ain't ready yet idiot..</span>"
	warpcharge_cost = 20

/spell/aoe_turf/fiery_form/cast(list/targets, mob/user)

	for(var/mob/living/L in targets)
		to_chat(L, "<span class='sinister'>Fire wreathes your form.</span>")
		L.attribute_constitution += 10
		L.health += 20
		L.soul_blaze_melee = TRUE
		L.vis_contents += new /obj/effect/overlay/purple_flame(L,12 SECONDS)
		spawn(12 SECONDS)
			to_chat(L, "<span class='sinister'>Warp energy fading, the fire dissipates.</span>")
			L.soul_blaze_melee = FALSE
			L.health -= 20
			L.attribute_constitution -= 10
			
/spell/aoe_turf/fiery_form/choose_targets(var/mob/user = usr)
	return list(user)