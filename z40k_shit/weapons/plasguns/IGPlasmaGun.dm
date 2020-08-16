/obj/item/weapon/iguard/ig_powerpack
	name = "Powerpack"
	desc = "Contains Hydrogen....Probably?"
	icon = 'z40k_shit/icons/obj/ig/IGarmorandclothesOBJ.dmi'
	icon_state = "powerpack"
	item_state = "powerpack"
	slot_flags = SLOT_BACK
	w_class = W_CLASS_LARGE
	var/max_fuel = 1500 //The max amount of fuel this can hold
	var/start_fueled = 1 // Do we start fueled
	var/my_gun //Where we store our gun ref if we link them together.

//We create our reagent here
/obj/item/weapon/iguard/ig_powerpack/New()
	. = ..()

	create_reagents(max_fuel)
	if(start_fueled)
		reagents.add_reagent(HYDROGEN, max_fuel)

//If someone drops a plasma gun onto us, we tie ourselves together.
/obj/item/weapon/iguard/ig_powerpack/MouseDropTo(atom/movable/O, mob/user )
	..()
	if(istype(O, /obj/item/weapon/gun/ig_plasma_gun))
		if(user.is_wearing_item(src, slot_back))
			var/obj/item/weapon/gun/ig_plasma_gun/ASS = O
			if(do_after(user,src,20))
				to_chat(user, "<span class='warning'>You attach hose to [src] and [O]</span>")
				ASS.my_pack = src
				my_gun = ASS
				ASS.connection_type = 3
				ASS.update_icon()

//If someone pulls our powerpack off, we unlink them, if we exist that is.
/obj/item/weapon/iguard/ig_powerpack/unequipped(mob/user)
	..()
	if(my_gun)
		var/obj/item/weapon/gun/ig_plasma_gun/ASS = locate(/obj/item/weapon/gun/ig_plasma_gun) in user.held_items
		if(ASS)
			ASS.my_pack = null
			my_gun = null
			ASS.update_icon()

//If we attack a hydrogen tank with our powerpack we refuel.
/obj/item/weapon/iguard/ig_powerpack/afterattack(obj/O, mob/user, proximity)
	if(!proximity)
		return
	if(istype(O, /obj/structure/reagent_dispensers/hydrogen_tank) && get_dist(src,O) <= 1)
		O.reagents.trans_to(src, max_fuel)
		to_chat(user, "<span class='notice'> Pack refueled</span>")
		playsound(src, 'sound/effects/refill.ogg', 50, 1, -6)
		return
 
//If we want to locate how much fuel we have, we use this proc.
/obj/item/weapon/iguard/ig_powerpack/proc/get_fuel()
	return reagents.get_reagent_amount(HYDROGEN)

//We have three icon states
//plasma_gun-e   Which is empty
//plasma_gun     We have a regular fuel cell in
//plasma_gun-ppack     We are linked to a powerpack
//Our fuel cell state is plas_fuel_cell
/obj/item/weapon/gun/ig_plasma_gun
	name = "Plasma Gun"
	desc = "Its a Plasma Gun"
	icon = 'z40k_shit/icons/obj/ig/IGequipment.dmi'
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/64x64plasgun_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/64x64plasgun_right.dmi')
	icon_state = "plasma_gun"
	item_state = "plasma_gun"
	var/obj/item/weapon/iguard/ig_powerpack/my_pack //The powerpack we are attached to if there is one. Basically a ref
	var/obj/item/hydrogen_fuel_cell/my_cell //Our cell if we got one.
	overcharged = FALSE //Are we overcharged or not?
	throw_range = 0
	throw_speed = 1
	fire_sound = null
	flags = TWOHANDABLE | MUSTTWOHAND
	slot_flags = null
	var/gunheat = 0 //GUN HEAT, because its a fucking plasgun damn.
	var/connection_type = 1 // 1 = No Connection, 2 = Cell connection, 3 = Ppack connection
	actions_types = list(/datum/action/item_action/warhams/heavydef_swap_stance,
						/datum/action/item_action/warhams/energy_overcharge)

/obj/item/weapon/gun/ig_plasma_gun/New()
	..()
	processing_objects.Add(src)
	update_icon()

