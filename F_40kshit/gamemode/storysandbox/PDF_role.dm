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
	var/datum/faction/F = find_active_faction_by_type(/datum/faction/story_sandbox_main)
	if(!F)
		F = ticker.mode.CreateFaction(/datum/faction/story_sandbox_main, null, 1)
		F.forgeObjectives()
		F.HandleRecruitedRole(src)
	else
		F.HandleRecruitedRole(src)
 
/datum/role/planetary_defense_force/OnPostSetup()
	Greet()
	return 1

/datum/role/planetary_defense_force/Greet(var/greeting,var/custom)
	var/icon/logo = icon('icons/logos.dmi', logo_state)
	to_chat(antag.current, {"<img src='data:image/png;base64,[icon2base64(logo)]' style='position: relative; top: 10;'/> 
	<span class='warning'><b>You are registered as a member of the Local Forces!</b>"})
	to_chat(antag.current, "You gain prestige by killing combatants, and patrolling.")
	to_chat(antag.current, "Swipe your ID onto checkpoint consoles out in the world, and hold position to be logged!")
	to_chat(antag.current, "Take Note that you are registered, not obligated to serve it.")


/datum/role/planetary_defense_force/GetScoreboard()
	return // We handle it on the faction proc, since its a score list.

/datum/role/planetary_defense_force/point_handler(var/mob/living/carbon/human/H)
	exterminated++ //Simple enough
	if(isork(H))
		orks_exterminated++
