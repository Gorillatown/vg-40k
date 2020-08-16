
/spell/slaanesh/celebfall
	name = "Fuck Sobriety!"
	desc = "I didn't make it this far by following THIER rules."
	invocation_type = SpI_NONE
	school = "evocation"
	panel = "Celebrity"
	charge_max = 40
	range = 1

/spell/slaanesh/celebfall/choose_targets(var/mob/user = usr)
	return list(user)

/spell/slaanesh/celebfall/cast(var/list/targets, var/mob/living/carbon/user)
	..()
	var/mob/living/carbon/human/H = user
	if(H.stat == DEAD)
		to_chat(H,"Looks like we went to that big disco in the sky!")//user is dead
		return
	if(!H.canmove || H.stat || H.restrained())
		H.say("Bartender! A little help here!")	//user is tied up
		return
	if(H.brainloss >= 60)
		to_chat(H,"<span class='notice'>You have no idea where you even are right now.</span>")	//user is stupid
		to_chat(H,"<span class='notice'>Your head feels funny.</span>")
		to_chat(H,"<span class='notice'>Oh crap. You need to call an adult!</span>")
		H.visible_message(text("<span class='alert'>[H] stares blankly.</span>"))
		H.say("Sing us a song you're the piano man! Sing us a song tonight!!</span>")
		return
	H.mind.job_quest.main_body()
	return