/obj/item/weapon/gun/ig_plasma_gun/Destroy()
	..()
	processing_objects.Remove(src)

/obj/item/weapon/gun/ig_plasma_gun/process()
	if(gunheat > 0) //If we are greater than 0
		gunheat -= 10

//If we drop this we will clear our pack reference.
/obj/item/weapon/gun/ig_plasma_gun/dropped(mob/user) //If we drop this, we clear references
	..()
	if(connection_type == 3) //We are linked to a pack
		my_pack = null //We clear the reference
		connection_type = 1 //And become connection type 1 which is NOTHING.
		update_icon()

/obj/item/weapon/gun/ig_plasma_gun/overcharge(var/mob/living/user)
	..()

/obj/item/weapon/gun/ig_plasma_gun/update_icon()
	var/mob/living/carbon/human/H = loc

	switch(connection_type)
		if(1) //No connection
			icon_state = "plasma_gun-e"
			item_state = "plasma_gun-e"
		if(2) //Fuel Cell connection
			icon_state = "plasma_gun"
			item_state = "plasma_gun"
		if(3) //Powerpack hose connection
			icon_state = "plasma_gun-ppack"
			item_state = "plasma_gun-ppack"
			
	if(istype(loc,/mob/living/carbon/human))
		H.update_inv_hands()

/obj/item/weapon/gun/ig_plasma_gun/attackby(var/obj/item/A, mob/user)
	if(istype(A, /obj/item/hydrogen_fuel_cell))
		switch(connection_type)
			if(1)
				user.drop_item(A, src)
				my_cell = A
				connection_type = 2
				update_icon()
			if(2)
				to_chat(user,"You begin replacing the fuel cell")
				my_cell.forceMove(get_turf(src))
				my_cell = null
				connection_type = 1
				if(do_after(user,src,40))
					user.drop_item(A, src)
					my_cell = A
					connection_type = 2
			if(3)
				to_chat(user,"The place for your fuel cell is currently occupied by a hose.")
	..()

/obj/item/weapon/gun/ig_plasma_gun/throw_impact(atom/hit_atom, mob/user) //If we throw this, we return to pack.
	..()
	if(isturf(hit_atom))
		if(connection_type == 3)
			my_pack.my_gun = null
			my_pack = null
			connection_type = 1
		update_icon()


/obj/item/weapon/gun/ig_plasma_gun/attack_self(var/mob/user) 
	..()

//Process chambered
/obj/item/weapon/gun/ig_plasma_gun/process_chambered(mob/living/user)
	if(in_chamber)
		return 1
	switch(connection_type)
		if(1) //No Connection
			return 0
		if(2) //Cell Connection
			if(my_cell.get_fuel() > 0)
				my_cell.reagents.remove_reagent(HYDROGEN,10)
				in_chamber = new /obj/item/projectile/plasma(src)
				return 1
		if(3) //Pack Connection
			if(my_pack.get_fuel() > 0)
				my_pack.reagents.remove_reagent(HYDROGEN, 10)
				in_chamber = new /obj/item/projectile/plasma(src)
				return 1
	return 0


/obj/item/weapon/gun/ig_plasma_gun/failure_check(mob/living/user)
	if(overcharged) 
		gunheat += 6
		if(prob(3+gunheat))
			user.visible_message("<span class='notice'> [src] begins failsafe venting.</span>")
			user.adjustFireLoss(500)
			gunheat = 0
			for(var/mob/living/burntcunts in range(1,user))
				burntcunts.adjustFireLoss(500)
			var/obj/effect/effect/smoke/S = new /obj/effect/effect/smoke(get_turf(src))
			S.time_to_live = 20 //2 seconds instead of full 10
	else
		gunheat += 3
		if(prob(1+gunheat)) //A good chance to boil alive if you spam shoot.
			user.visible_message("<span class='notice'> [src] begins failsafe venting.</span>")
			gunheat = 0
			for(var/mob/living/burntcunts in range(1,user))
				burntcunts.adjustFireLoss(500)
			var/obj/effect/effect/smoke/S = new /obj/effect/effect/smoke(get_turf(src))
			S.time_to_live = 20 //2 seconds instead of full 10
		
	return 1

