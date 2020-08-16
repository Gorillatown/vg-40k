/*
abilities
*/


/spell/slaanesh/push
	name = "Expose the Warp"
	desc = "Slaanesh pushes against the very fabric of reality- threatening to break through."
	invocation = "Get Turned up to Death!"
	invocation_type = SpI_SHOUT
	school = "evocation"
	panel = "Warp Magic"
	charge_max = 500
	range = 1

/spell/slaanesh/push/choose_targets(var/mob/user = usr)
	var/list/targets = list()
	for(var/mob/living/carbon/human/H in range(9, user.loc))
		if(H == user)
			continue
		targets += H
	return targets

/spell/slaanesh/push/cast(var/list/targets, var/mob/living/carbon/user)
	..()
	playsound(user.loc, 'z40k_shit/sounds/celeb.ogg', 75, 0)
	for(var/mob/living/carbon/human/H in targets)
		H.Jitter(250)												//make them jitter
		for(var/obj/item/device/shit in H.contents)
			if(istype(shit,/obj/item/device/soulstone))
				var/eyeofslaanesh = H.name
				to_chat(user, "<span class='slaanesh'>Kill [eyeofslaanesh] and bring their soulstone to me!</span>")
				H.Knockdown(4)
			else
				H.mutate("slaanesh")
				H.Knockdown(10)
				H.Stun(10)
				if(prob(25))
					warppush(H) //This is a rng teleportation

		if(iscarbon(user))	//regen but only if people are in range to see it
			if(!user.stat != DEAD)
				user.handcuffed = initial(user.handcuffed)
				user.heal_organ_damage(2,2)
				if(user.reagents)
					user.reagents.remove_all_type(/datum/reagent/toxin, 1*REM, 0, 2)
					user.adjustToxLoss(-2)

				for(var/datum/reagent/R in user.reagents.reagent_list)
					user.reagents.clear_reagents()
	
	user.visible_message("<span class='notice'>Space and time bend before your eyes!!</span>", \
						"<span class='notice'>LETS GET THIS PARTY STARTED!!</span>")

/spell/slaanesh/push/proc/warppush(var/mob/living/user)
	var/list/turflist = list()
	for(var/turf/T in orange(10,user))
		if(T.density)
			continue
		turflist += T

	var/turf/where_we_goin = pick(turflist)
	user.loc = where_we_goin.loc
	spawn(2 SECONDS)
		where_we_goin = pick(turflist)
		user.loc = where_we_goin.loc