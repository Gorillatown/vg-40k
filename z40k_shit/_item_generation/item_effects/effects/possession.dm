/datum/item_artifact/possess
	name = "Possession Effect"
	desc = "Makes you switch minds with someone else, but temporarily."

/datum/item_artifact/possess/item_act(var/mob/living/M)
	var/list/targets = list()
	for(var/mob/C in range(9,M))
		targets += C
	if(length(targets))
		var/mob/target = pick(targets)
		var/mob/dead/observer/ghost
		if(istype(target,/mob/living))
			ghost = target.ghostize(0)
		else
			ghost = target
		M.mind.transfer_to(target)
		ghost.mind.transfer_to(M)
		M.key = target.key
		to_chat(M, "<span class='warning'> You don't feel like yourself, somehow...</span>")
		to_chat(target, "<span class='warning'> You don't feel like yourself, somehow...</span>")
		spawn(150)
			var/mob/dead/observer/ghost2 = target.ghostize(0)
			M.mind.transfer_to(target)
			ghost2.mind.transfer_to(M)
			M.key = target.key
			