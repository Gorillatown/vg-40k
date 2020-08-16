/*
	Basically these buttons fuck with the trap with the var/tied_id ="1"
	that matches with our activate id variable
	If you hit it, it basically calls turn_my_ass_over()
*/

/obj/structure/nu_button
	name = "button"

	icon = 'icons/obj/objects.dmi'
	icon_state = "launcherbtt"
	var/base_state = "launcherbtt"
	var/activated_state = "launcheract"

	var/activate_id = "1" //id of the object we are activating
	var/global_search = TRUE //If true, search for all hidden doors in the world. Otherwise, only search for those in current area

	var/activated = FALSE //When the button is pressed, this variable switches from 0 to 1 and vice versa

	var/one_time = FALSE //If this button can only be used once
	var/one_time_used = FALSE

/obj/structure/nu_button/attack_hand(mob/user)
	if(one_time && one_time_used)
		to_chat(user, "<span class='info'>It won't budge!</span>")
		return

	visible_message("<span class='info'>[user] presses \the [src].</span>")
	activate()

/obj/structure/nu_button/proc/activate()
	if(global_search) //Do we search globally, aka in the list all traps append themself to.
		for(var/obj/structure/traps/my_trap in map_traps)
			if(is_correct_id(my_trap))
				my_trap.turn_my_ass_over()
				one_time_used = TRUE
	else //Or do we just loop in the area
		for(var/obj/structure/traps/my_trap in get_area(src))
			if(is_correct_id(my_trap))
				my_trap.turn_my_ass_over()
				one_time_used = TRUE

	/*
		This basically handles Icon Changes
	*/
	activated = !activated
	if(activated)
		icon_state = activated_state
	else
		icon_state = base_state

//We check the ID to the activate_id.
/obj/structure/nu_button/proc/is_correct_id(var/obj/structure/traps/my_trap)
	return (my_trap.tied_id == activate_id) 


/*
	This basically turns off the button last in the list once we pass the variable number
*/
var/global/list/last_buttons_pressed = list() //List of areas associated with lists that contain buttons, 
//e.g. [AWAY MISSION AREA] = list(BUTTON A, BUTTON B)
/obj/structure/nu_button/limitation_buttons
	global_search = FALSE //Only current area
	var/maximum_activated_at_once = 2

/obj/structure/nu_button/limitation_buttons/Destroy()
	var/list/L = last_buttons_pressed[get_area(src)]
	if(L)
		L.Remove(src)

	..()

/obj/structure/nu_button/limitation_buttons/activate(forced = FALSE)
	//Get my area's list of button presses. If no such list exists, create one
	var/list/L = last_buttons_pressed[get_area(src)]
	if(!L)
		L = list()
		last_buttons_pressed[get_area(src)] = L

	//This button can't be deactivated by pushing it. Deactivate it by calling this proc with the force argument set to 1
	if(activated)
		if(!forced)
			return

		return ..()

	//Attempting to activate the button - check how many buttons in this area have already been activated. Deactivate the oldest pressed button
	else if(L.len >= maximum_activated_at_once) //Greater than or equal to maximum activated at once 2~
		var/obj/structure/nu_button/button_to_toggle_off = L[1] //We are object number 1 in the list

		if(button_to_toggle_off.activated) //If button to toggle off is activated
			button_to_toggle_off.activate(TRUE) //then we activate
			L.Remove(button_to_toggle_off) //And remove the last button

	..()
	L.Add(src) //And add ourselves to the list

/obj/structure/nu_button/limitation_buttons/is_correct_id(var/obj/structure/traps/my_trap)
	return (..() || (my_trap.always_activate)) //Activate the always activate traps



/*

	This button de-activates everything in an area. Aka, their partners cleared it.
*/
/obj/structure/nu_button/unlock_all
	global_search = FALSE //This shouldn't amtter since we are just overwriting activate entirely.

/obj/structure/nu_button/unlock_all/activate()
	for(var/obj/structure/traps/my_trap in get_area(src))
		my_trap.currently_active = TRUE //Turn everything on at once
		my_trap.turn_my_ass_over() //The turn it all off
		//Reasons why we don't just turn it to false, and update the icons.
		//We cut down on proc calls and keep together for map scenario controller timing.
