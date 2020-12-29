/datum/roguelike_effects/mindswap
	name = "Soul Swap Effect"
	desc = "Meddles with souls."

/datum/roguelike_effects/mindswap/re_effect_act(mob/living/M, obj/item/I)
	if(..())
		return
	var/list/targets = list() //is_afk(?)
	for(var/mob/living/C in range(9,M)) //No ghosts with this one.
		if(C == M)
			continue
		targets += C
	if(targets.len)
		var/mob/target = pick(targets)
		var/mob/dead/observer/host_ghost = M.ghostize(0) //Turn our guy into a ghost
	
		target.mind?.transfer_to(M) //Transfer target into us
		host_ghost.mind.transfer_to(target) //Transfer us into target
		

		to_chat(M, "<span class='warning'> You don't feel like yourself, somehow...</span>")
		to_chat(target, "<span class='warning'> You don't feel like yourself, somehow...</span>")
		