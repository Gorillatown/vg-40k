/*
	The actual job quests are in like, systems/jobquests
	The purpose of this is to store variables to reference to help the scenario master out.
	Cause, we need to keep track of who gets what job_quest anyways to properly move them
	without scanning all mobs on the map etc.
	We are also going to make it setup storylines, and allocate shit later so move functionality in.
*/
/datum/job_quest/global_tracker
	var/datum/role/job_quest/harlequin //The mind of the current harlequin
	var/datum/mind/tzeentch_champion //Mind of the current tzeentch champion
	var/datum/mind/slaanesh_champion //mind of the current slaanesh champion
	var/list/game_end_objects = list() //List of game ending objects
	var/psyker_amount = 0 //Amount of psykers, percentage lowers as time goes on.
	
//gamble_time is exactly what it sounds like.
/datum/job_quest/global_tracker/proc/configure_quest(var/mob/living/target = null,var/quest_defininition = null)
	if(!target)
		warning("JOB QUEST GLOBAL TRACKER FAILURE: NULL MOB INPUT")
	if(!quest_defininition)
		warning("JOB QUEST GLOBAL TRACKER FAILURE: NULL QUEST DEFINITION INPUT")
 
	switch(quest_defininition)	
		if(HARLEQUIN) //Harlequin job quest - currently: tied into the mime	
			var/datum/role/job_quest/harlequin/harlequin_role = new
			harlequin_role.AssignToRole(target.mind,TRUE)
		
			harlequin = harlequin_role
			target.add_spell(new /spell/targeted/concentrate,"ork_spell_ready",/obj/abstract/screen/movable/spell_master/harlequin)
		if(SLAANESH_CHAMPION) //Harlequin job quest - currently: tied into the celeb
			var/datum/role/job_quest/slaanesh_one/slaanesh_role = new
			slaanesh_role.AssignToRole(target.mind,TRUE)
		
			slaanesh_champion = slaanesh_role
			target.add_spell(new /spell/slaanesh/celebfall)
		if(TZEENTCH_CHAMPION)
			var/datum/role/job_quest/tzeentch_one/tzeentch_role = new
			tzeentch_role.AssignToRole(target.mind,TRUE)
		
			tzeentch_champion = tzeentch_role
			target.add_spell(new /spell/targeted/dwell,"ork_spell_ready",/obj/abstract/screen/movable/spell_master/harlequin)
		if(ROGUE_PSYKER)
			var/prob_reduction = psyker_amount*20
			var/psyker_prob = 40-prob_reduction
			if(psyker_prob < 5)
				psyker_prob = 5
			if(prob(psyker_prob))
				var/datum/role/rogue_psyker/psyker_role = new
				psyker_role.AssignToRole(target.mind,TRUE)

