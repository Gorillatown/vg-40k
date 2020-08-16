/obj/item/weapon/powersword/harlequin
	name = "Harlequin's Blade"
	desc = "A harlequin's power sword."
	icon_state = "harlequin0"
	base_state = "harlequin"
	throwforce = 30
	force = 30
	activeforce = 45
	origin_tech = "combat=8"
	parryprob = 250
	parryduration = 10
	var/slicecooldown = 0

/obj/item/weapon/powersword/harlequin/verb/slice()
	set category = "Mime"
	set name = "Slice"
	set desc = "Sprint forward in a blur and slice things in your path."

	if(ishuman(usr))
		var/mob/living/carbon/human/H = usr
		if(!locate(/obj/item/clothing/suit/armor/harlequin) in H)
			to_chat(H, "<span class='warning'> You need your costume to use this ability!</span>")
			return
		if(!locate(/obj/item/clothing/mask/gas/mime) in H)
			to_chat(H, "<span class='warning'> You need your costume to use this ability!</span>")
			return
		if(H.loc != get_turf(H))
			return
		if(H.get_active_hand() != src)
			to_chat(H, "<span class='warning'> You can only do this while actually wielding the blade, silly.</span>")
			return
		if(slicecooldown)
			to_chat(H, "<span class='warning'> Ability charging.</span>")
			return
		slicecooldown = 1
		spawn(20) 
			slicecooldown = 0
		H.visible_message("<span class='warning'> [H] sprints forward in a blur!</span>")
		var/obj/effect/harl/B = new /obj/effect/harl(get_turf(H))
		B.master = src
		B.user = H
		H.loc = B
		step(B, H.dir)
		sleep(0.5)
		step(B, H.dir)
		sleep(0.5)
		step(B, H.dir)
		sleep(0.5)
		step(B, H.dir)
		sleep(0.5)
		step(B, H.dir)
		sleep(0.5)
		H.loc = get_turf(B)
		qdel(B)
	else
		to_chat(usr, "<span class='warning'> What... What the hell are you?</span>")
		return

/obj/effect/harl
	name = "blade slice"
	desc = "The slicing path of a harlequin blade."
	icon = 'z40k_shit/icons/32x32effects.dmi'
	icon_state = "slice"
	density = 1
	anchored = 1
	var/mob/living/carbon/human/user
	var/obj/item/weapon/powersword/harlequin/master

