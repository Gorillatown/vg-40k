/obj/item/weapon/grenade/stikkbomb
	name = "Stikkbomb"
	desc = "A simple grenade, pull the pin to light the fuse inside."
	icon_state = "stickbomb"
	item_state = "stickbomb"
	origin_tech = Tc_SYNDICATE + "=2" + Tc_COMBAT + "=3"

/obj/item/weapon/grenade/stikkbomb/prime()
	..()
	explosion(loc, 0, 2, 4, 6) //Explosive grenades pack a decent punch and are perfectly capable of breaking the hull, so beware
	spawn()
		qdel(src)

/obj/item/weapon/grenade/stikkbomb/ex_act(severity)
	switch(severity)
		if(1)
			prime()
		if(2)
			if(prob(80))
				prime()
		if(3)
			if(prob(50))
				prime()