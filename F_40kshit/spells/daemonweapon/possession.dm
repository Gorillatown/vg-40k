/spell/daemonweapon/blade_possession
	name = "Possession"
	desc = "Take control of the person whom is wielding you's body if they lack willpower to resist."//a much lesser version of the original ritual
	hud_state = "soulblade_boil"

	invocation_type = SpI_NONE
	charge_type = Sp_RECHARGE
	charge_max = 100
	range = 0
	spell_flags = null
	insufficient_holder_msg = ""
	still_recharging_msg = ""

	cast_delay = 0

	blood_cost = 30

/spell/daemonweapon/blade_possession/choose_targets(var/mob/user = usr)
	var/obj/item/weapon/daemonweapon/blissrazor/DW = user.loc
	if(DW.current_swordbearer)
		var/mob/living/M = DW.current_swordbearer
		if(M.attribute_willpower <= 13)
			to_chat(user,"<span class='notice'>Their willpower is weak, you creep into their body.</span>")
			return list(M)
		else
			to_chat(user,"<span class='notice'>Their willpower is too strong for you to takeover.</span>")
			return null
	else
		to_chat(user,"<span class='notice'>You need someone to hold you first.</span>")
		return null

/spell/daemonweapon/blade_possession/before_cast(var/list/targets, var/user)
	return targets

/spell/daemonweapon/blade_possession/cast(var/list/targets, var/mob/user)
	..()
	var/mob/living/wielder = pick(targets)
	var/obj/item/weapon/daemonweapon/blissrazor/DW = user.loc
	to_chat(wielder, "<span class='danger'>You feel like you are suddenly in a dream, the actions of your body feeling like they are your own. Yet it moves on its own.</span>")
	DW.hostage_brain.ckey = wielder.ckey
	wielder.ckey = DW.our_daemon.ckey
	DW.hostage_brain_occupied = TRUE
	