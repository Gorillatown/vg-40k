/*
	Within is just containers for job quests
											*/



/datum/job_quest
	var/title = "Jackshit - The Erroring"
	var/mob/living/our_protagonist = null //A link to the master aka the mob we are attached to for reference purposes.
	var/datum/mind/actual_protagonist = null
	var/alignment = 0 //Basically this will be put in place of purity. It can go negative or positive.

/datum/job_quest/proc/main_body()
	return
