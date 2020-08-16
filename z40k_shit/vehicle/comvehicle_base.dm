// honk
#define DAMAGE			1
#define FIRE			2
#define DOZERBLADE		3

//I am so not fucking fixing this
#define BATTLECANNON	4
#define DEMOLISHER		5
#define PUNISHER		6
#define HBOLTER			7

#define COMPLEX_VEHICLE_LIGHTS_RANGE_ON 8
#define COMPLEX_VEHICLE_LIGHTS_RANGE_OFF 3 //one tile beyond the complex_vehicle itself, "cockpit glow"

/obj/complex_vehicle
	name = "\improper complex_vehicle"
	desc = "A ground tank meant for ground travel."
	icon = 'z40k_shit/icons/complex_vehicle/Leman_Russ_128x128.dmi'
	density = 1 //Dense. To raise the heat.
	opacity = 0
	anchored = 1
	internal_gravity = 1 // Can move in 0-gravity
	layer = VEHICLE_LAYER
	plane = ABOVE_HUMAN_PLANE

	var/passenger_limit = 1 //Upper limit for how many passengers are allowed
	var/passengers_allowed = 1 //If the pilot allows people to jump in the side seats.
	var/list/occupants = list()

	var/hatch_open = 0
	var/list/tank_overlays
	var/health = 5000
	var/maxHealth = 5000
	var/lights_enabled = FALSE
	light_power = 2
	light_range = COMPLEX_VEHICLE_LIGHTS_RANGE_OFF
	appearance_flags = LONG_GLIDE
	var/datum/delay_controller/move_delayer = new(0.1, ARBITRARILY_LARGE_NUMBER) //See setup.dm, 12
	
	var/mainturret = /obj/complex_vehicle/complex_turret //What turret comes attached to us
	var/vehicle_width = 3 //We use this for action calculations
	var/vehicle_height = 3 //Basically its so it knows where the projectiles should appear.
	var/obj/complex_vehicle/GT

	var/list/chassis_actions = list(
		/datum/action/complex_vehicle_equipment/toggle_passengers,
		/datum/action/complex_vehicle_equipment/toggle_lights,
		/datum/action/complex_vehicle_equipment/toggle_engine,
		/datum/action/complex_vehicle_equipment/enter_and_exit,
		) //These are actions innate to the object, basically a reference list for what to add on.
	
	var/datum/comvehicle/equipment/ES //Our equipment controller and action holder.
	var/pilot_zoom = FALSE //Mostly so we don't fuck this up and let zoomed out people go scott free
	var/vehicle_zoom //So we can control how much vehicles zoom in and out without extra action code.
	var/dozer_blade = FALSE //Do we got a dozerblade on our vehicle?

	var/chosen_weapon_overlay //My laziness knows no bounds. Fuck cleaning up the icons again.
	
	var/vehicle_broken_husk = FALSE //Are we completely broken to leave a husk?

	// ENGINE MASTER
	var/engine_toggle = 0 //Whether the engine is on or off and our while loop is on.
	var/acceleration = 500 //Scale of 0 to 1000
	var/engine_cooldown = FALSE //To stop people from starting it on and off rapidly
	var/enginemaster_sleep_time = 1 //How long the enginemaster sleeps at the end of its loop.
	var/movement_delay = 3 //Speed of turning
	var/movement_warning_oncd = FALSE

	

//Visible Slots - I'm sure theres a better way to do this. But we can optimize later
	//What is in position 1, or Is there a position 1.
	var/position_1 = null

/obj/complex_vehicle/New()
	..()
	handle_new_overlays()
	bound_width = vehicle_width*WORLD_ICON_SIZE
	bound_height = vehicle_height*WORLD_ICON_SIZE
	dir = EAST

	ES = new(src) //New equipment system in US
	
	for(var/path in chassis_actions) //Mark 1
		var/cunts = new path(src) //We create the actions inside of this object. They should add themselve to held actions.
		ES.action_storage += cunts

