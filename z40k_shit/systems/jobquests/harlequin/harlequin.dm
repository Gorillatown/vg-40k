/datum/job_quest/harlequin
	title = "Cegorach or Bust - Harlequin Quest"
	var/suit_achieved = FALSE //Have we got our suit yet?

/datum/job_quest/harlequin/main_body()
	our_protagonist = actual_protagonist.current
	switch(alignment)
		if(1 to INFINITY)
			to_chat(our_protagonist, "<span class='notice'>There was something you needed to remember. What was it?</span>")
			alignment = 0
		if(0)
			to_chat(our_protagonist, "<span class='notice'>How did I even get here? Did I arrive with these humans? Humans... why do I call them that?</span>")
			alignment--
		if(-1)
			to_chat(our_protagonist, "<span class='notice'>Humans. Always so many humans. They breed like rabbits. Or maybe it just seems that way. It wasn't always like this.</span>")
			alignment--
		if(-2)
			to_chat(our_protagonist, "<span class='notice'>They tortured you. Not the humans. Your own kind. Terrible monsters that they were. They tortured others as well. Humans mostly. How long did you spend in that cage?</span>")
			alignment--
		if(-3)
			to_chat(our_protagonist, "<span class='notice'>With these clothes they think you are some kind of performer. They think you are from the tunnel city. But you have always been here. Ever since you escaped from Camorrah. These humans started building and you just walked inside.</span>")
			alignment--
		if(-4)
			to_chat(our_protagonist, "<span class='notice'>They gave you food and spoke low gothic. You don't look human, but you might as well be. The warp altered you. There was something... something else to remember. You need to focus.</span>")
			alignment--
			our_protagonist.add_spell(new /spell/targeted/focus,"ork_spell_ready",/obj/abstract/screen/movable/spell_master/harlequin)
		if(-5)
			to_chat(our_protagonist, "<span class='notice'>It's gnawing at the back of your mind. Focus.</span>")
		if(-7)
			to_chat(our_protagonist, "<span class='notice'>You remember now. You escaped here through the warp. Lept from the walls of Camorrah and fled through the red swirling madness. Slaanesh pulled at you, tried to take you. You were broken and wounded. A human saved you and he did so at a terrible cost to himself. You are free now. Free at last.</span>")
			alignment--
		if(-8)
			to_chat(our_protagonist, "<span class='notice'>Hiding. You are good at hiding. You've been hiding for a long long time. Not from humans. You've been hiding from THEM. They looked for you. They must have looked all over. Maybe thats why you are here now. Maybe you are tired of hiding. Perhaps you want to be found. Thats a dark thought. They'd kill you if they found you. You've become too much of a problem for them.</span>")
			alignment--
			our_protagonist.add_spell(new /spell/targeted/stealth,"ork_spell_ready",/obj/abstract/screen/movable/spell_master/harlequin)
		if(-9)
			to_chat(our_protagonist, "<span class='notice'>A dreamstone. That is what you need. If you want to cheat Slaanesh you must join the ranks of Ynnead. But where can we get a Spirit Stone on this desolate rock? There is one way... but it is dangerous. You'll need to find a multitool.</span>")
			alignment--
		if(-10)
			if(ismultitool(our_protagonist.get_active_hand()))
				our_protagonist.visible_message("<span class='notice'>[our_protagonist] pulls the device apart and begins to reconfigure it.</span>", "<span class='notice'>Not sure if this will work but it is worth a shot.</span>", "<span class='warning'>You can't see shit.</span>")
				qdel(our_protagonist.get_active_hand())
				new /obj/item/device/hacktool(our_protagonist.loc)
				alignment--
				return 1
			else if(ismultitool(our_protagonist.get_inactive_hand()))
				our_protagonist.visible_message("<span class='notice'>[our_protagonist] pulls the device apart and begins to reconfigure it.</span>", "<span class='notice'>Not sure if this will work but it is worth a shot.</span>", "<span class='warning'>You can't see shit.</span>")
				qdel(our_protagonist.get_inactive_hand())
				new /obj/item/device/hacktool(our_protagonist.loc)
				alignment--
				return 1
			else
				to_chat(our_protagonist, "<span class='notice'>You just need a multitool. Where can you find something like that?.</span>")
		if(-11)
			to_chat(our_protagonist, "<span class='notice'>We will need to use this device on a webway gate. If memory serves you, you can find a Dream Stone at Crone21775, along with a webway gate somewhere to the south-east. But be careful. That is in the eye of terror. Right in the center of it.</span>")
			alignment--
		if(-12)
			if(istype(our_protagonist.get_active_hand(), /obj/item/device/soulstone))
				usr.visible_message("<span class='notice'>[usr] stares at a small red crystal.</span>", "<span class='notice'>Yes. This is it. This is what we need to survive.</span>", "<span class='warning>You can't see shit.</span>")
				alignment--
				return 1
			else if(istype(our_protagonist.get_inactive_hand(), /obj/item/device/soulstone))
				usr.visible_message("<span class='notice'>[usr] stares at a small red crystal.</span>", "<span class='notice'>Yes. This is it. This is what we need to survive.</span>", "<span class='warning>You can't see shit.</span>")
				alignment--
				return 1
			else
				to_chat(our_protagonist, "<span class='notice'>Hold that soulstone in your hand. You must hold it. You must bind with it!</span>")
		if(-13)
			to_chat(our_protagonist, "<span class='notice'>It makes sense doesn't it? You kind forgot the old gods and in turn, they have all turned their backs on you. Standing still and waiting to be devoured by 'she who thirsts'. Every one of them destroyed. All except Cegorach.</span>")
			alignment--
		if(-14)
			to_chat(our_protagonist, "<span class='notice'>Why make another god to fight for you, when you still have one left. Cegorach helped you escape that place. Maybe you didn't see him. Maybe you did not hear his voice. But you should have died when you lept into the warp. Something must have guided you. Something- some one.</span>")
			alignment--
			new /mob/living/eventmob/darkeldarone(our_protagonist.loc)
		if(-15)
			to_chat(our_protagonist, "<span class='notice'>It's time to stop fighting the humans. Time to stop fighting your own kind. Time to end this worthless war. There is only one enemy here and it is Slaanesh. Cegorach did not abandon you. It is time for you to join him.</span>")
			our_protagonist.status_flags = 0
			our_protagonist.health = 200
			our_protagonist.add_spell(new /spell/targeted/battle_dance,"ork_spell_ready",/obj/abstract/screen/movable/spell_master/harlequin)
			alignment--
		if(-16)
			to_chat(our_protagonist, "<span class='notice'>This mask was a nice touch. It was just laying there on the floor and you put it on. It helped you to escape that place. But who are you in this grand dance of humans and necrons? Time to make another choice.</span>")
			alignment--
		if(-17)
			for(var/obj/item/clothing/mask/gas/mime/X in our_protagonist.contents)
				if (istype(X, /obj/item/clothing/mask/gas/mime/solitare))
					alignment--
					to_chat(our_protagonist, "<span class='notice'>The Dark Prince. Excellent choice. You must play the role of your greatest enemy. Only then can you understand her and one day defeat her at her own game.</span>")
					return
				if (istype(X, /obj/item/clothing/mask/gas/mime/cegorach))
					alignment--
					to_chat(our_protagonist, "<span class='notice'>They say that the Laughing God wears this mask and walks among his followers, playing the role of himself. Truly, he is the only one qualified.</span>")
					return
				if (istype(X, /obj/item/clothing/mask/gas/mime/death))
					alignment--
					to_chat(our_protagonist, "<span class='notice'>Death. The role that must be played. Shameful as it is, this mask appears very often on the grand stage. Joyful will be the day when no one plays it.</span>")
					return
				if (istype(X, /obj/item/clothing/mask/gas/mime/blind))
					alignment--
					to_chat(our_protagonist, "<span class='notice'>Serephinia, how you tried to prevent all of this. Where are your children now?</span>")
					return
			to_chat(our_protagonist, "<span class='notice'>Hold your mask in your hands and draw upon it with a Crayon.</span>")
		if(-18)
			to_chat(our_protagonist, "<span class='notice'>So you have chosen a face to bear. The right costume is necessary if you are to perform in the great dance that is battle. By the light of your performance, perhaps the humans and some day your own kind will remember the one true enemy.</span>")
			alignment--
			new /mob/living/eventmob/darkeldartwo(our_protagonist.loc)
		if(-19)
			to_chat(our_protagonist, "<span class='notice'>If you are to follow the dance of the laughing god, you must complete your costume. Your uniform. Let us begin with that.</span>")
			alignment--
		if(-20)
			for(var/obj/item/clothing/under/C in our_protagonist.contents)
				if(istype(C, /obj/item/clothing/under/harlequin))
					to_chat(our_protagonist, "<span class='notice'>Excellent. This looks somewhat better. There is still several things you will need to become a true performer for Cegorach. Let us move on to your shoes. They could use some reinforcing.</span>")
					alignment--
					return
			to_chat(our_protagonist, "<span class='notice'>Dye your mime's outfit in the washing machine by washing it with a pen.</span>")
		if(-21) 
			if((istype(our_protagonist.get_active_hand(), /obj/item/clothing/shoes) && istype(our_protagonist.get_inactive_hand(), /obj/item/stack/sheet/metal)) || (istype(our_protagonist.get_inactive_hand(), /obj/item/clothing/shoes) && istype(our_protagonist.get_active_hand(), /obj/item/stack/sheet/metal)))
				our_protagonist.visible_message("[our_protagonist] reinforces the shoes with metal.")
				var/obj/item/numone = our_protagonist.get_active_hand()
				var/obj/item/numtwo = our_protagonist.get_inactive_hand()
				our_protagonist.drop_item(numone, our_protagonist.loc)
				our_protagonist.drop_item(numtwo, our_protagonist.loc)
				qdel(numone)
				qdel(numtwo)
				our_protagonist.update_inv_hands()
				var/obj/item/clothing/shoes/swat/harlequin/HB = new /obj/item/clothing/shoes/swat/harlequin(our_protagonist)
				our_protagonist.put_in_hands(HB)
				spawn(30)
					to_chat(our_protagonist, "<span class='notice'>Yes... Good... You are getting good at creating this costume, even with quite limited materials. Now for the gloves. They need some color.</span>")
					alignment--
			else
				to_chat(our_protagonist, "<span class='notice'>You will need to hold a pair of shoes and some metal to do this.</span>")
		if(-22)
			for(var/obj/item/clothing/gloves/combat/harlequin/HG in our_protagonist.contents)
				to_chat(our_protagonist, "<span class='notice'>Good. This is coming together well. Now that you have proven yourself on the crone world and taken the mask of the harlequin, it is only fitting that you look the part.</span>")
				alignment--
				return
			to_chat(our_protagonist, "<span class='notice'>Use a crayon on those white gloves of yours.</span>")
		if(-23)
			to_chat(our_protagonist, "<span class='notice'>Now that hat. I know just the thing. Get out your beret.</span>")
			alignment--
			new /mob/living/eventmob/darkeldarthree(our_protagonist.loc)
		if(-24)
			if(istype(our_protagonist.get_active_hand(), /obj/item/clothing/head/beret))
				our_protagonist.visible_message("[our_protagonist] sticks some kind of plume in the beret!")
				qdel(our_protagonist.get_active_hand())
				our_protagonist.put_in_hands(new /obj/item/clothing/head/helmet/harlequin(our_protagonist))
				alignment--
			else
				to_chat(our_protagonist, "<span class='notice'>Hold your beret in your hand. You need to modify it.</span>")
		if(-25)
			to_chat(our_protagonist, "<span class='notice'>Hm... Your costume is nearly complete. Once it is, you will be nearer to finalizing your oath to Cegorach. But now you need something to cap off your apparel... Something to protect you in battle and deliver the right performance at once. The coat of a true harlequin.\n\nNow, apparently the human's have a celebrity stationed at this place. I am sure they can help you with a matter of fashion like this. That religious autodrobe they forced into your room against your will probably has something good for your needs. The celebrity though... You have an unexplainable sense of unease. Best be careful.</span>")
			alignment--
		if(-26)
			to_chat(our_protagonist, "<span class='notice'>You don't remember how this got in your pocket... It might be the work of the laughing god. You have a feeling it will help you get the armor you need. Perhaps we should start with that strange black religious vending machine in the room we awoke from.</span>")
			our_protagonist.visible_message("[our_protagonist] fishes a strange coin out of \his pocket!")
			new /obj/item/weapon/coin/harlequin(our_protagonist.loc)
			alignment--
		if(-27)
			for(var/obj/item/clothing/suit/armor/harlequin/HS in our_protagonist.contents)
				to_chat(our_protagonist, "<span class='notice'>Very good. Now you really look like a harlequin, and your new costume will be effective on the battle field, with the laughing god's guidance ever behind you.</span>")
				alignment--
				return
		if(-28)
			to_chat(our_protagonist, "<span class='notice'>You need a proper weapon now... Perhaps... There is still something you must remember.</span>")
			alignment--
		if(-29)
			to_chat(our_protagonist, "<span class='notice'>Where... There was something around here... Before you came here even.</span>")
			alignment--
		if(-30)
			to_chat(our_protagonist, "<span class='notice'>Some kind of room... It must be hidden now.</span>")
			alignment--
		if(-31)
			to_chat(our_protagonist, "<span class='notice'>The abandoned sector. There is something at the abandoned sector, near the webway gate, you remember something being in the power-room north of it.</span>")
			alignment--
			new /mob/living/eventmob/darkeldarfour(our_protagonist.loc)
		if(-32) 
			for(var/obj/effect/landmark/mimefalsewall/MF in range(2, our_protagonist))
				to_chat(our_protagonist, "<span class='notice'>Yes... This is the right place.</span>")
				var/turf/T = get_turf(MF)
				T.ChangeTurf(/turf/simulated/floor/plating)
				var/obj/structure/falserwall/R = new /obj/structure/falserwall(T)
				R.attack_hand()
				for(var/obj/effect/landmark/mimeequipmentdrop/ME in landmarks_list)
					new /obj/item/weapon/powersword/harlequin(get_turf(ME))
					qdel(ME)
				for(var/obj/effect/landmark/mimeopponentdrop/MO in landmarks_list)
					new /mob/living/simple_animal/hostile/faithless/harlequin(get_turf(MO))
					qdel(MO)
				qdel(MF)
				alignment--
				return
			to_chat(our_protagonist, "<span class='notice'>The power room. That underground area the humans built up has a power room. Something... Something there. Something was there before the humans were.</span>")
		if(-33)
			for(var/obj/item/weapon/powersword/harlequin/HB in our_protagonist.contents)
				to_chat(our_protagonist, "<span class='notice'>Now <i>this</i> is a suitable weapon. It must have remained in here for centuries... And that creature was attracted to it's power. It is yours now. You do not know the blade's story; it may have served one of the darker souls of your kind, or it may have served a performer for the laughing god. But you will forge a new story for it. A good one.</span>")
				alignment--
				return
			to_chat(our_protagonist, "<span class='notice'>There is a weapon in there. You <b>need</b> that weapon.</span>")
			return
		if(-34)
			alignment--
			var/mob/living/simple_animal/hostile/retaliate/mandrake/M = new(our_protagonist.loc)
			while(our_protagonist.health > -99)
				if(!M)
					return
				else if(!our_protagonist)
					qdel(M)
					return
				else if(our_protagonist.paralysis > 1)
					M.loc = our_protagonist.loc
					sleep(20)
					qdel(M)
					our_protagonist.gib()
					return
				else if(M.health > 0)
					M.loc = our_protagonist.loc
					our_protagonist.apply_damage(15, BRUTE, LIMB_HEAD)
					playsound(M.loc, 'z40k_shit/sounds/eldar2.ogg', 75, 0)
					usr.visible_message("<span class='notice'>[usr] is stabbed in the throat by some kind of creature!</span>", "<span class='notice'>You've been stabbed in the throat!</span>", "<span class='warning>You can't see shit. But there is some crazy stuff going down!</span>")
					sleep(120)
				else
					qdel(M)
					return
		if(-35)
			to_chat(our_protagonist, "<span class='notice'>The Exiles survived because they ran... but one can only run so far before they have to turn and fight. Time to hone these new skills.</span>")
			our_protagonist.add_spell(new /spell/targeted/projectile/shrieker_cannon,"ork_spell_ready",/obj/abstract/screen/movable/spell_master/harlequin)
			our_protagonist.add_spell(new /spell/targeted/swap,"ork_spell_ready",/obj/abstract/screen/movable/spell_master/harlequin)
//			H.mind.spell_list += new /obj/effect/proc_holder/spell/targeted/mime/trick(null)
			for(var/spell/targeted/concentrate/spell in our_protagonist.spell_list)
				our_protagonist.remove_spell(spell)
