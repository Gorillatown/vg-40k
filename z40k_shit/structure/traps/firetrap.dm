//Fire shooting pipe
/obj/structure/traps/fire_trap
	name = "mysterious pipe"
	desc = "A pipe looking out from a wall."
	icon_state = "pipe"

	anchored = 1
	density = 0

	var/fire_projectile = /obj/item/projectile/fire_breath
	var/fire_sound = 'z40k_shit/sounds/flamer.ogg'

	currently_active = TRUE

/obj/structure/traps/fire_trap/New()
	..()

/obj/structure/traps/fire_trap/Destroy()
	..()

/obj/structure/traps/fire_trap/turn_my_ass_over()
	var/obj/item/projectile/A = new fire_projectile(get_turf(src))

	if(!A)
		return 0

	playsound(src, fire_sound, 50, 1)
	var/turf/T = get_step(src, get_turf(src))
	var/turf/U = get_step(src, dir) //Turf in front of us
	A.original = U
	A.target = U
	A.current = T
	A.starting = T
	A.yo = U.y - T.y
	A.xo = U.x - T.x
	spawn()
		A.OnFired()
		A.process()

//Fire blasts from this trap fire in a straight line, without expanding at the end
/obj/structure/traps/fire_trap/no_spread
	fire_projectile = /obj/item/projectile/fire_breath/straight

/obj/structure/traps/fire_trap/no_spread/tick_one
	//Basically this fires off on tick 1
/obj/structure/traps/fire_trap/no_spread/tick_one/New()
	..()
	scenario_order_one += src

/obj/structure/traps/fire_trap/no_spread/tick_one/Destroy()
	scenario_order_one -= src
	..()
	
/obj/structure/traps/fire_trap/no_spread/tick_two
	//This one fires off on tick 2
/obj/structure/traps/fire_trap/no_spread/tick_two/New()
	..()
	scenario_order_two += src

/obj/structure/traps/fire_trap/no_spread/tick_two/Destroy()
	scenario_order_two -= src
	..()