
/*
	Design Draft

Basically we have two datums, the user and the target. We want to use the select in the nanoui template menu.
But that is without sharing the information with everyone.
So we store user choice on their datum, so other people cannot change their settings.
EX:
current_setting = green_alart
Display on other user green_alert(selected)

The Datum will ref a global list of interactive emotes possible, with checks on each to see if they are possible.

More Design Shit
	It is a combination horrible wrestling/interaction menu. 
	Except we can handle any number of parts so a issue arises.
	Thusly, we will split the parts interactions, and the wrestling interactions into two seperate screens.
	Another issue is how do we track things without holding a ton of refs to mob shit.
	So we avoid holding refs to mob parts as much as possible instead working with generics.

Proc Descriptions
	mob/living - 
		improper_interactions() - Calls the interaction datum initially on user input.
	
	datum/interactions - 
		New() - called on new creates the abstract parts datums.
		Destroy() - cleans up everything
		display_the_ui() - initial proc called handles target and src refs, and opens the nanoui.
		create_lewd_parts() - Creates the abstract parts unrelated to mob parts adds them to list
		check_all_existing_mobparts() - Handles existing mobparts
		get_src_desc() - Handles generating source description for lewd shit
		get_target_desc() - Handles generating target description for lewd shit
		Topic() - Handles topic calls from the ui
		ui_interact() - Handles the UI opening, template is interactions.tmpl

	obj/item/organ/miscellaneous
		meme_organ_desc(mob/living/L) - When called returns a string desc
		check_obscured(mob/living/L) - Whether you can see the desc/access the organ. TRUE on obscured, FALSE on not
*/
//Mob Level Verb

//UNCOMMENT THIS WHEN ITS DONE.
/mob/living/verb/improper_interactions()
	set name = "Interact/Wrestle"
	set category = null
	set desc = "Interact with your target"
	set src in view(1)
	
	var/mob/living/L = usr
	if(L)
		L.interactions.display_the_ui(src)

#define INTERACT_RELAXED		0
#define INTERACT_MODERATE		1
#define INTERACT_VIOLENT		2

#define WRESTLING_SCREEN 	0
#define LEWD_SCREEN 		1

//interactions definition
/datum/interactions
	var/mob/living/our_idiot = null //The person 
	var/mob/living/target_idiot = null

	var/first_open = TRUE //First time the UI has been opened on the target
	var/update_cooldown = 0

	var/current_screen = WRESTLING_SCREEN //Current Screen

	var/max_threshold = 100 //Max lewd charge
	var/current_threshold = 0 //Stored lewd charge
	
	var/max_fatigue = 100 //Max wrestling charge
	var/current_fatigue = 0 //Stored wrestling charge
	
	var/selected_force = INTERACT_RELAXED //selected force integer scale
	
	var/selected_interaction = null //Selected Interaction
	var/selected_part = null //Selected Part

	//A special and shit organ list, since we are dedicated to tridick, and quadtit because it will be funny.
	var/list/meme_organ_list = list()


//Created in living.dm Line 20: we pass the source mob in as a param.
/datum/interactions/New(var/mob/living/L)
	if(!L)
		qdel(src)
		return
	our_idiot = L
	create_lewd_parts()

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
	target_idiot = null
	if(the_target != our_idiot)
		target_idiot = the_target
	
	if(target_idiot?.interactions.first_open)
		target_idiot.interactions.check_all_existing_mobparts()
		target_idiot.interactions.first_open = FALSE
	
	if(first_open)
		check_all_existing_mobparts()
		first_open = FALSE
	
	ui_interact(our_idiot)

/*
	Create the parts
*/
/datum/interactions/proc/create_lewd_parts()

	if(our_idiot.gender == MALE && !isork(our_idiot))
		meme_organ_list += new /datum/interactive_organ/weiner()
		meme_organ_list += new /datum/interactive_organ/nuts()
	else
		if(ishuman(our_idiot) && !isork(our_idiot)) //yeah no thanks on a lot of shit. It will only ever be lgbt
			meme_organ_list += new /datum/interactive_organ/vagina()
			meme_organ_list += new /datum/interactive_organ/boob()
	meme_organ_list += new /datum/interactive_organ/anus()

