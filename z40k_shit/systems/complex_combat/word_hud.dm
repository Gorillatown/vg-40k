
//Im doing this on roles because im feeling lazy.
//Nevermind
//Anyways See: onclick human.dm line 379 for our entry
//We basically have to call update_powerwords_hud on the mob when we need to update it.

//Location of the power words area thing. See: _defines.dm for the rest
#define ui_powerwords "CENTER-1.5,NORTH-1:10"

/datum/hud/proc/powerwords_hud()
	// Display our currently active words.
	powerwords_display = new /obj/abstract/screen
	powerwords_display.name = "POWER WORDS"
	powerwords_display.icon = 'z40k_shit/icons/slightly_black_rectangle.dmi'
	powerwords_display.icon_state = "dark128x42"
	powerwords_display.screen_loc = ui_powerwords

	if(mymob.client)
		mymob.client.screen += list(powerwords_display)

/mob/living/carbon/human
	var/wordhud_disp_holder = ""

/mob/living/carbon/human/proc/update_powerwords_hud(conversion_strings, var/clear = 0)
	if(hud_used)
		if(!hud_used.powerwords_display)
			hud_used.powerwords_hud()

		if(clear)
			wordhud_disp_holder = ""
		else
			wordhud_disp_holder += conversion_strings
		
		hud_used.powerwords_display.maptext_width = 128
		hud_used.powerwords_display.maptext_height = 42
		hud_used.powerwords_display.maptext = "<div align='left' valign='top' style='position:relative; top:0px; left:6px'>\
				<br>\
				[wordhud_disp_holder]<br>\
				</div>"
	return