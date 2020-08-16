//CONTAINS: Detective's Scanner


/obj/item/device/detective_scanner
	name = "Scanner"
	desc = "Used to scan objects for DNA."
	icon_state = "forensic1"
	var/amount = 20.0
	var/list/stored = list()
	w_class = W_CLASS_SMALL
	item_state = "electronic"
	siemens_coefficient = 1
	slot_flags = SLOT_BELT

/obj/item/device/detective_scanner/attack(mob/living/carbon/human/M, mob/user )
	if ( !M.blood_DNA || !M.blood_DNA.len )
		to_chat(user, "<span class='notice'>No blood found on [M]</span>")
		if(M.blood_DNA)
			qdel(M.blood_DNA)
			M.blood_DNA = null
	else
		to_chat(user, "<span class='notice'>Blood found on [M]. Analysing...</span>")
		spawn(15)
			for(var/blood in M.blood_DNA)
				to_chat(user, "<span class='notice'>Blood type: [M.blood_DNA[blood]]\nDNA: [blood]</span>")
	return

/obj/item/device/detective_scanner/proc/extract_blood(var/atom/A)
	var/list/extracted_blood=list()
	if(A.blood_DNA)
		for(var/blood in A.blood_DNA)
			extracted_blood[blood]=A.blood_DNA[blood]
	return extracted_blood

/obj/item/device/detective_scanner/afterattack(atom/A, mob/user)
	if(!in_range(A,user))
		return
	if(loc != user)
		return

	var/list/blood_DNA_found    = src.extract_blood(A)

	if (istype(A,/obj/effect/rune))
		var/obj/effect/rune/R = A
		if (R.blood1)
			blood_DNA_found[R.blood1.data["blood_DNA"]] = R.blood1.data["blood_type"]
		if (R.blood2)
			blood_DNA_found[R.blood2.data["blood_DNA"]] = R.blood2.data["blood_type"]
		if (R.blood3)
			blood_DNA_found[R.blood3.data["blood_DNA"]] = R.blood3.data["blood_type"]
	// Blood/vomit splatters no longer clickable, so scan the entire turf.
	if (istype(A,/turf))
		var/turf/T=A
		for(var/atom/O in T)
			// Blood splatters, runes.
			if (istype(O, /obj/effect/decal/cleanable/blood) || istype(O, /obj/effect/rune_legacy))
				blood_DNA_found    += extract_blood(O)
			if (istype(O,/obj/effect/rune))
				var/obj/effect/rune/R = O
				if (R.blood1)
					blood_DNA_found[R.blood1.data["blood_DNA"]] = R.blood1.data["blood_type"]
				if (R.blood2)
					blood_DNA_found[R.blood2.data["blood_DNA"]] = R.blood2.data["blood_type"]
				if (R.blood3)
					blood_DNA_found[R.blood3.data["blood_DNA"]] = R.blood3.data["blood_type"]
	//General
	if (blood_DNA_found.len == 0)
		user.visible_message("\The [user] scans \the [A] with \a [src], the air around [user.gender == MALE ? "him" : "her"] humming[prob(70) ? " gently." : "."]",\
		"<span class='notice'>Unable to locate any blood on [A]!</span>",\
		"You hear a faint hum of electrical equipment.")
		return 0

	if(add_data(A,blood_DNA_found))
		to_chat(user, "<span class='notice'>Object already in internal memory. Consolidating data...</span>")
		return

	//Blood
	if (blood_DNA_found.len)
		to_chat(user, "<span class='notice'>Blood found on [A]. Analysing...</span>")
		spawn(15)
			for(var/blood in blood_DNA_found)
				to_chat(user, "Blood type: <span class='warning'>[blood_DNA_found[blood]] \t </span>DNA: <span class='warning'>[blood]</span>")

	if(prob(80))
		user.visible_message("\The [user] scans \the [A] with \a [src], the air around [user.gender == MALE ? "him" : "her"] humming[prob(70) ? " gently." : "."]",\
		"You finish scanning \the [A].",\
		"You hear a faint hum of electrical equipment.")
		return 0
	else
		user.visible_message("\The [user] scans \the [A] with \a [src], the air around [user.gender == MALE ? "him" : "her"] humming[prob(70) ? " gently." : "."]\n[user.gender == MALE ? "He" : "She"] seems to perk up slightly at the readout.",\
		"The results of the scan pique your interest.",\
		"You hear a faint hum of electrical equipment, and someone making a thoughtful noise.")
		return 0

/obj/item/device/detective_scanner/proc/add_data(var/atom/A, var/list/blood_DNA_found)
	//I love associative lists.
	var/list/data_entry = stored["\ref [A]"]
	if(islist(data_entry)) //Yay, it was already stored!
		var/list/blood = data_entry[3]
		if(!blood)
			blood = list()
		if(blood_DNA_found.len)
			for(var/main_blood in A.blood_DNA)
				if(!blood[main_blood])
					blood[main_blood] = A.blood_DNA[blood]
		return 1
	var/list/sum_list[2]	//Pack it back up!
	sum_list[1] = blood_DNA_found.Copy()
	sum_list[2] = "\The [A] in \the [get_area(A)]"
	stored["\ref [A]"] = sum_list
	return 0

