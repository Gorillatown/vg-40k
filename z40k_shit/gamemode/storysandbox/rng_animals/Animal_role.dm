//This is just the role that is appended to the player client.
/*
	As for why its so barren, in this new iteration someone could use the stat panel to sniff out a spy/agent
	We need to prevent that as much as possible, so things will be a bit loose
*/
/datum/role/native_animal
	name = NATIVEANIMAL
	id = NATIVEANIMAL
	special_role = NATIVEANIMAL
	logo_state = "catbeast-logo"

	var/total_growth = 0 //How many times we have grown.


/datum/role/native_animal/New(var/datum/mind/M, var/datum/faction/fac=null, var/new_id)
	..()
	if(faction)
		return
	var/datum/faction/F = find_active_faction_by_type(/datum/faction/native_animal_faction)
	if(!F)
		F = ticker.mode.CreateFaction(/datum/faction/native_animal_faction, null, 1)
		F.forgeObjectives()
		F.HandleRecruitedRole(src)
	else
		F.HandleRecruitedRole(src)
 
/datum/role/native_animal/GetScoreboard()
	return // We handle it on the faction proc, since its a score list.

/datum/role/native_animal/point_handler(var/mob/living/carbon/human/H)
	return
	