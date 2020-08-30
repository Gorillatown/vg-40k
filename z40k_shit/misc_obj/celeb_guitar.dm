/*
Guitar fun
*/
//See: Instruments.dm for the first guitar
/obj/item/weapon/propguitar	//basic guitar, playes sound.
	name = "A Guitar"
	desc = "An extremely expensive instrument. Probably worth more than this entire planet."
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/celebguitar_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/celebguitar_right.dmi')
	icon = 'z40k_shit/icons/obj/objects.dmi'
	icon_state = "guitar1"
	item_state = "guitar1"
	force = 9
	var/playing = 0

/obj/item/weapon/propguitar/attack_self(mob/user)
	interact(user)

/obj/item/weapon/propguitar/interact(mob/user)
	if(!isliving(user) || user.stat || user.restrained() || user.lying)
		to_chat(user, "You can not do that while restrained.")
		return
	if(playing)
		return
	else
		playing = 1
		var/guitarsound = pick('z40k_shit/sounds/guitar1.ogg','z40k_shit/sounds/guitar2.ogg')
		playsound(loc, guitarsound, 100, 0)
		to_chat(user, "Hmm... maybe you need some practice.")
		spawn(90)
			playing = 0

/*
Stage 1
*/

/obj/item/weapon/propguitar/one

/obj/item/weapon/propguitar/one/attackby(obj/item/weapon/W, mob/user)//stub for upgrades
	..()
	if(istype(W, /obj/item/weapon/screwdriver))
		playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
		to_chat(user, "The panel slides open.")
		new /obj/item/weapon/propguitar/two(user.loc)
		qdel(src)

/*
Stage 2
*/

/obj/item/weapon/propguitar/two
	desc = "A very expensive instrument. The rear cover has been opened and there appears to be enough space in here to fit a second powercell."

/obj/item/weapon/propguitar/two/attackby(obj/item/weapon/W, mob/user)//after screwdriver comes powercell
	..()
	if(istype(W, /obj/item/weapon/cell))
		playsound(src.loc, 'z40k_shit/sounds/misc_effects/bin_open.ogg', 50, 1)
		to_chat(user, "Must... have... more.... power....")
		new /obj/item/weapon/propguitar/three(user.loc)
		user.drop_item(W)
		qdel(W)
		qdel(src)
	else
		to_chat(user, "Stop that! You need a power cell!")
/*
Stage 3
*/

/obj/item/weapon/propguitar/three
	desc = "A heavily modified Guitar. This one appears to be in need of a little bit of wire in order to optimize it's power consumption."

/obj/item/weapon/propguitar/three/attackby(obj/item/weapon/W, mob/user)
	..()
	if(istype(W, /obj/item/stack/cable_coil))														//then some wire
		playsound(src.loc, 'sound/effects/zzzt.ogg', 50, 1)
		to_chat(user,"This is nice. Not that we are electricians or anything but this just seems natural some how. Now get out that screwdriver and lets close the cover.")
		new /obj/item/weapon/propguitar/four(user.loc)
		user.drop_item(W)
		qdel(W)
		qdel(src)
	else
		to_chat(user, "No... you need some wire for this.")

/*
Stage 4
*/

/obj/item/weapon/propguitar/four
	desc = "A very expensive instrument. The rear cover remains open."

/obj/item/weapon/propguitar/four/attackby(obj/item/weapon/W, mob/user)//then a screwdriver again
	..()
	if(istype(W, /obj/item/weapon/screwdriver))
		playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
		to_chat(user, "The panel closes.")
		new /obj/item/weapon/propguitar/five(user.loc)
		qdel(src)
	else
		to_chat(user, "Just use a screwdriver would ya?")

/*
Stage 5
*/

/obj/item/weapon/propguitar/five																		//start of the slaaneshi upgraded instrument
	name = "A Guitar"
	desc = "An extremely expensive instrument. It seems to draw you in as you look at it."
	icon = 'z40k_shit/icons/obj/objects.dmi'
	icon_state = "guitar2"
	item_state = "guitar2"
	force = 12

/obj/item/weapon/propguitar/five/attack_self(mob/user)
	interact(user)

/obj/item/weapon/propguitar/five/interact(mob/user)
	if(!isliving(user) || user.stat || user.restrained() || user.lying)
		to_chat(user, "Just.... can't.... reach....")
		return
	if(playing)
		return
	else
		playing = 1
		var/guitarsound = pick('z40k_shit/sounds/guitar3.ogg','z40k_shit/sounds/guitar4.ogg') //'z40k_shit/sounds/guitar5.ogg' this ones raining blood//new sounds
		flick("guitar2_on",src)
		playsound(loc, guitarsound, 100, 0)
		for(var/mob/living/M in hearers(4, user))//AOE stun
			if(M.faction == "Slaanesh")
				continue
			if(prob(15))
				user.say("THINGS WILL GET LOUD NOW!!!")
			if(iscarbon(M))
				M.dizziness += 100
				M.jitteriness += 20
				M.confused += 20
				to_chat(M, "Man that guy can ROCK!")
				M.audible_scream()
				M.Knockdown(3)
				M.Stun(3)

		spawn(90)
			playing = 0