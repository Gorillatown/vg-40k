/mob/living/captive_holder
	name = "captive soul"
	real_name = "captive soul"

/mob/living/captive_holder/say(var/message)

	if(src.client)
		if(src.client.handle_spam_prevention(message,MUTE_IC))
			return

	if(isliving(src.loc)) //IDC what is in the src.loc it should be generic
		var/mob/living/simple_animal/hostile/retaliate/daemon/controller = src.loc
		to_chat(src, "You whisper silently, \"[message]\"")
		to_chat(controller.possessed, "The captive mind of [src] whispers, \"[message]\"")

		for(var/mob/M in player_list)
			if(istype(M, /mob/new_player))
				continue
			if(istype(M,/mob/dead/observer)  && (M.client && M.client.prefs.toggles & CHAT_GHOSTEARS))
				var/controls = "<a href='byond://?src=\ref[M];follow2=\ref[M];follow=\ref[src]'>Follow</a>"
				if(M.client.holder)
					controls+= " | <A HREF='?_src_=holder;adminmoreinfo=\ref[src]'>?</A>"
				var/rendered="<span class='thoughtspeech'>Thought-speech, <b>[src.name]</b> ([controls]) -> <b>[controller.real_name]:</b> [message]</span>"
				M.show_message(rendered, 2) //Takes into account blindness and such.

/mob/living/captive_holder/emote(act, m_type = null, message = null, ignore_status = FALSE)
	return