/datum/roguelike_effects/possess
	name = "Soul Swap Effect"
	desc = "Meddles with souls."

/datum/roguelike_effects/possess/re_effect_act(mob/living/M, obj/item/I)
	if(..())
		return
	var/list/ghosts = list()
	for(var/mob/dead/observer/GST in player_list)
		if(GST.client && GST.mind)
			ghosts += GST
	
	if(ghosts.len)
		var/mob/dead/observer/ghost = pick(ghosts)
		if(M.stat != DEAD)
			var/mob/living/simple_animal/hostile/retaliate/daemon/daemonette/our_daemon = new(src)
			our_daemon.possessed = M
			our_daemon.handle_possession(TRUE)
			to_chat(M, "<span class='warning'> You don't feel like yourself, somehow...</span>")
			to_chat(our_daemon, "<span class='warning'> One moment you are in the warp, and the next you are now in a humans body, how amusing.</span>")
			spawn(150)
				our_daemon.handle_possession(FALSE)
				to_chat(our_daemon, "<span class='warning'> You lose control of your vessel momentarily.</span>")
				to_chat(M, "<span class='warning'> If you hadn't figured it out by now, you are now possessed by a daemon ya dipshit.</span>")	
		else
			to_chat(ghost, "<span class='warning'>Something forces your spirit into a corpse, bringing you new life. REJOICE!</span>")
			ghost.mind.transfer_to(M)
			
