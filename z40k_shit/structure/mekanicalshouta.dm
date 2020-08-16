//Basically a very forward comms device.

/obj/structure/mekanical_shouta
	name = "Mekanical Shouta"
	desc = "A very poor replacement for a actual shouta built by a mek."
	icon = 'z40k_shit/icons/obj/structures.dmi' //nmevermind lol
	icon_state = "mek_megaphone"
	density = 1
	opacity = 0
	anchored = 0
	var/busy = FALSE //Handles disassembly
	var/health = 200
	var/cooldown = 0

/obj/structure/mekanical_shouta/New()
	..()

/obj/structure/mekanical_shouta/Destroy()
	..()

/obj/structure/mekanical_shouta/proc/healthcheck(var/mob/M, var/sound = 1)
	if(health <= 0)
		visible_message("<span class='warning'>[src] comes apart!</span>")
		new /obj/item/stack/sheet/metal(loc, rand(5,20))
		setDensity(FALSE)
		qdel(src)

/obj/structure/mekanical_shouta/attack_hand(mob/user)
	//Bang bang bang bang
	if(usr.a_intent == I_HURT)
		user.delayNextAttack(10)
		health -= 2
		healthcheck()
		user.visible_message("<span class='warning'>[user] beats \the [src]!</span>", \
		"<span class='warning'>You beat \the [src]!</span>", \
		"You hear banging.")
	//Activate extreme noise
	else
		shouta_message(user)
	..() //Hulk
	return

/obj/structure/mekanical_shouta/attackby(obj/item/weapon/W, mob/user)
	if(iscrowbar(W) && !busy) //Only way to deconstruct, needs harm intent
		W.playtoolsound(loc, 75)
		user.visible_message("<span class='warning'>[user] starts struggling to pry \the [src] apart.</span>", \
		"<span class='notice'>You start struggling to pry \the [src] apart.</span>")
		busy = 1
		if(do_after(user, src, 50)) //Takes a while because it is a barricade instant kill
			playsound(loc, 'sound/items/Deconstruct.ogg', 75, 1)
			user.visible_message("<span class='warning'>[user] finishes turning \the [src] back into parts.</span>", \
			"<span class='notice'>You finish turning \the [src] back into parts.</span>")
			busy = 0
			new /obj/item/stack/sheet/metal(loc, 50)
			setDensity(FALSE)
			qdel(src)
			return
		else
			busy = 0

	if(iswrench(W))
		if(anchored)
			W.playtoolsound(src, 50)
			to_chat(user, "You unanchor the [src].")
			anchored = 0
		else
			W.playtoolsound(src, 50)
			to_chat(user, "You anchor the [src].")
			anchored = 1
	
	if(W.damtype == BRUTE || W.damtype == BURN)
		user.delayNextAttack(10)
		health -= W.force
		user.visible_message("<span class='warning'>\The [user] hits \the [src] with \the [W].</span>", \
		"<span class='warning'>You hit \the [src] with \the [W].</span>")
		healthcheck(user)
		return
	else
		..() //Weapon checks for weapons without brute or burn damage type and grab check

//ERE WE GO
/obj/structure/mekanical_shouta/proc/shouta_message(var/mob/living/user)
	if(world.time <= cooldown)
		to_chat(user,"You attempt to activate it, only to hear a click. Might want to wait a bit")
		return 0
	cooldown = world.time+200 //20 Seconds
	
	var/message = sanitize(input("GIVE A SHOUT OUT TO DA BOYZ.", "Mek Megaphone", "") as null|message, MAX_MESSAGE_LEN)
	if(!message)
		return
	
	var/msgsize = (30+(user.attribute_constitution+user.attribute_strength)) //70 was my starter val
	to_chat(world,"<span style='color:green;font-size:[msgsize]px'>[message]</span>")
	spark(src, 5)
	playsound(loc,"sparks",50,1)

	if(!isork(user))
		if(prob(25))
			spawn(15)
				explosion(src.loc, -1, 1, 3, adminlog = 0) //Overload
				qdel(src) //It exploded, rip
				return
