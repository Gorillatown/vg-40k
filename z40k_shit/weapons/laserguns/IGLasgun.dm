//Within is the imperial guard ranged stuff for the moment. Lasguns etc

/*
	MAGAZINES/AMMO
					*/
/obj/item/weapon/cell/lasgunmag //Our magazine
	name = "lasgun mag"
	origin_tech = Tc_POWERSTORAGE + "=8"
	icon = 'z40k_shit/icons/obj/ig/IGequipment.dmi'
	icon_state = "lasgunmag"
	maxcharge = 4500
	starting_materials = list(MAT_IRON = 700, MAT_GLASS = 80)

/*
	LASGUN OBJECT
					*/

/obj/item/weapon/gun/energy/lasgun 
	name = "M-Galaxy Pattern Lasgun"
	desc = "Standard issue ranged weapon given to Guardsmen of the Imperial Guard."
	icon = 'z40k_shit/icons/obj/ig/IGequipment.dmi'
	icon_state = "lasgun100-nby-nscp"
	item_state = "lasgun-unwielded-nby-nscp" //We jsut auto change neways
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/IG_lasgun_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/IG_lasgun_right.dmi')
	cell_type = "/obj/item/weapon/cell/lasgunmag" //Lasgunmag
	fire_sound = 'z40k_shit/sounds/Lasgun0.ogg'
	projectile_type = /obj/item/projectile/beam/lowpower
	force = 15
	charge_cost = 75
	icon_charge_multiple = 25 //Do I really need icon charge multiples for the lasgun.
	var/lasgun_shot_strength = 1 //For this we will use 1 to 3 to determine what state its set to.
	var/degradation_state = 10 //We will use this to keep track of the lasgun degradation, If it hits 1 we explode or fail.
	var/gunheat = 0 //The heat of the lasgun.
	flags = TWOHANDABLE
	actions_types = list(/datum/action/item_action/warhams/adjust_power,
						/datum/action/item_action/warhams/basic_swap_stance)

/obj/item/weapon/gun/energy/lasgun/New()
	..()
	processing_objects.Add(src)
	update_icon()

/obj/item/weapon/gun/energy/lasgun/Destroy()
	processing_objects.Remove(src)
	..()

/obj/item/weapon/gun/energy/lasgun/interpret_powerwords(mob/living/target, mob/living/user, def_zone, var/originator = null)
	..()
	var/mob/living/carbon/human/H = user
	var/mob/living/carbon/human/T = target

	switch(H.word_combo_chain)
		if("chargeknockbackhurt")
			user.visible_message("<span class='danger'>[H] follows up with a lunge into [T]!")
			target.adjustBruteLoss(15)
			T.attackby(src,user)
			H.word_combo_chain = ""
			H.update_powerwords_hud(clear = TRUE)

/*
	LASGUN EXAMINE
					*/
/obj/item/weapon/gun/energy/lasgun/examine(mob/user)
	..()
	switch(gunheat)
		if(60 to 120)
			to_chat(user, "The [src] is pretty hot.")
		if(121 to 151)
			to_chat(user, "<span class='warning'>The [src] is VERY hot.</span>")

/*
	RENAME GUN
				*/
/obj/item/weapon/gun/energy/lasgun/verb/rename_gun() //I could add possession here later for funs.
	set name = "Name Gun"
	set category = "Object"
	set desc = "Click to rename your gun."

	var/mob/M = usr
	if(!M.mind)
		return 0

	var/input = stripped_input(usr,"What do you want to name the gun?","", MAX_NAME_LEN)

	if(src && input && !M.stat && in_range(src,M))
		name = input
		to_chat(M, "You name the gun [input]. Say hello to your new friend.")
		return 1

/*
	LASGUN POWER ADJUSTMENT ACTION AND PROC HANDLING
													*/
/datum/action/item_action/warhams/adjust_power //This adjusts the strength of the lasgun shot.
	name = "Adjust Power"
	button_icon_state = "power_setting"

/datum/action/item_action/warhams/adjust_power/Trigger()
	var/obj/item/weapon/gun/energy/lasgun/LSG = target
	LSG.adjust_power(owner)

/obj/item/weapon/gun/energy/lasgun/proc/adjust_power(var/mob/user)
	var/chargestrength = input(user, "Adjust Power Settings (Warning: Mishandling can result in misfires)", "Lasgun Power Setting") in list("Low Power","Medium Power","Maximum Power")
	if(chargestrength)
		if(chargestrength == "Low Power")
			src.lasgun_shot_strength = 1 //We set strength
			src.charge_cost = 75	//And we set charge cost - 60 shots
		if(chargestrength == "Medium Power")
			src.lasgun_shot_strength = 2 //Med STR
			src.charge_cost = 150 // 30 Shots
		if(chargestrength == "Maximum Power")
			src.lasgun_shot_strength = 3 //High STR
			src.charge_cost = 300 //15 shots
		src.setprojtype() //The verb calls this, we can add arguments later once we know what we need.

