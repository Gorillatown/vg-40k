/mob/living/simple_animal/hostile/retaliate/growing_wolf
	name = "Detroid Wolf"
	desc = "Some say this species was brought from somewhere by a ancestor of the Mannheim lineage, you are pretty sure you shouldn't thank them for that."
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
	melee_damage_lower = 15
	melee_damage_upper = 20
	attacktext = "bites"
	attack_sound = 'sound/weapons/bite.ogg'
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/box
	attacktext = "kicks"
	health = 200
	speed = 0.9
	size = SIZE_SMALL
	min_oxy = 0
	max_oxy = 0
	min_n2 = 0
	max_n2 = 0
	treadmill_speed = 1.5
	speak_override = TRUE
	
	var/total_nutrition = 0 //Total nutrition
	var/series_of_fifteens = 0 //Series of 15s
	var/total_completion = FALSE //Are we a completely big pig? If so all the flags get turned on once

//Growth Mechanics
/mob/living/simple_animal/hostile/retaliate/growing_wolf/animal_food_act(var/obj/item/weapon/reagent_containers/food/food)
	var/nutrition = food.reagents.get_reagent_amount(NUTRIMENT)
	playsound(src,'sound/items/eatfood.ogg', rand(10,50), 1)
	src.visible_message("[src] shows it is as hungry as the wolf on [food].", "You eat [food].", "You hear crunching.")
	wolf_growth(nutrition)
	qdel(food)

/mob/living/simple_animal/hostile/retaliate/growing_wolf/New()
	..()
	appearance_flags |= PIXEL_SCALE

/mob/living/simple_animal/hostile/retaliate/growing_wolf/proc/wolf_growth(var/nutrition) //nutrition is a number
	total_nutrition += nutrition
	series_of_fifteens += nutrition
	if(series_of_fifteens >= 8)
		src.transform = src.transform.Scale(1.1)
		health += 25
		maxHealth += 25
		melee_damage_lower += 5
		melee_damage_upper += 5
		series_of_fifteens = 0
		to_chat(src, "<span class='notice'>You grow a bit.</span>")
		var/datum/role/native_animal/NTV = mind.GetRole(NATIVEANIMAL)
		if(NTV)
			NTV.total_growth++
	if((total_nutrition >= 200) && (!total_completion))
		environment_smash_flags |= SMASH_LIGHT_STRUCTURES | SMASH_CONTAINERS | SMASH_WALLS | SMASH_RWALLS | OPEN_DOOR_STRONG
		total_completion = TRUE
		var/n_name = copytext(sanitize(input(src, "What would you like to name yourself?", "Renaming \the [src]", null) as text|null), 1, MAX_NAME_LEN)
		if(n_name)
			name = "[n_name]"

/mob/living/simple_animal/hostile/retaliate/growing_wolf/examine(mob/user)
	..()
	switch(total_nutrition)
		if(0 to 10)
			to_chat(user, "<span class='info'>It's a [name] baby.</span>")
		if(11 to 40)
			to_chat(user, "<span class='info'>It's a respectable size.</span>")
		if(41 to 100)
			to_chat(user, "<span class='info'>It's huge!</span>")
		if(200 to INFINITY)
			to_chat(user, "<span class='info'>HOLY SHIT, ITS A MONSTER</span>")

/mob/living/simple_animal/hostile/retaliate/growing_wolf/Life()
	..()
	if((health < maxHealth) && (stat != DEAD))
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