/obj/complex_vehicle/initialize()
	..()
	GT = new mainturret(src.loc)
	lock_atom(GT)

/obj/complex_vehicle/Destroy()
	if(occupants.len)
		for(var/mob/living/L in occupants)
			move_outside(L)
			L.gib()
	
	if(ES.equipment_systems)
		for(var/obj/item/device/vehicle_equipment/bitch in ES.equipment_systems)
			bitch.forceMove(src.loc)
			bitch.throw_at(get_turf(pick(orange(7,src))))
		
	
	qdel(tank_overlays[DAMAGE])
	qdel(tank_overlays[FIRE])
	qdel(tank_overlays[DOZERBLADE])
	qdel(tank_overlays[DEMOLISHER])
	qdel(tank_overlays[BATTLECANNON])
	qdel(tank_overlays[PUNISHER])
	qdel(tank_overlays[HBOLTER])
	tank_overlays = null
	
	unlock_atom(GT)
	qdel(GT)

	..()

//Mostly so we leave a husk instead of destroying the vehicle completely
/obj/complex_vehicle/proc/break_this_shit()
	var/origin = get_turf(src) // A holder for height
	vehicle_broken_husk = TRUE //Making sure its stopped here and now doubly so.

	if(ES.equipment_systems)
		for(var/q=1 to vehicle_width+1)
			origin = get_step(origin,EAST)
		
		for(var/obj/item/device/vehicle_equipment/bitch in ES.equipment_systems)
			
			bitch.forceMove(origin)
			ES.make_it_end(src,bitch,FALSE,get_pilot())
			
			spawn(1)
				bitch.throw_at(get_turf(pick(orange(7,src))), 7, 20)

	handle_weapon_overlays()
	vehicle_broken_husk = TRUE

/obj/complex_vehicle/proc/handle_new_overlays()
	if(!tank_overlays)
		tank_overlays = new/list(7)
		tank_overlays[DAMAGE] = image(icon, icon_state="chassis_damage")
		tank_overlays[FIRE] = image(icon, icon_state="chassis_fire")
		tank_overlays[DOZERBLADE] = image(icon,icon_state="chassis_dozerblade")
		tank_overlays[DEMOLISHER] = image(icon,icon_state="chassis_demolisher")
		tank_overlays[BATTLECANNON] = image(icon,icon_state="chassis_battlecannon")
		tank_overlays[PUNISHER] = image(icon,icon_state="chassis_punisher")
		tank_overlays[HBOLTER] = image(icon,icon_state="chassis_hbolter")

/obj/complex_vehicle/proc/handle_weapon_overlays()
	overlays.Cut()
	
	chosen_weapon_overlay = null
	update_icon()
	if(dozer_blade)
		overlays += tank_overlays[DOZERBLADE]
	else
		overlays -= tank_overlays[DOZERBLADE]

	for(var/obj/item/device/vehicle_equipment/weaponry/FIRSTPICK in ES.equipment_systems)
		chosen_weapon_overlay = FIRSTPICK
		break

	if(chosen_weapon_overlay)
		if(istype(chosen_weapon_overlay, /obj/item/device/vehicle_equipment/weaponry/demolisher))
			overlays += tank_overlays[DEMOLISHER]
		if(istype(chosen_weapon_overlay, /obj/item/device/vehicle_equipment/weaponry/battlecannon))
			overlays += tank_overlays[BATTLECANNON]
		if(istype(chosen_weapon_overlay, /obj/item/device/vehicle_equipment/weaponry/punisher))
			overlays += tank_overlays[PUNISHER]
		if(istype(chosen_weapon_overlay, /obj/item/device/vehicle_equipment/weaponry/heavybolter))
			overlays += tank_overlays[HBOLTER]
	else
		return FALSE

