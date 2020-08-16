/datum/preferences
	//The mob should have a gender you want before running this proc. Will run fine without H

/datum/preferences/proc/randomize_appearance_for(var/mob/living/carbon/human/H)
	if(H)
		if(H.gender == MALE)
			gender = MALE
		else
			gender = FEMALE
	s_tone = random_skin_tone(species)
	h_style = random_hair_style(gender, species)
	f_style = random_facial_hair_style(gender, species)
	randomize_hair_color("hair")
	randomize_hair_color("facial")
	randomize_eyes_color()
	underwear = rand(1,underwear_m.len)
	backbag = 2
	age = rand(AGE_MIN,AGE_MAX)
	if(H)
		copy_to(H,1)


/datum/preferences/proc/randomize_hair_color(var/target = "hair")
	if(prob (75) && target == "facial") // Chance to inherit hair color
		r_facial = r_hair
		g_facial = g_hair
		b_facial = b_hair
		return

	var/red
	var/green
	var/blue

	var/col = pick ("blonde", "black", "chestnut", "copper", "brown", "wheat", "old", 15;"punk")
	switch(col)
		if("blonde")
			red = 255
			green = 255
			blue = 0
		if("black")
			red = 0
			green = 0
			blue = 0
		if("chestnut")
			red = 153
			green = 102
			blue = 51
		if("copper")
			red = 255
			green = 153
			blue = 0
		if("brown")
			red = 102
			green = 51
			blue = 0
		if("wheat")
			red = 255
			green = 255
			blue = 153
		if("old")
			red = rand (100, 255)
			green = red
			blue = red
		if("punk")
			red = rand(0, 255)
			green = rand(0, 255)
			blue = rand(0, 255)

	red = max(min(red + rand (-25, 25), 255), 0)
	green = max(min(green + rand (-25, 25), 255), 0)
	blue = max(min(blue + rand (-25, 25), 255), 0)

	switch(target)
		if("hair")
			r_hair = red
			g_hair = green
			b_hair = blue
		if("facial")
			r_facial = red
			g_facial = green
			b_facial = blue

/datum/preferences/proc/randomize_eyes_color()
	var/red
	var/green
	var/blue

	var/col = pick ("black", "grey", "brown", "chestnut", "blue", "lightblue", "green", "albino")
	switch(col)
		if("black")
			red = 0
			green = 0
			blue = 0
		if("grey")
			red = rand (100, 200)
			green = red
			blue = red
		if("brown")
			red = 102
			green = 51
			blue = 0
		if("chestnut")
			red = 153
			green = 102
			blue = 0
		if("blue")
			red = 51
			green = 102
			blue = 204
		if("lightblue")
			red = 102
			green = 204
			blue = 255
		if("green")
			red = 0
			green = 102
			blue = 0
		if("albino")
			red = rand (200, 255)
			green = rand (0, 150)
			blue = rand (0, 150)

	red = max(min(red + rand (-25, 25), 255), 0)
	green = max(min(green + rand (-25, 25), 255), 0)
	blue = max(min(blue + rand (-25, 25), 255), 0)

	r_eyes = red
	g_eyes = green
	b_eyes = blue

/datum/preferences/proc/blend_backpack(var/icon/clothes_s,var/backbag,var/satchel,var/backpack="backpack",var/messenger_bag)
	switch(backbag)
		if(2)
			clothes_s.Blend(new /icon('icons/mob/back.dmi', backpack), ICON_OVERLAY)
		if(3)
			clothes_s.Blend(new /icon('icons/mob/back.dmi', satchel), ICON_OVERLAY)
		if(4)
			clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel"), ICON_OVERLAY)
		if(5)
			clothes_s.Blend(new /icon('icons/mob/back.dmi', messenger_bag), ICON_OVERLAY)
	return clothes_s

/proc/valid_sprite_accessories(var/from_list, var/gender_restriction, var/species_restriction, var/flag_restriction)
	. = list()
	for(var/key in from_list)
		var/datum/sprite_accessory/S = from_list[key]
		if(species_restriction && !(species_restriction in S.species_allowed))
			continue
		if(flag_restriction && (S.flags & flag_restriction))
			continue
		if(gender_restriction)
			if(gender_restriction == MALE && S.gender == FEMALE)
				continue
			if(gender_restriction == FEMALE && S.gender == MALE)
				continue

		.[key] = from_list[key]

