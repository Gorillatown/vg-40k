/datum/role/job_quest
	name = HARLEQUIN
	id = HARLEQUIN
	special_role = HARLEQUIN
	var/alignment = 0
//	logo_state = "ig-standard-logo"

/datum/role/job_quest/New(var/datum/mind/M, var/datum/faction/fac=null, var/new_id)
	..()

/datum/role/job_quest/GetScoreboard()
	return // We handle it on the faction proc, since its a score list.

/datum/role/job_quest/point_handler(var/mob/living/carbon/human/H)
	return

/datum/role/job_quest/proc/alignment_handler()
	return