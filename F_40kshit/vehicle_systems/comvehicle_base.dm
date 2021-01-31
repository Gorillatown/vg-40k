/*
	TODO: Unify all vehicles into one system right here, so we can have parts
	and more customization.
	One day there will be a internal map appender for x-tra larges.
	Directional Damage/Plating
	Weight System
	Fuel System
	Ammo System
	Gear Ratios - Speed Calculations ETC

	Procs used are as follows

Base -
	New() - basically called upon new()
	Destroy() - Called upon qdel()
	vehicle_melee(atom/target) - Handles melee if target is adjacent in click_action_control()
	breakdown() - Handles when the vehicle gets broken
	handle_parts_overlays() - handles the parts overlays
	attackby(obj/item/W, mob/user) - Basically handles melee attacks on it/parts insertion
	attack_hand(mob/user) - basically handles parts removal
	toggle_part(var/systems_online, var/reference_id) - Handles toggling parts on and off
	
	enter_exit_handler(mob/user) - Handles moving in and out of the vehicle
	move_outside(mob/user, turf/exit_turf) - Handles moving a mob outside
	move_into_vehicle(mob/living/user) - Handles moving a mob into vehicle
	enter_vehicle_actions(mob/user) - Handles action handling when mob enters vehicle
	leave_vehicle_actions(mob/user) - Handles action handling when mob leaves vehicle

Click Procs - 
	MouseDropTo(mob/M, mob/user) - Handles click drag onto object
	MouseDropFrom(atom/over) - Handles what happens if you click and drag the object out
	click_action_control() - Handles what occurs if the user clicks while in or on vehicle.

Damage Procs -
	to_bump(atom/A) - Occurs when the object bumps into something
	bullet_act(obj/item/projectile/P) - Occurs when a bullet hits the vehicle
	ex_act(severity) - Occurs when caught in a explosion
	adjust_health(var/damage, var/direction) - Handles health adjustments from other procs.

Engine & Movement Procs -
	relaymove(mob/user, direction) - Basically when in the contents of something, handles arrow key presses.
	engine_fire_loop() - Basically a loop that handles our engine movement.
	Process() - This is a subsystem loop, it basically handles non user-input movement for this.

*/
/obj/com_vehicle
	name = "Complex Vehicle"
	density = 1
	opacity = 0
	anchored = 1
	appearance_flags = LONG_GLIDE
	layer = VEHICLE_LAYER
	plane = ABOVE_HUMAN_PLANE
	internal_gravity = 1 // Can move in 0-gravity

	var/mechanically_disabled = FALSE //Are we currently mechanically disabled? Aka health depleted etc
	var/health = 100 //the Moving Health value
	//list/chassis_actions - Basically this holds actions innate to the vehicle itself
	var/chassis_actions = list(/datum/action/linked_parts_buttons/toggle_engine)
	//list/occupants - Basically a list that keeps track of occupants, if it contains them instead of atom locks them on.
	var/list/occupants
	var/pilot_zoom = FALSE //Mostly so we don't fuck this up and let zoomed out people go scott free
	var/vehicle_zoom //So we can control how much vehicles zoom in and out without extra action code.
	var/maint_hatch_open = FALSE //Is the maintenance hatch open?
	var/next_melee_time = FALSE //Holder for the melee cooldown
	
	var/list/parts_overlays = list() //Holder for parts overlays
	var/list/damage_overlays = list("Damage" = null,
									"Disabled" = null) //Holder for damage overlays

//Configuration Variables -----------------------------------------
	var/passenger_limit = FALSE //Upper limit for how many passengers are allowed
	var/passengers_allowed = FALSE //If the pilot allows people to jump in the side seats.
	var/maxHealth = 100 //The maximum health we can achieve, health is set to this in New()
	//contains_occupants - Basically if the vehicle contains occupants, or lets them ride outside of the vehicle.
	var/contains_occupants = FALSE
	var/melee_time = 1 SECONDS //How often we can melee in a vehicle.
	var/list/destroyable_obj = list(/obj/mecha, /obj/structure/window, /obj/structure/grille, /obj/com_vehicle)

