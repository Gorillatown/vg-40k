/datum/faction/dyn_ork
	name = "Ork Mob"
	desc = "For orks who want friends."
	initial_role = ORKMOBBOSS
	late_role = ORKMOBBOSS
	roletype = /datum/role/mob_boss
	initroletype = /datum/role/mob_boss
	ID = CUSTOMSQUAD
	logo_state = "vampire-logo"
	hud_icons = list("vampire-logo", "thrall-logo")

/datum/faction/dyn_ork/New()
	..()
	ID = rand(1,999)
	//var/datum/objective/custom/c = new /datum/objective/custom
	//c.explanation_text = mission
//	AppendObjective(c)
	
/datum/faction/dyn_ork/proc/addMaster(var/datum/role/mob_boss/V)
	if(!leader)
		leader = V
		V.faction = src

/datum/faction/dyn_ork/proc/name_clan(var/datum/role/mob_boss/V)
	set waitfor = FALSE
	var/newname = copytext(sanitize(input(V.antag.current,"You are da boss of dis ere' mob. Think up a good name ya git", "Name change","")),1,MAX_NAME_LEN)
	if(newname)
		if (newname == "Unknown" || newname == "floor" || newname == "wall" || newname == "rwall" || newname == "_")
			to_chat(V.antag.current, "That name is reserved.")
		name = "The [newname]."


/datum/faction/dyn_ork/OnPostSetup()
	leader.OnPostSetup()

/datum/faction/dyn_ork/can_setup()
	// TODO : check if the number of players > 10, if we have at least 2 players with vamp enabled.
	return TRUE

/datum/faction/dyn_ork/Topic(href, href_list)
	..()

	var/mob/living/L = usr
	if(!istype(L))
		return
