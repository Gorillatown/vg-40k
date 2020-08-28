/datum/passive_effect/regen
	name = "Regeneration"
	desc = "Heals you rather quickly."

/datum/passive_effect/regen/runmob(var/mob/living/carbon/M)
	if(M.getOxyLoss()) 
		M.adjustOxyLoss(-1)
	if(M.getBruteLoss())
		M.heal_organ_damage(1,0)
	if(M.getFireLoss()) 
		M.heal_organ_damage(0,1)
	if(M.getToxLoss()) 
		M.adjustToxLoss(-1)
		