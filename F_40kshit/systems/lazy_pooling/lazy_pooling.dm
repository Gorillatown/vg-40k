//So, i'm going to try a vis_contents pooling system right here.
//We will explore the different forms of it, and see how it goes.
var/datum/market_economy/market_economy
var/datum/flavortown/flavortown
var/datum/lazy_pooler/lazy_pooler
var/list/manufacturing_recipes = list()
var/list/interaction_actions = list()
/*
If things get laggy with all the effects, I'll append a pooling system for them.
*/
/datum/lazy_pooler
	//var/list/effex_list = list()

/datum/lazy_pooler/New()
	load_overlays()
	load_manufacturing_recipes()
	load_interaction_actions()
	load_single_datums()

/datum/lazy_pooler/proc/load_single_datums()
	market_economy = new /datum/market_economy
	flavortown = new /datum/flavortown

/datum/lazy_pooler/proc/load_overlays()
	viscon_overlays[1] = new /obj/effect/overlay/viscons/water_overlay
	
	barricadepool[1] = new /obj/effect/overlay/viscons/aegisline/north
	barricadepool[2] = new /obj/effect/overlay/viscons/aegisline/south
	barricadepool[3] = new /obj/effect/overlay/viscons/aegisline/east_one
	barricadepool[4] = new /obj/effect/overlay/viscons/aegisline/east_two
	barricadepool[5] = new /obj/effect/overlay/viscons/aegisline/west_one
	barricadepool[6] = new /obj/effect/overlay/viscons/aegisline/west_two

/datum/lazy_pooler/proc/load_manufacturing_recipes()
	for(var/recipes in typesof(/datum/manufacturing_recipe) - /datum/manufacturing_recipe)
		var/datum/manufacturing_recipe/the_recipe = new recipes
		manufacturing_recipes += the_recipe

/datum/lazy_pooler/proc/load_interaction_actions()
	var/id_counter = 1 //If this ever manages to be the same it will be a shitty bug
	for(var/interactions in subtypesof(/datum/interactive_actions) - /datum/interactive_actions)
		var/datum/interactive_actions/N = new interactions()
		N.unique_id = "[id_counter]"
		interaction_actions += N
		id_counter++

/*
	I don't feel like I need this one yet. Its about complete tho at a basis
/datum/lazy_pooler/proc/handle_pooled_effects(atom/target)
	var/found = FALSE
	for(var/obj/effect/pooled_effects in effex_list)
		if(pooled_effects.appended)
			continue
		else
			target.vis_contents += pooled_effects
			found = TRUE
			break
	
	if(!found)
		var/added = new /obj/effect/pooled_effects
		target.vis_contents += added
*/