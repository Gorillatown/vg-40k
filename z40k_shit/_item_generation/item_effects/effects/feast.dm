/datum/item_artifact/eating
	name = "Feast Effect"
	desc = "Eats you."
	compatible_mobs = list(/mob/living/carbon/human)

/datum/item_artifact/eating/item_act(var/mob/living/carbon/human/M)
	to_chat(M, "<span class='warning'>A scream enters your mind and fades away!</span>")
	spawn(50)
		to_chat(M, "<span class='warning'> You are being eaten alive!</span>")
		to_chat(M, "<span class='warning'> You can tell you don't have very long to live...</span>")
		spawn(pick(6000,4800,7200)) //Still 8, 10, or 12 minutes. And if you manage to destroy the item, you *might * survive.
			M.Drain()
			to_chat(M, "<span class='warning'> You have been devoured by the curse!</span>")
			to_chat(M, "<span class='warning'> You feel your spirit coalescing over your corpse...</span>")
			spawn(150)
				for(var/mob/living/L in range(7,M))
					to_chat(L, "<span class='warning'> You hear insane laughter...</span>")
					to_chat(L, "<span class='warning'> You hear a loud burp.</span>")
				var/mob/living/S = new /mob/living/simple_animal/shade(M.loc) //Leaves them as a shade.
				S.name = "Cursed Spirit"
				if(M.mind)
					M.mind.transfer_to(S)
				M.gib()
				