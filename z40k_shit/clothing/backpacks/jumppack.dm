 
//Heres the jumppack and all of its code
/obj/item/ork/jumppack
	name = "Jumppack"
	desc = "A missile, it still works enough to launch you with it for the most part."
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	icon_state = "orkjumppack_off"
	item_state = "orkjumppack_off"
	slot_flags = SLOT_BACK
	w_class = W_CLASS_LARGE
	species_fit = list("Ork", "Ork Nob")
	var/wallcrashiterations = 4 // How many times are we going to destroy everything before we stop.
	var/highinair = 0 //Am I flying, like real high?, If I am flying and the user pulls me off they will die.
	var/stuntime = 5 //How much do I stun on collision.
	var/knockdowntime = 5 // How much do I knockdown on collision.
	var/leapduration = 5 SECONDS //How long we stay in the air
	var/landinganim = FALSE //Are we partway through the landing anim deciding whether we gib or not on unequip.

	//We have a var called highflying on the mob now for big jumps

	var/burning = FALSE //We are BURNING or not.
	actions_types = list(/datum/action/item_action/warhams/flight,
						/datum/action/item_action/warhams/hover,
						/datum/action/item_action/warhams/burstrush) //Actions go here

/obj/item/ork/jumppack/update_icon() //Right here is where we will apply the jumppack overlay.
	var/mob/living/carbon/human/H = loc

	if(istype(loc,/mob/living/carbon/human)) //Needs to always update its own overlay, but only update mob overlays if it's actually on a mob.
		if(burning) //FLAME ON
			icon_state = "orkjumppack_on"
			H.update_inv_back()
		else
			icon_state = "orkjumppack_off"//FLAME OFF
			H.update_inv_back()

/obj/item/ork/jumppack/unequipped(mob/living/carbon/human/user, var/from_slot = null)

	burning = FALSE //We are not staying lit pal.
	update_icon()

	if(user.highflying && !landinganim) //If we are highflying and not partway in the landing animation.
		user.visible_message("<span class='danger'> [user] learns that gravity does exist!</span>")
		animate(user, pixel_y = 0, time = 10, loop = 0, QUAD_EASING) //Our fun animation
		sleep(10) //10 ticks until we meet our end
		user.gib() //And we die
	
	if(user.flying) //The case where we take the jetpack off while hovering.
		user.flying = 0
		user.visible_message("<span class='danger'> [user] takes their jumppack off and meets the ground!</span>")
		user.Stun(stuntime)
		user.Knockdown(knockdowntime)
		user.drop_item(src)
		animate(user, pixel_y = pixel_y + 10 * PIXEL_MULTIPLIER, time = 1, loop = 1)
		animate(user, pixel_y = pixel_y, time = 10, loop = 1, easing = SINE_EASING)
		animate(user)
		if(user.lying)
			user.pixel_y -= 6 * PIXEL_MULTIPLIER
	
	if(landinganim) //If we are in the landing animation
		user.Stun(stuntime) //You get stunned
		user.Knockdown(knockdowntime) //And knocked down idiot
		user.drop_item(src)
		user.visible_message("<span class='danger'> [user] learns that elevation does exist!</span>")

/obj/item/ork/jumppack/proc/hoverleap(mob/user) // We are flying, but its more like hovering.
	if(user.flying)
		return
	if(user.highflying)
		return
	to_chat(user, "<span class='warning'>You begin hovering deftly off the ground!</span>")
	user.flying = 1 //We are now hovering along with an animation afterwards
	burning = TRUE
	update_icon() //Loop is 1 on the below animate.
	animate(user, pixel_y = 15, time=10, loop = -1, easing=SINE_EASING, flags=ANIMATION_RELATIVE)
	animate(pixel_y = 8, time=10, loop = -1, easing=SINE_EASING)

/obj/item/ork/jumppack/proc/hoverland(mob/user) // And then we stop hovering.
	to_chat(user, "<span class='warning'>You stop hovering!</span>")
	user.flying = 0
	
	//Animation will occur regardless because we are going to land.
	animate(user, pixel_y = 0, time = 15, easing = EASE_OUT)
	if(user.lying)
		user.pixel_y -= 6 * PIXEL_MULTIPLIER

	burning = FALSE
	update_icon()