/obj/item/weapon/gun/energy/lasgun/proc/setprojtype() // Yep
//This proc/verb set can be made into a generic on guns later with a actual list of choices.
	if(lasgun_shot_strength == 1) //So forgive me if its kinda ass
		switch(degradation_state)
			if(0 to 5)
				projectile_type = /obj/item/projectile/beam/lowpower/degraded
			if(6 to 10)
				projectile_type = /obj/item/projectile/beam/lowpower
	if(lasgun_shot_strength == 2)
		switch(degradation_state)
			if(0 to 5)
				projectile_type = /obj/item/projectile/beam/medpower/degraded
			if(6 to 10)
				projectile_type = /obj/item/projectile/beam/medpower
	if(lasgun_shot_strength == 3)
		switch(degradation_state)
			if(0 to 5)
				projectile_type = /obj/item/projectile/beam/maxpower/degraded
			if(6 to 10)
				projectile_type = /obj/item/projectile/beam/maxpower
	in_chamber = null
		
/obj/item/weapon/gun/energy/lasgun/process() //In process we handle heat
	if(gunheat > 0) //If we are greater than 0
		gunheat -= 15

/*
	FIRING PROCS
				*/

/obj/item/weapon/gun/energy/lasgun/process_chambered()
	if(in_chamber)
		return 1
	if(!power_supply)
		return 0
	if(!power_supply.use(charge_cost)) 
		return 0
	if(!projectile_type)
		return 0
	switch(lasgun_shot_strength) //We change the projectile processed based on lasgun strength
		if(1) //Low-power
			gunheat += 5
		if(2) //Medium-power
			gunheat += 10
		if(3) //High-power
			gunheat += 25
	in_chamber = new projectile_type(src)
	return 1

/obj/item/weapon/gun/energy/lasgun/Fire(atom/target, mob/living/user, params, reflex = 0, struggle = 0)
	var/atom/newtarget = target
	if(!wielded)
		newtarget = get_inaccuracy(target,1+recoil) //Inaccurate when not wielded
	..(newtarget,user,params,reflex,struggle)

/*
	ITEM INTERACTIONS
					*/
/obj/item/weapon/gun/energy/lasgun/attackby(var/obj/item/A, mob/user) //Loading
	if(A.is_screwdriver(user))
		to_chat(user, "<span class='notice'>You adjust and repair the [src].</span>")
		degradation_state = 10
		setprojtype()
	if(istype(A, /obj/item/weapon/cell))
		var/obj/item/weapon/cell/AM = A
		if(!power_supply)
			LoadMag(AM, user)
		else
			to_chat(user, "<span class='warning'>There is already a magazine loaded in \the [src]!</span>")
	..()

/obj/item/weapon/gun/energy/lasgun/attack_hand(mob/user)
	if(user.get_inactive_hand() == src)
		RemoveMag(user)
	else
		..()

/obj/item/weapon/gun/energy/lasgun/attack_self(mob/user) //Unloading (Need special handler for unattaching.)
	if(user.get_active_hand() == src)
		if(!wielded)
			wield(user)
			src.update_wield(user)
		else
			unwield(user)
			src.update_wield(user)

/obj/item/weapon/gun/energy/lasgun/update_wield(mob/user)
	..()
	force = wielded ? 35 : 15
	update_icon()

/*
	ICON HANDLING
					*/

/obj/item/weapon/gun/energy/lasgun/update_icon() // welp
	var/ratio = 0

	if(power_supply && power_supply.maxcharge > 0) //If the gun has a power cell, calculate how much % power is left in it
		ratio = power_supply.charge / power_supply.maxcharge

	//If there's no power cell, the gun looks as if it had an empty power cell
	ratio *= 100
	ratio = clamp(ratio, 0, 100) //Value between 0 and 100

	if(ratio >= 50)
		ratio = Floor(ratio, icon_charge_multiple)
	else
		ratio = Ceiling(ratio, icon_charge_multiple)

	var/mag //Mag String
	if(power_supply)
		mag = 1
	else
		mag = 0

	var/bayonet = FALSE
	var/scope = FALSE
	for(var/obj/item/weapon/attachment/ATCH in ATCHSYS.attachments)
		if(istype(ATCH, /obj/item/weapon/attachment/bayonet))
			bayonet = TRUE
		if(istype(ATCH, /obj/item/weapon/attachment/scope))
			scope = TRUE

	if(charge_states)
		icon_state = "lasgun[ratio][bayonet ? "-by" : "-nby"][scope ? "-scp" : "-nscp"][mag ? "" : "-e"]"
	item_state = "lasgun[wielded ? "-wielded" : "-unwielded"][bayonet ? "-by" : "-nby"][scope ? "-scp" : "-nscp"]"

/*
	MAGAZINE HANDLING
						*/

