/mob/living/carbon/human/relaymove(var/mob/user, direction)
	if(isdaemon(user))
		Move(get_step(user,user.dir),direction) //WE MOVE (If its a daemon I guess)
	..()