/obj/item/ork/jumppack/proc/flyleap(var/mob/living/user, leapduration, smoke = 1) //We fly high into the air
	//Yeah, this code is copy and pasted from ethereal jaunt mostly
	//ethereal_jaunt(user, duration, enteranim, exitanim, smoke) //Reference line

	burning = TRUE
	update_icon()

	if(user.incorporeal_move == INCORPOREAL_ETHEREAL) //they're already jaunting, we have another fix for this but this is sane
		return
	user.unlock_from()
	//Begin moving with an animation
	animate(user, pixel_y = 300, time = 20, loop = 0, QUAD_EASING)

	if(smoke)
		user.ExtinguishMob()
		var/obj/effect/effect/smoke/S = new /obj/effect/effect/smoke(get_turf(src))
		S.time_to_live = 20 //2 seconds instead of full 10

	//Turn on jaunt incorporeal movement, make him invincible, they can't see him over the screen anyways.
	user.incorporeal_move = INCORPOREAL_ETHEREAL
	user.invisibility = INVISIBILITY_MAXIMUM
	user.flags |= INVULNERABLE
	user.setDensity(FALSE)
	user.candrop = 0
	user.delayNextAttack(leapduration+25)
	user.click_delayer.setDelay(leapduration+25)
	user.highflying = 1 //INTO THE AIR

	sleep(leapduration)
	
	if(user.stat != DEAD) //If our dumb ass didn't take off the jetpack midair
		flyland(user) //we now land
	else //We somehow died in the air
		burning = FALSE
		update_icon()
		user.visible_message("<span class='danger'> A corpse suddenly makes its grand entrance!</span>")
		animate(user, pixel_y = 0, time = 10, loop = 0, QUAD_EASING) //Our fun animation
		sleep(10) //10 ticks until we meet our end
		user.gib() //And the corpse gibs

/obj/item/ork/jumppack/proc/flyland(var/mob/living/user, smoke = 1) //We land from high in the air
	
	//Begin landing
	var/mobloc = get_turf(user)
	//user.delayNextMove(25)
	user.dir = SOUTH

	animate(user, pixel_y = 0, time = 20, loop = 0, QUAD_EASING)

	//Forcemove him onto the tile and make him visible and vulnerable
	user.forceMove(mobloc)
	user.invisibility = 0
	user.flags &= ~INVULNERABLE
	user.candrop = 1
	user.incorporeal_move = INCORPOREAL_DEACTIVATE
	sleep(5)
	landinganim = TRUE //We partway in the landing animation, so we don't gib if we take the jumppack off
	sleep(15) //We should have 15 ticks before footprints start up again aka 20 total
	
	var/turf/T = get_turf(user)
	if(istype(T,/turf/simulated))
		user.gib()
		return

	user.setDensity(TRUE) // We also aren't dense until the anim is done too.
	user.highflying = 0 //BACK DOWN AGAIN

	if(user.flying) //If we were flying, we end this now.
		user.flying = 0

	landinganim = FALSE //We are also done with the landing animation.
	burning = FALSE
	update_icon()
	animate(user) //We also end any animations we are in if we were flying.

/datum/action/item_action/warhams/flight
	name = "Vertical Leap"
	background_icon_state = "bg_rustymetal"
	button_icon_state = "jump"
	desc = "Activate the jump pack to fly to high altitude. You may only take off or land outdoors."
	var/usetime

/datum/action/item_action/warhams/flight/Trigger()
	var/obj/item/ork/jumppack/S = target
	if(world.time < usetime + 120)
		to_chat(owner,"<span class='warning'> The jumppack is still charging!</span>")
		return
	else
		S.flight(owner)
		usetime = world.time


