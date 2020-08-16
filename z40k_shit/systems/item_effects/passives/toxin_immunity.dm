/datum/passive_effect/immunity
	name = "Immunity"
	desc = "Immunity to toxins and diseases."

/datum/passive_effect/immunity/runmob(var/mob/living/carbon/M)
	M.reagents.remove_all_type(/datum/reagent/toxin, 2, 0, 1) //Good luck poisoning this one.
	if(M.getToxLoss()) 
		M.adjustToxLoss(-2)
	for(var/datum/disease/D in M.viruses)
		D.spread = "Remissive"
		D.stage--
		if(D.stage < 1)
			D.cure()
