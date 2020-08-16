/datum/passive_effect/speed
	name = "Simulant"
	desc = "Makes you move faster."

/datum/passive_effect/speed/runmob(var/mob/living/carbon/M)
	M.movement_speed_modifier *= speed_modifier
