/datum/job_quest/slaanesh_champion
	title = "Celebrity Woes - Slaanesh Champion Quest"
	var/suit_achieved = FALSE //Have we got our suit yet?

/datum/job_quest/slaanesh_champion/main_body()
	our_protagonist = actual_protagonist.current
	switch(alignment)
		if(1 to INFINITY)
			to_chat(our_protagonist, "<span class='notice'>You renounce the Emperor and all that nonsense.</span>")
			alignment = 0
		if(0)
			to_chat(our_protagonist, "<span class='notice'>Yeah! We don't need their stupid rules. We can at least have a beer. Just one beer. What is the worst that could happen? Lets go find a bottle of beer.</span>")
			alignment--
		if(-1)
			if(istype(our_protagonist.get_active_hand(), /obj/item/weapon/reagent_containers/food/drinks/beer))
				our_protagonist.visible_message("<span class='notice'>[our_protagonist] downs the entire beer like some one that hasn't had one in a while.</span>", 
												"<span class='notice'>You drink the shit out of that beer.</span>", 
												"<span class='warning>You smell beer.</span>")
				playsound(our_protagonist.loc, 'sound/items/drink.ogg', 50, 1)
				alignment--
			else
				to_chat(our_protagonist,"<span class='notice'>What the crap? This isn't beer. It has to be a beer- just like old times. A beer in a beer bottle with a label on it that says 'space beer'. AND you have to be holding it in your hand!</span>")
				return
		if(-2)
			to_chat(our_protagonist, "<span class='notice'>Oh man that was nice! That really hit the spot. You know what would wash this down? Some blow. We need to get our hands on some laserbrain dust. I'm pretty sure you remembered hearing something about how there used to be a good spot to get high in the north-west caves somewhere from one of these unwashed inbred retards.</span>")
			our_protagonist.maxHealth = 150
			our_protagonist.health = 150
			alignment--
		if(-3)
			if(our_protagonist.reagents.has_reagent(LASERBRAIN_DUST))
				to_chat(our_protagonist,"<span class='notice'>Oh holy crap man! That was awesome! Are you feeling better? I'm feeling better. This is nice. REAL nice.</span>")
				alignment--
			else
				to_chat(our_protagonist,"<span class='notice'>Man I am a disembodied voice in your head! Did you really think you can trick me? Go get that Laserbrain dust! FUCKING STEAL IT if you have to! Just get it into your body!</span>")
		if(-4)
			to_chat(our_protagonist,"<span class='notice'>That was sweet but it's kind of lonely misbehaving by ourselves. Lets find some one else to get high with. And I know just the thing. WOOPS! Dropped it on the ground. Hope no one saw.</span>")
			new /obj/item/weapon/lighter/zippo(our_protagonist.loc)
			our_protagonist.equip_to_slot_or_drop(new /obj/item/clothing/mask/cigarette/celeb(our_protagonist), slot_l_hand)
			our_protagonist.visible_message(text("<span class='alert'>[our_protagonist] pulls out a cigarette and smiles at it.</span>"))
			to_chat(our_protagonist,"<span class='notice'>I forgot we had this. This will do nicely. Lets find some one to share it BEFORE we light it up.</span>")
			our_protagonist.maxHealth = 200
			our_protagonist.health = 200
			our_protagonist.faction = "Slaanesh"
			alignment--
		if(-5)
			to_chat(our_protagonist,"<span class='notice'>Puff puff Give Puff Puff Take Back, you know how this works.</span>")	//had to put this in because everyone kept spawning multiple ciggarettes and wondering why it wasn't working.
		if(-6)
			for(var/obj/effect/landmark/bedguitar/BG in range(2, our_protagonist.loc))
				to_chat(our_protagonist, "<span class='notice'>Yes... This is the right place.</span>") //This will create the stash from which the mime gets a special blade.
				new /obj/item/weapon/propguitar/one(get_turf(BG))
				alignment--
				return
			to_chat(our_protagonist,"<span class='notice'>It has been a while since we jammed. I'm pretty sure we left it underneath our bed. Lets find our guitar and see what we can manage.</span>")
		if(-7)
			if(istype(our_protagonist.get_active_hand(), /obj/item/weapon/propguitar))
				our_protagonist.visible_message("<span class='notice'>[our_protagonist] stares intently at the guitar.</span>", "<span class='notice'>This old thing. You have spent half your life with instruments like this. Lets tune it up a bit. We'll need a screwdriver.</span>", "<span class='warning>You can't see shit.</span>")
				alignment--
			else
				to_chat(our_protagonist,"<span class='notice'>Lets hear some tunes! Go find our old instrument in our room. It's in there somewhere. Trust me! I'm a disembodied voice!</span>")
		if(-8)
			if(istype(our_protagonist.get_active_hand(), /obj/item/weapon/propguitar/five))
				our_protagonist.visible_message("<span class='notice'>[our_protagonist] stares intently at the guitar.</span>", "<span class='notice'>It's looking nice. It's looking real nice. Lets go show off our new style. It'll be a scream.</span>", "<span class='warning>You can't see shit.</span>")
				alignment--
			else
				to_chat(our_protagonist,"<span class='notice'>No, this does not look like an upgraded guitar to me. Lets examine it again. Maybe figure out what we are doing wrong.</span>")
		if(-9)
			our_protagonist.visible_message("<span class='notice'>[our_protagonist] appears lost in thought.</span>", "<span class='notice'>Drugs, music, sex... it's all the same thing you know? It is all passion! What good is all the money in the universe if you don't feel alive? Lets go make ourselves a stun baton. Get some wire, rods, wirecutters and build one from scratch. One that is COMPLETELY ours.</span>", "<span class='warning>You can't see shit.</span>")
			alignment--
		if(-10)
			if(istype(our_protagonist.get_active_hand(), /obj/item/weapon/melee/baton))
				our_protagonist.visible_message("<span class='notice'>[our_protagonist] stares intently at the baton.</span>", "<span class='notice'>Every second of pain, like every note of music... is power. I think it is coming together now.</span>", "<span class='warning>You can't see shit.</span>")
				alignment--
			else
				to_chat(our_protagonist, "<span class='notice'>You need to feel alive again. You need to harm others and BE harmed yourself. What is life even worth if you can not feel anything? Build a stun baton and lets get going.</span>")
		if(-11)
			our_protagonist.visible_message("<span class='notice'>[our_protagonist] appears lost in thought.</span>", "<span class='notice'>This is where things get tricky. We have learned the secret to TRUE power. The secret to true strength. Instead of running from vice, we have embraced it, faced it, stolen it, eaten it. The music critics can't hold you back anymore and soon... even physics won't be able to hold you back. You have a chance to transcend...but you just need one thing. A human heart. Now I know what you are thinking, you are thinking that is pretty messed up. But don't get shy on me now. There has GOT to be a few dead bodies laying around somewhere. Get a human heart... and then we can find out just how powerful you really are.</span>", "<span class='warning>You can't see shit.</span>")
			alignment--
		if(-12)
			if(istype(our_protagonist.get_active_hand(), /obj/item/organ/internal/heart))
				var/obj/item/organ/internal/heart/theheart = our_protagonist.get_active_hand()
				our_protagonist.visible_message("<span class='notice'>[our_protagonist] stares intently at the human heart when suddenly it morphs into something else.</span>", "<span class='slaanesh'>I have been guiding you since you first stepped onto this planet. You are my chosen and your power shall be limitless. But there is danger. Those that sent you here want you to perish. Your music, your words, your style frees the people that they have enslaved. You liberate all those around you! The imperials fear you for that. We must act quickly. Search the inquisitor's office for a clue.</span>", "<span class='warning>You can't see shit.</span>")
				our_protagonist.drop_item(theheart)
				qdel(theheart)
				for(var/obj/effect/landmark/crashclue/crash in landmarks_list)
					new /obj/item/weapon/paper/crashclue(crash.loc)
				our_protagonist.equip_to_slot_or_drop(new /obj/item/weapon/sblade_stageone(our_protagonist), slot_l_hand)
				alignment--
			else
				to_chat(our_protagonist,"<span class='notice'>You need a human heart. You need to hold it in your hand and assimilate it's power.</span>")
		if(-13)
			to_chat(our_protagonist,"<span class='notice'>The blade needs your strength. Only then will the path be revealed. Hold it in your hand.</span>")
			var/t_his = "it's"
			if (our_protagonist.gender == MALE)
				t_his = "his"
			if (our_protagonist.gender == FEMALE)
				t_his = "her"
			if(istype(our_protagonist.get_active_hand(), /obj/item/weapon/sblade_stageone))

				var/mob/living/carbon/human/H = our_protagonist
				var/obj/item/weapon/sblade_stageone/theblade = our_protagonist.get_active_hand()
				our_protagonist.drop_item(theblade)
				qdel(theblade)
				
				our_protagonist.equip_to_slot_or_drop(new /obj/item/weapon/daemonweapon/blissrazor(our_protagonist), slot_l_hand)
				our_protagonist.visible_message("<span class='notice'>[our_protagonist] cuts a small symbol into [t_his] forehead.</span>", "<span class='notice'>Holding the blade up to your face, you close your eyes and slowly carve the symbol of Slaanesh into your forehead. Although you have never seen it before, it feels as if it has always been there. The pain is intense but it is the most natural thing you have ever known.</span>", "<span class='warning>Your hair stands on end.</span>")
				
				H.attribute_willpower = 15
				H.attribute_strength = 10
				H.mutate("mark of slaanesh")
				alignment--
			else
				to_chat(our_protagonist,"<span class='notice'>Get out your blade and hold it in your hand. It's time to declare allegiance. True power awaits.</span>")
		if(-14)
			for(var/obj/effect/landmark/chaosladder/theladder in orange(4,our_protagonist.loc))
				theladder.ourladder.loc = theladder.loc
				our_protagonist.say("I have travelled south. I have found the place. Slaanesh, show me the way inside.")
				alignment--
				for(var/obj/structure/ladder/theladders in ladders) //Get your asses to work ladders
					theladders.update_links()
				return
			to_chat(our_protagonist,"<span class='notice'> Remember that paper report? It said something about stuff going on far south..")
		if(-15)
