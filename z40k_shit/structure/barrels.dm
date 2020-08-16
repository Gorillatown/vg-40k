// BARRELS AND BARREL ACCESSORIES //
/obj/structure/reagent_dispensers/cauldron/barrel
	name = "metal barrel"
	icon_state = "metalbarrel"
	desc = "Originally used to store liquids & powder. It is now used as a source of comfort. This one is made of metal."
	layer = TABLE_LAYER
	flags = TWOHANDABLE | MUSTTWOHAND // If I end up being coherent enough to make it holdable in-hand
	throwforce = 40 // Ends up dealing 20~ brute when thrown because thank you, based throw damage formula
	var/list/exiting = list() // Manages people leaving the barrel

/obj/structure/reagent_dispensers/cauldron/barrel/wood
	name = "wooden barrel"
	icon_state = "woodenbarrel"
	desc = "Originally used to store liquids & powder. It is now used as a source of comfort. This one is made of wood."

/obj/structure/reagent_dispensers/cauldron/barrel/update_icon()
	return

/obj/structure/reagent_dispensers/cauldron/barrel/kick_act(mob/living/carbon/human/H)
	..()
	if (!reagents)
		return 1
	if(reagents.total_volume > 10) //Beakersplashing only likes to do this sound when over 10 units
		playsound(src, 'sound/effects/slosh.ogg', 25, 1)
	H.investigation_log(I_CHEMS, "has emptied \a [src] ([type]) containing [reagents.get_reagent_ids(1)] onto \the [usr.loc].")
	reagents.reaction(usr.loc)
	src.reagents.clear_reagents()
	H.visible_message("<span class='warning'>[usr] kicks \the [src]!</span>", "<span class='notice'>You kick \the [src].</span>")
	for(var/atom/movable/AM in src)
		AM.forceMove(loc)

/obj/structure/reagent_dispensers/cauldron/barrel/attackby(obj/item/weapon/W, mob/user)
	if(W.is_wrench(user))
		return
	if(istype(W,/obj/item/weapon/grab))
		var/obj/item/weapon/grab/G = W
		var/mob/living/target = G.affecting
		user.visible_message("<span class='danger'>[user] begins to drag [target] into the barrel!</span>")
		if(do_after_many(user,list(target,src),10)) //Twice the normal time
			enter_barrel(target)
	else
		..()

/obj/structure/reagent_dispensers/cauldron/barrel/attackby(obj/item/W, mob/user, params)

/obj/structure/reagent_dispensers/cauldron/barrel/proc/enter_barrel(mob/user)
	user.forceMove(src)
	update_icon()
	user.reset_view()
	to_chat(user,"<span class='notice'>You enter \the [src].</span>")

/obj/structure/reagent_dispensers/cauldron/barrel/MouseDropTo(atom/movable/O, mob/user)
	if(O.loc == user || !isturf(O.loc) || !isturf(user.loc) || !user.Adjacent(O)) //no you can't pull things out of your ass
		return
	if(user.incapacitated() || user.lying) //are you cuffed, dying, lying, stunned or other
		return
	if(!Adjacent(user) || !user.Adjacent(src)) // is the mob too far away from you, or are you too far away from the source
		return
	if(O.locked_to)
		return
	else if(O.anchored)
		return
	if(issilicon(O)) //robutts dont fit
		return
	if(!ishigherbeing(user) && !isrobot(user)) //No ghosts or mice putting people into the barrel
		return
	var/mob/living/target = O
	if(!istype(target))
		return
	for(var/mob/living/carbon/slime/M in range(1,target))
		if(M.Victim == target)
			to_chat(user, "[target.name] will not fit into \the [src] because they have a slime latched onto their head.")
			return

	if(target == user)
		to_chat(user,"<span class='notice'>You begin to climb into the barrel.</span>")
		if(do_after(target,src,10))
			enter_barrel(target)
	else
		user.visible_message("<span class='danger'>[user] begins to drag [target] into the barrel!</span>")
		if(do_after_many(user,list(target,src),10)) //Twice the normal time
			enter_barrel(target)

/obj/structure/reagent_dispensers/cauldron/barrel/container_resist(mob/user)
	if (exiting.Remove(user))
		to_chat(user,"<span class='warning'>You stop climbing free of \the [src].</span>")
		return
	visible_message("<span class='warning'>[user] begins to climb free of the \the [src]!</span>")
	exiting += user
	spawn(3 SECONDS)
		if(loc && exiting.Remove(user))
			user.forceMove(loc)
			update_icon()
			to_chat(user,"<span class='notice'>You climb free of the barrel.</span>")

/obj/structure/reagent_dispensers/cauldron/barrel/Destroy()
	for(var/atom/movable/AM in src)
		AM.forceMove(loc)
	..()


/*
	RNG CHEM BARRELS
					*/
/obj/structure/reagent_dispensers/cauldron/barrel/rng_barrels
	name = "Metal Barrel"
	desc = "Who knows what mysteries it holds."
	icon = 'z40k_shit/icons/obj/barrels.dmi'
	icon_state = "barrel_4"
	density = 1

/obj/structure/reagent_dispensers/cauldron/barrel/rng_barrels/New()
	. = ..()
	icon_state = "barrel_[rand(1,7)]"

	var/rngchem
	if(prob(80))
		rngchem = pick(rngchemlistbasic)
	else //20%
		var/onetothree = rand(1,3)
		switch(onetothree)
			if(1)
				rngchem = pick(rngchemlistdrinks)
			if(2)
				rngchem = pick(rngchemlistcondiments)
			if(3)
				rngchem = pick(rngchemlistfulls)
	
	reagents.add_reagent(rngchem, 1000)

/*
	RNG DRUG BARRELS
					*/
/obj/structure/reagent_dispensers/cauldron/barrel/drug_barrel
	name = "Metal Barrel"
	desc = "Who knows what mysteries it holds."
	icon = 'z40k_shit/icons/obj/barrels.dmi'
	icon_state = "barrel_4"
	density = 1

/obj/structure/reagent_dispensers/cauldron/barrel/drug_barrel/New()
	. = ..()
	var/rngchem = pick(rngdrugbarrel)
	reagents.add_reagent(rngchem,1000)