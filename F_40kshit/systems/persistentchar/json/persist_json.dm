/*
	Within is a disjointed save proc for the potential system.
																*/

//Basically this holds all of the datum for people to reference
var/list/json_persistence = list()

/datum/interactive_persistence
	var/potential = 0
	var/ooc_color = "#002eb8"
	var/money_saved = 0

	var/list/characters = list()
/*
	Unlike the sqlite3 iteration of persistence, this one just writes peoples shit to
	individual json files.
	I've mulled over many gameplans, basically instead of tying the datum to a client
	and datum to the client.
	We will try out making the datum, then keying it to the ckey in a string in a single global assc list.
	When a client logs in, we check, and if nothing turns up, we create it, also seeing if the json exists.

	THE PLAN -
	Basically we make the one datum to hold all the procs into this.
	When someone logs in, it searches for a file with their ckey name.
	Then the ckey name is json_encoded into the global list that is called json_persistence

*/
/datum/interactive_persistence/New(var/ckey)
	if(fexists("fuckyou/[ckey].json"))
		load_persistence_json(ckey)
	else //This only occurs on a player first joining.
		save_persistence_json(ckey)
		json_persistence["[ckey]"] = src

	to_chat(world,"INTERACTIVE PERSISTENCE NEW")

/datum/interactive_persistence/proc/save_persistence_json(var/ckey)
	to_chat(world,"INTERACTIVE PERSISTENCE SAVE")
	if(fexists("fuckyou/[ckey].json")) //check if the file already exists
		if(!fdel("fuckyou/[ckey].json")) //delete the old file.
			world.log << "unable to clear [ckey]'s old file!"
			return 0
	var/writing = file("fuckyou/[ckey].json")
	var/list/save_list = list()
	
	save_list["potential"] = potential
	save_list["ooc_color"] = ooc_color
	save_list["money_saved"] = money_saved
	/*var/list/char2save = list()
	for(var/datum/interactive_persistence_character/m in characters)
		char2save["character"] = list("charname" = "[m.charname]", "impurity" = "[m.impurity]")
	
	save_list["characters"] = char2save*/

	writing << json_encode(save_list)

/datum/interactive_persistence/proc/load_persistence_json(var/ckey)
	to_chat(world,"INTERACTIVE PERSISTENCE LOAD")
	var/list/load_list = list()
	var/reading = file("fuckyou/[ckey].json")
	load_list = json_decode(file2text(reading))
	for(var/key in load_list)
		switch(key)
			if("potential")
				potential = load_list[key]
			if("ooc_color")
				ooc_color = load_list[key]
			if("money_saved")
				money_saved = load_list[key]
			if("character")
				if(islist(load_list[key]))
					var/list/load_list_chars = load_list[key]
					for(var/load_char in load_list_chars)
						var/datum/interactive_persistence_character/argh = new()
						for(var/char_vars in load_list_chars)
							argh.charname = load_list_chars["charname"]
							argh.impurity = load_list_chars["impurity"]
							characters["[argh.charname]"] = argh
	
	json_persistence["[ckey]"] = src

/datum/interactive_persistence/proc/change_potential(var/value)
	if(!value)
		return
	if(value > 0)
		potential += value
	else
		potential -= value

/mob/verb/read_my_datum_nigga()
//	set name = "Gibself"
//	set category = "Fun"
	var/datum/interactive_persistence/persist = json_persistence["[ckey]"]
	to_chat(world,"potential: [persist.potential], ooc_color: [persist.ooc_color], money_saved: [persist.money_saved]")

/mob/verb/save_persistence()
	var/datum/interactive_persistence/persist = json_persistence["[ckey]"]
	persist.save_persistence_json(ckey)

/mob/verb/raise_potential()
	var/datum/interactive_persistence/persist = json_persistence["[ckey]"]
	var/new_potential = input(usr, "Select a new potential", "Potential", persist.potential) as null|num
	persist.potential = new_potential

/mob/verb/what_is_in_db()
	for(var/m in json_persistence)
		to_chat(world, "[m] = [json_persistence[m]]")