/*
	What a mess but we need wrestling shit basically a mass check on mob parts, so we can keep datums intact
*/
//TODO - MAKE THIS ACTUALLY SPAWN THE SHIT.
/datum/interactions/proc/check_all_existing_mobparts()
	if(ishuman(our_idiot))
		var/mob/living/carbon/human/H = our_idiot
		for(var/datum/interactive_organ/aaa in meme_organ_list)
			if(!aaa.lewd)
				qdel(aaa)

		for(var/datum/organ/external/E in H.organs)
			if(E.status & ORGAN_CUT_AWAY || E.status & ORGAN_DESTROYED)
				continue
			var/datum/interactive_organ/EH
			if(istype(E,/datum/organ/external/head))
				EH = new /datum/interactive_organ/head()
				EH = new /datum/interactive_organ/mouth()
				EH = new /datum/interactive_organ/neck()
				goto Loop_Finish
			if(istype(E,/datum/organ/external/chest))
				EH = new /datum/interactive_organ/chest() 
				goto Loop_Finish
			if(istype(E,/datum/organ/external/l_hand) || istype(E,/datum/organ/external/r_hand))
				EH = new /datum/interactive_organ/hand()
				goto Loop_Finish
			if(istype(E,/datum/organ/external/l_arm) || istype(E,/datum/organ/external/r_arm))
				EH = new /datum/interactive_organ/arm()
				goto Loop_Finish
			if(istype(E,/datum/organ/external/groin))
				EH = new /datum/interactive_organ/groin()
				goto Loop_Finish
			if(istype(E,/datum/organ/external/l_leg) || istype(E,/datum/organ/external/r_leg))
				EH = new /datum/interactive_organ/leg()
				goto Loop_Finish
			if(istype(E,/datum/organ/external/l_foot) || istype(E,/datum/organ/external/r_foot))
				EH = new /datum/interactive_organ/foot()

			Loop_Finish:
			if(E.status & ORGAN_BROKEN)
				EH.broken = TRUE
			
			meme_organ_list += EH

/*
	Fill out our desc
*/
/datum/interactions/proc/get_src_desc()
	var/desc = "We have...."
	for(var/datum/interactive_organ/aaa in meme_organ_list)
		if(aaa.check_obscured(our_idiot))
			continue
		if(current_screen == WRESTLING_SCREEN)
			if(aaa.lewd)
				continue
		else
			if(!aaa.lewd)
				continue

		desc += "<br>[aaa.meme_organ_desc(our_idiot)]"
	
	return desc

/*
	Fill out their desc
*/
/datum/interactions/proc/get_target_desc()
	var/desc = "<br>They have...."
	
	if(target_idiot?.interactions.first_open)
		target_idiot.interactions.check_all_existing_mobparts()
		target_idiot.interactions.first_open = FALSE
	
	for(var/datum/interactive_organ/aaa in target_idiot.interactions.meme_organ_list)
		if(aaa.check_obscured(target_idiot))
			continue
		if(current_screen == WRESTLING_SCREEN)
			if(aaa.lewd)
				continue
		else
			if(!aaa.lewd)
				continue
		
		desc += "<br>[aaa.meme_organ_desc(target_idiot)]"

	return desc


/*
	nanoui handler proc - Beware it updates because we have a bar so data and proc usage need to be kept down.
*/
//The nano_ui proc, in this we want to prepare data for display on (MY shoddy ass) js interface.
/datum/interactions/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = NANOUI_FOCUS)
	var/data[0]
	var/bar_color = FALSE
	data["current_screen"] = current_screen
//Wrestling Screen Data---------------------------
	if(current_screen == WRESTLING_SCREEN)
		data["displayMeter"] = round(100.0*current_fatigue/max_fatigue, 0.1)
		if(current_fatigue > target_idiot?.interactions.current_fatigue)
			bar_color = TRUE

//Lewd Screen Data--------------------------------
	if(current_screen == LEWD_SCREEN)
		data["displayMeter"] = round(100.0*current_threshold/max_threshold, 0.1)
		if(current_threshold > target_idiot?.interactions.current_threshold)
			bar_color = TRUE
		
		data["effort_invested"] = selected_force

//Uniformly sent Data below ----------------------
	data["funtime_barcolor"] = bar_color
	data["source_desc"] = get_src_desc()
	if(target_idiot)
		data["target_desc"] = get_target_desc()
	else
		data["target_desc"] = "<br>You are focused on yourself."

	// update the ui if it exists, returns null if no ui is passed/found
	ui = nanomanager.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		// the ui does not exist, so we'll create a new() one
        // for a list of parameters and their descriptions see the code docs in \code\\modules\nano\nanoui.dm
		ui = new(user, src, ui_key, "interaction.tmpl", "Interactions", 450, 500, ignore_distance = TRUE)
		// when the ui is first opened this is the data it will use
		ui.set_initial_data(data)
		// open the new ui window
		ui.open()
	ui.set_auto_update(1)

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

	if(href_list["selected_screen"])
		switch(href_list["selected_screen"])
			if("lewd")
				current_screen = LEWD_SCREEN
			if("wrestling")
				current_screen = WRESTLING_SCREEN
	return 1


#undef INTERACT_VIOLENT
#undef INTERACT_MODERATE
#undef INTERACT_RELAXED


#undef WRESTLING_SCREEN
#undef LEWD_SCREEN