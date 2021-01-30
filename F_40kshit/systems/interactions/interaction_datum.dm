
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
		create_lewd_parts() - Creates the datums unrelated to mob parts adds them to list
		check_all_existing_mobparts() - Handles existing mobparts and creates datums adds them to list
		get_src_desc() - Handles generating source description for lewd shit
		get_target_desc() - Handles generating target description for lewd shit
		Topic() - Handles topic calls from the ui
		ui_interact() - Handles the UI opening, template is interactions.tmpl
		let_free() - Cleans up all refs to other mob/parts refs

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
	var/next_action_fire = 0 //Delay on actions, basically world.time + 1 SECONDS

	var/current_screen = WRESTLING_SCREEN //Current Screen

	var/max_threshold = 100 //Max lewd charge
	var/current_threshold = 0 //Stored lewd charge
	
	var/max_fatigue = 100 //Max wrestling charge
	var/current_fatigue = 0 //Stored wrestling charge
	
	var/selected_force = INTERACT_RELAXED //selected force integer scale
	
	var/datum/interactive_actions/selected_action = null //Selected Interaction
	var/datum/interactive_organ/selected_part_user = null //Selected User Part
	var/datum/interactive_organ/selected_part_target = null //Selected Target Part

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
	selected_action = null
	selected_part_user = null
	selected_part_target = null
	for(var/datum/interactive_organ/EH in meme_organ_list)
		EH.parent_datum = null
		qdel(EH)
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
		var/datum/interactive_organ/EH = new /datum/interactive_organ/weiner()
		var/datum/interactive_organ/EHH = new /datum/interactive_organ/nuts()
		
		EH.parent_datum = src
		EHH.parent_datum = src
		meme_organ_list += EH
		meme_organ_list += EHH
	else
		if(ishuman(our_idiot) && !isork(our_idiot)) //yeah no thanks on a lot of shit. It will only ever be lgbt
			var/datum/interactive_organ/EH = new /datum/interactive_organ/vagina()
			var/datum/interactive_organ/EHH = new /datum/interactive_organ/boob()
			
			EH.parent_datum = src
			EHH.parent_datum = src
			meme_organ_list += EH
			meme_organ_list += EHH
	
	var/datum/interactive_organ/AA = new /datum/interactive_organ/anus()
	AA.parent_datum = src
	meme_organ_list += AA

/*
	What a mess but we need wrestling shit basically a mass check on mob parts, so we can keep datums intact
*/
/datum/interactions/proc/check_all_existing_mobparts()
	if(ishuman(our_idiot))
		var/mob/living/carbon/human/H = our_idiot
		for(var/datum/interactive_organ/aaa in meme_organ_list)
			if(!aaa.lewd)
				qdel(aaa)

		for(var/datum/organ/external/E in H.organs)
			if(E.status & ORGAN_CUT_AWAY || E.status & ORGAN_DESTROYED)
				continue
			var/datum/interactive_organ/EH = new()
			EH.name = E.display_name
			EH.organ_type = E.name
			switch(E.display_name)
				if(LIMB_HEAD)
					var/datum/interactive_organ/EHH = new /datum/interactive_organ/neck() //two extra parts to target w head
					var/datum/interactive_organ/EHHH = new /datum/interactive_organ/mouth()
					EHH.parent_datum = src
					EHHH.parent_datum = src
					meme_organ_list += EHH
					meme_organ_list += EHHH

			if(E.status & ORGAN_BROKEN)
				EH.broken = TRUE

			EH.parent_datum = src
			meme_organ_list += EH
			

/*
	Fill out our desc
*/
/datum/interactions/proc/get_src_desc()
	var/desc = "We have...."
	for(var/datum/interactive_organ/aaa in meme_organ_list)
		if(aaa.check_obscured(our_idiot))
			continue
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
		if(!aaa.lewd)
			continue
		
		desc += "<br>[aaa.meme_organ_desc(target_idiot)]"

	return desc


	

/*
	nanoui handler proc - Beware it autoupdates
*/
//The nano_ui proc, in this we want to prepare data for display on (MY shoddy ass) js interface.
/datum/interactions/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = NANOUI_FOCUS)
//Uniformly sent Data Start of Proc ----------------------
	var/data[0]
	var/bar_color = FALSE
	data["current_screen"] = current_screen
	
	if(selected_part_user)
		data["selected_user_part_uid"] = selected_part_user.unique_id
	if(selected_part_target)
		data["selected_target_part_uid"] = selected_part_target.unique_id

	var/avail_actions[0]
	if(selected_part_user && selected_part_target)
		for(var/datum/interactive_actions/ass in interaction_actions)
			if(ass.check_can_use(selected_part_user, selected_part_target))
				var/argh = "0"
				if(selected_part_user.current_action)
					argh = selected_part_user.current_action.unique_id
				avail_actions.Add(list(list("name" = ass.name, "action_unique_id" = ass.unique_id, "part_action_unique_id" = argh)))

	data["available_actions"] = avail_actions
	if(selected_action)
		data["selected_action_uid"] = selected_action.unique_id
	

