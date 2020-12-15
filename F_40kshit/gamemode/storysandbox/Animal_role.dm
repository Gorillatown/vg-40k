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


/datum/role/native_animal/Greet(var/greeting,var/custom)
	var/icon/logo = icon('icons/logos.dmi', logo_state)
	to_chat(antag.current, {"<img src='data:image/png;base64,[icon2base64(logo)]' style='position: relative; top: 10;'/> 
	<span class='warning'><b>You are a native!</span></b>"})
	to_chat(antag.current, "Unlike other animals, you find yourself capable of thought and notable growth!")
	to_chat(antag.current, "You heal through eating, and grow through eating.")
	to_chat(antag.current, "You are your own master!")

/datum/role/native_animal/OnPostSetup()
	Greet()
	return 1

/datum/role/native_animal/New(var/datum/mind/M, var/datum/faction/fac=null, var/new_id)
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
 
/datum/role/native_animal/GetScoreboard()
	return // We handle it on the faction proc, since its a score list.

/datum/role/native_animal/point_handler(var/mob/living/carbon/human/H)
	return
	