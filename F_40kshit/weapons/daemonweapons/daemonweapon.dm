// The chaos blade, a ghost role talking sword. Unlike the nullrod skins this thing works as a proper shield and has sharpness.
/obj/item/weapon/daemonweapon
	name = "chaos blade"
	desc = "Considered a 'cursed blade' legend says that anyone that tries to wield it end corrupted by chaos. It has three yellow eyes, two near the base of the hilt and one at the pommel, and a decorative jewel between its eyes."
	icon_state = "talking_sword"
	item_state = "talking_sword"
	sharpness_flags = SHARP_TIP |SHARP_BLADE
	sharpness = 1.5
	var/datum/free_recruiter/free_recruiter
	var/daemon_inside = FALSE
	var/last_ping_time = 0
	var/ping_cooldown = 5 SECONDS
/*	var/blood = 0
	var/maxregenblood = 8//the maximum amount of blood you can regen by waiting around.
	var/maxblood = 100
	var/movespeed = 2//smaller = faster
	health = 40
	var/maxHealth = 40*/
 
/obj/item/weapon/daemonweapon/attack_self(mob/living/user)
	if(daemon_inside)
		return
	awaken()


/obj/item/weapon/daemonweapon/proc/awaken()
	icon_state = "[initial(icon_state)]_a"
	visible_message("<span class='notice'>\The [name] shakes vigorously!</span>")
	if(!free_recruiter)
		free_recruiter = new(src)
		free_recruiter.master = src

	free_recruiter.recruit_bitches()

/obj/item/weapon/daemonweapon/plugin_ourboy(var/client/C)
	if(C)
		daemon_inside = TRUE
		visible_message("<span class='notice'>\The [name] awakens!</span>")
		var/mob/living/simple_animal/shade/sword/S = new(src)
		S.real_name = name
		S.name = name
		S.ckey = C.ckey
		S.universal_speak = TRUE
		S.universal_understand = TRUE
		S.status_flags |= GODMODE //Make sure they can NEVER EVER leave the blade.
		to_chat(S, "<span class='info'>You are currently trapped in a sword.</span>")
		to_chat(S, "<span class='info'>Unable to do anything by yourself, you need a wielder. Find someone with a strong will and become their strength so you may finally satiate your desires.</span>")
		var/input = copytext(sanitize(input(S, "What should i call myself?","Name") as null|text), TRUE, MAX_MESSAGE_LEN)

		if(src && input)
			name = input
			S.real_name = input
			S.name = input
	else
		icon_state = initial(icon_state)
		visible_message("<span class='notice'>\The [name] calms down.</span>")

/obj/item/weapon/daemonweapon/Destroy()
	for(var/mob/living/simple_animal/lol in contents)
		to_chat(lol, "Suddenly, you are released into realspace!")
		lol.loc = src.loc
	qdel(free_recruiter)
	free_recruiter = null
	..()

/obj/item/weapon/daemonweapon/attack_ghost(var/mob/dead/observer/O)
	if(daemon_inside)
		return
	awaken()

/obj/item/weapon/daemonweapon/IsShield()
	return TRUE
