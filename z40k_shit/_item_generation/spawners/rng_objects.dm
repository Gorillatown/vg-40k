/obj/abstract/loot_spawners
	icon = 'icons/obj/map/spawners.dmi'
	alpha = 255
	invisibility = 101
	mouse_opacity = 0

	var/item_position_jiggle = FALSE //Basically moves its pixel x and pixel y for decorative purposes
	var/amount_to_pick = 0 //Amount of objects to pick from the table
	var/prob_of_nothing = 0 //Probability nothing spawns
	var/prob_of_skipped_items = 0 //Probability we skip a item
	
	var/chance_of_artifact = 0 //Probability we run a object through the special artifact spawner.

	var/list/loot_table = list() //Loot table
/*	var/mob_spawn_list = list(
		/mob/living/simple_animal/hostile/asteroid/goliath  = 5,
		/mob/living/simple_animal/hostile/asteroid/goldgrub = 1,
		/mob/living/simple_animal/hostile/asteroid/basilisk = 3,
		/mob/living/simple_animal/hostile/asteroid/hivelord = 5,
		/mob/living/simple_animal/hostile/asteroid/magmaw = 4,
		/mob/living/simple_animal/hostile/asteroid/pillow = 2
	)*/

/obj/abstract/loot_spawners/New()
	..()
	if(prob(prob_of_nothing))
		perform_spawn()

/obj/abstract/loot_spawners/proc/perform_spawn()
	for(var/i=0 to amount_to_pick)
		if(prob(prob_of_skipped_items))
			continue
		else
			var/lootpick = pickweight(loot_table)
			CreateItem(lootpick)
	
	qdel(src)

/obj/abstract/loot_spawners/proc/CreateItem(new_item_type)
	var/obj/spawned = new new_item_type(loc)
	if(prob(chance_of_artifact))
		artifact_creation(spawned)

	if(item_position_jiggle)
		spawned.pixel_x = rand(-32,32)
		spawned.pixel_y = rand(-32,32)

/obj/abstract/loot_spawners/proc/artifact_creation(obj/our_object)
	var/effect_path = pick(item_artifact_effects)
	var/datum/item_artifact/E = new effect_path
	E.trigger = pick(item_artifact_triggers)
	E.item_init(our_object)
	if(prob(15))
		our_object.force += rand(5,20)
	E.desc += pick("It hums with internal energy",
					"It has a faint aura.",
					"It has an odd sigil on it.",
					"It has a small red stone pressed into it.",
					"It is covered in tiny cracks.",
					"It looks unsafe.")
