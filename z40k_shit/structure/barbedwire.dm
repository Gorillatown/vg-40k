
/obj/item/barbed_wire_handler
	name = "barbed wire roll"
	icon = 'z40k_shit/icons/obj/barbedwire.dmi'
	icon_state = "barbedwire_normal"
	w_class = W_CLASS_TINY
	restraint_resist_time = 20 SECONDS
	var/turf/start
	var/turf/end
	var/wire_type = /obj/structure/barbed_wire
	var/icon_base
	var/spool_amount = 50

/obj/item/barbed_wire_handler/attack_self(var/mob/living/user)
	..()
	lay_barbed_wire(user)

/obj/item/barbed_wire_handler/examine(mob/user)
	..()
	to_chat(user, "<span class='notice'>The [src] currently has [spool_amount] units of wire left.</span>")

/obj/item/barbed_wire_handler/proc/lay_barbed_wire(var/mob/living/user)
	if(icon_state == "barbedwire_start")
		start = get_turf(src)
		to_chat(usr, "<span class='notice'>You place the first end of [src].</span>")
		icon_state = "barbedwire_stop"
	else
		icon_state = "barbedwire_start"
		end = get_turf(src)
		
		if(start.y != end.y && start.x != end.x || start.z != end.z)
			to_chat(usr, "<span class='notice'>[src] can only be laid in a straight line.</span>")
			return 0

		if(!spool_amount)
			to_chat(usr, "<span class='notice'>[src] is currently out of wire... GHOSTWIRE")
			qdel(src)
			return 0

		var/turf/cur = start 
		var/dir
		if(start.x == end.x)
			var/d = end.y-start.y
			if(d)
				d = d/abs(d)
			end = get_turf(locate(end.x,end.y+d,end.z))
			dir = "v"
		else
			var/d = end.x-start.x
			if(d)
				d = d/abs(d)
			end = get_turf(locate(end.x+d,end.y,end.z))
			dir = "h"

		var/spool_check_limit = 0
		var/can_place = 1
		while(cur!=end && can_place)
			if(cur.density == 1)
				can_place = 0
			else
				for(var/obj/O in cur)
					if(!istype(O, /obj/structure/barbed_wire) && O.density)
						can_place = 0
						break
			cur = get_step_towards(cur,end)
			spool_check_limit++
			to_chat(usr,"<span class='notice'> You currently have [spool_amount-spool_check_limit] wire left.")
		if(!can_place)
			to_chat(usr, "<span class='warning'>You can't run [src] through that!</span>")
			return 0
		if(spool_check_limit > spool_amount)
			to_chat(usr, "<span class='warning'>Thats more wire than you actually have!</span>")
			return 0

		cur = start
		var/wiretest = 0
		while(cur!=end)
			for(var/obj/structure/barbed_wire/Ptest in cur)
				if(Ptest.icon_state == "barbedwire_[dir]")
					wiretest = 1
			if(wiretest != 1)
				var/obj/structure/barbed_wire/P = new wire_type(cur)
				spool_amount--
				P.icon_state = "barbedwire_[dir]"
			cur = get_step_towards(cur,end)
		
		if(spool_amount == 0)
			to_chat(user,"<span class='notice'> You have ran out of wire.</span>")
			qdel(src)
		
		if(start != end)//Prevent wasting charges on rolls with limited charges by just spamming use on the same tile.
			to_chat(usr, "<span class='notice'>You finish placing [src].</span>")
			user.visible_message("<span class='warning'>[user] finishes placing [src].</span>") //Now you know who to whack with a stun baton
			return 1

//Reset the process if dropped mid laying tape.
/obj/item/barbed_wire_handler/dropped(mob/user)
	. = ..()
	start = null
	end = null
	icon_state = "barbedwire_normal"

/obj/item/barbed_wire_handler/pickup(mob/user)
	icon_state = "barbedwire_start"


