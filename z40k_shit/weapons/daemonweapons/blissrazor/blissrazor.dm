/obj/item/weapon/daemonweapon/blissrazor
	name = "bliss razor" //Temporary name. They will get to rename it.
	desc = "A wickedly curved, jet black blade stained a deep royal purple. This blade hums and pulses with unearthly energies and bears a cetain inexplicable beauty and allure."
	icon = 'z40k_shit/icons/obj/64x64weapons.dmi'
	icon_state = "blissrazor_closed"
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/64x64blissrazor.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/64x64blissrazor.dmi')
	item_state = "blissrazor_closed"
	sharpness_flags = SHARP_TIP |SHARP_BLADE
	sharpness = 1.5
	force = 20 //A decent melee weapon, but not exactly spectacular. Gets better when it hosts more souls, et cetera.
	throwforce = 20

	//Cooldowns and safety
	daemon_inside = FALSE //Do we currently have a active daemon?
	var/hostage_brain_occupied = FALSE //Do we currently have a hostage brain occupied?
	last_ping_time = 0
	ping_cooldown = 5 SECONDS

	//References.
	var/datum/delay_controller/move_delayer = new(0.1, ARBITRARILY_LARGE_NUMBER) //See setup.dm, 12
	var/mob/living/simple_animal/hostile/retaliate/daemon/daemonette/player/our_daemon //Our protagonist
	var/mob/living/current_swordbearer //Just dictates who is currently holding the sword.
	var/mob/living/hostage_brain/hostage_brain //Used for swapping control of the body back and forth.
	free_recruiter //Basically the advertiser for the role.

	//BLOOOD
	var/blood = 0
	var/maxregenblood = 8//the maximum amount of blood you can regen by waiting around.
	var/maxblood = 100

	/*Movement shit*/
	var/movement_delay = 1//Our movement delay on movement.
	var/no_soul_piloting = TRUE //Whether people other than our daemon can currently pilot the sword.

	/*Soul counter*/
	var/soul_count = 0 //How many souls we have trapped
	var/list/soul_list = list() //The total list of souls we currently have sucked into us.
	var/no_soul_casting = TRUE //Whether our daemon is currently letting souls perform actions.


/obj/item/weapon/daemonweapon/blissrazor/New()
	..()
	hostage_brain = new(src) //We make a container to handle possession of bitches

/obj/item/weapon/daemonweapon/blissrazor/Destroy()
	for(var/mob/living/simple_animal/lol in contents)
		to_chat(lol, "Suddenly, you are released into realspace probably to the extreme terror of everyone!")
		lol.loc = src.loc
	our_daemon = null
	if(hostage_brain) //Unlike all the other denizens of the fucksword
		hostage_brain.ghostize(0) //You just get ejected into actual death if we are broken in half in your hands.
		qdel(hostage_brain)
		hostage_brain = null //And the reference to something is cleaned out.
	current_swordbearer = null
	qdel(free_recruiter)
	free_recruiter = null
	..()

/*
	Chunk of shit that handles getting a daemon into us
*/
/obj/item/weapon/daemonweapon/blissrazor/attack_self(mob/living/user)
	if(daemon_inside)
		return
	awaken()

//Attack Ghost
/obj/item/weapon/daemonweapon/blissrazor/attack_ghost(var/mob/dead/observer/O)
	if(daemon_inside)
		return
	awaken()

/obj/item/weapon/daemonweapon/blissrazor/awaken()
	visible_message("<span class='notice'>\The [name] shakes vigorously!</span>")
	if(!free_recruiter)
		free_recruiter = new(src)
		free_recruiter.master = src

	free_recruiter.recruit_bitches()

/obj/item/weapon/daemonweapon/blissrazor/plugin_ourboy(var/client/C)
	if(C)
		daemon_inside = TRUE
		visible_message("<span class='notice'>\The [name] awakens!</span>")
		//We have a 20000 hp special daemonette contained within us. Release it if you want the round to go to hell.
		our_daemon = new(src) 
		our_daemon.real_name = name
		our_daemon.name = name
		our_daemon.ckey = C.ckey
		our_daemon.universal_speak = TRUE
		our_daemon.universal_understand = TRUE
		our_daemon.give_blade_powers()
		update_icon()
		to_chat(our_daemon, "<span class='info'>You are currently a daemonette trapped in a sword.</span>")
		to_chat(our_daemon, "<span class='info'>Unable to do anything major by yourself, you need a wielder. Find someone and satiate your desires.</span>")
		var/input = copytext(sanitize(input(our_daemon, "What should i call myself?","Name") as null|text), TRUE, MAX_MESSAGE_LEN)

		if(src && input)
			name = input
			our_daemon.real_name = input
			our_daemon.name = input
		
	else
		update_icon()
		visible_message("<span class='notice'>\The [name] calms down.</span>")