/obj/item/weapon/gun/energy/lasgun/proc/LoadMag(var/obj/item/weapon/cell/AM, var/mob/user)
	if(istype(AM, /obj/item/weapon/cell) && !power_supply)
		if(user)
			if(user.drop_item(AM, src))
				to_chat(user, "<span class='notice'>You load the magazine into \the [src].</span>")
			else
				return

		power_supply = AM
		AM.update_icon()
		update_icon()
		return 1
	return 0

/obj/item/weapon/gun/energy/lasgun/proc/RemoveMag(var/mob/user)
	if(power_supply)
		power_supply.forceMove(get_turf(src.loc))
		if(user)
			user.put_in_hands(power_supply)
			to_chat(user, "<span class='notice'>You pull the magazine out of \the [src].</span>")
		power_supply.update_icon()
		power_supply = null
		update_icon()
		return 1
	return 0

/*
	LASGUN DEGRADATION SYSTEM
								*/

//In the failure check we will account for heat failures, along with weapon degradation.
/obj/item/weapon/gun/energy/lasgun/failure_check(var/mob/living/carbon/human/M)
	if(istext(projectile_type))
		projectile_type = text2path(projectile_type)
	switch(projectile_type)
		if(/obj/item/projectile/beam/lowpower, /obj/item/projectile/beam/lowpower/degraded)
			if(prob(2)) //2
				degradegun(M)
				return 1
		if(/obj/item/projectile/beam/medpower, /obj/item/projectile/beam/medpower/degraded)
			if(prob(5)) //5
				degradegun(M)
				return 1
		if(/obj/item/projectile/beam/maxpower, /obj/item/projectile/beam/maxpower/degraded)
			if(prob(20)) //20
				degradegun(M)
				return 1
			if(prob(5)) // 1
				to_chat(M, "<span class='danger'>\The [src] overloads and explodes!.</span>")
				explosion(get_turf(loc), -1, 0, 2)
				M.drop_item(src, force_drop = 1)
				qdel(src)
				return 0

	switch(gunheat) //Heat failure, we handle this on a increasing scale of probability.
		if(60 to 79)
			if(prob(70))
				spark(src)
				to_chat(M, "<span class='warning'>\The [src] sparks violently. Its feeling a bit hot</span>")
				return 1
		if(80 to 120)
			if(prob(10))
				fire_delay += rand(2, 6)
				M.drop_item()
				M.audible_scream()
				M.adjustFireLossByPart(rand(1, 3), LIMB_LEFT_HAND, src)
				M.adjustFireLossByPart(rand(1, 3), LIMB_RIGHT_HAND, src)
				to_chat(M, "<span class='danger'>\The [src] burns your hands!.</span>")
				return 0
		if(121 to 150)
			if(prob(50))
				fire_delay += rand(2, 6)
				M.drop_item()
				M.audible_scream()
				M.adjustFireLossByPart(rand(5, 10), LIMB_LEFT_HAND, src)
				M.adjustFireLossByPart(rand(5, 10), LIMB_RIGHT_HAND, src)
				to_chat(M, "<span class='danger'>\The [src] SCORCHES your hands!.</span>")
				return 0
			if(prob(25))
				var/turf/T = get_turf(loc)
				explosion(T, 0, 1, 3, 5)
				M.drop_item(src, force_drop = 1)
				qdel(src)
				to_chat(M, "<span class='danger'>\The [src] explodes!.</span>")
				return 0
		if(151 to INFINITY)
			var/turf/T = get_turf(loc)
			explosion(T, 0, 1, 3, 5)
			M.drop_item(src, force_drop = 1)
			qdel(src)
			to_chat(M, "<span class='danger'>\The [src] explodes!.</span>")
			return 0

	return ..()

//Right here is where the beam change occurs.
/obj/item/weapon/gun/energy/lasgun/proc/degradegun(var/mob/living/carbon/human/M)
	if(degradation_state > 0)
		degradation_state--
		fire_delay +=3
		to_chat(M, "<span class='warning'>Something inside \the [src] pops.</span>")
	if(0 >= degradation_state)
		if(prob(50))
			var/turf/T = get_turf(loc)
			explosion(T, 0, 1, 3, 5)
			M.drop_item(src, force_drop = 1)
			qdel(src)
			to_chat(M, "<span class='danger'>\The [src] explodes!.</span>")
		else
			to_chat(M, "<span class='danger'>\The [src] breaks apart!.</span>")
			qdel(src)


/*
	BEAMLIST
			*/

/obj/item/projectile/beam/maxpower
	name = "powerful laser"
	damage = 45

/obj/item/projectile/beam/maxpower/degraded
	damage = 30
	
/obj/item/projectile/beam/medpower
	name = "average laser"
	damage = 25

/obj/item/projectile/beam/medpower/degraded
	damage = 15

/obj/item/projectile/beam/lowpower
	name = "low-power laser"
	damage = 15

/obj/item/projectile/beam/lowpower/degraded
	damage = 10