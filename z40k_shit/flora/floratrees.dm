/obj/structure/flora/tree
	name = "tree"
	anchored = 1
	density = 1

	layer = FLY_LAYER
	plane = ABOVE_HUMAN_PLANE
	icon = 'icons/obj/flora/deadtrees.dmi'
	icon_state = "tree_1"

	pixel_x = -WORLD_ICON_SIZE/2

	var/health = 100
	var/maxHealth = 100

	var/height = 6 //How many logs are spawned


	var/falling_dir = 0 //Direction in which spawned logs are thrown.

	var/const/randomize_on_creation = 1
	var/const/log_type = /obj/item/weapon/grown/log/tree
	var/holo = FALSE

/obj/structure/flora/tree/New()
	..()

	for(var/atom/A in loc)
		if(istype(A,/obj/effect/decal/ruinshit/rubble/rubblefull))
			qdel(src)
			return

	if(randomize_on_creation)
		health = rand(60, 200)
		maxHealth = health

		height = rand(3, 8)

		icon_state = pick(
		"tree_1",
		"tree_2",
		"tree_3",
		"tree_4",
		"tree_5",
		"tree_6",
		)


	//Trees Z-fight due to being bigger than one tile, so we need to perform serious layer fuckery to hide this obvious defect)

	var/rangevalue = 0.1 //Range over which the values spread. We don't want it to collide with "true" layer differences

	layer += rangevalue * (1 - (y + 0.5 * (x & 1)) / world.maxy)

/obj/structure/flora/tree/examine(mob/user)
	.=..()

	//Tell user about the height. Note that normally height ranges from 3 to 8 (with a 5% chance of having 6 to 15 instead)
	to_chat(user, "<span class='info'>It appears to be about [height*3] feet tall.</span>")
	switch(health / maxHealth)
		if(0.6 to 0.9)
			to_chat(user, "<span class='info'>It's been partially cut down.</span>")
		if(0.2 to 0.6)
			to_chat(user, "<span class='notice'>It's almost cut down, [falling_dir ? "and it's leaning towards the [dir2text(falling_dir)]." : "but it still stands upright."]</span>")
		if(0 to 0.2)
			to_chat(user, "<span class='danger'>It's going to fall down any minute now!</span>")

/obj/structure/flora/tree/attackby(obj/item/W, mob/living/user)
	..()

	if(istype(W, /obj/item/weapon))
		if(W.sharpness_flags & (CHOPWOOD|SERRATED_BLADE))
			health -= ((user.attribute_strength/2) * (W.force))
			user.stat_increase(ATTR_STRENGTH,75)
			playsound(loc, 'sound/effects/woodcuttingshort.ogg', 50, 1)
		else
			to_chat(user, "<span class='info'>\The [W] doesn't appear to be suitable to cut into \the [src]. Try something sturdier.</span>")

	update_health()

	return 1

/obj/structure/flora/tree/proc/fall_down()
	if(!falling_dir)
		falling_dir = pick(cardinal)

	var/turf/our_turf = get_turf(src) //Turf at which this tree is located
	var/turf/current_turf = get_turf(src) //Turf in which to spawn a log. Updated in the loop

	playsound(loc, 'sound/effects/woodcutting.ogg', 50, 1)

	qdel(src)

	if(!holo)
		spawn()
			while(height > 0)
				if(!current_turf)
					break //If the turf in which to spawn a log doesn't exist, stop the thing

				var/obj/item/I = new log_type(our_turf) //Spawn a log and throw it at the "current_turf"
				I.throw_at(current_turf, 10, 10)

				current_turf = get_step(current_turf, falling_dir)

				height--

				sleep(1)

/obj/structure/flora/tree/proc/update_health()
	if(health < 40 && !falling_dir)
		falling_dir = pick(cardinal)
		visible_message("<span class='danger'>\The [src] starts leaning to the [dir2text(falling_dir)]!</span>",
			drugged_message = "<span class='sinister'>\The [src] is coming to life, man.</span>")

	if(health <= 0)
		fall_down()

/obj/structure/flora/tree/ex_act(severity)
	switch(severity)
		if(1) //Epicentre
			return qdel(src)
		if(2) //Major devastation
			height -= rand(1,4) //Some logs are lost
			fall_down()
		if(3) //Minor devastation (IED)
			health -= rand(10,30)
			update_health()

//---------Snow Trees---------------
/obj/structure/flora/tree/pine
	name = "pine tree"
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_state = "pine_1"

/obj/structure/flora/tree/pine/New()
	..()
	icon_state = "pine_[rand(1, 3)]"

/obj/structure/flora/tree/pine/xmas
	name = "xmas tree"
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_state = "pine_c"

/obj/structure/flora/tree/pine/xmas/holo
	holo = TRUE

/obj/structure/flora/tree/pine/xmas/New()
	..()
	icon_state = "pine_c"

/obj/structure/flora/tree/dead
	name = "dead tree"
	icon = 'icons/obj/flora/deadtrees.dmi'
	icon_state = "tree_1"

/obj/structure/flora/tree/dead/holo
	holo = TRUE

/obj/structure/flora/tree/dead/New()
	..()
	icon_state = "tree_[rand(1, 6)]"

/obj/structure/flora/tree_stump
	name = "tree stump"
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_state = "pine_stump"
	shovelaway = TRUE

//--------------Dead desert Trees-----------//

/obj/structure/flora/tree/dead/desert
	name = "dead tree"
	icon = 'z40k_shit/icons/doodads/flora64x64.dmi'

/obj/structure/flora/tree/dead/desert/New()
	..()
	icon_state = "deadtree_[rand(1, 6)]"
			
			
/obj/structure/flora/tree/dead/desert/tall
	name = "tall dead tree"
	icon = 'z40k_shit/icons/doodads/flora64x128.dmi'

/obj/structure/flora/tree/dead/desert/tall/New()
	..()
	icon_state = "tree_[rand(1, 3)]"