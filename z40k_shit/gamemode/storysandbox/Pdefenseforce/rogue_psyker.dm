//This is just the role that is appended to the player client.
/*
	As for why its so barren, in this new iteration someone could use the stat panel to sniff out a spy/agent
	We need to prevent that as much as possible, so things will be a bit loose
*/
/datum/role/rogue_psyker
	name = ROGUE_PSYKER
	id = ROGUE_PSYKER
	special_role = ROGUE_PSYKER
	logo_state = "ig-psyker-logo"

/datum/role/rogue_psyker/New(var/datum/mind/M, var/datum/faction/fac=null, var/new_id)
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
 
/datum/role/rogue_psyker/GetScoreboard()
	return // We handle it on the faction proc, since its a score list.

