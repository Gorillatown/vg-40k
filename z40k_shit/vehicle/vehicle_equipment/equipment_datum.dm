/*
	DYNAMIC EQUIPMENT DATUM
							*/
//Work in progress
//So forgive me if things aren't as optimized as they need to be.
//Things must first start to exist and function before we think about how to optimally route them.
//Love - JTGSZ (3/5/2020)

/datum/comvehicle/equipment
	var/obj/my_atom //Holder for what spawned our asses
	var/weapons_allowed = 5 //How many weapons we have can attach by default.
	var/list/equipment_systems = list() //Container of all the equipment we currently have.
	var/list/action_storage = list() //Container of all the actions we currently have.
	var/list/extra_actions = list() //A container of duplicate actions granted to extra users.

/datum/comvehicle/equipment/New(var/obj/CV)
	..()
	if(istype(CV))
		my_atom = CV
/*
Proc call vars. - Attachment Master
 (1) master object	-	Must be source object... or at least a object.
 (2) attached equipment		-	Must be of the type. /obj/item/device/vehicle_equipment ...Unless you add all the vars.
 (3) attach or detach	-	Basically either TRUE or FALSE
 (4) master user	-	Must be a mob. Usually get_pilot()
*/
/datum/comvehicle/equipment/proc/make_it_end(var/obj/complex_vehicle/master_src, var/obj/item/device/vehicle_equipment/equipment, var/slide_in, var/user)
	if(slide_in)
		equipment.my_atom = master_src //My equipmentes atom is the massa object.
		equipment_systems += equipment //We add equipment to our equipment list
		if(equipment.tied_action) //If equipment has a tied action.
			var/datum/action/complex_vehicle_equipment/equipment_action = new equipment.tied_action(master_src) //new abstract construct spawned into massa obj.
			action_storage += equipment_action

			spawn(1)
				equipment_action.id = equipment.id //The actions ID is now the objects ID, tying them together.
	
			if(user) //If we have a massa man
				equipment_action.Grant(user) //grant him our equipment_action.

			if(!equipment_action.pilot_only)
				var/theuser
				if(master_src.occupants.len > 1)
					for(var/i=1 to master_src.occupants.len)
						if(i==1)
							continue
						theuser = master_src.occupants[i]
						var/datum/action/fuck = new equipment_action.type(master_src)
						extra_actions += fuck
						fuck.Grant(theuser)
						
		if(istype(equipment,/obj/item/device/vehicle_equipment/dozer_blade)) //Dozerblade
			master_src.dozer_blade = TRUE

	else //I'm pullin out.
		equipment.my_atom = null //you don't got no atom equipment.
		equipment_systems -= equipment //and you leavin our equipment_systems
		
		var/located_equipment = locate(equipment.tied_action) in action_storage
		if(located_equipment)
			action_storage -= located_equipment
			var/datum/action/ARSE = located_equipment
			if(user)
				ARSE.Remove(user) //And I'm removing your ass too.

			var/extra_action_locate
			var/datum/action/ASS
			var/other_users
			if(extra_actions.len) //If extra actions has length
				for(var/i=1 to master_src.occupants.len) //for var i=1 to len of occupants on master src
					if(i==1) //While we are on 1 we just continue
						continue

					extra_action_locate = locate(equipment.tied_action) in extra_actions //We find the tied action in extra actions
					if(extra_action_locate) //If we find it
						ASS = extra_action_locate //We assigned it to the action var
						extra_actions -= located_equipment //We remove the extra actions of the located equipment
						other_users = master_src.occupants[i] //Other user is in the occupants iteration
						ASS.Remove(other_users) //We remove the action from them too.

		if(istype(equipment,/obj/item/device/vehicle_equipment/dozer_blade)) //Dozerblade
			master_src.dozer_blade = FALSE

	master_src.handle_weapon_overlays()

/*
	VEHICLE EQUIPMENT PARENT
							*/
//Here mostly so we can append stuff fast during development
/obj/item/device/vehicle_equipment
	name = "equipment"
	icon = 'z40k_shit/icons/complex_vehicle/vehicle_equipment.dmi'
	var/tied_action //The action button tied to the object
	var/obj/my_atom //Basically the object we are attached to.
	var/id			//The ID we share with our action button if we have one.
	
//Our ID is tied to the action button ID. Theoretically theres a 1 in 10000 chance for a magic button.
/obj/item/device/vehicle_equipment/New()
	id = rand(1, 10000)

//Basically when you click with the switch toggled on, it performs this proc.
/obj/item/device/vehicle_equipment/proc/action(atom/target)
	return

/obj/item/device/vehicle_equipment/ex_act() //No QDEL from ex_Acts
	return

/*
	VEHICLE EQUIPMENT WEAPONERY PARENT
										*/
//Parent of all weapon objects.
/obj/item/device/vehicle_equipment/weaponry
	name = "weapon parent"
	desc = "You shouldn't be seeing this"
	var/projectile_type //Type of Projectile
	var/fire_delay = 10 //Delay on when next action can be done.
	var/projectiles_per_shot = 2 //How many projectiles come out
	tied_action = null //Action tied to this piece of equipment.
	var/weapon_online = FALSE //Is our weapon online or not, we are checked in the click loop.
	var/next_firetime = 0 //Basically Holds our cooldown
	var/list/fire_sound = list('z40k_shit/sounds/slugga_1.ogg') //Fire sound when we fire
	var/projectile_max = 45 //Max amount of projectiles we will spit out

/obj/item/device/vehicle_equipment/weaponry/New()
	..() //Gives us our ID

//Basically when you click with the switch toggled on, it performs this proc.
/obj/item/device/vehicle_equipment/weaponry/action(atom/target)
	return