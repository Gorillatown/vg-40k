/spell/targeted/mental_fortitude	//Raaagh
	name = "Mental Fortitude"
	abbreviation = "MF"
	desc = "Blessing - Fills everyone around your target with visions of glorious victory."
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	override_base = "cult"
	hud_state = "mental_fortitude"
	user_type = USER_TYPE_PSYKER
	spell_flags = INCLUDEUSER
	specialization = SSTELEPATHY
	charge_type = Sp_RECHARGE
	charge_max = 100
	invocation_type = SpI_NONE
	range = 0
	still_recharging_msg = "<span class='notice'>You ain't ready yet idiot..</span>"
	warpcharge_cost = 20

/spell/targeted/mental_fortitude/cast(list/targets, mob/user)
	for(var/atom/target in targets)
		for(var/mob/living/L in range(2, target))
			to_chat(L, "<span class='sinister'>Visions of victory flood your mind, and you charge forward.</span>")
			L.movement_speed_modifier += 1.0
			for(var/i=1 to 6)
				step(L,user.dir)
				sleep(1)

			spawn(12 SECONDS)
				to_chat(L, "<span class='sinister'>The visions leave your mind, along with your vigor.</span>")
				L.movement_speed_modifier -= 1.0

