	
/spell/slaanesh/ascension
	name = "Ascension"
	desc = "Become a Champion of Chaos."
	invocation = "MY SOUL FOR YOU!!"
	invocation_type = SpI_SHOUT
	school = "evocation"
	panel = "Warp Magic"
	charge_max = 500
	range = 1

/spell/slaanesh/ascension/choose_targets(var/mob/user = usr)
	return list(user)

/spell/slaanesh/ascension/cast(var/list/targets, var/mob/living/carbon/user)
	..()
	var/mob/living/carbon/human/H = user
	new /mob/living/simple_animal/hostile/retaliate/daemon/daemonette(H.loc)
	H.visible_message("<span class='notice'>[H] bends and twists into some kind of abomination!</span>", "<span class='notice'>Only your body is needed. Your soul serves me better in the warp.</span>")
	H.gib() //Yeah, this is literally a recoding not a reimagining. Maybe later ill do something about this lmao.

