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
	var/datum/faction/F = find_active_faction_by_type(/datum/faction/story_sandbox_main)
	if(!F)
		F = ticker.mode.CreateFaction(/datum/faction/story_sandbox_main, null, 1)
		F.forgeObjectives()
		F.HandleRecruitedRole(src)
	else
		F.HandleRecruitedRole(src)
 
/datum/role/rogue_psyker/OnPostSetup()
	if(ishuman(antag.current))
		equip_rogue_psyker(antag.current)
		Greet()
	return 1

/datum/role/rogue_psyker/Greet()
	var/icon/logo = icon('icons/logos.dmi', logo_state)
	to_chat(antag.current, {"<img src='data:image/png;base64,[icon2base64(logo)]' style='position: relative; top: 10;'/> 
	<span class='warning'><b>You are a unsanctioned psyker!</span></b>"})
	to_chat(antag.current, "Obviously nobody knows you are a psyker except yourself at this moment!")
	to_chat(antag.current, "Keep in mind that you are currently NOT tainted by Chaos")
	to_chat(antag.current, "You'll locate a power dictionary in your backpack!")

/datum/role/rogue_psyker/proc/equip_rogue_psyker(var/mob/living/carbon/human/H)
	H.equip_or_collect(new /obj/item/weapon/psychic_spellbook, slot_in_backpack)
	H.attribute_willpower += 4
	H.attribute_sensitivity = 500
	H.psyker_points = 4

/datum/role/rogue_psyker/GetScoreboard()
	return // We handle it on the faction proc, since its a score list.

