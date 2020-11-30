/datum/roguelike_effects/passives/regen
	name = "Regeneration"
	desc = "Heals you rather quickly."

/datum/roguelike_effects/passives/regen/sc_process()
	if(current_mob)
		current_mob.adjustBruteLoss(-5)
		current_mob.adjustToxLoss(-5)
		current_mob.adjustOxyLoss(-5)
		current_mob.adjustFireLoss(-5)