//-------Sounds--------
	var/list/movement_sounds = null
	var/list/turning_sounds = null
	var/list/engine_startup_noise = null
	
/*****************************
	Engine Master Variables
*****************************/
	var/engine_fire_delay = 0 //Delay until next engine movement fire.
	var/engine_online = FALSE //Whether the engine is on or off
	var/engine_cooldown = FALSE
	var/engine_looping = FALSE //Safety Var
	var/speed = 0 //The current acceleration we are at a scale of -1000 to 1000
	var/movement_warning_oncd = FALSE
	var/datum/delay_controller/move_delayer = new(1, ARBITRARILY_LARGE_NUMBER) //See setup.dm, 12

//Configuration Variables ---------------------
	var/max_speed = 0 //Max Speed we can go
	var/max_reverse_speed = 0 //Max Reverse Speed we can go
	var/speed_loss = 0 //Amount we tick down in loss
	var/acceleration = 0 //Amount we gain when we use a keyboard input
	var/movement_delay = 4 //Basically the speed of turning/direction inputs/gliding etc
	var/inverse_handling = FALSE //Whether we have inverse handling or not
	var/can_reverse = FALSE //Can we reverse or not, If its not then it turns into a brake
	var/idle_output = FALSE //If during engine idle range we continue outputting movement.

/***************************
	Parts & Equipment Masters
****************************/
	var/datum/comvehicle_parts/comvehicle_parts

/**************************
		new
**************************/
/obj/com_vehicle/New()
	..()

	processing_objects += src
	health = maxHealth
	
	comvehicle_parts = new
	comvehicle_parts.my_atom = src
	
	for(var/path in chassis_actions) //Mark 1
		var/innate_actions = new path(src) //We create the actions inside of this object. They should add themselve to held actions.
		comvehicle_parts.action_storage += innate_actions

	if(contains_occupants)
		occupants = list()
		var/datum/action/linked_parts_buttons/exit_vehicle/exit = new(src)
		comvehicle_parts.action_storage += exit

/**************************
		destroy
**************************/
/obj/com_vehicle/Destroy()
	processing_objects -= src
	
	qdel(comvehicle_parts)
	comvehicle_parts = null
	
	..()

/**************************
		vehicle_melee
**************************/
/obj/com_vehicle/proc/vehicle_melee(atom/target)
	return 0

/**************************
		attackby
**************************/
/obj/com_vehicle/attackby(obj/item/W, mob/user)
	if(iscrowbar(W))
		maint_hatch_open = !maint_hatch_open
		to_chat(user, "<span class='notice'>You [maint_hatch_open ? "open" : "close"] the maintenance hatch.</span>")
		return
	if(health < maxHealth && iswelder(W))
		var/obj/item/weapon/weldingtool/WT = W
		if(WT.do_weld(user, src, 30, 5))
			to_chat(user, "<span class='notice'>You patch up \the [src].</span>")
			adjust_health(-rand(15,30))
			handle_damage_overlays()
			return
	if(istype(W, /obj/item/vehicle_parts))
		if(!maint_hatch_open)
			return ..()
		if(user.drop_item(W, src))
			to_chat(user, "<span class='notice'>You insert the [W] into [src].</span>")
			comvehicle_parts.parts_insertion(get_pilot(), W)
			handle_parts_overlays()
			return
	
	if(W.force)
		visible_message("<span class = 'warning'>\The [user] hits \the [src] with \the [W]</span>")
		adjust_health(W.force)
		W.on_attack(src, user)

