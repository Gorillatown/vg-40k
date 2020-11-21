
/mob/living/simple_animal/hostile/retaliate/growing_pig
	name = "Detroid Hog"
	desc = "A distant descendent of the common domesticated Earth pig, corrupted by generations of splicing and genetic decay, along with evolution from countless battles. It has withstood the test of time."
	icon = 'z40k_shit/icons/mob/animals.dmi'
	icon_state = "pig_RANDY"
	icon_living = "pig_RANDY"
	icon_dead = "pig_RANDY_dead"
	speak = list("SQUEEEEE!","Oink...","Oink, oink", "Oink, oink, oink", "Oink!", "Oiiink.")
	emote_hear = list("squeals hauntingly")
	emote_see = list("roots about","squeals hauntingly")
	emote_sound = list("sound/voice/pigsnort.ogg","sound/voice/pigsqueal.ogg")
	speak_chance = 1
	turns_per_move = 1
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/box
	response_help  = "pets"
	response_disarm = "gently pushes aside"
	response_harm   = "kicks"
	attacktext = "kicks"
	health = 200
	speed = 1
	melee_damage_lower = 5
	melee_damage_upper = 10 //Those tusk will maul you!
	size = SIZE_SMALL
	min_oxy = 0
	max_oxy = 0
	min_n2 = 0
	max_n2 = 0
	treadmill_speed = 1.5
	speak_override = TRUE
	
	var/total_nutrition = 0 //Total nutrition
	var/series_of_fifteens = 0 //Series of 15s
	var/sprite_scales = 0
	var/total_completion = FALSE //Are we a completely big pig? If so all the flags get turned on once

//Growth Mechanics
/mob/living/simple_animal/hostile/retaliate/growing_pig/animal_food_act(var/obj/item/weapon/reagent_containers/food/food)
	var/nutrition = food.reagents.get_reagent_amount(NUTRIMENT)
	playsound(src,'sound/items/eatfood.ogg', rand(10,50), 1)
	src.visible_message("[src] pigs out on [food].", "You eat [food].", "You hear crunching.")
	pig_growth(nutrition)
	qdel(food)

/mob/living/simple_animal/hostile/retaliate/growing_pig/New()
	..()
	appearance_flags |= PIXEL_SCALE

/mob/living/simple_animal/hostile/retaliate/growing_pig/proc/pig_growth(var/nutrition) //nutrition is a number
	total_nutrition += nutrition
	series_of_fifteens += nutrition
	
	adjustBruteLoss(-20)
	
	if(series_of_fifteens >= 15)
		health += 25
		maxHealth += 25
//		melee_damage_lower += 5
		melee_damage_upper += 1
		series_of_fifteens = 0
		to_chat(src, "<span class='notice'>You grow a bit.</span>")
		var/datum/role/native_animal/NTV = mind.GetRole(NATIVEANIMAL)
		if(NTV)
			NTV.total_growth++

		if(sprite_scales <= 5)
			src.transform = src.transform.Scale(1.1)
			pixel_y += 1
			sprite_scales++

	if((total_nutrition >= 200) && (!total_completion))
		environment_smash_flags |= SMASH_LIGHT_STRUCTURES | SMASH_CONTAINERS | SMASH_WALLS | SMASH_RWALLS | OPEN_DOOR_STRONG
		total_completion = TRUE
		var/n_name = copytext(sanitize(input(src, "What would you like to name yourself?", "Renaming \the [src]", null) as text|null), 1, MAX_NAME_LEN)
		if(n_name)
			name = "[n_name]"

/mob/living/simple_animal/hostile/retaliate/growing_pig/examine(mob/user)
	..()
	switch(total_nutrition)
		if(0 to 10)
			to_chat(user, "<span class='info'>It's a [name] baby.</span>")
		if(11 to 40)
			to_chat(user, "<span class='info'>It's a respectable size.</span>")
		if(41 to 100)
			to_chat(user, "<span class='info'>It's huge - a prize winning porker!</span>")
		if(200 to INFINITY)
			to_chat(user, "<span class='info'>HOLY SHIT, ITS A MONSTER</span>")

/mob/living/simple_animal/hostile/retaliate/growing_pig/Life()
	..()

/mob/living/simple_animal/hostile/retaliate/growing_pig/death(var/gibbed = FALSE)
	..(gibbed)
	playsound(src, 'sound/effects/box_scream.ogg', 100, 1)

/mob/living/simple_animal/hostile/retaliate/growing_pig/attackby(var/obj/item/O, var/mob/user)
	if(istype(O, /obj/item/weapon/reagent_containers/food)) //Pigs like FOOD
		if(!user.drop_item(O))
			to_chat(user, "<span class='notice'>You can't let go of \the [O]!</span>")
			return
		user.visible_message("<span class='notice'>[user] feeds [O] to [name].</span>","<span class='notice'>You feed [O] to [name].</span>")
		var/nutrition = O.reagents.get_reagent_amount(NUTRIMENT)
		pig_growth(nutrition)
		qdel(O)
	else
		..()


