//This is just the role that is appended to the player client.

/datum/role/imperial_guard
	name = IMPERIALGUARDSMEN
	id = IMPERIALGUARDSMEN
	special_role = IMPERIALGUARDSMEN
	logo_state = "ig-standard-logo"

/datum/role/imperial_guard/New(var/datum/mind/M, var/datum/faction/fac=null, var/new_id)
	..()
	if(faction)
		return
	var/datum/faction/F = find_active_faction_by_type(/datum/faction/imperial_guard)
	if(!F)
		F = ticker.mode.CreateFaction(/datum/faction/imperial_guard, null, 1)
		F.forgeObjectives()
		F.HandleRecruitedRole(src)
	else
		F.HandleRecruitedRole(src)

//This is where we append /datum/objective path type things later.
/datum/role/imperial_guard/ForgeObjectives()
	..()

/datum/role/imperial_guard/proc/mind_storage(var/datum/mind/M)
	M.store_memory("The artifacts on the map are: [english_list(mcguffin_items)]")

//Just whats in the stat panel if they have the mind
/datum/role/imperial_guard/StatPanel()
	var/datum/faction/imperial_guard/iguard = faction
	if (!istype(iguard))
		return
	var/fucktime = round(iguard.time_left)
	var/dat = "Raid time left: [num2text((fucktime/60))] Minutes"
	return dat
	