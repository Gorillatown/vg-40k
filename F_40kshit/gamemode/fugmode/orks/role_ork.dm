//This is just the role that is appended to the player client.

/datum/role/ork_raider
	name = ORKRAIDER
	id = ORKRAIDER
	special_role = ORKRAIDER
	logo_state = "ork-standard-logo"

/datum/role/ork_raider/New(var/datum/mind/M, var/datum/faction/fac=null, var/new_id)
	..()
	if(faction)
		return
	var/datum/faction/F = find_active_faction_by_type(/datum/faction/ork_raiders)
	if(!F)
		F = ticker.mode.CreateFaction(/datum/faction/ork_raiders, null, 1)
		F.forgeObjectives()
		F.HandleRecruitedRole(src)
	else
		F.HandleRecruitedRole(src)

//This is where we append /datum/objective path type things later.
/datum/role/imperial_guard/ForgeObjectives()
	..()

/datum/role/ork_raider/proc/mind_storage(var/datum/mind/M)
	M.store_memory("The artifacts on the map are: [english_list(mcguffin_items)]")

//Just whats in the stat panel if they have the mind
/datum/role/ork_raider/StatPanel()
	var/datum/faction/ork_raiders/orkraider = faction
	if (!istype(orkraider))
		return
	var/fucktime = round(orkraider.time_left)
	var/dat = "Raid time left: [num2text((fucktime/60))] Minutes"
	return dat
	