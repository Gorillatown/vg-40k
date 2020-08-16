/*
	DATUM BUTTON CRAFTING
							*/
/datum/button_crafting
	var/temp = null
	var/next_desc_fire //CD so we can't have someone rapidfire flood with the mek desc
	var/list/possible_recipes = list()

/datum/button_crafting/New(var/list/recipes)
	..()
	possible_recipes = recipes.Copy()

/datum/button_crafting/proc/use(mob/user)
	var/dat
	dat += {"<B>Build Recipes</B><BR>
			<HR>
			<B>Build Object:</B><BR>
			<I>The requirements are afterwards, click the button for a desc of the object.</I><BR>"}
	for(var/datum/crafting_recipes/recipe in src.possible_recipes)
		dat += "<A href='byond://?src=\ref[src];build=1;recipe=\ref[recipe]'>[recipe.title]</A> <A href='byond://?src=\ref[src];desc=1;recipe=\ref[recipe]'>[recipe.build_desc]</A><BR>"
	dat += "<HR>"
	if(src.temp)
		dat += "[src.temp]"
	var/datum/browser/popup = new(user, "craftbuilder", "Crafting Menu")
	popup.set_content(dat)
	popup.open()

/datum/button_crafting/Topic(href, href_list)
	..()

	var/mob/living/L = usr
	if(!istype(L))
		return

	if(href_list["build"])
		var/datum/crafting_recipes/MR = locate(href_list["recipe"])
		if(consume_resources(L,MR))
			return 1

	if(href_list["desc"])
		if(world.time >= next_desc_fire) //only do this every 2 seconds.
			var/datum/crafting_recipes/MR = locate(href_list["recipe"])
			if(find_desc(L,MR))
				return 1

	src.use(usr)

//We consume resources here, basically it calls a proc on the recipe datum.
//If the proc returns 0 it gives a error message.
/datum/button_crafting/proc/consume_resources(mob/living/user, var/datum/crafting_recipes/crafting_recipes)
	crafting_recipes.datum_begin_chaintest(user)

//Basically this just plugs in a desc if you click the mat value
/datum/button_crafting/proc/find_desc(mob/living/user, var/datum/crafting_recipes/crafting_recipes)
	next_desc_fire = world.time + 0.5 SECONDS
	to_chat(user,"Item Description: [crafting_recipes.obj_desc]")
	return 1

/*
	DATUM CRAFTING RECIPES
						*/
//Basically these are the recipes you can build on the mek builder menu.
/datum/crafting_recipes
	var/title = "ERROR" //Title of it on the mek build menu
	var/obj/result_type //What we will get
	var/time = 50 //Time spent processing each individual recipe object.
	var/build_desc //The building desc for how to make it.
	var/obj_desc //A description of the object

	var/list/sheet_types = list() // Sheet type then number we are using
	var/list/other_objects = list()

//We can have custom building right here, you return 1 if they succeed and 0 if they fail.
/datum/crafting_recipes/proc/datum_begin_chaintest(mob/living/user)
	var/list/qdel_these_idiot = list() //Extra Object Deletion List
	var/list/eat_these_bitches = list() //Stack deletion list
	var/list/jokes_on_you_cunt = list() //Humorous Extra Item Deletion List
	var/sheet_checks_passed = TRUE //Did we pass all the checks
	var/object_checks_passed = TRUE

	if(sheet_types.len) //If the sheet_types list has a length
		var/obj/item/stack/YEAH
		for(var/i=1 to sheet_types.len) 
			sheet_checks_passed = FALSE 
			var/obj/chosen_sheet = sheet_types[i] 
			var/required_amount = sheet_types[chosen_sheet] 
			if(istype(user.get_inactive_hand(), chosen_sheet))
				YEAH = user.get_inactive_hand()
				if(YEAH.amount >= required_amount)
					sheet_checks_passed = TRUE
					eat_these_bitches.Add(YEAH)
					eat_these_bitches[YEAH] = required_amount
					continue
			else if(istype(user.get_active_hand(), chosen_sheet)) 
				YEAH = user.get_active_hand()
				if(!(YEAH in eat_these_bitches))
					if(YEAH.amount >= required_amount)
						sheet_checks_passed = TRUE
						eat_these_bitches.Add(YEAH)
						eat_these_bitches[YEAH] = required_amount
						continue
			else if(!sheet_checks_passed) 
				for(var/obj/item/stack/THEBOYS in range(1,user)) 
					if(istype(THEBOYS, chosen_sheet)) 
						if(!(THEBOYS in eat_these_bitches)) 
							if(THEBOYS.amount >= required_amount) 
								eat_these_bitches.Add(THEBOYS) 
								eat_these_bitches[THEBOYS] = required_amount 
								sheet_checks_passed = TRUE 
								break 

	if(!sheet_checks_passed)
		to_chat(user, "<span class='bad'>Theres not enough sheets.</span>")
		return 0

	if(other_objects.len)
		var/obj/item/YEAHYEAH
		for(var/i=1 to other_objects.len) 
			object_checks_passed = FALSE 
			var/obj/recipe_obj = other_objects[i]
			var/recipe_amount = other_objects[recipe_obj] 
			for(var/ii=1 to recipe_amount) 
				object_checks_passed = FALSE 
				if(istype(user.get_inactive_hand(), recipe_obj)) 
					YEAHYEAH = user.get_inactive_hand()
					if(!(YEAHYEAH in qdel_these_idiot)) 
						object_checks_passed = TRUE 
						qdel_these_idiot += YEAHYEAH 
						continue 
				else if(istype(user.get_active_hand(),recipe_obj)) 
					YEAHYEAH = user.get_active_hand()
					if(!(YEAHYEAH in qdel_these_idiot))
						object_checks_passed = TRUE 
						qdel_these_idiot += YEAHYEAH 
						continue
				else if(!object_checks_passed) 
					for(var/obj/THEBOYS in range(1,user)) 
						if(istype(THEBOYS,recipe_obj))
							if(!(THEBOYS in qdel_these_idiot)) 
								object_checks_passed = TRUE 
								qdel_these_idiot += THEBOYS 
								break
						else if(prob(5))
							jokes_on_you_cunt += THEBOYS 
			
	if(!object_checks_passed)
		to_chat(user,"<span class='bad'>Theres not enough components.</span>")
		return 0

	if(sheet_checks_passed && object_checks_passed)
		var/failed = FALSE
		to_chat(user,"<span class='average'>Finding all the materials, You begin crafting the [title]</span>")

		for(var/obj/theniggas in qdel_these_idiot)
			if(do_after(user,user,time))
				qdel(theniggas)
			else
				failed = TRUE
				to_chat(user, "<span class='bad'>You were disrupted.</span>")
				break
			sleep(1)
		
		var/MOTHERFUCKER
		if(!failed)
			for(var/obj/item/stack/WOO in eat_these_bitches)
				if(do_after(user,user,time))
					WOO.use(eat_these_bitches[WOO])
				else
					failed = TRUE
					to_chat(user, "<span class='bad'>You were disrupted.</span>")
					break
				sleep(1)
			
			MOTHERFUCKER = new result_type(user.loc)
			to_chat(user,"<span class='good'> You finish crafting the [title]</span>")
		else
			to_chat(user,"<span class='bad'>You failed the craft the [title]</span>")

		if(jokes_on_you_cunt.len)
			var/extra_force = 0
			for(var/obj/item/fucked in jokes_on_you_cunt)
				to_chat(user, "<span class='sinister'> You use extra resources </span>")
				extra_force += 5
				qdel(fucked)
		
			if(!failed)
				if(istype(MOTHERFUCKER, /obj/item))
					var/obj/item/OHYEAH = MOTHERFUCKER
					switch(extra_force)
						if(10)
							to_chat(user, "<span class='good'> Your object seems notably stronger than normal.</span>")
							OHYEAH.desc += "<span class='good'> This object seems to be of high quality.</span>"
						if(11 to 30)
							to_chat(user,"<span class='good'> You feel power emanating from this object.</span>")
							if(prob(20))
								OHYEAH.desc += "<span class='sinister'> This object pulses with OVERWHELMING power.</span>"
								extra_force += rand(10,50)
							else
								OHYEAH.desc += "<span class='sinister'> You feel power emanating from this object.</span>"
								extra_force += 10
					OHYEAH.force += extra_force
	else
		to_chat(user,"<span class='warning'> You do not have enough materials near you. </span>")
		return 0

