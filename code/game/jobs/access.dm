//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:31

/var/const/access_lord = 1
/var/const/access_knight = 2
/var/const/access_enginseer = 3
/var/const/access_seneschal = 4

/obj/var/list/req_access = null
/obj/var/req_access_txt = "0"			// A user must have ALL of these accesses to use the object
/obj/var/list/req_one_access = null
/obj/var/req_one_access_txt = "0"		// If this list is populated, a user must have at least ONE of these accesses to use the object

//returns 1 if this mob has sufficient access to use this object
/obj/proc/allowed(var/mob/M)
	set_up_access()
	if(!M || !istype(M))
		return 0 // I guess?  This seems to happen when AIs use something.
	if(M.hasFullAccess()) // AI, adminghosts, etc.
		return 1
	var/list/ACL = M.GetAccess()
	return can_access(ACL,req_access,req_one_access)

/obj/item/proc/GetAccess()
	return list()

/proc/get_all_accesses()
	return list()

/proc/get_region_accesses(var/code)
	switch(code)
		if(0 to 7)
			return get_all_accesses()

/proc/get_region_accesses_name(var/code)
	switch(code)
		if(0 to 7)
			return "All"

/obj/item/proc/GetID()
	return null

/obj/item/proc/get_owner_name_from_ID()
	return null

/obj/proc/set_up_access()
	//These generations have been moved out of /obj/New() because they were slowing down the creation of objects that never even used the access system.
	if(!src.req_access)
		src.req_access = list()
		if(src.req_access_txt)
			var/list/req_access_str = splittext(req_access_txt,";")
			for(var/x in req_access_str)
				var/n = text2num(x)
				if(n)
					req_access += n

	if(!src.req_one_access)
		src.req_one_access = list()
		if(src.req_one_access_txt)
			var/list/req_one_access_str = splittext(req_one_access_txt,";")
			for(var/x in req_one_access_str)
				var/n = text2num(x)
				if(n)
					req_one_access += n

/obj/proc/check_access(obj/item/I)
	set_up_access()
	var/list/ACL = list()
	if(I)
		ACL=I.GetAccess()
	return can_access(ACL,req_access,req_one_access)

/obj/proc/check_access_list(var/list/L)
	set_up_access()
	if(!src.req_access  && !src.req_one_access)
		return 1
	if(!istype(src.req_access, /list))
		return 1
	if(!src.req_access.len && (!src.req_one_access || !src.req_one_access.len))
		return 1
	if(!L)
		return 0
	if(!istype(L, /list))
		return 0
	for(var/req in src.req_access)
		if(!(req in L)) //doesn't have this access
			return 0
	if(src.req_one_access && src.req_one_access.len)
		for(var/req in src.req_one_access)
			if(req in L) //has an access from the single access list
				return 1
		return 0
	return 1

/proc/get_access_desc(A)
	switch(A)
		if("Ass")
			return "Fuck you"

// /vg/ - Generic Access Checks.
// Allows more flexible access checks.
/proc/can_access(var/list/L, var/list/req_access=null,var/list/req_one_access=null)
	// No perms set?  He's in.
	if(!req_access  && !req_one_access)
		return 1
	// Fucked permissions set?  He's in.
	if(!istype(req_access, /list))
		return 1
	// Blank permissions set?  He's in.
	if(!req_access.len && (!req_one_access || !req_one_access.len))
		return 1

	// User doesn't have any accesses?  Fuck off.
	if(!L)
		return 0
	if(!istype(L, /list))
		return 0

	// Doesn't have a req_access
	for(var/req in req_access)
		if(!(req in L)) //doesn't have this access
			return 0

	// If he has at least one req_one access, he's in.
	if(req_one_access && req_one_access.len)
		for(var/req in req_one_access)
			if(req in L) //has an access from the single access list
				return 1
		return 0
	
	return 0

/proc/wpermit(var/mob/M) //weapons permit checking
	return 1

// Cache - N3X
var/global/list/all_jobs
/proc/get_all_jobs()
	// Have cache?  Use cache.
	if(all_jobs)
		return all_jobs

	// Rebuild cache.
	all_jobs=list()
	for(var/jobtype in typesof(/datum/job) - /datum/job)
		var/datum/job/jobdatum = new jobtype
		if(jobdatum.info_flag & JINFO_SILICON)
			continue
		all_jobs.Add(jobdatum.title)
	return all_jobs

/proc/get_all_centcom_jobs()
	return list("VIP Guest","Custodian","Thunderdome Overseer","Intel Officer","Medical Officer","Death Commando","Research Officer","BlackOps Commander","Supreme Commander")


/proc/FindNameFromID(var/mob/living/carbon/human/H)
	ASSERT(istype(H))
	var/obj/item/weapon/card/id/C = H.get_active_hand()
	if( istype(C) || istype(C, /obj/item/device/pda) )
		var/obj/item/weapon/card/id/ID = C

		if( istype(C, /obj/item/device/pda) )
			var/obj/item/device/pda/pda = C
			ID = pda.id
		if(!istype(ID))
			ID = null

		if(ID)
			return ID.registered_name

	C = H.wear_id

	if( istype(C) || istype(C, /obj/item/device/pda) )
		var/obj/item/weapon/card/id/ID = C

		if( istype(C, /obj/item/device/pda) )
			var/obj/item/device/pda/pda = C
			ID = pda.id
		if(!istype(ID))
			ID = null

		if(ID)
			return ID.registered_name

/proc/get_all_job_icons() //For all existing HUD icons
	return get_all_jobs() + list("Prisoner", "visitor")