/obj/item/ork/jumppack/proc/flight(mob/living/user)
	if(!user.canmove || user.stat || user.restrained())
		return
	if(user.highflying)
		to_chat(user,"<span class='notice'> You pulse the jump pack to land again.</span>")
		flyland(user)
		return
	if(!istype(user.loc, /turf/unsimulated/outside))
		user.visible_message("<span class='danger'> [user] shoots into the air and hits their head on the ceiling!</span>")
		user.Stun(stuntime)
		user.Knockdown(knockdowntime)
		user.take_organ_damage(15, 0)
		return
	to_chat(user, "<span class='warning'>You take off and jump high off the ground!</span>")
	flyleap(user, leapduration) // We leap into the air.

/datum/action/item_action/warhams/hover
	name = "Hover"
	background_icon_state = "bg_rustymetal"
	button_icon_state = "hover"
	desc = "Hover with the jumppack."
	var/usetime

/datum/action/item_action/warhams/hover/Trigger()
	var/obj/item/ork/jumppack/S = target
	if(world.time < usetime + 120)
		to_chat(owner, "<span class='warning'>The Jumppack is still charging!</span>")
		return
	else
		S.hover(owner)
		usetime = world.time

/obj/item/ork/jumppack/proc/hover(mob/living/user)
	if(!user.canmove || user.stat || user.restrained())
		to_chat(user, "<span class='warning'>You seem to have too many issues at the moment!</span>")
		return
	if(user.highflying)
		to_chat(user, "<span class='warning'>You can't stay up here forever!</span>")
		return
	if(!user.flying)
		hoverleap(user)
	else
		hoverland(user)

/datum/action/item_action/warhams/burstrush
	name = "Jumppack (short burst)"
	background_icon_state = "bg_rustymetal"
	button_icon_state = "jumprush"
	desc = "Fly forward in a short potentially explosive burst."
	var/usetime // cooldown holder for actions

/datum/action/item_action/warhams/burstrush/Trigger()
	var/obj/item/ork/jumppack/S = target
	if(world.time < usetime + 60)
		to_chat(owner, "<span class='warning'> The jumppack is still charging!</span>")
	else
		S.burstrush(owner)
		usetime = world.time

/obj/item/ork/jumppack/proc/burstrush(mob/living/user)
	if(!user.canmove || user.stat || user.restrained())
		return
	if(ismob(user))
		if(user.highflying) 
			return

	burning = TRUE
	update_icon()
	playsound(loc, 'z40k_shit/sounds/Jump_Pack1.ogg', 75, 0)

	var/obj/effect/effect/smoke/S = new /obj/effect/effect/smoke(get_turf(src))
	S.time_to_live = 20 //2 seconds instead of full 10

	for(var/i = 1 to wallcrashiterations) //We just loop this way.
		var/movementdirection = user.dir
		var/range = 1
		user.Move(get_step(usr,movementdirection), movementdirection)
		for(var/turf/simulated/wall/M in range(range, src.loc))									//Cool-Aid man 'OH YEAH!!!'
			if(istype(M, /turf/simulated/wall) && !istype(M, /turf/simulated/wall/r_wall))
				var/randomizer = pick('z40k_shit/sounds/wallsmash1.ogg','z40k_shit/sounds/wallsmash2.ogg', 'z40k_shit/sounds/wallsmash3.ogg')
				playsound(loc, randomizer, 75, 0)
				M.ex_act(1)
			if(istype(M, /turf/simulated/wall/r_wall))
				user.gib()
				break
		for(var/obj/structure/M in range(range, src.loc))
			if(prob(25))
				qdel(M)
			else
				user.Stun(stuntime)
				user.Knockdown(knockdowntime)
				break
		for(var/turf/simulated/floor/M in range(range, src.loc))
			M.burn_tile()
		for(var/obj/machinery/M in range(range, src.loc))
			qdel(M)
		for(var/mob/living/carbon/human/M in orange(range, src.loc))
			M.Stun(stuntime)
			M.Knockdown(knockdowntime)
		playsound(loc, 'z40k_shit/sounds/Jump_Pack2.ogg', 75, 0)
		user.Move(get_step(usr,movementdirection), movementdirection)
		sleep(2)

	sleep(3)
	playsound(loc, 'z40k_shit/sounds/Jump_Pack3.ogg', 75, 0) //We end our shit
	user.Move(get_step(user,user.dir), user.dir)
	burning = FALSE
	update_icon()
	