//Wrestling Screen Data---------------------------
	var/user_wrestling_data[0]
	var/target_wrestling_data[0]
	if(current_screen == WRESTLING_SCREEN)
		data["displayMeter"] = round(100.0*current_fatigue/max_fatigue, 0.1)
		if(current_fatigue > target_idiot?.interactions.current_fatigue)
			bar_color = TRUE

		for(var/datum/interactive_organ/aaa in meme_organ_list)
			if(aaa.lewd)
				continue
			user_wrestling_data.Add(list(list("name" = aaa.name, "unique_id" = aaa.unique_id)))
	
		if(target_idiot)
			for(var/datum/interactive_organ/bbb in target_idiot.interactions.meme_organ_list)
				if(bbb.lewd)
					continue
				target_wrestling_data.Add(list(list("name" = bbb.name, "unique_id" = bbb.unique_id)))
		
		data["user_wrestling_parts"] = user_wrestling_data
		data["target_wrestling_parts"] = target_wrestling_data


//Lewd Screen Data--------------------------------
	if(current_screen == LEWD_SCREEN)
		data["displayMeter"] = round(100.0*current_threshold/max_threshold, 0.1)
		if(current_threshold > target_idiot?.interactions.current_threshold)
			bar_color = TRUE
		
		data["effort_invested"] = selected_force

		data["source_desc"] = get_src_desc()
		if(target_idiot)
			data["target_desc"] = get_target_desc()
		else
			data["target_desc"] = "<br>You are focused on yourself."

//Uniformly sent Data End of Proc ----------------------
	data["funtime_barcolor"] = bar_color

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
	
	if(href_list["perform"]) //Nothing else passed in soo....
		if(world.time > next_action_fire) //Cooldown check
			next_action_fire = world.time + 1 SECONDS 
			for(var/datum/interactive_organ/aggressor in meme_organ_list) //loop thru our list
				if(aggressor.current_action) //If it has a current action
					if(aggressor.part_grabbing.len && aggressor != selected_part_user) //If it is currently grabbing something
						to_chat(world,"ENTER FIRST HALF")
						for(var/user_unique_ids in aggressor.part_grabbing) //loop thru unique ids of things its grabbing
							for(var/datum/interactive_organ/victim_organ in target_idiot.interactions.meme_organ_list)
								if(victim_organ.unique_id == user_unique_ids) //If the organ in targets list matches grabbed thing
									aggressor.current_action.on_use(aggressor,victim_organ) //aggressor current action onuse found organ
					else //If it is not currently grabbing something we have a conundrum
						to_chat(world,"ENTER SECOND HALF")
						aggressor.current_action.on_use(selected_part_user,selected_part_target)
						

	if(href_list["parts_interactions"])
		switch(href_list["parts_interactions"])
			if("our_side")
				var/part_id = href_list["part_id"]
				for(var/datum/interactive_organ/aaa in meme_organ_list)
					if(aaa.unique_id == part_id)
						selected_part_user = aaa
			
			if("target_side")
				var/part_id = href_list["part_id"]
				for(var/datum/interactive_organ/aaa in target_idiot.interactions.meme_organ_list)
					if(aaa.unique_id == part_id)
						selected_part_target = aaa
						break

	if(href_list["action_interactions"])
		var/selected_action_uid = href_list["action_unique_id"]
		to_chat(world, "ACTION INTERACTIONS")
		for(var/datum/interactive_actions/aaa in interaction_actions)
			if(selected_action_uid == aaa.unique_id)
				selected_part_user.current_action = aaa
				break
			
	if(href_list["let_free"]) //a nasty full ref cleaning
		let_free()
				
	return 1

/*
	Cleans refs between us and the target, but not refs between the target and other aggressors
*/
/datum/interactions/proc/let_free()
	for(var/datum/interactive_organ/aaa in meme_organ_list)
		aaa.current_action = null //Clean up ref of actions selected
		
		for(var/datum/interactive_organ/bbb in target_idiot.interactions.meme_organ_list) 
			for(var/some_uids in aaa.part_grabbing) 
				if(some_uids == bbb.unique_id) //We found bbb organ in our grabbing list
					bbb.part_grabbed_by -= aaa.unique_id //Remove aaa from bbb grabbed by list
					aaa.part_grabbing -= bbb.unique_id  //Remove bbb from aaa grabbing list
	
			for(var/more_uids in aaa.part_grabbed_by)
				if(more_uids == bbb.unique_id) //We found bbb organ in our grabbed by list
					bbb.part_grabbing -= aaa.unique_id //Remove aaa from bbb grabbing list
					aaa.part_grabbed_by -= bbb.unique_id //Remove bbb from aaa grabbed by list
			
	target_idiot = null //Clean up ref to other mob


#undef INTERACT_VIOLENT
#undef INTERACT_MODERATE
#undef INTERACT_RELAXED

#undef WRESTLING_SCREEN
#undef LEWD_SCREEN
