//This is just the role that is appended to the player client.
/*
	As for why its so barren, in this new iteration someone could use the stat panel to sniff out a spy/agent
	We need to prevent that as much as possible, so things will be a bit loose
*/
/datum/role/planetary_defense_force
	name = PDF
	id = PDF
	special_role = PDF
	logo_state = "ig-standard-logo"
	var/times_patrolled = 0 //Total times patrolled
	var/exterminated = 0 //Total things we have killed
	var/orks_exterminated = 0 //Total orks we have killed

/datum/role/planetary_defense_force/New(var/datum/mind/M, var/datum/faction/fac=null, var/new_id)
	..()
	if(faction)
		return
	var/datum/faction/F = find_active_faction_by_type(/datum/faction/planetary_defense_force)
	if(!F)
		F = ticker.mode.CreateFaction(/datum/faction/planetary_defense_force, null, 1)
		F.forgeObjectives()
		F.HandleRecruitedRole(src)
	else
		F.HandleRecruitedRole(src)
 
/datum/role/planetary_defense_force/GetScoreboard()
	return // We handle it on the faction proc, since its a score list.

/datum/role/planetary_defense_force/point_handler(var/mob/living/carbon/human/H)
	exterminated++ //Simple enough
	if(isork(H))
		orks_exterminated++
