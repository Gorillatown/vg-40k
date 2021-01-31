/mob/living/simple_animal/hostile/growing_deer
	name = "deer"
	desc = "A large herbivore, sporting antlers on their head. Quick to spook."
	icon_state = "deer"
	icon_living = "deer"
	icon_dead = "deer_dead"
	faction = "deer"
	health = 150
	maxHealth = 150
	size = SIZE_NORMAL
	response_help  = "pets"

	attacktext = "gores"
	melee_damage_lower = 5
	melee_damage_upper = 15

	minbodytemp = 200

	var/consumption_delay = FALSE

	var/current_nutrition = 0 //How much current growth we have undertaken
	var/next_nutrition_level = 16
	var/rolling_ticker = 1

	var/sprite_scales = 0

	var/list/edibles = list(/obj/structure/flora/grass,
	/obj/structure/flora/ausbushes,
	/obj/structure/flora/swampbusha,
	/obj/structure/flora/swampbushb,
	/obj/structure/flora/swampbushc,
	/obj/structure/flora/swampbushlarge)

/mob/living/simple_animal/hostile/growing_deer/Life()
	..()
	if(health < maxHealth && stat != DEAD)
		health += 2

/mob/living/simple_animal/hostile/growing_deer/proc/deer_growth(var/nutrition) //nutrition is a number
	current_nutrition += nutrition
	consumption_delay = TRUE
	spawn(3 SECONDS)
		consumption_delay = FALSE

	adjustBruteLoss(-5)

	if(current_nutrition >= next_nutrition_level)
		to_chat(src, "<span class='notice'>You grow a bit.</span>")
		health += 15
		maxHealth += 15
		rolling_ticker++
		current_nutrition = 0
		next_nutrition_level += round(next_nutrition_level/2) //raise the max for the next one

		if(rolling_ticker >= 3) //if the rolling ticker hits 3 or errors higher
			sprite_scales++ //Time for a sprite scale
			rolling_ticker = 0 //I could prob use a modulo but I'm tired
			melee_damage_upper += 1
		
			if(sprite_scales <= 5)
				src.transform = src.transform.Scale(1.1)
				pixel_y += 1
				sprite_scales++

				switch(sprite_scales)
					if(3)
						density = TRUE
						pass_flags = 0
						size = SIZE_BIG
						speed = 1
					if(5)
						environment_smash_flags |= SMASH_LIGHT_STRUCTURES | SMASH_CONTAINERS | SMASH_WALLS | SMASH_RWALLS | OPEN_DOOR_STRONG
						var/n_name = copytext(sanitize(input(src, "What would you like to name yourself?", "Renaming \the [src]", null) as text|null), 1, MAX_NAME_LEN)
						if(n_name)
							name = "[n_name]"

		var/datum/role/native_animal/NTV = mind.GetRole(NATIVEANIMAL)
		if(NTV)
			NTV.total_growth++

/mob/living/simple_animal/hostile/growing_deer/UnarmedAttack(var/atom/A)
	if(is_type_in_list(A, edibles))
		if(!consumption_delay)
			delayNextAttack(10)
			deer_growth(8)
			gulp(A)
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
