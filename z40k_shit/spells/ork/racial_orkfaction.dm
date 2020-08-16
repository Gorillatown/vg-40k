/spell/aoe_turf/ork_mob_builder //Raaagh
	name = "Ork Mob Builder"
	abbreviation = "WG"
	desc = "For the boys to get together."
	panel = "Racial Abilities"
	spell_flags = INCLUDEUSER
	charge_type = Sp_RECHARGE
	charge_max = 10
	invocation_type = SpI_NONE
	still_recharging_msg = "<span class='notice'>You ain't ready yet idiot..</span>"
	
	override_base = "basic_button"
	override_icon = 'z40k_shit/icons/buttons/generic_action_buttons.dmi'
	hud_state = "mek_build"


	var/datum/faction/dyn_ork/our_faction = null
	var/currently_leader = FALSE

/spell/aoe_turf/ork_mob_builder/Destroy()
	our_faction = null
	..()

/spell/aoe_turf/ork_mob_builder/cast(var/list/targets, mob/user)
	popup_window(user)

/spell/aoe_turf/ork_mob_builder/proc/popup_window(var/mob/living/carbon/human/user)
	var/dat
	dat += {"<B>Ork Mob Builder Menu</B><BR>
			<HR>
			<I>Where ya go to get the feels.</I><BR>"}

	if(!our_faction)
		dat += "<B> If ya do this ya gotta find other boyz to work with, at least THREE, ya can't ever leave ya own mob too.</B><BR>"
		dat += "<A href='byond://?src=\ref[src];createorkmob=1'>Create ya own Mob</A>"
	else
		dat += "<B>Amount of boyz: [our_faction.members.len]</B><BR>"
		if(currently_leader) //Todo: make this actually find the leader in the faction
			dat += "<A href='byond://?src=\ref[src];recruitork=1'>Recruit a git near ya!</A><BR>"
			for(var/datum/role/therole in our_faction.members)
				var/mob/M = therole.antag.current
				dat += "[M] <A href='byond://?src=\ref[src];removeork=1;therole=\ref[therole]'>Kick this git out!</A><BR>"
		else
			for(var/datum/role/therole in our_faction.members)
				var/mob/M = therole.antag.current
				dat += "[M]"
		dat += "<HR>"
	
	dat += "<HR>"
		
	var/datum/browser/popup = new(user, "mobbuilder", "Mob Builder Menu")
	popup.set_content(dat)
	popup.open()

/spell/aoe_turf/ork_mob_builder/Topic(href, href_list)
	var/mob/living/L = usr
	if(!istype(L))
		return

	if(href_list["createorkmob"])
		if(!our_faction)
			create_ork_mob(usr)

	if(href_list["recruitork"])
		if(our_faction)
			for(var/mob/living/carbon/human/theperson in range(2,L))
				if(isork(theperson))
					var/already_in_faction = FALSE
					for(var/spell/aoe_turf/ork_mob_builder/spell in theperson.spell_list)
						if(spell.our_faction)
							already_in_faction = TRUE
					if(!already_in_faction)
						if(alert(theperson,"Want ta join [our_faction.name]?","Recruitment","YEAH!","NO!") != "YEAH!")
							break
						var/datum/role/free_ork/freeloada = new
						freeloada.AssignToRole(theperson.mind,1)
						our_faction.HandleRecruitedRole(freeloada)
						for(var/spell/aoe_turf/ork_mob_builder/spell in theperson.spell_list)
							spell.our_faction = our_faction

	if(href_list["removeork"])
		if(our_faction)
			var/datum/role/ourork = locate(href_list["therole"])
			if(alert(L,"Are you completely sure?","Kick from Mob","YEAH!","Ehhhh....") != "YEAH!")
				return
			ourork.Drop()

	src.popup_window(usr)

/spell/aoe_turf/ork_mob_builder/proc/create_ork_mob(mob/user)
	var/datum/faction/dyn_ork/fac = ticker.mode.CreateFaction(/datum/faction/dyn_ork, null, 1)
	var/datum/role/mob_boss/ourboss = new (user.mind, fac, override = TRUE)
	our_faction = fac
	fac.leader = ourboss
	if(fac)
		var/newname = copytext(sanitize(input(ourboss.antag.current,"You are da boss of dis ere' mob. Think up a good name ya git", "Name change","")),1,MAX_NAME_LEN)
		if(newname)
			if(newname == "Unknown" || newname == "floor" || newname == "wall" || newname == "rwall" || newname == "_")
				to_chat(ourboss.antag.current, "That name is reserved.")
			fac.name = "[newname]."
		else
			fac.name = "DA BOYZ"
		currently_leader = TRUE