/datum/preferences/proc/update_preview_icon(var/for_observer=0)		//seriously. This is horrendous.
	preview_icon_front = null
	preview_icon_side = null
	preview_icon = null

	var/g = "m"
	if(gender == FEMALE)
		g = "f"

	var/icon/icobase
	var/datum/species/current_species = all_species[species]

	//icon based species color
	if(current_species)
		if(current_species.name == "Vox")
			switch(s_tone)
				if(6)
					icobase = 'icons/mob/human_races/vox/r_voxemrl.dmi'
				if(5)
					icobase = 'icons/mob/human_races/vox/r_voxazu.dmi'
				if(4)
					icobase = 'icons/mob/human_races/vox/r_voxlgrn.dmi'
				if(3)
					icobase = 'icons/mob/human_races/vox/r_voxgry.dmi'
				if(2)
					icobase = 'icons/mob/human_races/vox/r_voxbrn.dmi'
				else
					icobase = 'icons/mob/human_races/vox/r_vox.dmi'
		else if(current_species.name == "Grey")
			switch(s_tone)
				if(4)
					icobase = 'icons/mob/human_races/grey/r_greyblue.dmi'
				if(3)
					icobase = 'icons/mob/human_races/grey/r_greygreen.dmi'
				if(2)
					icobase = 'icons/mob/human_races/grey/r_greylight.dmi'
				else
					icobase = 'icons/mob/human_races/grey/r_grey.dmi'
		else if(current_species.name == "Ork")
			if(job_engsec_high)
				switch(job_engsec_high)
					if(BASICORK)
						icobase = 'icons/mob/human_races/r_ork.dmi'
