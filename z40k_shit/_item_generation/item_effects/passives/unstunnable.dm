/datum/passive_effect/unstunabble
	name = "Stun Recovery"
	desc = "Protects you from being stunned."

/datum/passive_effect/unstunnable/runmob(var/mob/living/carbon/M)
	M.drowsyness = 0
	M.sleeping = 0
	M.AdjustParalysis(-5)
	M.AdjustStunned(-5)
