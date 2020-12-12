/datum/roguelike_effects/curses/petrify
	name = "Petrification Curse"
	desc = "A curse that turns people to stone, though only breifly."
	cooldown_max = 20

/datum/roguelike_effects/curses/petrify/re_effect_act(mob/living/L, obj/item/I)
	if(..())
		return
	var/instant = FALSE
	//Turn the mob into a statue forever
	//Return 1 on success
	//Silicons and other cockatrices unaffected
	if(prob(50))
		instant = TRUE

	if(issilicon(L) || (L.mob_property_flags & MOB_NO_PETRIFY))
		return 0

	if(!ishuman(L) || instant)
		if(!L.turn_into_statue(1)) //Statue forever
			return 0

		to_chat(L, "<span class='userdanger'>You have been turned to stone.</span>")
		add_logs(src, L, "instantly petrified", admin = L.ckey ? TRUE : FALSE)

	else if(ishuman(L))
		var/mob/living/carbon/human/H = L

		add_logs(src, L, "petrified", admin = L.ckey ? TRUE : FALSE)

		var/found_virus = FALSE
		for(var/datum/disease/petrification/P in H.viruses) //If already petrifying, speed up the process!
			P.stage = P.max_stages
			P.stage_act()
			found_virus = TRUE
			break

		if(!found_virus)
			var/datum/disease/D = new /datum/disease/petrification
			D.holder = H
			D.affected_mob = H
			H.viruses += D