/proc/get_timestamp()
	return time2text(world.time + 432000, "hh:mm:ss")

/obj/item/device/detective_scanner/forger
	var/list/custom_forgery[3]
	var/forging = 0

/obj/item/device/detective_scanner/forger/New()
	..()
	custom_forgery[1] = list()
	custom_forgery[2] = list()
	custom_forgery[3] = list()

/obj/item/device/detective_scanner/forger/attack_self(var/mob/user )
	var/list/customblood = list()
	if(forging)
		to_chat(user, "<span class='warning'>You are already forging evidence</span>")
		return 0
	clear_forgery()
	while(1)
		var/blood = html_encode(input(usr,"Please enter a custom Blood DNA or hit cancel to finish forging") as text|null)
		var/bloodtype = html_encode(input(usr,"Please enter a custom Blood Type") as text|null)
		if(!usr.client)
			forging = 0
			break
		if(!blood)
			break
		customblood[blood] = bloodtype
	forging = 0
	to_chat(user, "<span class='notice'>Forgery saved and will be tied to the next applicable scanned item.</span>")
	custom_forgery[1] = customblood ? customblood.Copy() : null

//shameless copy pasting
/obj/item/device/detective_scanner/forger/afterattack(atom/A, mob/user)
	var/list/custom_blood = list()

	if(custom_forgery)
		custom_blood = custom_forgery[3]

	if(!in_range(A,user))
		return
	if(loc != user)
		return

	var/list/blood_DNA_found = src.extract_blood(A)

	// Blood/vomit splatters no longer clickable, so scan the entire turf.
	if (istype(A,/turf))
		var/turf/T=A
		for(var/atom/O in T)
			// Blood splatters, runes.
			if (istype(O, /obj/effect/decal/cleanable/blood) || istype(O, /obj/effect/rune_legacy))
				blood_DNA_found += extract_blood(O)

	//General
	if (blood_DNA_found.len == 0)
		if(!custom_blood.len)
			user.visible_message("\The [user] scans \the [A] with \a [src], the air around [user.gender == MALE ? "him" : "her"] humming[prob(70) ? " gently." : "."]",\
			"<span class='notice'>Unable to locate any blood on [A]!</span>",\
			"You hear a faint hum of electrical equipment.")
			return 0
		else
			user.visible_message("\The [user] scans \the [A] with \a [src], the air around [user.gender == MALE ? "him" : "her"] humming[prob(70) ? " gently." : "."]",\
			"<span class='notice'>Unable to locate any blood on [A], loading custom forgery instead.</span>",\
			"You hear a faint hum of electrical equipment.")

	if(add_data(A,blood_DNA_found))
		to_chat(user, "<span class='notice'>Object already in internal memory. Consolidating data...</span>")
		return

	//Blood
	if(custom_blood.len)
		to_chat(user, "<span class='notice'>Forged Blood found. Analysing...</span>")
		spawn(15)
			for(var/blood in custom_blood)
				to_chat(user, "Blood type: <span class='warning'>[custom_blood[blood]] \t </span>DNA: <span class='warning'>[blood]</span>")
	else if (blood_DNA_found.len)
		to_chat(user, "<span class='notice'>Blood found on [A]. Analysing...</span>")
		spawn(15)
			for(var/blood in blood_DNA_found)
				to_chat(user, "Blood type: <span class='warning'>[blood_DNA_found[blood]] \t </span>DNA: <span class='warning'>[blood]</span>")
	return

/obj/item/device/detective_scanner/forger/add_data(var/atom/A, var/list/blood_DNA_found)
	//I love associative lists.
	var/list/data_entry = stored["\ref [A]"]
	var/list/custom_blood = list()

	if(custom_forgery)
		custom_blood = custom_forgery[1]

	if(islist(data_entry)) //Yay, it was already stored!
		// Blud
		var/list/blood = data_entry[3]
		if(!blood)
			blood = list()
		if(custom_blood.len)
			for(var/main_blood in custom_blood)
				if(!blood[main_blood])
					blood[main_blood] = custom_blood[blood]
		else if(blood_DNA_found && blood_DNA_found.len)
			for(var/main_blood in blood_DNA_found)
				if(!blood[main_blood])
					blood[main_blood] = blood_DNA_found[blood]
		return 1
	var/list/sum_list[2]	//Pack it back up!
	if(custom_blood.len)
		sum_list[1] = blood_DNA_found.Copy()
	sum_list[2] = "\The [A] in \the [get_area(A)]"
	stored["\ref [A]"] = sum_list
	clear_forgery()
	return 0

/obj/item/device/detective_scanner/forger/proc/clear_forgery()
	if(custom_forgery.len)
		custom_forgery[1] = list()
		custom_forgery[2] = list()
		custom_forgery[3] = list()
