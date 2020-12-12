/mob/living/simple_animal/hostile/growing_lizard
	name = "Detroid Lizard"
	desc = "A lizard once again named after the system it is from, it is effectively unable to die from old age, and grows for the entire duration of its life."
	icon_state = "lizard"
	icon_living = "lizard"
	icon_dead = "lizard_dead"
	speak_emote = list("hisses")
	health = 50
	maxHealth = 50
	speed = 0.9
	attacktext = "bites"
	melee_damage_lower = 2
	melee_damage_upper = 4
	response_help  	= "pets"
	response_disarm = "shoos"
	response_harm 	= "stomps on"

	size = SIZE_TINY
	mob_property_flags = MOB_NO_PETRIFY //Can't get petrified (nethack references)
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/animal/lizard
	held_items = list()

	stop_automated_movement_when_pulled = TRUE
	environment_smash_flags = 0
	density = FALSE
	pass_flags = PASSTABLE | PASSMOB
	vision_range = 6
	aggro_vision_range = 6
	idle_vision_range = 6
	search_objects = 1

	var/consumption_delay = 10 //Ticks down in life
	var/current_nutrition = 0 //How much current growth we have undertaken
	var/next_nutrition_level = 16
	var/rolling_ticker = 1
	var/sprite_scales = 0

	var/static/list/edibles = list(/mob/living/simple_animal/cockroach, 
	/obj/item/weapon/reagent_containers/food/snacks/roach_eggs, 
	/mob/living/simple_animal/bee, 
	/mob/living/simple_animal/snail,
	/mob/living/simple_animal/hostile/giant_spider/spiderling) //Add bugs to this as they get added in

//Growth Mechanics
/mob/living/simple_animal/hostile/growing_lizard/animal_food_act(var/obj/item/weapon/reagent_containers/food/food)
	var/nutrition = food.reagents.get_reagent_amount(NUTRIMENT)
	playsound(src,'sound/items/eatfood.ogg', rand(10,50), 1)
	src.visible_message("[src] consumes [food].", "You eat [food].", "You hear crunching.")
	lizard_growth(nutrition)
	qdel(food)

/mob/living/simple_animal/hostile/growing_lizard/New()
	..()
	appearance_flags |= PIXEL_SCALE

/mob/living/simple_animal/hostile/growing_lizard/proc/lizard_growth(var/nutrition) //nutrition is a number
	current_nutrition += nutrition
	adjustBruteLoss(-20)
	consumption_delay = 10

	if(current_nutrition >= next_nutrition_level)
		to_chat(src, "<span class='notice'>You grow a bit.</span>")
		health += 10
		maxHealth += 10
		rolling_ticker++
		current_nutrition = 0
		next_nutrition_level += round(next_nutrition_level/2) //raise the max for the next one

		if(rolling_ticker >= 3) //if the rolling ticker hits 3 or errors higher
			sprite_scales++ //Time for a sprite scale
			rolling_ticker = 0 //I could prob use a modulo but I'm tired
			melee_damage_upper += 2
		
			if(sprite_scales <= 5)
				src.transform = src.transform.Scale(1.1)
				pixel_y += 1
				sprite_scales++

				switch(sprite_scales)
					if(2)
						size = SIZE_SMALL
					if(3)
						density = TRUE
						pass_flags = 0
						size = SIZE_NORMAL
						speed = 1
					if(4)
						size = SIZE_BIG
						health += 50
						maxHealth += 50
					if(5)
						environment_smash_flags |= SMASH_LIGHT_STRUCTURES | SMASH_CONTAINERS | SMASH_WALLS | SMASH_RWALLS | OPEN_DOOR_STRONG
						var/n_name = copytext(sanitize(input(src, "What would you like to name yourself?", "Renaming \the [src]", null) as text|null), 1, MAX_NAME_LEN)
						if(n_name)
							name = "[n_name]"

		var/datum/role/native_animal/NTV = mind.GetRole(NATIVEANIMAL)
		if(NTV)
			NTV.total_growth++

/mob/living/simple_animal/hostile/growing_lizard/UnarmedAttack(var/atom/A)
	if(is_type_in_list(A, edibles))
		if(!consumption_delay)
			delayNextAttack(10)
			lizard_growth(15)
			gulp(A)
	else return ..()

/mob/living/simple_animal/hostile/growing_lizard/proc/gulp(var/atom/eat_this)
	if(istype(eat_this,/mob/living/simple_animal/bee)) //Bees are complicated. They don't work like normal mobs.
		var/mob/living/simple_animal/bee/B = eat_this
		visible_message("\The [name] lashes \the [B] with its sticky tongue.", "<span class='notice'>You eat a [B.bee_species].</span>")
		var/datum/bee/victim = pick_n_take(B.bees)
		qdel(victim)
		B.update_icon()
		//The reason we're doing it this way instead of just AdjustBruteLoss is because it doesn't make sense to leave corpses.
	else
		visible_message("\The [name] consumes [eat_this] in a single gulp.", "<span class='notice'>You consume [eat_this] in a single gulp.</span>")
		qdel(eat_this)
	playsound(src,'sound/items/egg_squash.ogg', rand(30,70), 1)
	adjustBruteLoss(-2)

/mob/living/simple_animal/hostile/growing_lizard/Life()
	..()
	if(consumption_delay)
		consumption_delay--

/mob/living/simple_animal/hostile/growing_lizard/CanAttack(var/atom/the_target)//Can we actually attack a possible target?
	if(see_invisible < the_target.invisibility)//Target's invisible to us, forget it
		return FALSE
	if(is_type_in_list(the_target, edibles))
		return TRUE
	return FALSE

/mob/living/simple_animal/hostile/growing_lizard/attackby(var/obj/item/O, var/mob/user)
	if(istype(O, /obj/item/weapon/reagent_containers/food)) //Lizards like FOOD
		if(!user.drop_item(O))
			to_chat(user, "<span class='notice'>You can't let go of \the [O]!</span>")
			return
		user.visible_message("<span class='notice'>[user] feeds [O] to [name].</span>","<span class='notice'>You feed [O] to [name].</span>")
		var/nutrition = O.reagents.get_reagent_amount(NUTRIMENT)
		lizard_growth(nutrition)
		qdel(O)
	else
		..()