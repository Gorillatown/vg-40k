/*
	The actual job quests are in like, systems/jobquests
	The purpose of this is to store variables to reference to help the scenario master out.
	Cause, we need to keep track of who gets what job_quest anyways to properly move them
	without scanning all mobs on the map etc.
	We are also going to make it setup storylines, and allocate shit later so move functionality in.
*/
/datum/job_quest/global_tracker
	var/datum/mind/harlequin //The mind of the current harlequin
	var/datum/mind/tzeentch_champion //Mind of the current tzeentch champion
	var/datum/mind/slaanesh_champion //mind of the current slaanesh champion
	var/list/game_end_objects = list() //List of game ending objects

/datum/job_quest/global_tracker/proc/configure_quest(var/mob/living/target = null,var/quest_defininition = null)
	if(!target)
		warning("JOB QUEST GLOBAL TRACKER FAILURE: NULL MOB INPUT")
	if(!quest_defininition)
		warning("JOB QUEST GLOBAL TRACKER FAILURE: NULL QUEST DEFINITION INPUT")

	var/datum/job_quest/the_quest = null

	switch(quest_defininition)	
		if(HARLEQUIN) //Harlequin job quest - currently: tied into the mime	
			the_quest = new /datum/job_quest/harlequin()

			target.mind.job_quest = the_quest
			the_quest.actual_protagonist = target.mind
			
			harlequin = target.mind
			target.add_spell(new /spell/targeted/concentrate,"ork_spell_ready",/obj/abstract/screen/movable/spell_master/harlequin)
		if(SLAANESH_CHAMPION) //Harlequin job quest - currently: tied into the celeb
			the_quest = new /datum/job_quest/slaanesh_champion()
	
			target.mind.job_quest = the_quest
			the_quest.actual_protagonist = target.mind
			
			slaanesh_champion = target.mind
			target.add_spell(new /spell/slaanesh/celebfall)
		if(TZEENTCH_PLOT_ONE)
			the_quest = new /datum/job_quest/tzeentch_plot_one()

			target.mind.job_quest = the_quest
			the_quest.actual_protagonist = target.mind
		
			tzeentch_champion = target.mind
			target.add_spell(new /spell/targeted/dwell,"ork_spell_ready",/obj/abstract/screen/movable/spell_master/harlequin)

