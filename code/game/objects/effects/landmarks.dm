/obj/effect/landmark
	name = "landmark"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	anchored = 1
	w_type=NOT_RECYCLABLE
	invisibility = 101
	var/landmark_override = FALSE

/obj/effect/landmark/New()
	. = ..()
	tag = text("landmark*[]", name)
	landmarks_list += src

	switch(name)			//some of these are probably obsolete
		if("shuttle")
			shuttle_z = z
			qdel(src)

		if("airtunnel_stop")
			airtunnel_stop = x

		if("airtunnel_start")
			airtunnel_start = x

		if("airtunnel_bottom")
			airtunnel_bottom = y

		if("monkey") 
			monkeystart += loc
			qdel(src)

		if("wizard")
			wizardstart += loc
			qdel(src)

		if("AssetJoinLate")
			peasant_latejoin += loc
			qdel(src)

		//prisoners
		if("prisonwarp")
			prisonwarp += loc
			qdel(src)

		if("Holding Facility")
			holdingfacility += loc
		if("tdome1")
			tdome1	+= loc
		if("tdome2")
			tdome2 += loc
		if("tdomeadmin")
			tdomeadmin	+= loc
		if("tdomeobserve")
			tdomeobserve += loc
		//not prisoners
		if("prisonsecuritywarp")
			prisonsecuritywarp += loc
			qdel(src)

		if("blobstart")
			blobstart += loc
			qdel(src)

		if("xeno_spawn")
			xeno_spawn += loc
			qdel(src)

		if("endgame_exit")
			endgame_safespawns += loc
			qdel(src)
		if("bluespacerift")
			endgame_exits += loc
			qdel(src)

		if("grinchstart")
			grinchstart += loc

		if("voxstart")
			voxstart += loc

		if("voxlocker")
			voxlocker += loc
			
		if("ninjastart")
			ninjastart += loc
	return 1

/obj/effect/landmark/Destroy()
	landmarks_list -= src
	..()

/obj/effect/narration
	name = "narrator"
	icon_state = "megaphone"
	invisibility = 101
	var/msg
	var/play_sound
	var/list/saw_ckeys = list() //List of ckeys which have seen the message

/obj/effect/narration/New()
	..()

/obj/effect/narration/Crossed(mob/living/O)
	if(istype(O))
		if(!saw_ckeys.Find(O.ckey))
			saw_ckeys.Add(O.ckey)

			display(O)

	return ..()

/obj/effect/narration/proc/display(mob/living/L)
	if(msg)
		to_chat(L, msg)

	if(play_sound)
		L << play_sound

/obj/effect/landmark/grinchstart
	name = "grinchstart"

/obj/effect/landmark/xtra_cleanergrenades
	name = "xtra_cleanergrenades"

/obj/effect/landmark/vox_locker
	name = "vox_locker"
