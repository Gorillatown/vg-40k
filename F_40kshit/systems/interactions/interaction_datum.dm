/*
	The return of these fuckers, altho im not gonna like port it, instead ill just code my own
	iteration.
*/
/*
	Design Draft

Basically we have two datums, the user and the target. We want to use the select in the nanoui template menu.
But that is without sharing the information with everyone.
So we store user choice on their datum, so other people cannot change their settings.
EX:
current_setting = green_alart
Display on other user green_alert(selected)

The Datum will ref a global list of interactive emotes possible, with checks on each to see if they are possible.
*/
//Mob Level Verb
/*
//UNCOMMENT THIS WHEN ITS DONE.
/mob/living/verb/improper_interactions()
	set name = "Interact"
	set category = null
	set desc = "Interact with your target"
	set src in view(1)
	
	var/mob/living/L = usr
	if(L)
		L.interactions.display_the_ui(src)
*/
#define INTERACT_VIOLENT		2
#define INTERACT_MODERATE		1
#define INTERACT_RELAXED		0

//interactions definition
/datum/interactions
	var/mob/living/our_idiot = null //The person 
	var/mob/living/target_idiot = null
/*
	ha ah aha
*/
	var/max_threshold = 100 //Max stored charge
	var/current_threshold = 0 //Stored charge
	var/selected_force = 0 //selected force integer scale
	
	var/selected_interaction = 0
	var/selected_part = 0 

//Created in living.dm Line 20: we pass the source mob in as a param.
/datum/interactions/New(var/mob/living/L)
	if(!L)
		qdel(src)
		return
	our_idiot = L

//Called in Living.dm Line 22 when cleaning up stuff
/datum/interactions/Destroy()
	our_idiot.interactions = null
	our_idiot = null
	target_idiot = null
	..()

/*
	This is called when the verb is used on a mob
*/
/datum/interactions/proc/display_the_ui(mob/living/the_target)
	target_idiot = the_target


/*
	Below is UI and TOPIC handling
*/
//Href handlin
/datum/interactions/Topic(href, href_list)
	if(href_list["selected_force"])
		switch(href_list["selected_force"])
			if("violent")
				selected_force = INTERACT_VIOLENT
			if("moderate")
				selected_force = INTERACT_MODERATE
			if("relaxed")
				selected_force = INTERACT_RELAXED

	return 1

//The nano_ui proc, in this we want to prepare data for display on (MY shoddy ass) js interface.
/datum/interactions/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = NANOUI_FOCUS)
	var/data[0]
	data["displayThreshold"] = round(100.0*current_threshold/max_threshold, 0.1)
	var/bar_color = FALSE
	if(current_threshold > target_idiot.interactions.current_threshold)
		bar_color = TRUE
	data["funtime_barcolor"] = bar_color
	
	//TODO: make target desc fill out an assc list
	var/target_desc_list[0]
	//for(var/strings in FILL THIS OUT) 
		//target_desc_list.Add(list(list("target_feature" = "[strings]"))) 
	data["target_desc"] = target_desc_list

	var/source_desc_list[0]
	//for(var/strings in FILL THIS OUT)
		//source_desc_list.Add(list(list("source_feature" = "[strings]"))) 
	data["source_desc"] = source_desc_list
	data["effort_invested"] = selected_force
	
	// update the ui if it exists, returns null if no ui is passed/found
	ui = nanomanager.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		// the ui does not exist, so we'll create a new() one
        // for a list of parameters and their descriptions see the code docs in \code\\modules\nano\nanoui.dm
		ui = new(user, src, ui_key, "interaction.tmpl", "Interactions", 450, 500)
		// when the ui is first opened this is the data it will use
		ui.set_initial_data(data)
		// open the new ui window
		ui.open()
	ui.set_auto_update(1)

#undef INTERACT_VIOLENT
#undef INTERACT_MODERATE
#undef INTERACT_RELAXED
