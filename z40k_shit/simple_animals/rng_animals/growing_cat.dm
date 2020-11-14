//Cat
/mob/living/simple_animal/hostile/growing_cat
	name = "Detroid Cat"
	desc = "At some point in a distant era, you can imagine these used to be house cats."

	icon_state = "cat2"
	icon_living = "cat2"
	icon_dead = "cat2_dead"
	gender = MALE
	size = SIZE_SMALL
	speak = list("Meow!", "Esp!", "Purr!", "HSSSSS")
	speak_emote = list("purrs", "meows")
	emote_hear = list("meows", "mews")
	emote_see = list("shakes its head", "shivers")
	emote_sound = list("sound/voice/catmeow.ogg")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6

	health = 100
	speed = 1
	melee_damage_lower = 5
	melee_damage_upper = 10 //Those tusk will maul you!

	speak_override = TRUE
	response_help  = "pets"
	response_disarm = "gently pushes aside"
	response_harm   = "kicks"
	min_oxy = 0
	max_oxy = 0
	min_n2 = 0
	max_n2 = 0

	var/total_nutrition = 0 //Total nutrition
	var/series_of_fifteens = 0 //Series of 15s
	var/total_completion = FALSE //Are we a completely big pig? If so all the flags get turned on once

//Growth Mechanics
/mob/living/simple_animal/hostile/growing_cat/animal_food_act(var/obj/item/weapon/reagent_containers/food/food)
	var/nutrition = food.reagents.get_reagent_amount(NUTRIMENT)
	playsound(src,'sound/items/eatfood.ogg', rand(10,50), 1)
	src.visible_message("[src] eats [food].", "You eat [food].", "You hear crunching.")
	cat_growth(nutrition)
	qdel(food)

/mob/living/simple_animal/hostile/growing_cat/New()
	..()
	appearance_flags |= PIXEL_SCALE
 
/mob/living/simple_animal/hostile/growing_cat/proc/cat_growth(var/nutrition) //nutrition is a number
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

/mob/living/simple_animal/hostile/growing_cat/examine(mob/user)
	..()
	switch(total_nutrition)
		if(0 to 10)
			to_chat(user, "<span class='info'>It's a [name] baby.</span>")
		if(11 to 40)
			to_chat(user, "<span class='info'>It's a respectable size.</span>")
		if(41 to 100)
			to_chat(user, "<span class='info'>Its a very large cat!</span>")
		if(200 to INFINITY)
			to_chat(user, "<span class='info'>HOLY SHIT, ITS A MONSTER</span>")

/mob/living/simple_animal/hostile/growing_cat/Life()
	..()
	if((health < maxHealth) && (stat != DEAD))
		health += 5

/mob/living/simple_animal/hostile/growing_cat/attackby(var/obj/item/O, var/mob/user)
	if(istype(O, /obj/item/weapon/reagent_containers/food)) //Cats like FOOD
		if(!user.drop_item(O))
			to_chat(user, "<span class='notice'>You can't let go of \the [O]!</span>")
			return
		user.visible_message("<span class='notice'>[user] feeds [O] to [name].</span>","<span class='notice'>You feed [O] to [name].</span>")
		var/nutrition = O.reagents.get_reagent_amount(NUTRIMENT)
		cat_growth(nutrition)
		qdel(O)
	else
		..()

/mob/living/simple_animal/hostile/growing_cat/attack_hand(mob/living/carbon/human/M)
	. = ..()
	react_to_touch(M)
	M.delayNextAttack(2 SECONDS)

/mob/living/simple_animal/hostile/growing_cat/proc/react_to_touch(mob/M)
	if(M && !isUnconscious())
		switch(M.a_intent)
			if(I_HELP)
				var/image/heart = image('icons/mob/animal.dmi',src,"heart-ani2")
				heart.plane = ABOVE_HUMAN_PLANE
				flick_overlay(heart, list(M.client), 20)
				emote("me", EMOTE_AUDIBLE, "purrs.")
				playsound(loc, 'sound/voice/catpurr.ogg', 50, 1)
			if(I_HURT)
				playsound(loc, 'sound/voice/cathiss.ogg', 50, 1)
				emote("me", EMOTE_AUDIBLE, "hisses.")