/**************************
		attack_hand
**************************/
/obj/com_vehicle/attack_hand(mob/user)
	if(!maint_hatch_open)
		return ..()
	if(!comvehicle_parts.equipment_systems.len)
		to_chat(user, "<span class='warning'>The [src] has no vehicle parts in it, and the hatch is open.</span>")
		return
	var/PEEPEE = input(user,"Remove which equipment?", "", "Cancel") as null|anything in comvehicle_parts.equipment_systems
	if(PEEPEE != "Cancel")
		var/obj/item/vehicle_parts/SCREE = PEEPEE
		if(user.put_in_any_hand_if_possible(SCREE))
			to_chat(user, "<span class='notice'>You remove \the [SCREE] from the equipment system, and turn any systems off.</span>")
			comvehicle_parts.parts_removal(get_pilot(), SCREE)
			handle_parts_overlays()
		else
			to_chat(user, "<span class='warning'>You need an open hand to do that.</span>")

/**************************
		breakdown
**************************/
/obj/com_vehicle/proc/breakdown()
	mechanically_disabled = TRUE //Making sure its stopped here and now doubly so.

	if(comvehicle_parts.equipment_systems)
		for(var/obj/item/vehicle_parts/equipment in comvehicle_parts.equipment_systems)
			equipment.forceMove(loc)
			comvehicle_parts.parts_removal(get_pilot(), equipment)
			equipment.throw_at(get_edge_target_turf(loc, pick(alldirs)), 7, 30)
	
	comvehicle_parts.action_clean_up()
	handle_parts_overlays()

/**************************
	move_outside
**************************/
/obj/com_vehicle/proc/move_outside(mob/user, turf/exit_turf)
	if(!exit_turf)
		exit_turf = get_turf(src)
	leave_vehicle_actions(user)
	if(pilot_zoom && user == get_pilot())
		user.regenerate_icons()
		var/client/C = user.client
		C.changeView(C.view - vehicle_zoom)
		pilot_zoom = FALSE
	user.forceMove(exit_turf)

/**************************
	move_into_vehicle
**************************/
/obj/com_vehicle/proc/move_into_vehicle(mob/living/user)
	var/was_zoomed = FALSE
	for(var/obj/item/weapon/gun/G in user.contents)
		if(G.currently_zoomed)
			G.currently_zoomed = FALSE
			was_zoomed = TRUE
			for(var/obj/item/weapon/attachment/scope/ATCH in G.ATCHSYS.attachments)
				if(ATCH.currently_zoomed)
					was_zoomed = TRUE
					ATCH.currently_zoomed = FALSE
	if(was_zoomed)
		user.regenerate_icons()
		var/client/C = user.client
		C.changeView()

	if(user in range(1))
		user.reset_view(src)
		user.stop_pulling()
		user.forceMove(src)
		enter_vehicle_actions(user)
		return 1
	return 0

/**************************
	enter_exit_handler
**************************/
/obj/com_vehicle/proc/enter_exit_handler(mob/user)
	if(occupants.Find(user))
		move_outside(user, get_turf(src))
		return
	if(user.incapacitated() || user.lying) //are you cuffed, dying, lying, stunned or other
		return
	if(!ishigherbeing(user))
		visible_message("<span class='notice'>[user] starts to climb into \the [src] but can't because its too stupid.</span>")
		return
	
	visible_message("<span class='notice'>[user] starts to climb into \the [src].</span>")
	if(do_after(user, user, 4 SECONDS))
		if(!get_pilot() || occupants.len+1 < passenger_limit)
			move_into_vehicle(user)
		else
			to_chat(user, "<span class='warning'>Not enough room inside \the [src].</span>")
	else
		to_chat(user, "You stop entering \the [src].")
	return

/**************************
		get_pilot
**************************/
/obj/com_vehicle/proc/get_pilot()
	if(occupants.len)
		return occupants[1]
	return 0

/**************************
	enter_vehicle_actions
**************************/
/obj/com_vehicle/proc/enter_vehicle_actions(mob/user)
	occupants += user
	var/pilot = get_pilot()
	for(var/datum/action/linked_parts_buttons/action in comvehicle_parts.action_storage)
		if(user == pilot)
			action.Grant(user)
		else 
			if(action.pilot_only)
				continue
			else
				var/datum/action/newaction = new action.type(src)
				comvehicle_parts.extra_actions += newaction
				newaction.Grant(user)

