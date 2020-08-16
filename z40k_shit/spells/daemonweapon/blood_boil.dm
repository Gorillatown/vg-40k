//////////////////////////////
//                          //Click dat button if a guy you don't like is holding you (aka: a sec officer or a greyshit)
//        BLADE BOIL        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                          //Doesn't actually damage as much as the original cult spell, unless you manage to use it more than once, in which case they're dumb
//////////////////////////////But if you get some idiot to grab you and use it twice, you'll get back to full blood, and they'll be most likely dead.

/spell/daemonweapon/blade_boil
	name = "Blood Boil"
	desc = "(FREE) Punish your wielder by boiling their blood, and burning their flesh."//a much lesser version of the original ritual
	hud_state = "soulblade_boil"

	invocation_type = SpI_NONE
	charge_type = Sp_RECHARGE
	charge_max = 20
	range = 0
	spell_flags = null
	insufficient_holder_msg = ""
	still_recharging_msg = ""

	cast_delay = 0

	blood_cost = 10
 
/spell/daemonweapon/blade_boil/choose_targets(var/mob/user = usr)
	var/obj/item/weapon/daemonweapon/blissrazor/SB = user.loc
	if(!ismob(SB.loc))
		to_chat(user,"<span class='notice'>You need someone to hold you first.</span>")
		return null
	var/mob/M = SB.loc
	return list(M)

/spell/daemonweapon/blade_boil/before_cast(var/list/targets, var/user)
	return targets

/spell/daemonweapon/blade_boil/cast(var/list/targets, var/mob/user)
	..()
	var/mob/living/wielder = pick(targets)
	wielder.take_overall_damage(25,25)
	playsound(wielder.loc, 'sound/effects/bloodboil.ogg', 50, 0, -1)
	to_chat(wielder, "<span class='danger'>You suddenly feel your blood boil in your veins!</span>")
	if(iscarbon(wielder))
		var/mob/living/carbon/C = wielder
		C.take_blood(null,50)
		to_chat(user, "<span class='warning'>You steal a good amount of their blood too, that'll show them.</span>")