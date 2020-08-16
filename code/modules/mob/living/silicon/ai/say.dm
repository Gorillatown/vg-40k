/mob/living/silicon/ai/say(var/message)
	if(loc.loc && istype(loc.loc,/obj/item/weapon/storage/belt/silicon)) //loc would be an aicard in this case
		RenderBeltChat(loc.loc,src,message)
		return 1
	if(parent && istype(parent) && parent.stat != 2) //If there is a defined "parent" AI, it is actually an AI, and it is alive, anything the AI tries to say is said by the parent instead.
		parent.say(message)
		return 1
	return ..(message)


/mob/living/silicon/ai/render_speaker_track_start(var/datum/speech/speech)
	//this proc assumes that the message originated from a radio. if the speaker is not a virtual speaker this will probably fuck up hard.
	var/mob/M = speech.speaker.GetSource()

	var/atom/movable/virt_speaker = speech.radio
	if(!virt_speaker || !istype(virt_speaker, /obj/item/device/radio))
		virt_speaker = src
	if(speech.speaker != src && M != src)
		if(M)
			var/faketrack = "byond://?src=\ref[virt_speaker];track2=\ref[src];track=\ref[M]"
			if(speech.speaker.GetTrack())
				faketrack = "byond://?src=\ref[virt_speaker];track2=\ref[src];faketrack=\ref[M]"

			return "<a href='byond://?src=\ref[virt_speaker];open2=\ref[src];open=\ref[M]'>\[OPEN\]</a> <a href='[faketrack]'>"
	return ""

/mob/living/silicon/ai/render_speaker_track_end(var/datum/speech/speech)
	//this proc assumes that the message originated from a radio. if the speaker is not a virtual speaker this will probably fuck up hard.
	var/mob/M = speech.speaker.GetSource()

	var/atom/movable/virt_speaker = speech.radio
	if(!virt_speaker || !istype(virt_speaker, /obj/item/device/radio))
		virt_speaker = src
	if(speech.speaker != src && M != src)
		if(M)
			return "</a>"
	return ""


/mob/living/silicon/ai/say_quote(var/text)
	var/ending = copytext(text, length(text))

	if (ending == "?")
		return "queries, [text]";
	else if (ending == "!")
		return "declares, [text]";

	return "states, [text]";

/mob/living/silicon/ai/IsVocal()
	return !config.silent_ai

/mob/living/silicon/ai/get_message_mode(message)
	. = ..()
	if(!. && istype(current, /obj/machinery/hologram/holopad))
		return MODE_HOLOPAD

/mob/living/silicon/ai/handle_inherent_channels(var/datum/speech/speech, var/message_mode)
	say_testing(src, "[type]/handle_inherent_channels([message_mode])")

	if(..(speech, message_mode))
		return 1

	if(message_mode == MODE_HOLOPAD)
		holopad_talk(speech)
		return 1

//For holopads only. Usable by AI.
/mob/living/silicon/ai/proc/holopad_talk(var/datum/speech/speech)
	say_testing(src, "[type]/holopad_talk()")
	var/turf/turf = get_turf(src)
	log_say("[key_name(src)] (@[turf.x],[turf.y],[turf.z]) Holopad: [speech.message]")

	speech.message = trim(speech.message)

	if (!speech.message)
		return

	var/obj/machinery/hologram/holopad/T = current
	if(istype(T) && T.holo && T.master == src)//If there is a hologram and its master is the user.
		T.send_speech(speech, 7, "R")
		to_chat(src, "<i><span class='[speech.render_wrapper_classes()]'>Holopad transmitted, <span class='name'>[real_name]</span> [speech.render_message()]</span></i>")//The AI can "hear" its own message.

	else
		to_chat(src, "No holopad connected.")
	return
