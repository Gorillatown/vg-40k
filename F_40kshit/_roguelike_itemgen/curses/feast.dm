/datum/roguelike_effects/curses/eating
	name = "Feast Effect"
	desc = "Appears to feel quite hungry."

/datum/roguelike_effects/curses/eating/re_effect_act(mob/living/M, obj/item/I)
	if(..())
		return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		to_chat(H, "<span class='warning'>A scream enters your mind and fades away!</span>")
		spawn(50)
			to_chat(H, "<span class='warning'> You are being eaten alive!</span>")
			to_chat(M, "<span class='warning'> You can tell you don't have very long to live...</span>")
			spawn(pick(6000,4800,7200)) //Still 8, 10, or 12 minutes. And if you manage to destroy the item, you *might * survive.
				H.Drain()
				to_chat(H, "<span class='warning'> You have been devoured by the curse!</span>")
				to_chat(H, "<span class='warning'> You feel your spirit coalescing over your corpse...</span>")
				spawn(150)
					for(var/mob/living/L in range(7,H))
						to_chat(L, "<span class='warning'> You hear insane laughter...</span>")
						to_chat(L, "<span class='warning'> You hear a loud burp.</span>")
					var/mob/living/S = new /mob/living/simple_animal/shade(H.loc) //Leaves them as a shade.
					H.name = "Cursed Spirit"
					if(H.mind)
						H.mind.transfer_to(S)
					H.gib()
					