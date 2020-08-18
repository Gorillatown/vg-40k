/datum/role/mob_boss
	name = ORKMOBBOSS
	id = ORKMOBBOSS
	special_role = ORKMOBBOSS
	logo_state = "ork-standard-logo"

/datum/role/mob_boss/New(var/datum/mind/M, var/datum/faction/fac=null, var/new_id,var/override = FALSE)
	..()
	var/datum/faction/dyn_ork/ork_faction
	if(!fac)
		ork_faction = new
		ork_faction.addMaster(src)
	else if (istype(fac, /datum/faction/dyn_ork))
		ork_faction = fac
		ork_faction.addMaster(src)

/datum/role/mob_boss/OnPostSetup()
	. = ..()
	ForgeObjectives()
	if(faction && istype(faction, /datum/faction/dyn_ork) && faction.leader == src)
		var/datum/faction/dyn_ork/V = faction
		V.name_clan(src)

/datum/role/mob_boss/RemoveFromRole(var/datum/mind/M)
	..()

/datum/role/mob_boss/GetScoreboard()
	var/recruited_total = faction.members.len
	. = "Total Boyz In Mob: <b>[recruited_total]</b><br/>"
	. += ..() // Who he was, his objectives...

/datum/role/mob_boss/process()
	..()
	var/mob/living/carbon/human/H = antag.current
	if(!istype(H))
		return FALSE // The life() procs only work on humans.
//	if(istype(H.loc, /obj/structure/closet/coffin))
	if(faction.members.len >= 3)
		H.adjustBruteLoss(-4)
		H.adjustFireLoss(-4)
		H.adjustToxLoss(-4)
		H.adjustOxyLoss(-4)
		for(var/datum/organ/internal/I in H.internal_organs)
			if(I && I.damage > 0)
				I.damage = max(0, I.damage - 4)
			if(I)
				I.status &= ~ORGAN_BROKEN
				I.status &= ~ORGAN_SPLINTED
				I.status &= ~ORGAN_BLEEDING
		for(var/datum/organ/external/O in H.organs)
			O.status &= ~ORGAN_BROKEN
			O.status &= ~ORGAN_SPLINTED
			O.status &= ~ORGAN_BLEEDING

//This is where we append /datum/objective path type things later.
/datum/role/mob_boss/ForgeObjectives()
	..()

/*
	The role of orks not a leader
*/
/datum/role/free_ork
	name = FREELOADA
	id = FREELOADA
	special_role = FREELOADA
	logo_state = "ork-standard-logo"
	var/datum/role/mob_boss/master

/datum/role/free_ork/New(var/datum/mind/M, var/datum/faction/fac=null, var/new_id, var/override = FALSE, var/datum/role/vampire/master)
	. = ..()
	if(!istype(master))
		return FALSE
	src.master = master
	update_faction_icons()
	Greet(TRUE)
	ForgeObjectives()
	AnnounceObjectives()
	OnPostSetup()

/datum/role/free_ork/Greet(var/you_are = TRUE)
	var/dat
	if(you_are)
		dat = "<span class='danger'>Ya now in a mob!</br> Ya agreed ya boss wuz <b>[master.antag.current]</b> [faction?"in da [faction.name].":"."]</span>"
	dat += {""}
	to_chat(antag.current, dat)
//	to_chat(antag.current, "<B>You must complete the following tasks:</B>")
//	antag.current << sound('sound/effects/vampire_intro.ogg')

/datum/role/free_ork/Drop(var/deconverted = FALSE)
//	var/mob/M = antag.current
/*	if (deconverted)
		M.visible_message("<span class='big danger'>[M] suddenly becomes calm and collected again, \his eyes clear up.</span>",
		"<span class='big notice'>Your blood cools down and you are inhabited by a sensation of untold calmness.</span>")*/
	update_faction_icons()
	return ..()

//This is where we append /datum/objective path type things later.
/datum/role/free_ork/ForgeObjectives()
	..()

