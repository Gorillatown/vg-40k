/*
	Basically this loads things onto the client screen, unrenders them.
	Then it basically makes objects the client passes by to be rendered cheaply(?) thanks to this
	I am unsure of how to actually gauge performance increase so for now this will be unticked.
	As at best we are using this for misc overlays.
*/

/client/proc/initialize_fuckmaster()
	if(fuckmaster)
		screen -= fuckmaster
		qdel(fuckmaster)
	fuckmaster = new /obj/fuckmasterholder
	screen += fuckmaster
	fuckmaster.init_super_shitcode(src)


/obj/fuckmasterholder
	plane = 26
	var/obj/abstract/screen/fuckzero = null
	var/obj/abstract/screen/fuckone = null
	var/obj/abstract/screen/fucktwo = null
	var/obj/abstract/screen/fuckthree = null
	var/obj/abstract/screen/fuckfour = null

/obj/fuckmasterholder/proc/init_super_shitcode(client/c)
	fuckzero = new /obj/abstract/screen/fuckzero()
	fuckone = new /obj/abstract/screen/fuckone()
	fucktwo = new /obj/abstract/screen/fucktwo()
	fuckthree = new /obj/abstract/screen/fuckthree()
	fuckfour = new /obj/abstract/screen/fuckfour()
	
	c.screen += fuckzero
	c.screen += fuckone
	c.screen += fucktwo
	c.screen += fuckthree
	c.screen += fuckfour

/obj/fuckmasterholder/Destroy()
	fuckzero = null
	fuckone = null
	fucktwo = null
	fuckthree = null
	fuckfour = null

	..()

/obj/abstract/screen/fuckzero //light overlays
	icon = 'z40k_shit/icons/turfs/imperial_road_overlays.dmi'
	icon_state = "roadmarker_n"
	render_target = "*0"
	screen_loc = "1,1"
	
/obj/abstract/screen/fuckone //ruin decals
	icon = 'z40k_shit/icons/turfs/ruindecals.dmi'
	icon_state = "rubblefull"
	screen_loc = "1,2"
	render_target = "*1"

/obj/abstract/screen/fucktwo
	icon = 'z40k_shit/icons/turfs/imperial_road_overlays.dmi'
	icon_state = "roadmarker_s"
	screen_loc = "1,3"
	render_target = "*2"

/obj/abstract/screen/fuckthree
	icon = 'z40k_shit/icons/turfs/imperial_road_overlays.dmi'
	icon_state = "roadmarker_e"
	screen_loc = "1,4"
	render_target = "*3"

/obj/abstract/screen/fuckfour
	icon = 'z40k_shit/icons/turfs/imperial_road_overlays.dmi'
	icon_state = "roadmarker_w"
	screen_loc = "1,5"
	render_target = "*4"