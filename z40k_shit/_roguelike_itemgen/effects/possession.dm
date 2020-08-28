/datum/roguelike_effects/possess
	name = "Soul Swap Effect"
	desc = "A forboding artifact."

/datum/roguelike_effects/possess/re_effect_act(mob/living/M, obj/item/I)
	if(..())
		return
	var/list/targets = list()
	for(var/mob/C in range(9,M))
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
		ghost?.mind.transfer_to(M)
		to_chat(M, "<span class='warning'> You don't feel like yourself, somehow...</span>")
		to_chat(target, "<span class='warning'> You don't feel like yourself, somehow...</span>")
		spawn(150)
			var/mob/dead/observer/ghost2 = target.ghostize(0)
			M.mind?.transfer_to(target)
			ghost2.mind?.transfer_to(M)
			