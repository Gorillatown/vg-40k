/datum/roguelike_effects/mindswap
	name = "Soul Swap Effect"
	desc = "Meddles with souls."

/datum/roguelike_effects/mindswap/re_effect_act(mob/living/M, obj/item/I)
	if(..())
		return
	var/list/targets = list()
	for(var/mob/living/C in range(9,M)) //Can include ghosts. Because that is basically possession
		if(C == M)
			continue
		targets += C
	if(length(targets))
		var/mob/target = pick(targets)
		var/mob/dead/observer/ghost
		if(istype(target,/mob/living))
			ghost = target.ghostize(0)
		else
			ghost = target
		M.mind?.transfer_to(target)
		ghost.mind?.transfer_to(M)
		to_chat(M, "<span class='warning'> You don't feel like yourself, somehow...</span>")
		to_chat(target, "<span class='warning'> You don't feel like yourself, somehow...</span>")
		