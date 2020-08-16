/datum/free_recruiter
	var/client/our_boy = null //Where we put this shit into.
	var/obj/item/master = null //What we are currently attached to
	var/consentual = TRUE //Do we want consent?

/datum/free_recruiter/proc/recruit_bitches()
	var/list/possible_candidates = brute_get_candidates()
	if(consentual)
		for(var/client/candidate in possible_candidates)
			to_chat(candidate.mob, "<span class='recruit'> A special role is being requested. (<a href='?src=\ref[src];free_recruit=\ref[candidate.mob]'>Apply now!</a>)</span>")
	else
		our_boy = pick(possible_candidates)
		master.plugin_ourboy(our_boy) //Make no mistake this is a client too.

/datum/free_recruiter/Topic(href, href_list)
	if(usr.stat != DEAD)
		return

	if(href_list["free_recruit"])//We don't have time to wait for the recruiter, just grab whoever applied first!
		if(!our_boy)
			our_boy = usr.client
			master.plugin_ourboy(usr.client)
		else
			to_chat(usr, "<span class='warning'>Uhm, Someone got the role before you. Bitch</span>")

/obj/item/proc/plugin_ourboy(var/client/C)
	return
/*
An example of what would go here would be something like so.
/obj/item/proc/create_mob(var/client/C)
	if(!C)
		return 0

	var/mob/bigboy = new(src.loc) //We've passed the client and made the mob
	bigboy.key = C.key //Now we can put the client into the mob!

	//And bigboy is referenced for us to continue on down without having to deal with stupid shit gating ppl.
*/
