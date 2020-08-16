/*
Drugs are bad!
*/

/obj/item/clothing/mask/cigarette/celeb
	name = "fatty boom batty"
	icon_state = "blunt"
	overlay_on = "bluntlit"
	desc = "From the agriworld 'Daronoco', the hard working Imperials have tirelessly worked the fields in order to bring you a stick of quality nicotene. Although some one seems to have mixed the contents of this premium ciggarette with cheap lho."
	var/thekey = null
	var/active = 0

/obj/item/clothing/mask/cigarette/celeb/New()
	..()
	//reagents.add_reagent("lho", 20)

/obj/item/clothing/mask/cigarette/celeb/process()
	var/turf/location = get_turf(src)
	var/mob/living/carbon/human/M = loc
	var/list/factions = list("Slaanesh")
	if(isliving(loc))
		M.IgniteMob()
	smoketime--
	if(smoketime < 1)
		new type_butt(location)
		processing_objects.Remove(src)
		if(ismob(loc))
			to_chat(M, "<span class='notice'>Your [name] goes out.</span>")
			M.u_equip(src, 1)	//un-equip it so the overlays can update //Force the un-equip so the overlays update
		qdel(src)
		return
	if(isliving(loc))
		if(length(factions & M.faction))
			thekey = M.ckey
	if(location)
		location.hotspot_expose(700, 5)
	if(reagents && reagents.total_volume)	//Check if it has any reagents at all
		if(iscarbon(M) && ((src == M.wear_mask) || (loc == M.wear_mask))) //If it's in the human/monkey mouth, transfer reagents to the mob
			if(M.reagents.has_any_reagents(LEXORINS) || (M_NO_BREATH in M.mutations) || istype(M.loc, /obj/machinery/atmospherics/unary/cryo_cell))
				reagents.remove_any(REAGENTS_METABOLISM)
			else
				if(prob(25)) //So it's not an instarape in case of acid
					reagents.reaction(M, INGEST)
				reagents.trans_to(M, 1)
		else //Else just remove some of the reagents
			reagents.remove_any(REAGENTS_METABOLISM)
	if(!istype(M)) 
		return //This was throwing runtime errors when the cig was lit and on the ground, cuz turf has no variable called ckey. -Drake
	if(M.ckey != thekey)
		active = 1
	if((active) && (M.ckey == thekey))
		if(M.mind.job_quest)
			M.mind.job_quest.alignment --
			to_chat(M,"<span class='notice'>Nice. That was real nice. This has been a real inspiration. Now that we are in the correct frame of mind. Lets go back to our shitshack and see just how inspired we really are.</span>")
			qdel(src)
	return