/obj/structure/barbed_wire
	name = "barbed wire"
	icon = 'z40k_shit/icons/obj/barbedwire.dmi'
	icon_state = "barbedwire_h"
	anchored = 1
	density = 1
	var/health = 200
	var/icon_base

//We return 1 if its going to pass, otherwise its 0 if its not gonna pass
/obj/structure/barbed_wire/Cross(atom/movable/mover, turf/target, height = 1.5, air_group = 0)
	if(air_group || !height) //The mover is an airgroup
		return 1 //We aren't airtight, only exception to PASSGLASS
	if(!density)
		return 1
	if(ismob(mover))
		var/mob/M = mover
		if(M.flying || M.highflying)
			return 1
		else
			return (barbwire_action(mover))
	if(istype(mover,/obj/item/projectile))
		return 1
	return 0

//You return !density when you want them to pass
//You return false when you want them to fail.
//You return true when you want it to just end
/obj/structure/barbed_wire/proc/barbwire_action(mob/living/user)
	if(user.attribute_strength >= 16 && user.attribute_constitution >= 16)
		user.visible_message("<span class='warning'>[user] charges through [src] with their EXTREMELY muscled LITERALLY rock hard body!</span>")
		qdel(src)
		return 1
	else
		switch(user.attribute_dexterity)
			if(1 to 6)
				user.apply_damage(4,BRUTE,(pick(LIMB_LEFT_LEG, LIMB_RIGHT_LEG)))
				user.Knockdown(5)
				user.Stun(5)
				user.visible_message("<span class='warning'>[user] gets caught in [src] and collapses!</span>")
				user.stat_increase(ATTR_DEXTERITY,50)
				return 0
			if(6 to 12)
				if(prob(20))
					user.apply_damage(4,BRUTE,(pick(LIMB_LEFT_LEG, LIMB_RIGHT_LEG)))
					user.visible_message("<span class='warning'>[user] gets caught in [src] but pushes through. DAMN!</span>")
					user.stat_increase(ATTR_DEXTERITY,50)
					return !density
				else
					user.apply_damage(4,BRUTE,(pick(LIMB_LEFT_LEG, LIMB_RIGHT_LEG)))
					user.Knockdown(5)
					user.Stun(5)
					user.visible_message("<span class='warning'>[user] gets caught in [src] and collapses!</span>")
					user.stat_increase(ATTR_CONSTITUTION, 25)
					return 0
			if(12 to 16)
				if(prob(25))
					user.apply_damage(4,BRUTE,(pick(LIMB_LEFT_LEG, LIMB_RIGHT_LEG)))
					user.visible_message("<span class='warning'>[user] gets caught in [src] but pushes through. DAMN!</span>")
					return !density
					user.stat_increase(ATTR_CONSTITUTION, 25)
				else if(prob(10))
					user.visible_message("<span class='warning'>[user] gets caught in [src] and trips!</span>")
					user.Knockdown(3)
					return 0
				else
					user.visible_message("<span class='warning'>[user] carefully passes over [src]!</span>")
					return !density
			if(16 to 30)
				user.visible_message("<span class='warning'>[user] gracefully dances through [src] with ease!</span>")
				return !density

/obj/structure/barbed_wire/attackby(var/obj/item/weapon/W, var/mob/living/user)
	if(W)
		if(!W.is_sharp())
			health -= W.force/2
			user.visible_message("<span class='warning'>[user] bashes [src] with [W]!</span>")
			user.adjustBruteLoss(W.force/6)
			health_handler(W, user)
		else
			if(W.is_sharp())
				user.visible_message("<span class='warning'>[user] cuts [src]!</span>")
				qdel(src)
	else
		to_chat(user, "<span class='warning'> Seems like a bad idea doesn't it.</span>")

/obj/structure/barbed_wire/proc/health_handler(var/obj/item/weapon/W, var/mob/living/user)
	if(health <= 0)
		user.visible_message("<span class='warning'>[user] breaks [src]!</span>")
		qdel(src)