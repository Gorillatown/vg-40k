/mob/living/simple_animal/hostile/retaliate/growing_wolf
	name = "Detroid Wolf"
	desc = "Some say this species was brought from somewhere from soneone into wolves, you are pretty sure you shouldn't thank them for that."
	icon_state = "wolf"
	icon_living = "wolf"
	icon_dead = "wolf_dead"
	speak_chance = 5
	emote_hear = list("growls", "howls")
	turns_per_move = 4
	response_help = "pets"
	response_disarm = "gently pushes aside"
	response_harm = "hits"
	harm_intent_damage = 8
	melee_damage_lower = 10
	melee_damage_upper = 20       //that bite will hurt you!
	attacktext = "bites"
	attack_sound = 'sound/weapons/bite.ogg'
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/box
	attacktext = "sinks its fangs into"
	health = 200
	maxHealth = 200
	speed = 0.9
	size = SIZE_SMALL
	min_oxy = 0
	max_oxy = 0
	min_n2 = 0
	max_n2 = 0
	treadmill_speed = 1.5
	speak_override = TRUE
	
	var/consumption_delay = FALSE
	var/current_nutrition = 0 //How much current growth we have undertaken
	var/next_nutrition_level = 16
	var/rolling_ticker = 1
	var/sprite_scales = 0

//Growth Mechanics
/mob/living/simple_animal/hostile/retaliate/growing_wolf/animal_food_act(var/obj/item/weapon/reagent_containers/food/food)
	if(!consumption_delay)
		var/nutrition = food.reagents.get_reagent_amount(NUTRIMENT)
		playsound(src,'sound/items/eatfood.ogg', rand(10,50), 1)
		src.visible_message("[src] shows it is as hungry as the wolf on [food].", "You eat [food].", "You hear crunching.")
		wolf_growth(nutrition)
		qdel(food)

/mob/living/simple_animal/hostile/retaliate/growing_wolf/New()
	..()
	appearance_flags |= PIXEL_SCALE

/mob/living/simple_animal/hostile/retaliate/growing_wolf/proc/wolf_growth(var/nutrition) //nutrition is a number
	current_nutrition += nutrition
	adjustBruteLoss(-10)
	consumption_delay = TRUE
	spawn(1 SECONDS)
		consumption_delay = FALSE

	if(current_nutrition >= next_nutrition_level)
		to_chat(src, "<span class='notice'>You grow a bit.</span>")
		health += 25
		maxHealth += 25
		rolling_ticker++
		current_nutrition = 0
		next_nutrition_level += round(next_nutrition_level/2) //raise the max for the next one

		if(rolling_ticker >= 3) //if the rolling ticker hits 3 or errors higher
			sprite_scales++ //Time for a sprite scale
			rolling_ticker = 0 //I could prob use a modulo but I'm tired
			melee_damage_lower += 5
			melee_damage_upper += 10
		
			if(sprite_scales <= 5)
				src.transform = src.transform.Scale(1.1)
				pixel_y += 1
				sprite_scales++

				switch(sprite_scales)
					if(3)
						size = SIZE_NORMAL
					if(4)
						size = SIZE_BIG
					if(5)
						environment_smash_flags |= SMASH_LIGHT_STRUCTURES | SMASH_CONTAINERS | SMASH_WALLS | SMASH_RWALLS | OPEN_DOOR_STRONG
						var/n_name = copytext(sanitize(input(src, "What would you like to name yourself?", "Renaming \the [src]", null) as text|null), 1, MAX_NAME_LEN)
						if(n_name)
							name = "[n_name]"

		var/datum/role/native_animal/NTV = mind.GetRole(NATIVEANIMAL)
		if(NTV)
			NTV.total_growth++

/mob/living/simple_animal/hostile/retaliate/growing_wolf/examine(mob/user)
	..()
	switch(sprite_scales)
		if(0 to 2)
			to_chat(user, "<span class='info'>It's a [name] baby.</span>")
		if(3)
			to_chat(user, "<span class='info'>It's a respectable size.</span>")
		if(4)
			to_chat(user, "<span class='info'>It's huge!</span>")
		if(5 to INFINITY)
			to_chat(user, "<span class='info'>It truly is a wolf of great character.</span>")

/mob/living/simple_animal/hostile/retaliate/growing_wolf/Life()
	..()
	if(health < maxHealth && stat != DEAD)
		health += 5

/mob/living/simple_animal/hostile/retaliate/growing_wolf/attackby(var/obj/item/O, var/mob/user)
	if(istype(O, /obj/item/weapon/reagent_containers/food)) //wolves like FOOD
		if(!user.drop_item(O))
			to_chat(user, "<span class='notice'>You can't let go of \the [O]!</span>")
			return
		user.visible_message("<span class='notice'>[user] feeds [O] to [name].</span>","<span class='notice'>You feed [O] to [name].</span>")
		var/nutrition = O.reagents.get_reagent_amount(NUTRIMENT)
		wolf_growth(nutrition)
		qdel(O)
	else
		..()