/*
	Safeties Pickup and drop
*/
/obj/item/weapon/daemonweapon/blissrazor/pickup(var/mob/living/user)
	to_chat(user, "<span class='warning'>An overwhelming feeling of bliss comes over you as you pick up \the [src].</span>")
	current_swordbearer = user

/obj/item/weapon/daemonweapon/blissrazor/dropped(var/mob/user)
	..()
	if(hostage_brain && hostage_brain_occupied)
		our_daemon.ckey = user.ckey
		user.ckey = hostage_brain.ckey
		to_chat(user,"<span class='good'> You suddenly feel the dream come to an end as you reoccupy your body.</span>")
	current_swordbearer = null

/*
	Basically we call this to update our icon and such
*/
/obj/item/weapon/daemonweapon/blissrazor/update_icon()
	if(daemon_inside)
		item_state = "blissrazor_open"
		icon_state = "blissrazor_open"
	else
		item_state = "blissrazor_closed"
		icon_state = "blissrazor_closed"

/*
	Suicide act etc etc
*/
/obj/item/weapon/daemonweapon/blissrazor/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] begins pressing [src.name] into their chest! It looks like \he's trying to commit suicide.</span>")
	to_chat(user, "<span class='warning'> You hear the sound of laughter in your mind as darkness overtakes your consciousness.</span>")
	spawn(100)
		user.visible_message("<span class='suicide'>You hear a hissing sound as a wave of exquisite pain washes over you.</span>") //Spooky slaaneshi shit.
		to_chat(user, "<span class='warning'> Your essence is consumed by [src]!</span>") //If someone willingly sacrifices themselves with the blade, it becomes even more powerful than if you forcibly captured their soul.
		src.force += 20
		src.throwforce += 20
		src.absorb_soul(null, user)
	return (SUICIDE_ACT_BRUTELOSS)

//In the scenario someone thinks they can just stack welding fuel ontop of each other and detonate it over the blade
/obj/item/weapon/daemonweapon/blissrazor/ex_act(severity)
	return

//We are a shield yeah.
/obj/item/weapon/daemonweapon/blissrazor/IsShield()
	return TRUE

/*
	Attack procs
*/
/obj/item/weapon/daemonweapon/blissrazor/attack(var/mob/living/target, var/mob/living/carbon/human/user)
	if(istype(target,/mob/living/carbon))
		var/mob/living/carbon/C = target
		if(C == user)
			user.visible_message("<span class='warning'> [user] slits their wrist with [src]!</span>", \
	"<span class='warning'> You draw your own blood to strengthen the sorcery in [src], bringing the inhabitant spirits under greater control.</span>", \
	"<span class='warning'> You hear a hissing sound.</span>")
			blood += 30
			force += 1
			throwforce += 1
			user.take_organ_damage(25,0)
			return
		if(C.stat == DEAD)
			to_chat(user, "<span class='warning'> [src] greedily absorbs [C]'s essence!</span>")
			if(C.client)
				to_chat(user, "<span class='warning'> [src] seems to hum with energy as [C]'s torment is soaked up by the blade!</span>")
				absorb_soul(user, C)
				playsound(loc, 'sound/hallucinations/wail.ogg', 50, 1, -1)
				return
			else
				C.gib()
				return
		else
			if(prob(item_effects.len*30))
				to_chat(user, "<span class='warning'> [src] overloads [C]'s senses and casts them into a breif coma.</span>")
				C.sleeping += 10
	else if(istype(target,/mob/living/simple_animal)) //Still gibs animals, but gets less power from them.
		var/mob/living/simple_animal/A = target
		if(A.stat == DEAD)
			to_chat(user, "<span class='warning'> [src] accepts your sacrifice.")
			to_chat(user, "<span class='warning'> [src] seems slightly energized.")
			force += 3
			throwforce += 5
			A.gib()
			playsound(loc, 'sound/hallucinations/wail.ogg', 50, 1, -1)
			return

	return ..()	

