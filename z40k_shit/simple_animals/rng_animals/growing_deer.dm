/mob/living/simple_animal/hostile/growing_deer
	name = "deer"
	desc = "A large herbivore, sporting antlers on their head. Quick to spook."
	icon_state = "deer"
	icon_living = "deer"
	icon_dead = "deer_dead"
	faction = "deer"
	health = 50
	maxHealth = 50
	size = SIZE_NORMAL
	response_help  = "pets"

	attacktext = "kicks"
	melee_damage_lower = 5
	melee_damage_upper = 10

	minbodytemp = 200

	var/consumption_delay = 4 //Ticks down in life
	var/total_nutrition = 0 //Total nutrition
	var/sprite_scales = 0
	var/series_of_fifteens = 0 //Series of 15s
	var/total_completion = FALSE //Are we a completely big pig? If so all the flags get turned on once

	var/list/edibles = list(/obj/structure/flora/grass,
	/obj/structure/flora/ausbushes,
	/obj/structure/flora/swampbusha,
	/obj/structure/flora/swampbushb,
	/obj/structure/flora/swampbushc,
	/obj/structure/flora/swampbushlarge)

/mob/living/simple_animal/hostile/growing_deer/Life()
	..()
	if(isDead())
		return
	if(consumption_delay)
		consumption_delay--

/mob/living/simple_animal/hostile/growing_deer/proc/deer_growth(var/nutrition) //nutrition is a number
	total_nutrition += nutrition
	series_of_fifteens += nutrition

	adjustBruteLoss(-20)

	if(series_of_fifteens >= 15)
		src.transform = src.transform.Scale(1.1)
		health += 25
		maxHealth += 25
	//	melee_damage_lower += 1
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

/mob/living/simple_animal/hostile/growing_deer/UnarmedAttack(var/atom/A)
	if(is_type_in_list(A, edibles))
		if(!consumption_delay)
			delayNextAttack(10)
			deer_growth(8)
			gulp(A)
			consumption_delay = 4
	else return ..()

/mob/living/simple_animal/hostile/growing_deer/proc/gulp(var/atom/eat_this)
	visible_message("\The [name] chews on [eat_this].", "<span class='notice'>You consume [eat_this].</span>")
	qdel(eat_this)
	playsound(get_turf(src),'sound/items/eatfood.ogg', rand(10,50), 1)
	adjustBruteLoss(-30)

/mob/living/simple_animal/hostile/growing_deer/attackby(obj/W, mob/user)
	if(!isDead() && (istype(W, /obj/item/weapon/reagent_containers/food/snacks/grown/apple) || (istype (W, /obj/item/weapon/reagent_containers/food/snacks/grown/goldapple))))
		var/obj/item/weapon/reagent_containers/food/snacks/grown/apple/A = W

		playsound(get_turf(src),'sound/items/eatfood.ogg', rand(10,50), 1)
		visible_message("<span class='info'>\The [src] gobbles up \the [W]!")
		//user.drop_item(A, force_drop = 1)

		if(istype (W, /obj/item/weapon/reagent_containers/food/snacks/grown/goldapple))
			icon_living = "deer_flower"
			icon_dead = "deer_dead"
			icon_state = "deer_flower"

		if(prob(25))
			if(!friends.Find(user))
				friends.Add(user)
				to_chat(user, "<span class='info'>You have gained \the [src]'s trust.</span>")
			name_mob(user)
		qdel(A)

		if(istype (W, /obj/item/weapon/reagent_containers/food/snacks/grown/apple/poisoned))
			spawn(rand(50,150))
				death() //You dick
		return
	..()

/mob/living/simple_animal/hostile/growing_deer/update_icons()
	.=..()

	if(stat == DEAD && butchering_drops)
		var/datum/butchering_product/deer_head/our_head = locate(/datum/butchering_product/deer_head) in butchering_drops
		if(istype(our_head))
			icon_state = "[icon_dead][(our_head.amount) ? "" : "_headless"]"
