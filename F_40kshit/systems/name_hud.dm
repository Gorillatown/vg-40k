//client
	//var/obj/abstract/screen/statusbar_display = null

//client/proc/update_statusbar_display()
//	if(!statusbar_display)
//		statusbar_display = new()
//		screen += list(statusbar_display)
//client/proc/Check_object(atom/object)


//{ font-family: 'JH_fallout'; font-size: 6px; color: white; line-height: 1.2; }

/client/MouseEntered(atom/object, location, control, params)
	. = ..()
	var/input = "<font color='#94bec9'>[object.name]</font>"
	if(ismob(object))
		if(ishuman(object))
			if(isork(object))
				input = "<font color='#ff0000'>[object.name]</font>"
			else
				input = "<font color='#2bff00'>[object.name]</font>"
		else
			input = "<font color='#fcc101'>[object.name]</font>"
	
	mob.hud_used?.statusbar_display.maptext = "<div align='left' valign='top' style='-dm-text-outline:1px #000000;position:relative; top:0px; left:0px; font-family:Fixedsys Excelsior'>\
				<br>\
				[input]<br>\
				</div>"