/**************************
	leave_vehicle_actions
**************************/
/obj/com_vehicle/proc/leave_vehicle_actions(mob/user)
	occupants -= user

	for(var/datum/action/linked_parts_buttons/action in comvehicle_parts.action_storage)
		action.Remove(user)
	
	for(var/datum/action/linked_parts_buttons/action in comvehicle_parts.extra_actions)
		if(action.owner)
			if(action.owner == user)
				comvehicle_parts.extra_actions -= action
				action.Remove(user)
				qdel(action)
		else
			comvehicle_parts.extra_actions -= action
			qdel(action)

	if(get_pilot()) //In the scenario we have another pilot after the first pilot leaves.
		var/mob/living/new_pilot = get_pilot()
		for(var/datum/action/linked_parts_buttons/action in comvehicle_parts.extra_actions)
			if(action.owner)
				if(action.owner == new_pilot)
					action.Remove(new_pilot)
					comvehicle_parts.extra_actions -= action
					qdel(action)
			else
				comvehicle_parts.extra_actions -= action
				qdel(action)
		
		for(var/datum/action/linked_parts_buttons/action in comvehicle_parts.action_storage)
			action.Grant(new_pilot)

/**************************
	handle_parts_overlays
**************************/
/obj/com_vehicle/proc/handle_parts_overlays()
	vis_contents.Cut()
	for(var/obj/item/vehicle_parts/parts in comvehicle_parts.equipment_systems)
		if(parts.vis_con_overlay)
			var/obj/effect/overlay/the_overlay = new parts.vis_con_overlay()
			the_overlay.icon_state = "[the_overlay.icon_state]-[name]"
			vis_contents += the_overlay

/obj/com_vehicle/proc/handle_damage_overlays()
	var/obj/effect/overlay/damaged_overlay/CHECK = damage_overlays["damaged"]
	
	if(health < maxHealth/2 && !CHECK)
		var/obj/effect/overlay/damaged_overlay/DO = new()
		damage_overlays["damaged"] = DO
		DO.icon_state = "damaged-[name]"
		vis_contents += DO
	
	if(health > maxHealth/2 && CHECK)
		vis_contents -= damage_overlays["damaged"]
		damage_overlays["damaged"] = null
		qdel(CHECK)

	if(health <= 0)
		var/obj/effect/overlay/disabled_overlay/DISO = new()
		damage_overlays["Disabled"] = DISO
		DISO.icon_state = "fire-[name]"
		vis_contents += DISO
	

/**************************
		update_icon
**************************/
/obj/com_vehicle/update_icon()
	return

/**************************
		toggle_part
**************************/
/obj/com_vehicle/proc/toggle_part(var/systems_online, var/reference_id)
	if(usr!=get_pilot())
		return
	for(var/obj/item/vehicle_parts/parts in comvehicle_parts.equipment_systems)
		if(parts.id == reference_id)
			if(systems_online)
				parts.systems_online = TRUE
				to_chat(get_pilot(), "<span class='notice'>[parts.name] switched on.</span>")
				playsound(src, 'sound/items/flashlight_on.ogg', 50, 1)
			else
				parts.systems_online = FALSE
				to_chat(get_pilot(), "<span class='notice'>[parts.name] switched off.</span>")
				playsound(src, 'sound/items/flashlight_on.ogg', 50, 1)

/**************************
	Overlays
**************************/
/obj/effect/overlay/damaged_overlay
	name = "damage"
	icon = 'F_40kshit/icons/complex_vehicle/vehicle_overlays64x64.dmi'
	plane = ABOVE_HUMAN_PLANE
	layer = VEHICLE_LAYER

	vis_flags = VIS_INHERIT_ID|VIS_INHERIT_DIR

/obj/effect/overlay/disabled_overlay
	name = "disabled"
	icon = 'F_40kshit/icons/complex_vehicle/vehicle_overlays64x64.dmi'
	plane = ABOVE_HUMAN_PLANE
	layer = VEHICLE_LAYER

	vis_flags = VIS_INHERIT_ID|VIS_INHERIT_DIR