/*
	Basically projectile launching
*/
/obj/item/weapon/daemonweapon/blissrazor/afterattack(var/atom/A, var/mob/living/user, var/proximity_flag, var/click_parameters)
	if(proximity_flag)
		return
	if(user.is_pacified(VIOLENCE_SILENT,A,src))
		return
	if(blood >= 5)
		blood = max(0,blood-5)
		var/turf/starting = get_turf(user)
		var/turf/target = get_turf(A)
		var/obj/item/projectile/bloodslash/BS = new (starting)
		BS.firer = user
		BS.original = A
		BS.target = target
		BS.current = starting
		BS.starting = starting
		BS.yo = target.y - starting.y
		BS.xo = target.x - starting.x
		user.delayNextAttack(4)
		if(user.zone_sel)
			BS.def_zone = user.zone_sel.selecting
		else
			BS.def_zone = LIMB_CHEST
		BS.OnFired()
		playsound(starting, 'sound/effects/forge.ogg', 100, 1)
		BS.process()


/*
	On attack, handles taking blood from people we hit with this
*/
/obj/item/weapon/daemonweapon/blissrazor/on_attack(var/atom/attacked, var/mob/user)
	..()
	if(ismob(attacked))
		var/mob/living/M = attacked
		M.take_organ_damage(0,5)
		playsound(loc, 'sound/weapons/welderattack.ogg', 50, 1)
		if (iscarbon(M))
			var/mob/living/carbon/C = M
			if (C.stat != DEAD)
				if(C.take_blood(null,10))
					blood = min(100,blood+10)
					to_chat(user, "<span class='warning'>You steal some of their blood!</span>")
			else
				if(C.take_blood(null,5))//same cost as spin, basically negates the cost, but doesn't let you farm corpses. It lets you make a mess out of them however.
					blood = min(100,blood+5)
					to_chat(user, "<span class='warning'>You steal a bit of their blood, but not much.</span>")

			if(our_daemon && our_daemon.hud_used && our_daemon.gui_icons && our_daemon.gui_icons.soulblade_bloodbar)
				var/matrix/MAT = matrix()
				MAT.Scale(1,blood/maxblood)
				var/total_offset = (60 + (100*(blood/maxblood))) * PIXEL_MULTIPLIER
				our_daemon.hud_used.mymob.gui_icons.soulblade_bloodbar.transform = MAT
				our_daemon.hud_used.mymob.gui_icons.soulblade_bloodbar.screen_loc = "WEST,CENTER-[8-round(total_offset/WORLD_ICON_SIZE)]:[total_offset%WORLD_ICON_SIZE]"
				our_daemon.hud_used.mymob.gui_icons.soulblade_coverLEFT.maptext = "[blood]"

/*
	Soul Absorption
	Basically handles converting clients and ghosts into souls
*/
/obj/item/weapon/daemonweapon/blissrazor/proc/absorb_soul(var/mob/living/carbon/user, var/mob/living/carbon/C)
	if(!C.client)
		if(user)
			to_chat(user, "<span class='warning'> This one's soul is not present. Sacrifice failed.</span>")
		return //No absorbing AFK people.
	if(C.ckey)
		var/mob/living/simple_animal/hostile/bitchspirit/ourbitch = new(src) //THEN CRAM THEM UP THE SWORDS ASS!
		ourbitch.name = C.real_name
		ourbitch.real_name = C.real_name
		ourbitch.ckey = C.ckey
		
		ourbitch.icon = C.icon
		ourbitch.icon_state = C.icon_state
		ourbitch.icon_living = C.icon_state

		ourbitch.universal_speak = TRUE
		ourbitch.universal_understand = TRUE
		
		ourbitch.see_invisible = SEE_INVISIBLE_OBSERVER
		ourbitch.verbs -= /mob/living/verb/ghost //No escapies not ever no not ever.

		soul_list += ourbitch
		soul_count += 1

	force += 10
	throwforce += 10

/*
	Movement Procs
	When a move tries to move inside of something relaymove is called.
*/
/obj/item/weapon/daemonweapon/blissrazor/Move(NewLoc, Dir = 0, step_x = 0, step_y = 0, glide_size_override = 0)
	var/oldloc = loc
	. = ..()
	if(Dir && (oldloc != NewLoc))
		loc.Entered(src, oldloc)

/obj/item/weapon/daemonweapon/blissrazor/relaymove(mob/user, direction) //Relaymove basically sends the user and the direction when we hit the buttons
	if(user != our_daemon && no_soul_piloting) //If our daemon isn't attempting to pilot it, and no soul piloting is on
		return 0
	if(current_swordbearer)
		return 0 //No takin off unless we are dropped.
	if(move_delayer.blocked()) //If we are blocked from moving by move_delayer, return false. Delay
		return 0
	if(blood <= 0) //No blood, no movement.
		return 0
	
	set_glide_size(DELAY2GLIDESIZE(movement_delay)) //Otherwise we good to go
	step(src, direction)
	blood--

	move_delayer.delayNext(round(movement_delay,world.tick_lag)) //Delay
