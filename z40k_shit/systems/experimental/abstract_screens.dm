/obj/abstract/screen/viscons
	icon = 'z40k_shit/icons/screens.dmi'
	icon_state = "blank"

/* Ghost Bodies
*/
/obj/abstract/screen/viscons/ghostbodies
	name = "Ghost Body Select"
	var/given_body = "god"
	var/colorable = FALSE
	var/potential_req = 0

/obj/abstract/screen/viscons/ghostbodies/Click(location, control, params)
	if(!usr)
		return 1

	if(!isobserver(usr))
		return 1

	var/g_red = 0
	var/g_green = 0
	var/g_blue = 0

	usr.icon_state = given_body
	if(colorable)
		switch(alert("Do you want to pick a color?",,"Yes","No","Maybe"))
			if("Yes")
				var/pckcolor = input("Color Wheel") as color|null
				usr.color = pckcolor
				g_red = hex2num(copytext(pckcolor, 2, 4))
				g_green = hex2num(copytext(pckcolor, 4, 6))
				g_blue = hex2num(copytext(pckcolor, 6, 8))
			if("No")
				usr.color = null
			if("Maybe")
				g_red = rand(0,255)
				g_green = rand(0,255)
				g_blue = rand(0,255)
				usr.color = rgb(g_red, g_green, g_blue)
	else
		usr.color = null

	if(usr.client)
		var/client/C = usr.client
		C.persist.ghost_form = given_body
		C.persist.ghost_red = g_red
		C.persist.ghost_green = g_green
		C.persist.ghost_blue = g_blue
