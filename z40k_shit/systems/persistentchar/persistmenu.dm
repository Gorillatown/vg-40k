/datum/interactive_persistence/proc/PersistMenu(mob/user)
	if(!user || !user.client)
		return

	var/dat = "<html><link href='./common.css' rel='stylesheet' type='text/css'><body>"

	if(IsGuestKey(user.key))
		dat += "Please create an account to access the persistence menu."
	else

		dat += "<b>Your Potential: [potential].</b><br>"
		dat += {"Current OOC Color: <span style='border:1px solid #161616; background-color: [ooc_color];'>&nbsp;&nbsp;&nbsp;</span>
				<a href='?src=\ref[src];change_ooc_color=1'>Change</a><BR>"}
//<a href='?src=\ref[src];unlock=1;unlock_tree=telekinesis'>Unlock Tree</a>
	//user << browse(dat, "window=preferences;size=560x580")
	var/datum/browser/popup = new(user, "persistencemenu", "<div align='center'>Persistence Menu</div>", 240, 340)
	popup.set_content(dat)
	popup.open(0)

/datum/interactive_persistence/Topic(href, href_list)
	if(!client)
		return
	if(!usr)
		WARNING("No usr on Topic for [client] with href [href]!")
		return
	if(client.mob!=usr)
		to_chat(usr, "YOU AREN'T ME GO AWAY")
		return

	if(href_list["change_ooc_color"])
		if(potential >= 25)
			var/new_ooccolor = input(usr, "Choose your OOC colour:", "Rewards Menu") as color|null
			if(new_ooccolor)
				ooc_color = new_ooccolor
				save_persistence_sqlite(client.ckey,client,FALSE)
		else
			to_chat(usr, "You don't have enough potential to stand out.")
	
	PersistMenu()
