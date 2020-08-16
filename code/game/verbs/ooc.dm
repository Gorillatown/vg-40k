/client/verb/ooc(msg as text)
	set name = "OOC" //Gave this shit a shorter name so you only have to time out "ooc" rather than "ooc message" to use it --NeoFite
	set category = "OOC"

	if(say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='warning'>Speech is currently admin-disabled.</span>")
		return

	if(!mob)
		return

	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	msg = parse_emoji(msg, ooc_mode = TRUE)
	if(!msg)
		return

	if(!(prefs.toggles & CHAT_OOC))
		to_chat(src, "<span class='warning'>You have OOC muted.</span>")
		return

	if(!holder)
		if(!ooc_allowed)
			to_chat(src, "<span class='warning'>OOC is globally muted</span>")
			return
		if(!dooc_allowed && (mob.stat == DEAD))
			to_chat(usr, "<span class='warning'>OOC for dead mobs has been turned off.</span>")
			return
		if(prefs.muted & MUTE_OOC)
			to_chat(src, "<span class='warning'>You cannot use OOC (muted).</span>")
			return
		if(oocban_isbanned(ckey))
			to_chat(src, "<span class='warning'>You cannot use OOC (banned).</span>")
			return
		if(handle_spam_prevention(msg,MUTE_OOC))
			return
		if((copytext(msg, 1, 2) in list(".",";",":","#")) || (findtext(lowertext(copytext(msg, 1, 5)), "say")))
			if(alert("Your message \"[msg]\" looks like it was meant for in game communication, say it in OOC?", "Meant for OOC?", "No", "Yes") != "Yes")
				return

	var/display_colour = src.persist.ooc_color

	for(var/client/C in clients)
		if(C.prefs.toggles & CHAT_OOC)
			var/display_name = src.key
			if(holder)
				if(holder.fakekey)
					if(C.holder)
						display_name = "[holder.fakekey]/([src.key])"
					else
						display_name = holder.fakekey
			to_chat(C, "<font color='[display_colour]'><span class='ooc'><span class='prefix'>OOC:</span> <EM>[display_name]:</EM> <span class='message'>[msg]</span></span></font>")
	
// Stealing it back :3c -Nexypoo
/client/verb/looc(msg as text)
	set name = "LOOC" //Gave this shit a shorter name so you only have to time out "ooc" rather than "ooc message" to use it --NeoFite
	set desc = "Local OOC, seen only by those in view."
	set category = "OOC"

	if(say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='warning'>Speech is currently admin-disabled.</span>")
		return

	if(!mob)
		return
	if(IsGuestKey(key))
		to_chat(src, "Guests may not use OOC.")
		return

	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	msg = parse_emoji(msg, ooc_mode = TRUE)
	if(!msg)
		return

	if(!(prefs.toggles & CHAT_LOOC))
		to_chat(src, "<span class='warning'>You have LOOC muted.</span>")
		return

	if(!holder)
		if(!looc_allowed)
			to_chat(src, "<span class='warning'>LOOC is globally muted</span>")
			return
		if(!dooc_allowed && (mob.stat == DEAD))
			to_chat(usr, "<span class='warning'>LOOC for dead mobs has been turned off.</span>")
			return
		if(prefs.muted & MUTE_OOC)
			to_chat(src, "<span class='warning'>You cannot use LOOC (muted).</span>")
			return
		if(oocban_isbanned(ckey))
			to_chat(src, "<span class='warning'>You cannot use LOOC (banned).</span>")
			return
		if(handle_spam_prevention(msg,MUTE_OOC))
			return
		/*if(findtext(msg, "byond://"))
			to_chat(src, "<B>Advertising other servers is not allowed.</B>")
			log_admin("[key_name(src)] has attempted to advertise in LOOC: [msg]")
			message_admins("[key_name_admin(src)] has attempted to advertise in LOOC: [msg]")
			return
		*/
		if((copytext(msg, 1, 2) in list(".",";",":","#")) || (findtext(lowertext(copytext(msg, 1, 5)), "say")))
			if(alert("Your message \"[msg]\" looks like it was meant for in game communication, say it in LOOC?", "Meant for LOOC?", "No", "Yes") != "Yes")
				return
	log_ooc("(LOCAL) [mob.name]/[key] (@[mob.x],[mob.y],[mob.z]): [msg]")
	var/list/heard
	var/mob/living/silicon/ai/AI
	if(!isAI(src.mob))
		heard = get_hearers_in_view(7, src.mob)
	else
		AI = src.mob
		heard = get_hearers_in_view(7, (istype(AI.eyeobj) ? AI.eyeobj : AI)) //if it doesn't have an eye somehow give it just the AI mob itself
	for(var/mob/M in heard)
		if(AI == M)
			continue
		if(!M.client)
			continue
		var/client/C = M.client
		if (C in admins)
			continue //they are handled after that
		if(isAIEye(M))
			var/mob/camera/aiEye/E = M
			if(E.ai)
				C = E.ai.client
		if(C.prefs.toggles & CHAT_LOOC)
			var/display_name = src.key
			var/is_living = isliving(src.mob) //Ghosts will show up with their ckey, living people show up with their names
			if(holder)
				if(holder.fakekey)
					if(C.holder)
						display_name = "[holder.fakekey]/([src.key])"
					else
						display_name = holder.fakekey
			to_chat(C, "<font color='#6699CC'><span class='ooc'><span class='prefix'>LOOC:</span> <EM>[is_living ? src.mob.name : display_name]:</EM> <span class='message'>[msg]</span></span></font>")

	for(var/client/C in admins)
		if(C.prefs.toggles & CHAT_LOOC)
			var/prefix = "(R)LOOC"
			if (C.mob in heard)
				prefix = "LOOC"
			to_chat(C, "<font color='#6699CC'><span class='ooc'><span class='prefix'>[prefix]:</span> <EM>[src.key]/[src.mob.name]:</EM> <span class='message'>[msg]</span></span></font>")
	if(istype(AI))
		var/client/C = AI.client
		if (C in admins)
			return //already been handled

		if(C.prefs.toggles & CHAT_LOOC)
			var/display_name = src.key
			var/is_living = isliving(src.mob)
			if(holder)
				if(holder.fakekey)
					if(C.holder)
						display_name = "[holder.fakekey]/([src.key])"
					else
						display_name = holder.fakekey
			to_chat(C, "<font color='#6699CC'><span class='ooc'><span class='prefix'>LOOC:</span> <EM>[is_living ? src.mob.name : display_name]:</EM> <span class='message'>[msg]</span></span></font>")