//					if(ORKGRETCHIN)
//						icobase = 'icons/mob/human_races/r_orkgretchin.dmi'
			else
				icobase = 'icons/mob/human_races/r_ork.dmi'
		else
			icobase = current_species.icobase
	else
		icobase = 'icons/mob/human_races/r_human.dmi'

	var/fat=""
	if(disabilities&DISABILITY_FLAG_FAT && current_species.anatomy_flags & CAN_BE_FAT)
		fat="_fat"
	preview_icon = new /icon(icobase, "torso_[g][fat]")
	preview_icon.Blend(new /icon(icobase, "groin_[g]"), ICON_OVERLAY)
	preview_icon.Blend(new /icon(icobase, "head_[g]"), ICON_OVERLAY)

	for(var/name in list(LIMB_LEFT_ARM,LIMB_RIGHT_ARM,LIMB_LEFT_LEG,LIMB_RIGHT_LEG,LIMB_LEFT_FOOT,LIMB_RIGHT_FOOT,LIMB_LEFT_HAND,LIMB_RIGHT_HAND))
		// make sure the organ is added to the list so it's drawn
		if(organ_data[name] == null)
			organ_data[name] = null

	for(var/name in organ_data)
		if(organ_data[name] == "amputated")
			continue

		var/o_icobase=icobase
		if(organ_data[name] == "peg")
			o_icobase='icons/mob/human_races/o_peg.dmi'
		else if(organ_data[name] == "cyborg")
			o_icobase='icons/mob/human_races/o_robot.dmi'

		var/icon/temp = new /icon(o_icobase, "[name]")

		preview_icon.Blend(temp, ICON_OVERLAY)

	// Skin tone
	if(current_species && (current_species.anatomy_flags & HAS_SKIN_TONE))
		if (s_tone >= 0)
			preview_icon.Blend(rgb(s_tone, s_tone, s_tone), ICON_ADD)
		else
			preview_icon.Blend(rgb(-s_tone,  -s_tone,  -s_tone), ICON_SUBTRACT)

	var/icon/eyes_s = new/icon("icon" = 'icons/mob/human_face.dmi', "icon_state" = current_species ? current_species.eyes : "eyes_s")
	eyes_s.Blend(rgb(r_eyes, g_eyes, b_eyes), ICON_ADD)

	var/datum/sprite_accessory/hair_style = hair_styles_list[h_style]

	if(hair_style)
		var/icon/hair_s = new/icon("icon" = hair_style.icon, "icon_state" = "[hair_style.icon_state]_s")
		if(hair_style.do_colouration)
			hair_s.Blend(rgb(r_hair, g_hair, b_hair), ICON_ADD)
		if(hair_style.additional_accessories)
			hair_s.Blend(icon("icon" = hair_style.icon, "icon_state" = "[hair_style.icon_state]_acc"), ICON_OVERLAY)
		eyes_s.Blend(hair_s, ICON_OVERLAY)		

	var/datum/sprite_accessory/facial_hair_style = facial_hair_styles_list[f_style]
	if(facial_hair_style)
		var/icon/facial_s = new/icon("icon" = facial_hair_style.icon, "icon_state" = "[facial_hair_style.icon_state]_s")
		facial_s.Blend(rgb(r_facial, g_facial, b_facial), ICON_ADD)
		eyes_s.Blend(facial_s, ICON_OVERLAY)

	var/icon/clothes_s = null

	var/uniform_dmi
	var/suit_dmi
	var/feet_dmi
	// UNIFORM DMI
	if(current_species)
		uniform_dmi=current_species.uniform_icons
		if(disabilities&DISABILITY_FLAG_FAT && current_species.fat_uniform_icons)
			uniform_dmi=current_species.fat_uniform_icons

	// SUIT DMI
	if(current_species)
		suit_dmi=current_species.wear_suit_icons
		if(disabilities&DISABILITY_FLAG_FAT && current_species.fat_wear_suit_icons)
			suit_dmi=current_species.fat_wear_suit_icons


	// SHOES DMI
		feet_dmi=current_species.shoes_icons

	if(!for_observer)
		// Commenting this check so that, if all else fails, the preview icon is never naked. - N3X
		//if(job_civilian_low & ASSISTANT) //This gives the preview icon clothes depending on which job(if any) is set to 'high'
		if((current_species.name != "Ork")) 
			clothes_s = new /icon(uniform_dmi, "squatteroutfit_s")
			clothes_s.Blend(new /icon('icons/mob/head.dmi', "squatter_hat"), ICON_OVERLAY)
			clothes_s.Blend(new /icon(feet_dmi, "black"), ICON_UNDERLAY)
		//if(current_species.name == "Ork") //Ss40k edit
		//	clothes_s = new /icon(uniform_dmi, "orkuniform1_s") //Edit end - No naked orks on job pref.
		//else
		if(job_civilian_high)//I hate how this looks, but there's no reason to go through this switch if it's empty
			switch(job_civilian_high)
				if(BARTENDER)
					clothes_s = new /icon(uniform_dmi, "ba_suit_s")
					clothes_s.Blend(new /icon(feet_dmi, "black"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon(suit_dmi, "armor"), ICON_OVERLAY)
					clothes_s=blend_backpack(clothes_s,backbag,"satchel-norm",null,"courierbag")
				if(CHEF)
					clothes_s = new /icon(uniform_dmi, "chef_s")
					clothes_s.Blend(new /icon(feet_dmi, "black"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "chef"), ICON_OVERLAY)
					clothes_s=blend_backpack(clothes_s,backbag,"satchel-norm",null,"courierbag")
				if(PREACHER)
					clothes_s = new /icon(uniform_dmi, "chapblack_s")
					clothes_s.Blend(new /icon(feet_dmi, "laceups"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/back.dmi', "eviscerator_off"), ICON_OVERLAY)
					clothes_s.Blend(new /icon(suit_dmi, "preacher_robe_t"), ICON_OVERLAY)
				if(CELEBRITY)
					clothes_s = new /icon(uniform_dmi, "red_suit_s")
					clothes_s.Blend(new /icon(feet_dmi, "cowboy"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon(suit_dmi, "celeb"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "pwig"), ICON_OVERLAY)
				if(MIME)
					clothes_s = new /icon(uniform_dmi, "mime_s")
					clothes_s.Blend(new /icon(feet_dmi, "black"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "white"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/mask.dmi', "mime"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "beret"), ICON_OVERLAY)
					clothes_s.Blend(new /icon(suit_dmi, "suspenders"), ICON_OVERLAY)
					clothes_s=blend_backpack(clothes_s,backbag,"satchel-norm",null,"courierbag")

		else if(job_medsci_high)
			switch(job_medsci_high)
				if(DOCTOR)
					clothes_s = new /icon(uniform_dmi, "medical_s")
					clothes_s.Blend(new /icon(feet_dmi, "white"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/in-hand/left/items_lefthand.dmi', "firstaid"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon(suit_dmi, "labcoat_open"), ICON_OVERLAY)
					clothes_s=blend_backpack(clothes_s,backbag,"satchel-med","medicalpack","courierbagmed")

		else if(job_engsec_high)
			switch(job_engsec_high)
				if(INQUISITOR)
					clothes_s = new /icon(uniform_dmi, "uni-church_s")
					clothes_s.Blend(new /icon(feet_dmi, "noble-boots"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "black"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "inqhat"), ICON_OVERLAY)
					clothes_s.Blend(new /icon(suit_dmi, "inq"), ICON_OVERLAY)
					clothes_s=blend_backpack(clothes_s,backbag,"satchel-norm",null,"courierbag")
				if(AI)//Gives AI and borgs assistant-wear, so they can still customize their character
					clothes_s = new /icon(uniform_dmi, "grey_s")
					clothes_s.Blend(new /icon(feet_dmi, "black"), ICON_UNDERLAY)
					clothes_s=blend_backpack(clothes_s,backbag,"satchel-norm",null,"courierbag")
				if(CYBORG)
					clothes_s = new /icon(uniform_dmi, "grey_s")
					clothes_s.Blend(new /icon(feet_dmi, "black"), ICON_UNDERLAY)
					clothes_s=blend_backpack(clothes_s,backbag,"satchel-norm",null,"courierbag")
				if(BASICORK) //SS40k EDIT
					clothes_s = new /icon(uniform_dmi, "orkuniform1_s")
					clothes_s.Blend(new /icon('z40k_shit/icons/mob/orks/orkgearMOB.dmi', "orkhelmet1"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('z40k_shit/icons/mob/orks/orkgearMOB.dmi', "orkboots1"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('z40k_shit/icons/mob/orks/orkgearMOB.dmi', "orkbackpack"), ICON_OVERLAY)
				if(LORD)
					clothes_s = new /icon(uniform_dmi, "lord_s")
					clothes_s.Blend(new /icon(feet_dmi, "lord"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('z40k_shit/icons/mob/lord_hat.dmi', "lord_hat"), ICON_OVERLAY)
					clothes_s.Blend(new /icon(suit_dmi, "lord"), ICON_OVERLAY)
				if(KNIGHTOFFICER)
					clothes_s = new /icon(uniform_dmi, "knight_officer_s")
					clothes_s.Blend(new /icon(feet_dmi, "knight_officer"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "knight_officer"), ICON_OVERLAY)
					clothes_s.Blend(new /icon(suit_dmi, "knight_officer"), ICON_OVERLAY)
				if(PATROLMAN)
					clothes_s = new /icon(uniform_dmi, "patrolman_s")
					clothes_s.Blend(new /icon(feet_dmi, "patrolman"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "patrolman"), ICON_OVERLAY)
					clothes_s.Blend(new /icon(suit_dmi, "patrolman"), ICON_OVERLAY)
				if(COMMISSAR)
					clothes_s = new /icon(uniform_dmi, "commissar_s")
					clothes_s.Blend(new /icon(feet_dmi, "noble-boots"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "commissarcap"), ICON_OVERLAY)
					clothes_s.Blend(new /icon(suit_dmi, "commissarcoat"), ICON_OVERLAY) 

	// Observers get tourist outfit.
	else
		clothes_s = new /icon(uniform_dmi, "tourist_s")
		clothes_s.Blend(new /icon(feet_dmi, "black"), ICON_UNDERLAY)
		clothes_s=blend_backpack(clothes_s,backbag,"satchel-norm",null,"courierbag")

	if(disabilities & NEARSIGHTED)
		preview_icon.Blend(new /icon('icons/mob/eyes.dmi', "glasses"), ICON_OVERLAY)

	preview_icon.Blend(eyes_s, ICON_OVERLAY)
	if(clothes_s)
		preview_icon.Blend(clothes_s, ICON_OVERLAY)
	preview_icon_front = new(preview_icon, dir = SOUTH)
	preview_icon_side = new(preview_icon, dir = WEST)

	eyes_s = null
	clothes_s = null
