//////////////////////////////
//                          //Spend 10 blood -> Heal 10 brute damage on your wielder and clamp their bleeding wounds. Good trade, yes?
//        MEND              ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                          //
//////////////////////////////

/spell/daemonweapon/blade_mend
	name = "Mend"
	desc = "(10 BLOOD) Heal some of your wielder's brute damage using your blood."
	hud_state = "soulblade_mend"

	invocation_type = SpI_NONE
	charge_type = Sp_RECHARGE
	charge_max = 20
	range = 0
	spell_flags = null
	insufficient_holder_msg = ""
	still_recharging_msg = ""

	cast_delay = 0

	blood_cost = 10

/spell/daemonweapon/blade_mend/choose_targets(var/mob/user = usr)
	var/obj/item/weapon/daemonweapon/blissrazor/SB = user.loc
	if (!ismob(SB.loc))
		return null
	var/mob/living/wielder = SB.loc
	if (wielder.getBruteLoss())
		return list(wielder)
	else
		to_chat(user,"<span class='notice'>Your wielder's wounds are already all closed up.</span>")
		return null

/spell/daemonweapon/blade_mend/before_cast(var/list/targets, var/user)
	return targets

/spell/daemonweapon/blade_mend/cast(var/list/targets, var/mob/user)
	..()
	var/mob/living/wielder = pick(targets)
	if(istype(wielder,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = wielder
		for(var/datum/organ/internal/I in H.internal_organs)
			if(prob(50))
				if(I && I.damage > 0)
					I.damage = max(0, I.damage - 4)
				if(I)
					I.status &= ~ORGAN_BROKEN
					I.status &= ~ORGAN_SPLINTED
					I.status &= ~ORGAN_BLEEDING
		for(var/datum/organ/external/O in H.organs)
			if(prob(50))
				O.status &= ~ORGAN_BROKEN
				O.status &= ~ORGAN_SPLINTED
				O.status &= ~ORGAN_BLEEDING
	playsound(wielder.loc, 'sound/effects/mend.ogg', 50, 0, -2)
	wielder.heal_organ_damage(10, 0)
	to_chat(user,"You heal some of your wielder's wounds.")
	to_chat(wielder,"\The [user] heals some of your wounds.")
