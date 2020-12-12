/obj/effect/proc_holder/spell/targeted/mime/trick //This might turn out to just be irritating, but while I am writing miscillaneous harlequin verbs I might as well...
	name = "Trick (You have to stand right next to some one)"
	desc = "Do the god of pranks proud."
	invocation = "none"
	invocation_type = "none"
	school = "mime"
	panel = "Mime"
	clothes_req = 0
	human_req = 1
	charge_max = 300
	range = -1
	include_user = 1

/obj/effect/proc_holder/spell/targeted/mime/trick/cast()
	if(!usr) return
	if(!ishuman(usr)) return
	for(var/mob/living/carbon/human/H in range(1, usr))
		if(H != usr)
			var/obj/item/weapon/grenade/G
			if(istype(H.l_store, /obj/item/weapon/grenade))
				G = H.l_store
			if(istype(H.r_store, /obj/item/weapon/grenade))
				G = H.r_store
			if(G)
				usr.visible_message("<span class='warning'> [usr] pulls the pin on the [G] in [H]'s pocket!</span>", "You pull the pin on the [G] in [H]'s pocket! What a prank!", "You hear a clicking sound.")
				G.attack_self(usr)
				..()
				return
			var/randprank = rand(1, 2)
			switch(randprank)
				if(1)
					var/obj/item/weapon/legcuffs/beartrap/BT = new /obj/item/weapon/legcuffs/beartrap(get_turf(usr))
					BT.armed = 1
					BT.update_icon()
					to_chat(usr, "<span class='warning'> You drop the [BT].</span>")
					usr.start_pulling(H)
					step(usr, get_dir(usr, get_step_away(usr, H)))
				if(2)
					usr.visible_message("<span class='warning'> [usr] stabs [H] with a small needle!</span>")
					H.reagents.add_reagent(pick("curare", "chloralhydrate", "hallucinations", "fatigue"), 5)
	..()