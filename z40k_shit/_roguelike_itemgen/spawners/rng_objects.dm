/obj/abstract/loot_spawners
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	alpha = 255
	invisibility = 101
	mouse_opacity = 0

	var/item_position_jiggle = TRUE //Basically moves its pixel x and pixel y for decorative purposes
	var/amount_to_pick = 0 //Amount of objects to pick from the table
	var/prob_of_skipped_items = 0 //Probability we skip a item
	
	var/chance_of_artifact = 0 //Probability we run a object through the special artifact spawner.

	var/list/loot_table = list() //Loot table

/obj/abstract/loot_spawners/New()
	..()
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
	var/obj/item/spawned = new new_item_type(loc)
	if(prob(chance_of_artifact))
		artifact_creation(spawned)
		spawned.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))

	if(item_position_jiggle)
		spawned.pixel_x = rand(-32,32)
		spawned.pixel_y = rand(-32,32)

/obj/abstract/loot_spawners/proc/artifact_creation(obj/item/our_object)
	if(prob(90))
		var/effect_path = pick(roguelike_item_effects)
		var/datum/roguelike_effects/RE = new effect_path
		var/picked_trigger = pick(roguelike_effects_triggers)
		RE.trigger_effects += picked_trigger
		RE.add_effect_to_object(our_object)
		if(prob(10))
			var/effect_path_passive = pick(roguelike_item_passives)
			var/datum/roguelike_effects/passives/PRE = new effect_path_passive
			PRE.add_effect_to_object(our_object)
	else
		for(var/i=0 to rand(2,3))
			var/effect_path = pick(roguelike_item_effects)
			var/datum/roguelike_effects/RE = new effect_path
			var/picked_trigger = pick(roguelike_effects_triggers)
			RE.trigger_effects += picked_trigger
			RE.add_effect_to_object(our_object)
		if(prob(10))
			var/effect_path_passive = pick(roguelike_item_passives)
			var/datum/roguelike_effects/passives/PRE = new effect_path_passive
			PRE.add_effect_to_object(our_object)

	if(prob(15))
		our_object.force += rand(5,20)
	our_object.desc += pick("It hums with internal energy",
					"It has a faint aura.",
					"It has an odd sigil on it.",
					"It has a small red stone pressed into it.",
					"It is covered in tiny cracks.",
					"It looks unsafe.")