/obj/complex_vehicle/update_icon()
	if(health <= round(initial(health)/2))
		overlays += tank_overlays[DAMAGE]
		if(health <= round(initial(health)/4))
			overlays += tank_overlays[FIRE]
		else
			overlays -= tank_overlays[FIRE]
	else
		overlays -= tank_overlays[DAMAGE]

/obj/complex_vehicle/attackby(obj/item/W, mob/user)
	if(iscrowbar(W))
		hatch_open = !hatch_open
		to_chat(user, "<span class='notice'>You [hatch_open ? "open" : "close"] the maintenance hatch.</span>")
		return
	if(health < maxHealth && iswelder(W))
		var/obj/item/weapon/weldingtool/WT = W
		if(WT.do_weld(user, src, 30, 5))
			to_chat(user, "<span class='notice'>You patch up \the [src].</span>")
			adjust_health(-rand(15,30))
			return
	if(istype(W, /obj/item/device/vehicle_equipment))
		if(!hatch_open)
			return ..()
		if(istype(W, /obj/item/device/vehicle_equipment))
			if(user.drop_item(W, src))
				to_chat(user, "<span class='notice'>You insert the [W] into [src].</span>")
				ES.make_it_end(src,W,TRUE,get_pilot())
				update_icon()
				return
	if(W.force)
		visible_message("<span class = 'warning'>\The [user] hits \the [src] with \the [W]</span>")
		adjust_health(W.force)
		W.on_attack(src, user)


/obj/complex_vehicle/attack_hand(mob/user )
	if(!hatch_open)
		return ..()
	if(!ES.equipment_systems.len)
		to_chat(user, "<span class='warning'>The [src] has no vehicle parts in it, and the hatch is open.</span>")
		return
	var/PEEPEE = input(user,"Remove which equipment?", "", "Cancel") as null|anything in ES.equipment_systems
	if(PEEPEE != "Cancel")
		var/obj/item/device/vehicle_equipment/SCREE = PEEPEE
		if(user.put_in_any_hand_if_possible(SCREE))
			to_chat(user, "<span class='notice'>You remove \the [SCREE] from the equipment system, and turn any systems off.</span>")
			ES.make_it_end(src,SCREE,FALSE,get_pilot())
			update_icon()
		else
			to_chat(user, "<span class='warning'>You need an open hand to do that.</span>")

/obj/complex_vehicle/proc/toggle_lights()
	if(lights_enabled)
		set_light(COMPLEX_VEHICLE_LIGHTS_RANGE_OFF)
		to_chat(usr, "<span class='notice'>Lights disabled.</span>")
	else
		set_light(COMPLEX_VEHICLE_LIGHTS_RANGE_ON)
		to_chat(usr, "<span class='notice'>Lights enabled.</span>")
	lights_enabled = !lights_enabled

/obj/complex_vehicle/acidable()
	return 0

/obj/complex_vehicle/proc/move_into_vehicle(var/mob/living/user)
	if(user && user.client && user in range(1))
		user.reset_view(src)
		user.stop_pulling()
		user.forceMove(src)
		tight_fuckable_dickhole(user, TRUE)
		return 1
	return 0

/obj/complex_vehicle/proc/get_pilot()
	if(occupants.len)
		return occupants[1]
	return 0

/obj/complex_vehicle/proc/get_maingunner()
	if(occupants.len)
		return occupants[2]
	return 0

/obj/complex_vehicle/proc/has_passengers()
	if(occupants.len > 1)
		return occupants.len-1
	return 0

/obj/complex_vehicle/proc/get_passengers()
	var/list/L = list()
	if(occupants.len > 1)
		L = occupants.Copy(2)
	return L

