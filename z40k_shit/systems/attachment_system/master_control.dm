
//Named Master Control cause it sounds badass lol
/*
	DATUM ATTACHMENT SYSTEM
							*/
//Revision 3/6/2020 - JTGSZ

//Within is the attachment system, mostly because all of the additional text was confusing me.
//See: tactical_light.dm

/obj/item/weapon/gun/New()
	ATCHSYS = new(src)
	..()

/datum/attachment_system
	var/obj/item/weapon/gun/my_atom //Holder for what spawned our asses
	var/list/attachments = list() //Container of all the attachments we currently have.
	var/list/action_storage = list() //Container of all the actions we currently have.
	var/initial_meleesound
	var/initial_firesound

/datum/attachment_system/New(var/obj/CHOSEN_ONE)//Basically new is used as a standard proc call too
	..()
	if(istype(CHOSEN_ONE)) //Our chosen one is the place we are spawned into
		my_atom = CHOSEN_ONE

	var/RAGH = /datum/action/item_action/warhams/attachment/remove_atch
	my_atom.actions_types += RAGH

/datum/attachment_system/proc/attachment_handler(var/obj/item/weapon/attachment/ATCH, var/going_in, var/mob/user)
	if(going_in)
		var/boink
		for(var/obj/item/weapon/attachment/CHEK in attachments)
			if(istype(CHEK, ATCH))
				boink++

		if(ATCH.atch_total_limit)
			if(boink >= ATCH.atch_total_limit)
				to_chat(user,"This object cannot fit anymore of that attachment")
				return 0

		attachments += ATCH
		if(ATCH.tied_action)
			action_storage += ATCH.tied_action
			var/datum/action/item_action/warhams/ass = new ATCH.tied_action(my_atom)
			ass.my_atom = ATCH
		ATCH.my_atom = my_atom

		if(ATCH.atch_effect_flags & MELEE_DMG) //We add force on from attachment
			my_atom.force += ATCH.force
		if(ATCH.atch_effect_flags & MELEE_SOUNDSWAP) //Swap melee noises
			initial_meleesound = my_atom.hitsound
			my_atom.hitsound = ATCH.hitsound
		if(ATCH.atch_effect_flags & GUN_FIRESOUNDSWAP) //Swap gunfire noises
			initial_firesound = my_atom.fire_sound
			my_atom.fire_sound = ATCH.fire_sound
		if(ATCH.atch_effect_flags & TOGGLE_ACTION)  //Add the action to the source object
			my_atom.actions_types |= ATCH.tied_action
		
		to_chat(user, "<span class='notice'>You attach [ATCH] to [my_atom].</span>")
		user.drop_item(ATCH, my_atom)
		my_atom.update_icon()
		return 1

	else //The inverse of going in, which is !going_in, or technically null
		
		ATCH.special_detachment(user)

		if(ATCH.tied_action)
			action_storage -= ATCH.tied_action
			for(var/datum/action/A in my_atom.actions)
				if(istype(A, ATCH.tied_action))
					qdel(A)
		
		attachments -= ATCH
		ATCH.my_atom = null

		if(ATCH.atch_effect_flags & MELEE_DMG) //We remove force from attachment
			my_atom.force -= ATCH.force
		if(ATCH.atch_effect_flags & MELEE_SOUNDSWAP) //Set hitsound to initial sound.
			my_atom.hitsound = initial_meleesound
			initial_meleesound = null
		if(ATCH.atch_effect_flags & GUN_FIRESOUNDSWAP) //Set fire_sound to initial sound.
			my_atom.fire_sound = initial_firesound
			initial_firesound = null
		if(ATCH.atch_effect_flags & TOGGLE_ACTION) //Remove action from source object.
			my_atom.actions_types.Remove(ATCH.tied_action)
		
		my_atom.update_icon()
		return 1