//Fire action
/obj/item/weapon/gun/ig_plasma_gun/Fire(atom/target, mob/living/user, params, reflex = 0, struggle = 0)
	var/atom/newtarget = target
	var/plasdelay = 15

	switch(connection_type)
		if(1)
			return 0
		if(2)
			if(my_cell.get_fuel() > 0)
				if(istype(user.get_held_item_by_index(GRASP_RIGHT_HAND), src)) //right hand
					user.vis_contents += new /obj/effect/overlay/plasgun_charge(user,plasdelay,"rhand")
				else //left hand
					user.vis_contents += new /obj/effect/overlay/plasgun_charge(user,plasdelay,"lhand")
				sleep(plasdelay)
		if(3)
			if(my_pack.get_fuel() > 0)
				if(istype(user.get_held_item_by_index(GRASP_RIGHT_HAND), src)) //right hand
					user.vis_contents += new /obj/effect/overlay/plasgun_charge(user,plasdelay,"rhand")
				else //left hand
					user.vis_contents += new /obj/effect/overlay/plasgun_charge(user,plasdelay,"lhand")
				sleep(plasdelay)
	
	..(newtarget,user,params,reflex,struggle)


/*
	VISCONTENTS EFFRTS OVERLAYS
								*/

/obj/effect/overlay/plasgun_charge
	name = "plasgun charge"
	icon = 'z40k_shit/icons/64x64effects.dmi'
	icon_state = "plasgun_overlay_left"
	layer = LIGHTING_LAYER
	vis_flags = VIS_INHERIT_DIR
	pixel_y = -3
	pixel_x = -WORLD_ICON_SIZE/2
	pixel_y = -WORLD_ICON_SIZE/2

/obj/effect/overlay/plasgun_charge/New(var/mob/M,var/effect_duration,var/handstring)
	..()

	switch(handstring)
		if("rhand")
			icon_state = "plasgun_overlay_right"
		if("lhand")
			icon_state = "plasgun_overlay_left"

	animate(src, alpha = 0)
	animate(src, alpha = 255, time = effect_duration)

	spawn(effect_duration)
		M.vis_contents -= src
		qdel(src)

/*
	Hydrogen tank lmao
						*/
/obj/structure/reagent_dispensers/hydrogen_tank
	name = "hydrogen tank"
	desc = "A tank filled with hydrogen."
	icon_state = "degreasertank"
	amount_per_transfer_from_this = 5

/obj/structure/reagent_dispensers/degreaser/New()
	. = ..()
	reagents.add_reagent(HYDROGEN, 1000)

/*
	Plasma Projectile
						*/
/obj/item/projectile/plasma
	name = "plasma"
	damage_type = BRUTE
	flag = "bullet"
	kill_count = 100
	penetration = 20
	layer = PROJECTILE_LAYER
	damage = 90
	icon = 'z40k_shit/icons/obj/projectiles.dmi'
	icon_state = "plasma"
	animate_movement = 2
	custom_impact = 1
	linear_movement = 0
	fire_sound = 'z40k_shit/sounds/plasmagun.ogg'

/obj/item/projectile/plasma/OnFired()
	..()
	var/obj/item/weapon/gun/ig_plasma_gun/plasgun = shot_from
	if(!plasgun || !istype(plasgun))
		return
	if(plasgun.overcharged)
		icon = 'z40k_shit/icons/obj/64x64projectiles.dmi'
		damage = 140
		kill_count = 20
	else
		icon = 'z40k_shit/icons/obj/projectiles.dmi'


/*
	HYDROGEN FUEL CELL
						*/
/obj/item/hydrogen_fuel_cell
	name = "Hydrogen Fuel Cell"
	desc = "Cryogenically frozen hydrogen, fit for jamming into a plasma weapon. Good for 10 shots."
	icon = 'z40k_shit/icons/obj/ig/IGequipment.dmi'
	icon_state = "plas_fuel_cell"
	var/max_fuel = 100
	
/obj/item/hydrogen_fuel_cell/New()
	..()
	src.pixel_x = rand(1,10)
	src.pixel_y = rand(1,10)
	create_reagents(max_fuel)
	reagents.add_reagent(HYDROGEN, max_fuel)

/obj/item/hydrogen_fuel_cell/proc/get_fuel()
	return reagents.get_reagent_amount(HYDROGEN)