/obj/complex_vehicle/proc/toggle_passengers()
	if(usr!=get_pilot())
		return
	src.passengers_allowed = !passengers_allowed
	to_chat(src.get_pilot(), "<span class='notice'>Now [passengers_allowed?"allowing passengers":"disallowing passengers, and ejecting any current passengers"].</span>")
	if(!passengers_allowed && has_passengers())
		for(var/mob/living/L in get_passengers())
			to_chat(L, "<span class='warning'>Ejection sequence activated: Ejecting in 3 seconds</span>")
			spawn(30)
				if(occupants.Find(L) && L.loc == src)
					playsound(src, 'sound/weapons/rocket.ogg', 50, 1)
					var/turf/T = get_turf(src)
					var/turf/target_turf
					move_outside(L,T)
					target_turf = get_edge_target_turf(T, opposite_dirs[dir])
					L.throw_at(target_turf,100,3)

/obj/complex_vehicle/proc/move_outside(var/mob/user, var/turf/exit_turf)
	if(!exit_turf)
		exit_turf = get_turf(src)
	tight_fuckable_dickhole(user, FALSE)
	if(pilot_zoom && user == get_pilot())
		user.regenerate_icons()
		var/client/C = user.client
		C.changeView(C.view - vehicle_zoom)
		pilot_zoom = FALSE
	user.forceMove(exit_turf)

/obj/complex_vehicle/proc/tight_fuckable_dickhole(var/mob/user, var/Entered)
	var/pilot
	if(Entered)
		occupants.Add(user)
		pilot = get_pilot()
		if(user == pilot)
			for(var/datum/action/complex_vehicle_equipment/action in ES.action_storage)
				action.Grant(user)
		else
			for(var/datum/action/complex_vehicle_equipment/action in ES.action_storage)
				if(action.pilot_only)
					continue
				else
					var/datum/action/newaction = new action.type(src)
					ES.extra_actions += newaction
					newaction.Grant(user)

	else //Exited
		pilot = get_pilot()
		occupants.Remove(user)
		if(user == pilot)
			for(var/datum/action/complex_vehicle_equipment/action in ES.action_storage)
				action.Remove(user)
		else
			for(var/datum/action/complex_vehicle_equipment/action in ES.extra_actions)
				if(action.owner)
					if(action.owner == user)
						ES.extra_actions -= action
						action.Remove(user)
						qdel(action)
				else
					ES.extra_actions -= action
					qdel(action)
		if(get_pilot() && pilot != get_pilot()) //In the scenario we have another pilot after the first pilot leaves.
			var/mob/living/new_pilot = get_pilot()
			if(!new_pilot)
				return
			for(var/datum/action/complex_vehicle_equipment/action in ES.extra_actions)
				if(action.owner)
					if(action.owner == new_pilot)
						action.Remove(new_pilot)
						ES.extra_actions -= action
						qdel(action)
				else
					ES.extra_actions -= action
					qdel(action)
			for(var/datum/action/complex_vehicle_equipment/action in ES.action_storage)
				action.Grant(new_pilot)

/obj/complex_vehicle/proc/toggle_weapon(var/weapon_toggle, var/obj/item/device/vehicle_equipment/weaponry/mygun, var/datum/action/complex_vehicle_equipment/actionid)
	if(usr!=get_pilot())
		return
	for(mygun in ES.equipment_systems)
		if(mygun.id == actionid)
			if(weapon_toggle)
				mygun.weapon_online = TRUE
				to_chat(src.get_pilot(), "<span class='notice'>[mygun.name] switched on.</span>")
				playsound(src, 'sound/items/flashlight_on.ogg', 50, 1)
			else
				mygun.weapon_online = FALSE
				to_chat(src.get_pilot(), "<span class='notice'>[mygun.name] switched off.</span>")
				playsound(src, 'sound/items/flashlight_on.ogg', 50, 1)


#undef DAMAGE
#undef FIRE
#undef DOZERBLADE

#undef BATTLECANNON	
#undef DEMOLISHER		
#undef PUNISHER		
#undef HBOLTER			

#undef COMPLEX_VEHICLE_LIGHTS_RANGE_ON
#undef COMPLEX_VEHICLE_LIGHTS_RANGE_OFF
