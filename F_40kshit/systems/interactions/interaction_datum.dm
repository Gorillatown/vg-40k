
/*
	Design Draft
*/
//Mob Level Verb

//UNCOMMENT THIS WHEN ITS DONE.
/*
/mob/living/verb/improper_interactions()
	set name = "Interact/Wrestle"
	set category = null
	set desc = "Interact with your target"
	set src in view(1)
	
	var/mob/living/L = usr
	if(L)
		L.interactions.display_the_ui(src)
*/

#define SCREEN_WRESTLING 1

//interactions definition
/datum/interactions
	var/mob/living/our_idiot = null //The person 
	var/mob/living/target_idiot = null
	var/current_screen = SCREEN_WRESTLING

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
/datum/interactions/proc/display_the_ui(mob/living/user)
	var/dat
	//SCREEN SELECTION
	dat += {"<head><title> Wrestling Menu </title></head>
		<body style="color:#2ae012" bgcolor="#181818"><ul>"}
	
	dat += {"
			<b>Menus Available:
			<a href='?src=\ref[src];current_screen=wrestling'>Wrestling</a>
			<hr>
			"}
	if(current_screen == SCREEN_WRESTLING)
		dat += "<div id=\"part_segment\" style=\"width:100%; height:100%; display:flex;\">"
		dat +=	"<div id=\"userside\" style=\"float: left; width: 50%\";background-color:#1f1c1c; border-style:solid; border-color: #999797\">"
		//FOR LOOP HERE
		dat += "</div>"	

					
		dat += "<div id=\"targetside\" style=\"float:right; width:50%; background-color:#1f1c1c; border-style:solid; border-color: #999797\">"
		dat += "</div></div>"

	
	dat += "</body>"
	
	user << browse(dat, "window=wrestle_menu;size=550x600")
	onclose(user, "wrestle_menu")

/*
	Create the parts
*/


/*
	What a mess but we need wrestling shit basically a mass check on mob parts, so we can keep datums intact
*/
/*
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
*/		

/*
	Below is UI and TOPIC handling
*/
//Href handlin
/datum/interactions/Topic(href, href_list)
	return 1


#undef SCREEN_WRESTLING
