/datum/roguelike_effects/passives/unstunabble
	name = "Stun Recovery"
	desc = "Protects you from being stunned."

/datum/roguelike_effects/passives/unstunnable/re_process()
	current_mob.drowsyness = 0
	current_mob.sleeping = 0
	current_mob.AdjustParalysis(-5)
	current_mob.AdjustStunned(-5)