//			our_protagonist.loud = 1
			var/mob/living/carbon/human/H = our_protagonist
			for(var/obj/effect/decal/slaaneshmarker/ourmarker in range(4,our_protagonist.loc))
				our_protagonist.say("Things will get loud now!")
				H.mutate("tentacle mutation")
				our_protagonist.maxHealth = 300
				our_protagonist.health = 300
				our_protagonist.status_flags &= ~CANSTUN
				our_protagonist.status_flags &= ~CANKNOCKDOWN
				our_protagonist.status_flags &= ~CANPARALYSE
				H.attribute_strength += 4
				H.attribute_agility += 3
				H.attribute_dexterity += 3
				to_chat(our_protagonist, "<span class='warning'> You feel stronger. A LOT stronger</span>")
				alignment--
		if(-16)
			to_chat(our_protagonist,"<span class='slaanesh'>So... Disciple... I have heard certain whispers of an escaped eldar in your location. This one managed to escape the care of the darker variant of its kind... I would be so pleased if you could capture this one. Crush their spirit stone and keep them in exquisite agony...</span>")
			alignment--
			our_protagonist.add_spell(new /spell/slaanesh/push,"cult_spell_ready",/obj/abstract/screen/movable/spell_master/slaanesh)
		if(-17)
			to_chat(our_protagonist, "<span class='slaanesh'>You have done well thus far. Now is the time for you to assume your final form. I grant you the greatest blessing you will ever know. Find a private place and join the eternal party as an ascended champion!</span>")
			our_protagonist.add_spell(new /spell/slaanesh/ascension,"cult_spell_ready",/obj/abstract/screen/movable/spell_master/slaanesh)
			for(var/spell/slaanesh/celebfall/spell in our_protagonist.spell_list)
				our_protagonist.remove_spell(spell)
			alignment--
