/obj/item/vehicle_parts/weaponery
	name = "ERROR IDIOT"
	desc = "Go fuck yourself if you spawned this"
	var/projectile_type //Type of Projectile
	var/fire_delay = 10 SECONDS //Delay on when next action can be done. World.time + this
	var/projectiles_per_shot = 2 //How many projectiles come out
	tied_action = null //Action tied to this piece of equipment.
	
	var/weapon_online = FALSE //Is our weapon online or not, we are checked in the click loop.
	var/next_firetime = 0 //Basically Holds our cooldown
	var/performing_action = FALSE
	var/list/fire_sound = null
