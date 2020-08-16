/mob/living/simple_animal/hostile/bitchspirit/verb/healbearer() //Added as verbs on initialization in artifact.
	set name = "(2 Points) Give Swordbearer Vitality"
	set category = "Spirit Powers"

	if(spirit_charge > 2)
		if(istype(loc,/obj/item/weapon/daemonweapon/blissrazor))
			var/obj/item/weapon/daemonweapon/blissrazor/SB = loc
			if(SB.current_swordbearer)
				var/mob/living/carbon/M = SB.current_swordbearer
				M.drowsyness = 0
				M.sleeping = 0
				M.stunned = 0
				M.knockdown = 0
				M.heal_organ_damage(5,0)
				to_chat(M, "<span class='good'> You feel a sudden surge in vitality. </span>")
				to_chat(src, "<span class='danger'> You lend [M] some of your strength</span>")
				spirit_charge -= 2


/mob/living/simple_animal/hostile/bitchspirit/verb/harmbearer()
	set name = "(2 Points) Lash at Swordbearer"
	set category = "Spirit Powers"

	if(spirit_charge >= 2)
		if(istype(loc,/obj/item/weapon/daemonweapon/blissrazor))
			var/obj/item/weapon/daemonweapon/blissrazor/SB = loc
			if(SB.current_swordbearer)
				var/mob/living/carbon/M = SB.current_swordbearer
				M.take_overall_damage(5)
				to_chat(M, "<span class='danger'> Suddenly a large cut appears upon your flesh. </span>")
				to_chat(src, "<span class='danger'> You assault [M] with what little power you can muster.</span>")
				spirit_charge -= 2
	else
		to_chat(src, "<span class='danger'> Not enough energy left in you.</span>")

/mob/living/simple_animal/hostile/bitchspirit/verb/telepathbearer()
	set name = "(1 Point) Telepathic Communication"
	set category = "Spirit Powers"

	if(spirit_charge >= 1)
		if(istype(loc,/obj/item/weapon/daemonweapon/blissrazor))
			var/obj/item/weapon/daemonweapon/blissrazor/SB = loc
			if(SB.current_swordbearer)
				var/mob/living/carbon/M = SB.current_swordbearer
				var/msg = sanitize(input("Message:", "Daemonic Astropathy") as text|null)
				to_chat(M, "<span class='sinister' style='font-size:3'>[msg]</span>")
				to_chat(src, "<span class='sinister'>You project '[msg]' to [M.name].</span>")

/mob/living/simple_animal/hostile/bitchspirit/verb/distant_telepath_msg()
	set name = "(5 Points) Distant Telepathic Message"
	set category = "Spirit Powers"

	if(spirit_charge >= 5)
		if(istype(loc,/obj/item/weapon/daemonweapon/blissrazor))
			var/list/possible = list()
			for(var/mob/living/M in player_list)
				if(M && M.client)
					possible += M
			var/mob/choice = input("Choose a soul to send a message to", "Daemonic Astropathy") in player_list
			if(!choice)
				return 0
			var/msg = sanitize(input("Message:", "Daemonic Astropathy") as text|null)
			to_chat(choice, "<span class='sinister'>[msg]</span>")
			to_chat(src, "<span class='sinister'>You project '[msg]'' to [choice].</span>")